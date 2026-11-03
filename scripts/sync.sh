#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/lib.sh"

export PATH="$HOME/.local/bin:/home/linuxbrew/.linuxbrew/bin:/usr/local/bin:/usr/bin:/bin:$PATH"

usage() {
  cat <<'EOF'
Usage: ./sync.sh [options]

Options:
  --dry-run           Show pending changes without committing or pushing.
  --message MESSAGE   Use MESSAGE instead of generating one with opencode.
  --no-ai             Do not call opencode; use a fallback commit message.
  --no-push           Commit locally but skip pull/push.
  -h, --help          Show this help.
EOF
}

dry_run=0
use_ai="${ARFS6_AI:-1}"
do_push=1
custom_message=""

while [ $# -gt 0 ]; do
  case "$1" in
    --dry-run) dry_run=1 ;;
    --message)
      [ $# -ge 2 ] || die "--message requires a value"
      custom_message="$2"
      shift
      ;;
    --message=*) custom_message="${1#*=}" ;;
    --no-ai) use_ai=0 ;;
    --no-push) do_push=0 ;;
    -h|--help)
      usage
      exit 0
      ;;
    *) die "unknown option: $1" ;;
  esac
  shift
done

require_command git
require_command flock

lock_dir="${XDG_RUNTIME_DIR:-/tmp}"
lock_file="$lock_dir/arfs6-sync-$(id -u).lock"
exec 9>"$lock_file"
if ! flock -n 9; then
  log "another sync is already running"
  exit 0
fi

cd -- "$REPO_ROOT"
git rev-parse --is-inside-work-tree >/dev/null 2>&1 || die "not a git repository: $REPO_ROOT"

make_commit_message() {
  local stat="$1"
  local diff="$2"
  local fallback
  local raw
  local msg
  local prompt

  fallback="chore: sync dotfiles $(date '+%Y-%m-%d')"

  if [ "$use_ai" -eq 1 ] && command -v opencode >/dev/null 2>&1; then
    prompt="Write one concise git commit message for the changes below.
Use imperative mood, keep it under 72 characters, and output only the message.
Do not use tools, quotes, markdown, or an explanation.

Files changed:
$stat

Diff:
$diff"

    raw="$(timeout "${ARFS6_OPENCODE_TIMEOUT:-120}" opencode run --format json "$prompt" 2>/dev/null || true)"
    msg="$(printf '%s\n' "$raw" | python3 -c '
import json
import sys

texts = []
for line in sys.stdin:
    try:
        event = json.loads(line)
    except Exception:
        continue
    if event.get("type") != "text":
        continue
    part = event.get("part") or {}
    value = part.get("text")
    if value:
        texts.append(value)

text = (texts[-1] if texts else "").strip()
for line in text.splitlines():
    line = line.strip().strip("`").strip()
    if line:
        print(line)
        break
' 2>/dev/null || true)"

    msg="${msg#\#\#\# }"
    msg="$(printf '%s' "$msg" | sed -e 's/[[:space:]]\+/ /g' -e 's/^ //' -e 's/ $//')"
    msg="${msg#\"}"
    msg="${msg%\"}"
    [ -n "$msg" ] || msg="$fallback"
    printf '%s\n' "${msg:0:100}"
    return 0
  fi

  printf '%s\n' "$fallback"
}

sync_remote() {
  local branch
  local upstream
  local remote
  local remote_branch

  branch="$(git symbolic-ref --quiet --short HEAD || true)"
  if [ -z "$branch" ]; then
    log "detached HEAD; skipping remote sync"
    return 0
  fi

  upstream="$(git rev-parse --abbrev-ref --symbolic-full-name '@{u}' 2>/dev/null || true)"
  if [ -z "$upstream" ]; then
    log "no upstream configured; skipping pull and push"
    return 0
  fi

  remote="${upstream%%/*}"
  remote_branch="${upstream#*/}"

  if ! git pull --rebase --autostash --quiet; then
    log "pull/rebase failed; leaving the repository for manual review"
    git rebase --abort >/dev/null 2>&1 || true
    return 1
  fi

  if ! git push --quiet "$remote" "HEAD:$remote_branch"; then
    log "push failed; the commit remains available locally"
    return 1
  fi

  log "synced with $upstream"
}

changes="$(git status --porcelain --untracked-files=all)"

if [ -z "$changes" ]; then
  log "no local changes"
  if [ "$dry_run" -eq 1 ]; then
    log "dry run: skipping remote sync"
    exit 0
  fi
  if [ "$do_push" -eq 1 ]; then
    sync_remote || exit 1
  fi
  exit 0
fi

if [ "$dry_run" -eq 1 ]; then
  log "pending changes:"
  printf '%s\n' "$changes" >&2
  exit 0
fi

git add -A

stat="$(git diff --cached --stat)"
diff="$(git diff --cached --no-ext-diff --unified=3 | head -c 24000 || true)"

if [ -n "$custom_message" ]; then
  message="$custom_message"
else
  message="$(make_commit_message "$stat" "$diff")"
fi

git commit --quiet -m "$message"
log "committed: $message"

if [ "$do_push" -eq 1 ]; then
  sync_remote || exit 1
fi

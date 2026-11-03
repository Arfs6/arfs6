#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd -- "$SCRIPT_DIR/.." && pwd)"
MANIFEST="$REPO_ROOT/dotfiles.manifest"

log() {
  printf '[%s] %s\n' "$(date '+%Y-%m-%d %H:%M:%S')" "$*" >&2
}

die() {
  log "error: $*"
  exit 1
}

require_command() {
  command -v "$1" >/dev/null 2>&1 || die "required command not found: $1"
}

expand_home() {
  case "$1" in
    "~") printf '%s\n' "$HOME" ;;
    "~/"*) printf '%s/%s\n' "$HOME" "${1#\~/}" ;;
    *) printf '%s\n' "$1" ;;
  esac
}

repo_relative() {
  case "$1" in
    "$REPO_ROOT"/*) printf '%s\n' "${1#"$REPO_ROOT"/}" ;;
    *) printf '%s\n' "$1" ;;
  esac
}

read_manifest() {
  local repo_rel home_rel rest source target

  [ -f "$MANIFEST" ] || die "manifest not found: $MANIFEST"

  while IFS=$' \t' read -r repo_rel home_rel rest || [ -n "${repo_rel:-}" ]; do
    [ -z "${repo_rel:-}" ] && continue
    case "$repo_rel" in
      \#*) continue ;;
    esac
    if [ -z "${home_rel:-}" ]; then
      log "invalid manifest line: $repo_rel"
      continue
    fi
    source="$REPO_ROOT/$repo_rel"
    target="$(expand_home "$home_rel")"
    printf '%s\t%s\n' "$source" "$target"
  done < "$MANIFEST"
}

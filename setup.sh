#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/scripts/lib.sh"

usage() {
  cat <<'EOF'
Usage: ./setup.sh [options]

Options:
  --adopt             Import existing home files into the repo before linking.
  --interval PERIOD   Sync schedule: hourly, daily, weekly, or none. Default: daily.
  --no-timer          Do not install the systemd timer.
  --dry-run           Show what would happen without changing anything.
  -h, --help          Show this help.

Without --adopt, the repo versions are linked into your home directory.
Existing files are always backed up under ~/.local/state/arfs6/backups/.
EOF
}

adopt=0
no_timer=0
dry_run=0
interval="daily"

while [ $# -gt 0 ]; do
  case "$1" in
    --adopt) adopt=1 ;;
    --no-timer) no_timer=1 ;;
    --dry-run) dry_run=1 ;;
    --interval)
      [ $# -ge 2 ] || die "--interval requires a value"
      interval="$2"
      shift
      ;;
    --interval=*) interval="${1#*=}" ;;
    -h|--help)
      usage
      exit 0
      ;;
    *) die "unknown option: $1" ;;
  esac
  shift
done

case "$interval" in
  hourly|daily|weekly|none) ;;
  *) die "invalid interval: $interval (use hourly, daily, weekly, or none)" ;;
esac

[ "$interval" = "none" ] && no_timer=1

require_command git
require_command rsync

backup_root="${XDG_STATE_HOME:-$HOME/.local/state}/arfs6/backups/$(date '+%Y%m%d-%H%M%S')"

backup_target() {
  local target="$1"
  local relative="${target#"$HOME"/}"
  local backup

  [ "$relative" = "$target" ] && relative="external/$(basename -- "$target")"
  backup="$backup_root/$relative"

  if [ "$dry_run" -eq 1 ]; then
    log "would back up: $target -> $backup"
    printf '%s\n' "$backup"
    return 0
  fi

  mkdir -p -- "$(dirname -- "$backup")"
  mv -- "$target" "$backup"
  log "backed up: $target -> $backup"
  printf '%s\n' "$backup"
}

adopt_backup() {
  local backup="$1"
  local source="$2"

  [ "$adopt" -eq 1 ] || return 0
  [ -L "$backup" ] && { log "skipping import of symlink: $backup"; return 0; }

  if [ "$dry_run" -eq 1 ]; then
    log "would import: $backup -> $source"
    return 0
  fi

  if [ -d "$backup" ]; then
    [ -d "$source" ] && [ ! -L "$source" ] || die "cannot import directory $backup onto non-directory $source"
    rsync -a --delete -- "$backup/" "$source/"
  else
    [ -d "$source" ] && [ ! -L "$source" ] && die "cannot import file $backup onto directory $source"
    mkdir -p -- "$(dirname -- "$source")"
    cp -a -- "$backup" "$source"
  fi
  log "imported: $backup -> $source"
}

link_entry() {
  local source="$1"
  local target="$2"
  local desired current backup

  if [ ! -e "$source" ] && [ ! -L "$source" ]; then
    log "skipping missing repo path: $source"
    return 0
  fi

  desired="$(readlink -f -- "$source" 2>/dev/null || true)"

  if [ -L "$target" ]; then
    current="$(readlink -f -- "$target" 2>/dev/null || true)"
    if [ -n "$desired" ] && [ "$current" = "$desired" ]; then
      log "already linked: $target"
      return 0
    fi
  fi

  if [ -e "$target" ] || [ -L "$target" ]; then
    backup="$(backup_target "$target")"
    if [ "$adopt" -eq 1 ]; then
      adopt_backup "$backup" "$source"
    fi
  fi

  if [ "$dry_run" -eq 1 ]; then
    log "would link: $target -> $source"
    return 0
  fi

  mkdir -p -- "$(dirname -- "$target")"
  ln -s -- "$source" "$target"
  log "linked: $target -> $source"
}

install_timer() {
  local unit_dir service_file timer_file calendar delay

  [ "$no_timer" -eq 1 ] && { log "systemd timer not installed"; return 0; }

  if ! command -v systemctl >/dev/null 2>&1 || ! systemctl --user show-environment >/dev/null 2>&1; then
    log "systemd user services unavailable; skipping timer"
    log "add this to cron to sync automatically: 0 3 * * * $REPO_ROOT/scripts/sync.sh"
    return 0
  fi

  case "$interval" in
    hourly) calendar="hourly"; delay="5m" ;;
    daily) calendar="daily"; delay="30m" ;;
    weekly) calendar="weekly"; delay="1h" ;;
  esac

  unit_dir="${XDG_CONFIG_HOME:-$HOME/.config}/systemd/user"
  service_file="$unit_dir/arfs6-sync.service"
  timer_file="$unit_dir/arfs6-sync.timer"

  if [ "$dry_run" -eq 1 ]; then
    log "would install timer: $interval"
    return 0
  fi

  mkdir -p -- "$unit_dir"

  cat > "$service_file" <<EOF
[Unit]
Description=Sync arfs6 dotfiles repository
Wants=network-online.target
After=network-online.target

[Service]
Type=oneshot
WorkingDirectory=$REPO_ROOT
ExecStart=$REPO_ROOT/scripts/sync.sh
EOF

  cat > "$timer_file" <<EOF
[Unit]
Description=$interval arfs6 dotfiles sync

[Timer]
OnCalendar=$calendar
Persistent=true
RandomizedDelaySec=$delay
Unit=arfs6-sync.service

[Install]
WantedBy=timers.target
EOF

  if [ -n "${SSH_AUTH_SOCK:-}" ]; then
    systemctl --user import-environment SSH_AUTH_SOCK >/dev/null 2>&1 || true
  fi
  if ! systemctl --user daemon-reload; then
    log "warning: systemd daemon-reload failed"
  fi
  if ! systemctl --user enable arfs6-sync.timer >/dev/null; then
    log "warning: could not enable arfs6-sync.timer"
    return 0
  fi
  if ! systemctl --user restart arfs6-sync.timer; then
    log "warning: could not start arfs6-sync.timer"
    return 0
  fi
  log "installed $interval systemd timer: arfs6-sync.timer"
}

install_command() {
  local bin_dir="$HOME/.local/bin"

  if [ "$dry_run" -eq 1 ]; then
    log "would install command: $bin_dir/arfs6-sync"
    return 0
  fi

  mkdir -p -- "$bin_dir"
  ln -sfn -- "$REPO_ROOT/scripts/sync.sh" "$bin_dir/arfs6-sync"
  log "installed command: $bin_dir/arfs6-sync"
}

while IFS=$'\t' read -r source target; do
  link_entry "$source" "$target"
done < <(read_manifest)

install_command
install_timer

if [ "$dry_run" -eq 0 ]; then
  log "setup complete"
  [ -d "$backup_root" ] && log "backups: $backup_root"
fi

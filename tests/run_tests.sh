#!/bin/sh
set -eu
REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
WRAPPER="$REPO_ROOT/scripts/who_is_ralph.colorize.sh"

if [ -x "$REPO_ROOT/scripts/who_is_ralph.sh" ]; then TARGET="$REPO_ROOT/scripts/who_is_ralph.sh"; elif [ -x "$REPO_ROOT/who_is_ralph.sh" ]; then TARGET="$REPO_ROOT/who_is_ralph.sh"; else echo "no target who_is_ralph.sh found" >&2; exit 1; fi

# Choose checksum command
if command -v shasum >/dev/null 2>&1; then CHECKSUM_CMD="shasum -a 256"; else CHECKSUM_CMD="sha256sum"; fi

BEFORE=$($CHECKSUM_CMD "$TARGET" | awk '{print $1}')

# Run wrapper and capture stdout
OUT=$("$WRAPPER")

ESC=$(printf '\033')
# Verify colorization present
case "$OUT" in
  *"${ESC}[35mRalph${ESC}[0m"*) ;;
  *) echo "color sequence missing" >&2; exit 2 ;;
esac

# Verify original file unchanged
AFTER=$($CHECKSUM_CMD "$TARGET" | awk '{print $1}')
if [ "$BEFORE" != "$AFTER" ]; then echo "original file modified" >&2; exit 3; fi

echo "TESTS PASSED"

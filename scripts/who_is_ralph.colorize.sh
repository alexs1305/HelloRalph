#!/bin/sh
# who_is_ralph.colorize.sh - Wrapper that colorizes every exact occurrence of "Ralph" in who_is_ralph.sh output.
# Portable POSIX sh, uses mktemp and sed. Idempotent: strips existing purple wrapper before applying color.

# Locate target script
TARGET="./scripts/who_is_ralph.sh"
if [ ! -x "$TARGET" ]; then
  TARGET="./who_is_ralph.sh"
fi

ESC=$(printf '\033')
TMP=$(mktemp) || exit 1
# Capture stdout to temp file, leave stderr alone
"$TARGET" >"$TMP"
EXIT_CODE=$?
# Remove any existing purple wrapper around Ralph, then apply purple (35) and reset (0)
sed "s/${ESC}\[35mRalph${ESC}\[0m/Ralph/g" "$TMP" | sed "s/Ralph/${ESC}[35m&${ESC}[0m/g"
rm -f "$TMP"
exit $EXIT_CODE

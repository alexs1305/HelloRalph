#!/bin/sh
# Wrapper: print the ASCII question-mark header, then exec the original script (non-destructive)
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
ART_FILE="$SCRIPT_DIR/ascii-question-mark.txt"
# Print the header if available
if [ -r "$ART_FILE" ]; then
  cat "$ART_FILE"
fi
# Prefer the preserved original script if present
if [ -x "$SCRIPT_DIR/who_is_ralph.orig.sh" ]; then
  exec "$SCRIPT_DIR/who_is_ralph.orig.sh"
else
  # Fallback: try to execute bundled original content if present
  exec "$SCRIPT_DIR/who_is_ralph.sh.real" || exit $?
fi

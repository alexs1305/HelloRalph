#!/bin/sh
# Unified who_is_ralph script: prints ASCII header, the message, and colorizes "Ralph" in purple.
SCRIPT_DIR="$(cd "$(dirname "$0")" >/dev/null 2>&1 && pwd)"
PURPLE="$(printf '\033[35m')"
RESET="$(printf '\033[0m')"
# Print header if present
ART_FILE="$SCRIPT_DIR/ascii-question-mark.txt"

print_header() {
  if [ -r "$ART_FILE" ]; then
    cat "$ART_FILE"
  fi
}

# Color occurrences of "Ralph" in a string and print
colorize_msg() {
  printf '%s\n' "$1" | awk -v p="$PURPLE" -v r="$RESET" '{gsub(/Ralph/, p "Ralph" r); print}'
}

trim() {
  printf '%s' "$1" | awk '{$1=$1;print}'
}

prompt_for_bound() {
  while :; do
    printf 'Enter an upper bound (0-100 inclusive): '
    if ! read USER_INPUT; then
      exit 0
    fi
    USER_INPUT=$(trim "$USER_INPUT")
    case "$USER_INPUT" in
      ''|*[!0-9]*)
        printf 'Invalid input: please enter an integer between 0 and 100 (inclusive).\n'
        continue
        ;;
    esac
    N=$USER_INPUT
    if [ "$N" -ge 0 ] 2>/dev/null && [ "$N" -le 100 ] 2>/dev/null; then
      return 0
    else
      printf 'Invalid input: please enter an integer between 0 and 100 (inclusive).\n'
    fi
  done
}

print_fizzbuzz_up_to() {
  i=1
  while [ "$i" -le "$1" ]; do
    out=''
    if [ $((i % 3)) -eq 0 ]; then out='Ralph'; fi
    if [ $((i % 5)) -eq 0 ]; then
      if [ -n "$out" ]; then out="$out Wiggum"; else out='Wiggum'; fi
    fi
    if [ -z "$out" ]; then out="$i"; fi
    case "$out" in
      *Ralph*)
        printf '%s%s%s\n' "$PURPLE" "$out" "$RESET"
        ;;
      *)
        printf '%s\n' "$out"
        ;;
    esac
    i=$((i + 1))
  done
}

# Main
MSG='Ralph is an autonomous AI coding assistant that follows spec-driven development.'
print_header
colorize_msg "$MSG"
prompt_for_bound
print_fizzbuzz_up_to "$N"

exit 0

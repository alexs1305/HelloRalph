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

# Color occurrences of "Ralph" in a string and print (make bold for emphasis and ensure accessible reset)
colorize_msg() {
  BOLD="$(printf '\033[1m')"
  printf '%s\n' "$1" | awk -v p="$PURPLE" -v b="$BOLD" -v r="$RESET" '{gsub(/Ralph/, b p "Ralph" r); print}'
}

trim() {
  # Trim leading/trailing whitespace in a POSIX-friendly way
  printf '%s' "$1" | awk '{$1=$1;print}'
}

prompt_for_bound() {
  # Provide clearer prompt, accessible hint, and repeat criteria on invalid input
  while :; do
    printf '\nEnter an upper bound (0-100 inclusive): '
    if ! read USER_INPUT; then
      printf '\nInput closed, exiting.\n'
      exit 0
    fi
    USER_INPUT=$(trim "$USER_INPUT")
    case "$USER_INPUT" in
      ''|*[!0-9]*)
        printf '\nInvalid input: please enter an integer between 0 and 100 (inclusive). Example: 42\n'
        continue
        ;;
    esac
    N=$USER_INPUT
    if [ "$N" -ge 0 ] 2>/dev/null && [ "$N" -le 100 ] 2>/dev/null; then
      return 0
    else
      printf '\nInvalid input: please enter an integer between 0 and 100 (inclusive).\n'
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

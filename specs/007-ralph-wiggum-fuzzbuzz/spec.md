# Spec 007: Ralph Wiggum FuzzBuzz

## Status: JUNIOR_DONE

## Summary

Extend `scripts/who_is_ralph.sh` so that after displaying the ASCII question-mark header and purple-colored Ralph description, it interactively asks the user for an upper bound between 0 and 100 and then prints a Ralph/Wiggum-themed FizzBuzz sequence up to that number.

## Acceptance Criteria

- [ ] The script prompts the user to enter a number between 0 and 100 (inclusive) and continues re-prompting until the input is numeric, trimmed of surrounding whitespace, and within range. Each invalid attempt restates the criteria.
- [ ] Once a valid integer `N` is provided, the script iterates from 1 through `N`, outputting one line per value with the following mapping:
  - Multiples of 3 → `Ralph`
  - Multiples of 5 → `Wiggum`
  - Multiples of both 3 and 5 → `Ralph Wiggum`
  - All other numbers print as the number itself
- [ ] The existing ASCII art header and the purple-colored Ralph description remain unchanged and precede the new interactive output.
- [ ] The implementation remains POSIX `sh` compatible and relies only on standard shell utilities (`read`, arithmetic tests, `printf`, etc.).
- [ ] The script exits with status 0 after printing the requested sequence.

## Technical Notes

- Trim whitespace from user input before validation; a simple `while` loop with `case` or arithmetic comparison is sufficient.
- Reuse the existing ANSI purple color for lines containing "Ralph" to maintain consistent styling.
- Helper functions are acceptable if they keep the script readable, but avoid unnecessary complexity.

## Dependencies

- `scripts/who_is_ralph.sh`
- `scripts/ascii-question-mark.txt`

## Assumptions

- The counting starts at 1 even if the user enters 0.
- Invalid input must re-display the “0–100 inclusive” criteria before re-prompting.

<!-- NR_OF_TRIES: 1 -->

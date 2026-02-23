#!/bin/sh
# Original who_is_ralph script (backed up by wrapper)
# Produce an ANSI escape byte and build color codes
ESC=$(printf '\033')
PURPLE="${ESC}[35m"
RESET="${ESC}[0m"

colorize() {
	# Replace every literal 'Ralph' with the purple-colored version
	printf '%s' "$1" | sed "s/Ralph/${PURPLE}Ralph${RESET}/g"
}

text="Ralph is an autonomous AI coding assistant that follows spec-driven development."
printf '%b\n' "$(colorize "$text")"

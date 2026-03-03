#!/usr/bin/env bash
# utils/term-colors.sh -- list of terminal color escape codes

# Text Reset
declare -rx RESET='\033[0m'
declare -rx NO_COLOR='\033[0m'

# Regular Colors
declare -rx BLACK='\033[0;30m'
declare -rx RED='\033[0;31m'
declare -rx GREEN='\033[0;32m'
declare -rx YELLOW='\033[0;33m'
declare -rx BLUE='\033[0;34m'
declare -rx MAGENTA='\033[0;35m'
declare -rx PURPLE='\033[0;35m'
declare -rx CYAN='\033[0;36m'
declare -rx WHITE='\033[0;37m'

# Bold Colors
declare -rx BOLD_BLACK='\033[1;30m'
declare -rx BOLD_RED='\033[1;31m'
declare -rx BOLD_GREEN='\033[1;32m'
declare -rx BOLD_YELLOW='\033[1;33m'
declare -rx BOLD_BLUE='\033[1;34m'
declare -rx BOLD_MAGENTA='\033[1;35m'
declare -rx BOLD_PURPLE='\033[1;35m'
declare -rx BOLD_CYAN='\033[1;36m'
declare -rx BOLD_WHITE='\033[1;37m'

# Underline Colors
declare -rx UNDERLINE_BLACK='\033[4;30m'
declare -rx UNDERLINE_RED='\033[4;31m'
declare -rx UNDERLINE_GREEN='\033[4;32m'
declare -rx UNDERLINE_YELLOW='\033[4;33m'
declare -rx UNDERLINE_BLUE='\033[4;34m'
declare -rx UNDERLINE_MAGENTA='\033[4;35m'
declare -rx UNDERLINE_PURPLE='\033[4;35m'
declare -rx UNDERLINE_CYAN='\033[4;36m'
declare -rx UNDERLINE_WHITE='\033[4;37m'

# Background Colors
declare -rx BG_BLACK='\033[40m'
declare -rx BG_RED='\033[41m'
declare -rx BG_GREEN='\033[42m'
declare -rx BG_YELLOW='\033[43m'
declare -rx BG_BLUE='\033[44m'
declare -rx BG_MAGENTA='\033[45m'
declare -rx BG_PURPLE='\033[45m'
declare -rx BG_CYAN='\033[46m'
declare -rx BG_WHITE='\033[47m'

# High Intensity Colors
declare -rx INTENSE_BLACK='\033[0;90m'
declare -rx INTENSE_RED='\033[0;91m'
declare -rx INTENSE_GREEN='\033[0;92m'
declare -rx INTENSE_YELLOW='\033[0;93m'
declare -rx INTENSE_BLUE='\033[0;94m'
declare -rx INTENSE_MAGENTA='\033[0;95m'
declare -rx INTENSE_PURPLE='\033[0;95m'
declare -rx INTENSE_CYAN='\033[0;96m'
declare -rx INTENSE_WHITE='\033[0;97m'

# Bold High Intensity Colors
declare -rx BOLD_INTENSE_BLACK='\033[1;90m'
declare -rx BOLD_INTENSE_RED='\033[1;91m'
declare -rx BOLD_INTENSE_GREEN='\033[1;92m'
declare -rx BOLD_INTENSE_YELLOW='\033[1;93m'
declare -rx BOLD_INTENSE_BLUE='\033[1;94m'
declare -rx BOLD_INTENSE_MAGENTA='\033[1;95m'
declare -rx BOLD_INTENSE_PURPLE='\033[1;95m'
declare -rx BOLD_INTENSE_CYAN='\033[1;96m'
declare -rx BOLD_INTENSE_WHITE='\033[1;97m'

# High Intensity Background Colors
declare -rx BG_INTENSE_BLACK='\033[0;100m'
declare -rx BG_INTENSE_RED='\033[0;101m'
declare -rx BG_INTENSE_GREEN='\033[0;102m'
declare -rx BG_INTENSE_YELLOW='\033[0;103m'
declare -rx BG_INTENSE_BLUE='\033[0;104m'
declare -rx BG_INTENSE_MAGENTA='\033[0;105m'
declare -rx BG_INTENSE_PURPLE='\033[0;105m'
declare -rx BG_INTENSE_CYAN='\033[0;106m'
declare -rx BG_INTENSE_WHITE='\033[0;107m'

# Text Formatting
declare -rx BOLD='\033[1m'
declare -rx DIM='\033[2m'
declare -rx ITALIC='\033[3m'
declare -rx UNDERLINE='\033[4m'
declare -rx BLINK='\033[5m'
declare -rx REVERSE='\033[7m'
declare -rx HIDDEN='\033[8m'
declare -rx STRIKETHROUGH='\033[9m'

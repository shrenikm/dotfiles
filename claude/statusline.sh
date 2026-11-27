#!/bin/bash

# Claude Code status line.
# Reads the session JSON on stdin and prints the model, effort level, context
# usage and the 5-hour/weekly rate limits, color coded by how close each is to
# its cap. Segments whose fields are absent (e.g. rate limits on API-key auth
# or older versions) are skipped.
# ------------------------------------------------

set -u

# Defining colors
# ------------------------------------------------
# Green is truecolor (base16 default-dark green) because the kitty theme maps
# ANSI green to gray. The rest follow the terminal palette.
RED=$'\033[31m'
GREEN=$'\033[38;2;161;181;108m'
YELLOW=$'\033[33m'
BLUE=$'\033[34m'
MAGENTA=$'\033[35m'
CYAN=$'\033[36m'
BOLD=$'\033[1m'
GRAY=$'\033[90m'
NO_COLOR=$'\033[0m'

BAR_WIDTH=8
COMPACT_BELOW_COLUMNS=110
WEEKLY_RESET_FORMAT='%a %-I:%M%P'
WARN_PERCENT=50
CRITICAL_PERCENT=80
SEPARATOR=" ${GRAY}│${NO_COLOR} "

# Helpers
# ------------------------------------------------
percent_color() {
    local percent="$1"
    if [ "$percent" -ge "$CRITICAL_PERCENT" ]; then
        echo -n "$RED"
    elif [ "$percent" -ge "$WARN_PERCENT" ]; then
        echo -n "$YELLOW"
    else
        echo -n "$GREEN"
    fi
}

effort_color() {
    case "$1" in
        low) echo -n "$BLUE" ;;
        medium) echo -n "$CYAN" ;;
        high) echo -n "$GREEN" ;;
        xhigh) echo -n "$MAGENTA" ;;
        max) echo -n "$RED" ;;
        *) echo -n "$NO_COLOR" ;;
    esac
}

# Prints the bar plus a trailing space, or nothing on narrow terminals.
progress_bar() {
    local percent="$1"
    local color="$2"
    [ "${COLUMNS:-$COMPACT_BELOW_COLUMNS}" -lt "$COMPACT_BELOW_COLUMNS" ] && return

    local filled=$(( (percent * BAR_WIDTH + 50) / 100 ))

    # Keep at least one cell lit for any nonzero usage, and clamp overflow.
    if [ "$percent" -gt 0 ] && [ "$filled" -eq 0 ]; then
        filled=1
    elif [ "$filled" -gt "$BAR_WIDTH" ]; then
        filled=$BAR_WIDTH
    fi

    local filled_cells empty_cells
    printf -v filled_cells '%*s' "$filled" ''
    printf -v empty_cells '%*s' "$(( BAR_WIDTH - filled ))" ''
    echo -n "${color}${filled_cells// /━}${GRAY}${empty_cells// /━}${NO_COLOR} "
}

format_countdown() {
    local resets_at="$1"
    local now
    printf -v now '%(%s)T' -1
    local seconds=$(( resets_at - now ))
    [ "$seconds" -le 0 ] && return

    local days=$(( seconds / 86400 ))
    local hours=$(( seconds % 86400 / 3600 ))
    local minutes=$(( seconds % 3600 / 60 ))
    if [ "$days" -gt 0 ]; then
        echo -n "${days}d${hours}h"
    elif [ "$hours" -gt 0 ]; then
        echo -n "${hours}h${minutes}m"
    else
        echo -n "${minutes}m"
    fi
}

# An optional strftime format appends the absolute reset time to the countdown.
usage_segment() {
    local label="$1"
    local percent="$2"
    local resets_at="$3"
    local reset_time_format="${4:-}"
    local color
    color=$(percent_color "$percent")

    local segment="${GRAY}${label}${NO_COLOR} $(progress_bar "$percent" "$color")${color}${percent}%${NO_COLOR}"
    if [ -n "$resets_at" ]; then
        local countdown
        countdown=$(format_countdown "$resets_at")
        if [ -n "$countdown" ]; then
            segment+=" ${GRAY}↻ ${countdown}"
            if [ -n "$reset_time_format" ]; then
                local reset_time
                printf -v reset_time "%(${reset_time_format})T" "$resets_at"
                segment+=" (${reset_time})"
            fi
            segment+="${NO_COLOR}"
        fi
    fi
    echo -n "$segment"
}

# Parse the session JSON
# ------------------------------------------------
# One jq pass emits every field joined by the unit separator, which (unlike a
# tab) keeps empty fields intact when split by read.
IFS=$'\x1f' read -r model effort context_percent context_used context_size \
    five_hour_percent five_hour_resets seven_day_percent seven_day_resets < <(
    jq -r '
        def num: if . == null then "" else round end;
        def tokens:
            if . >= 1000000 then "\(. / 100000 | round / 10)M"
            elif . >= 1000 then "\(. / 1000 | round)k"
            else tostring end;
        [
            .model.display_name // "",
            .effort.level // "",
            (.context_window.used_percentage // 0 | round),
            (.context_window.total_input_tokens // 0 | tokens),
            (.context_window.context_window_size | if . == null then "" else tokens end),
            (.rate_limits.five_hour.used_percentage | num),
            (.rate_limits.five_hour.resets_at | num),
            (.rate_limits.seven_day.used_percentage | num),
            (.rate_limits.seven_day.resets_at | num)
        ]
        | map(tostring)
        | join("\u001f")
    ' 2>/dev/null
)

# Build the status line
# ------------------------------------------------
model_segment="${BOLD}${model:-Claude}${NO_COLOR}"
if [ -n "$effort" ]; then
    model_segment+=" ${GRAY}·${NO_COLOR} $(effort_color "$effort")${effort}${NO_COLOR}"
fi
segments=("$model_segment")

if [ -n "$context_size" ]; then
    context_color=$(percent_color "$context_percent")
    segments+=("${GRAY}ctx${NO_COLOR} $(progress_bar "$context_percent" "$context_color")${context_color}${context_percent}%${NO_COLOR} ${GRAY}${context_used}/${context_size}${NO_COLOR}")
fi

if [ -n "$five_hour_percent" ]; then
    segments+=("$(usage_segment 5h "$five_hour_percent" "$five_hour_resets")")
fi
if [ -n "$seven_day_percent" ]; then
    segments+=("$(usage_segment 7d "$seven_day_percent" "$seven_day_resets" "$WEEKLY_RESET_FORMAT")")
fi

output="${segments[0]}"
for segment in "${segments[@]:1}"; do
    output+="${SEPARATOR}${segment}"
done
printf '%s\n' "$output"

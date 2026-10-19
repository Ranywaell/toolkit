#!/bin/bash
source "$(dirname "$0")/utils.sh"

bar_chart() {
    file=$1
    label_col=$2
    value_col=$3

    if [ ! -f "$file" ]; then echo "File not found: $file"; return 1; fi
    if ! is_positive_int "$label_col" || ! is_positive_int "$value_col"; then
        echo "Invalid column index"
        return 1
    fi

    labels=($(get_column_values "$label_col" "$file"))
    values=($(get_column_values "$value_col" "$file"))

    echo "BAR CHART"
    for i in "${!labels[@]}"; do
        v=${values[i]}
        if ! is_integer "$v" || [ "$v" -lt 0 ]; then
            echo "Invalid value for ${labels[i]}: $v"
            return 1
        fi
        bar=""
        n=$(( v / 2 ))
        [ "$n" -gt 0 ] && bar=$(printf '%*s' "$n" '' | tr ' ' '#')
        printf "%-10s | %s (%d)\n" "${labels[i]}" "$bar" "$v"
    done
}

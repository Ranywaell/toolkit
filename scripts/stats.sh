#!/bin/bash
source "$(dirname "$0")/utils.sh"

print_stats() {
    file=$1
    col=$2

    if [ ! -f "$file" ]; then echo "File not found: $file"; return 1; fi
    if ! is_positive_int "$col"; then echo "Invalid column index: $col"; return 1; fi

    total=0
    count=0
    max=""
    min=""

    for v in $(get_column_values "$col" "$file"); do
        if ! is_integer "$v"; then
            echo "Non-numeric value in column $col: $v"
            return 1
        fi
        total=$((total + v))
        if [ -z "$max" ] || (( v > max )); then max=$v; fi
        if [ -z "$min" ] || (( v < min )); then min=$v; fi
        count=$((count + 1))
    done

    if [ "$count" -eq 0 ]; then echo "No data found in column $col"; return 1; fi

    avg=$(awk -v t="$total" -v c="$count" 'BEGIN { printf "%.2f", t / c }')

    echo "Count : $count"
    echo "Sum   : $total"
    echo "Mean  : $avg"
    echo "Max   : $max"
    echo "Min   : $min"
}

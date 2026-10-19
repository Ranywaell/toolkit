#!/bin/bash

get_column_values() {
    col=$1
    tail -n +2 "$2" | cut -d',' -f"$col"
}

# Succeeds only if the argument is a positive integer (valid column index).
is_positive_int() {
    [[ "$1" =~ ^[1-9][0-9]*$ ]]
}

# Succeeds only if the argument is an integer (optionally negative).
is_integer() {
    [[ "$1" =~ ^-?[0-9]+$ ]]
}

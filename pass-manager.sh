#!/bin/bash

file="path/to/txtfile"

if [ $# -eq 2 ]; then
  echo "$1: $2" >>"$file"

elif [ $# -eq 1 ] && [ "$1" == "list" ]; then
  cut -d ':' -f 1 "$file"

elif [ $# -eq 1 ]; then
  result=$(grep "^$1:" "$file")

  if [ -n "$result" ]; then
    pass=$(echo "$result" | cut -d ':' -f 2- | xargs)
    echo "$1 pass is: $pass"
  else
    echo "$1 not found."
  fi

elif [ $# -eq 3 ] && [ "$3" == "change" ]; then
  result=$(grep "^$1:" "$file")

  if [ -n "$result" ]; then
    sed -i "s/^$1: .*/$1: $2/" "$file"
    echo "Changed $1's pass to: $2"

else
  exit 1
fi

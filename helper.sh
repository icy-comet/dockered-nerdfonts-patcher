#!/bin/sh

args=""

# Parse passed arguments
while [ "$#" -gt 0 ]; do
  # Ignore `-out` and `--outputdir` options
  if [ "$1" = "-out" ] || [ "$1" = "--outputdir" ]; then
    # Discard the arg
    shift
    # Handle the supplied path to this arg
    case "$1" in
      # Avoid discarding the next arg if no path supplied
      # Matches any text starting with a dash (-)
      -*) continue ;;
      # Discard the path if present
      *) shift $(($# > 0 ? 1 : 0)) ;;
    esac
    continue
  fi
  # show help msg & exit
  if [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
    args="$1"
    fontforge -script /patcher/font-patcher $args
    exit
  fi

  args="$args $1"
  shift

done


echo "Running with args:"
echo "$args"

find /in -type f -regex ".*.\(ttf\|otf\|woff\|eot\|ttc\)" -exec fontforge -script /patcher/font-patcher -out /out $args {} \;

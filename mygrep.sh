#!/bin/bash

show_help() {
  echo "Usage: ./mygrep.sh [options] search_string filename"
  echo "Options:"
  echo "  -n    Show line numbers"
  echo "  -v    Invert match"
  echo "  --help Show this help message"
}

if [[ "$1" == "--help" ]]; then
  show_help
  exit 0
fi

if [[ $# -lt 2 ]]; then
  echo "Error: Not enough arguments."
  show_help
  exit 1
fi

SHOW_LINE_NUMBERS=false
INVERT_MATCH=false

while [[ "$1" == -* ]]; do
  case "$1" in
    -n) SHOW_LINE_NUMBERS=true ;;
    -v) INVERT_MATCH=true ;;
    -vn|-nv) SHOW_LINE_NUMBERS=true; INVERT_MATCH=true ;;
    *) echo "Error: Unknown option $1"; show_help; exit 1 ;;
  esac
  shift
done

SEARCH_STRING="$1"
FILENAME="$2"

if [[ -z "$SEARCH_STRING" || -z "$FILENAME" ]]; then
  echo "Error: Missing search string or filename."
  show_help
  exit 1
fi

if [[ ! -f "$FILENAME" ]]; then
  echo "Error: File '$FILENAME' does not exist."
  exit 1
fi

GREP_OPTIONS="-i" 
if [[ "$SHOW_LINE_NUMBERS" == true ]]; then
  GREP_OPTIONS="$GREP_OPTIONS -n"
fi
if [[ "$INVERT_MATCH" == true ]]; then
  GREP_OPTIONS="$GREP_OPTIONS -v"
fi

grep $GREP_OPTIONS -- "$SEARCH_STRING" "$FILENAME"


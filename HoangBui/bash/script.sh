#!/bin/bash

# Function to display usage message
usage() {
    echo "Usage: ./script.sh [-v] [-h] [-f filename] [parameter1] [parameter2]"
}

# Function to display version
getver() {
    echo "Version: 1.1.1"
}

help() {
    getver
    usage
    echo "-v --version: display version"
    echo "-h --help: display help"
    echo "-f [filename]: display file"
    echo "parameter1 parameter2: it will be add"
}


# Default values for optional parameters
filename=""
version=false
help=false

#Get parameter
while [[ $# > 0 ]]
do
    case "$1" in
    -v|--version)
    version=true
    ;;
    -h|--help)
    help=true
    ;;
    -f|--file)
    filename="$2"
    shift
    ;;
    -*)
    usage
    exit 1
    ;;
    *)
    if [ $# -lt 2 ]; then
        usage
        exit 1
    fi
    param1=$1
    param2=$2
    shift
    ;;
    esac
    shift
done

# Check if the flags are set
if $help; then
    help
    exit 0
fi

if $version; then
    getver
    exit 0
fi

# Check file and display file

if [ -n "$filename" ]; then
    cat "$filename"
fi

# Perform some operations with the parameters
result=$((param1 + param2))
echo "Result: $result"
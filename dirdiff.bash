#!/bin/bash
#Serena Elzein

# Check if inputs arguments are
if [[ $# -ne 2 ]]; then
    echo "Error: Expected two input parameters."
    echo "Usage: $0 <originaldirectory> <comparisondirectory>"
    exit 1
fi

originalDir="$1"
comparisonDir="$2"

# Check if both input parameters are directories
if [[ ! -d "$originalDir" ]]; then
    echo "Error: Directory $originalDir not found or is not a directory."
    echo "Usage: $0 <originaldirectory> <comparisondirectory>"
    exit 2
fi

if [[ ! -d "$comparisonDir" ]]; then
    echo "Error: Directory $comparisonDir not found or is not a directory."
    echo "Usage: $0 <originaldirectory> <comparisondirectory>"
    exit 2
fi

# Check if the inputs are different directories
if [[ "$originalDir1" == "$comparisonDir" ]]; then
    echo "Error: The input directories are the same."
    echo "Usage: $0 <originaldirectory> <comparisondirectory>"
    exit 2
fi

# Base names of the input directories
dir1_base="$(basename $originalDir)"
dir2_base="$(basename $comparisonDir)"

# Check+record if differences were found
differences_found=false

# Iterate over the files in each directory
for file in $(ls -p "$originalDir"); do
    # Check if the file exists in the second directory
    if [[ -e "$comparisonDir/$(basename $file)" ]]; then
        # Compare the files to check if they are the same
        if ! diff -q "$originalDir/$file" "$comparisonDir/$(basename $file)" >/dev/null 2>&1; then
            echo "File $(basename $file) differs"
            differences_found=true
        fi
    else
        echo "File $(basename $file) is missing"
        differences_found=true
    fi
done

for file in $(ls -p "$comparisonDir"); do
    # Check if the file exists in the first directory
    if [[ ! -e "$originalDir/$(basename $file)" ]]; then
        echo "File $(basename $file) is missing"
        differences_found=true
    fi
done

# Check if differences were found
if [[ "$differences_found" = false ]]; then
    exit 0
else
    exit 3
fi

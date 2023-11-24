#!/bin/bash

# Bash script requirements:
# Create 25 empty (0 KB) files. 
# The file names should be <yourName><number>, <yourName><number+1>, <yourName><number+2>, and so on.
# Design the script so that each time it is run, it creates the next batch of 25 files with increasing numbers starting with the last or maximum number that already exists.
# Do not hard code these numbers. You need to generate them by using automation.
# Test the script. Display a long list of the directory and its contents to validate that the script created the expected files.

yourName="yourName"
directory="files_directory"

# Create directory if it doesn't exist
mkdir -p "$directory"

# Find the maximum number in the existing files
lastNumber=$(find "$directory" -maxdepth 1 -type f -name "${yourName}*" | grep -oE '[0-9]+' | sort -n | tail -n 1)

# If no existing files, start from 1
if [ -z "$lastNumber" ]; then
  lastNumber=0
fi

# Create 25 empty files with increasing numbers
for ((i = 1; i <= 25; i++)); do
  fileName="${yourName}$((lastNumber + i))"
  filePath="$directory/$fileName"
  touch "$filePath"
  
  # Append the creation date to the file
  echo "Created on: $(date)" >> "$filePath"
done

# Display a long list of the directory and its contents
find "$directory" -maxdepth 1 -type f -name "${yourName}*" | sort -V


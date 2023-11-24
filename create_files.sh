#!/bin/bash

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


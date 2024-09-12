#!/bin/bash

# File to monitor
FILE_TO_MONITOR="your_file.txt"
# Store the hash of the file in a temporary file
HASH_FILE=".file_hash"

# Generate the initial hash if the hash file doesn't exist
if [ ! -f "$HASH_FILE" ]; then
    md5sum "$FILE_TO_MONITOR" > "$HASH_FILE"
    echo "Monitoring started. Hash created for $FILE_TO_MONITOR."
    exit 0
fi

# Get the current hash and the old hash
OLD_HASH=$(cat "$HASH_FILE" | awk '{print $1}')
CURRENT_HASH=$(md5sum "$FILE_TO_MONITOR" | awk '{print $1}')

# Compare the two hashes
if [ "$OLD_HASH" != "$CURRENT_HASH" ]; then
    echo "File content has changed!"
    # Update the stored hash
    md5sum "$FILE_TO_MONITOR" > "$HASH_FILE"
else
    echo "No changes detected."
fi

#!/bin/bash

echo "Enter the drive path you want to wipe (e.g., /dev/sdb):"
read drive_path

if [[ ! -b "$drive_path" ]]; then
    echo "Invalid drive path. Please enter a valid block device path."
    exit 1
fi

echo "Enter the number of wipes (recommended is to do at least 10 to be safe):"
read num_wipes

if ! [[ "$num_wipes" =~ ^[0-9]+$ ]]; then
    echo "Invalid input. Please enter a valid number."
    exit 1
fi

for (( i=0; i<num_wipes; i++ )); do
    if (( i % 2 == 0 )); then
        echo "Wipe $((i+1)) using /dev/zero..."
        sudo dd if=/dev/zero of="$drive_path" bs=1M status=progress
    else
        echo "Wipe $((i+1)) using /dev/urandom..."
        sudo dd if=/dev/urandom of="$drive_path" bs=1M status=progress
    fi
done

echo "


Wiping completed."




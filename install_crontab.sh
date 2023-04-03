#!/usr/bin/env bash

if [ ! -f "$1" ] || [ ! -d "$2" ] || [ ! -d "$3" ]; then
    echo "Usage: $0 <backup_script> <project_dir> <local_backup_dir> [<remote_backup_dir>]"
    exit 1
fi

cmd="33 3 * * 1 $(realpath "$1") $(realpath "$2") $(realpath "$3")"
if [ -d "$4" ]; then
    cmd+=" $(realpath "$4")"
fi

file=$(mktemp)
file2=$(mktemp)
sudo crontab -u root -l > "$file"
echo "$cmd" >> "$file"
uniq "$file" >> "$file2"
cat "$file2"
sudo crontab -u root "$file2"
rm -f "$file" "$file2"

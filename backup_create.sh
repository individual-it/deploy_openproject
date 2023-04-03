#!/usr/bin/env bash

project_dir="$1"
local_backup_dir="$2"
remote_backup_dir="$3"
project_name="$(basename "$(dirname "$(realpath "$0")")")"

if [ ! -d "$project_dir" ] || [ ! -d "$local_backup_dir" ]; then
    1>&2 echo "Usage: $0 <project_dir> <local_backup_dir> [<remote_backup_dir>]"
    exit 1
fi

pushd "$project_dir" || exit

set -a
. ./.env
set +a

docker-compose stop

archive=${2}/backup_${project_name}_$(date '+%Y-%m-%d').tar.gz

tar -cf "$archive" "$project_dir"

docker-compose start

# https://unix.stackexchange.com/a/129600/237921
if ! tar -xOf "$archive" &> /dev/null; then
    ./send_email.py "${project_name} backup problem" "There was an error during ${project_name} backup."
fi

if [ -d "$remote_backup_dir" ]; then
    rsync "$archive" "$remote_backup_dir"
fi

popd || exit

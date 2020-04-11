#!/bin/bash

show_help(){
    echo "
dlyt.sh - downloads videos from YouTube

usage: dlyt.sh [-h] -l youtube-link -d download-directory
"
}

log(){
    echo "[$(date +"%Y-%m-%m %H:%M:%S")] $@"
}

VIRTUAL_ENV_PATH="/tmp/dlenv"

setup_env(){
    dependencies=(
        ffmpeg
        virtualenv
        python3
    )
    log "Checking for dependencies ${dependencies[@]}"
    for dep in  "${dependences[@]}"; do
        if ! command -v "$dep" &>/dev/null; then
            log "$dep not found. Please install $dep before continuing!"
            exit 1
        fi
    done
    log "Depencies met."
    virtualenv "$VIRTUAL_ENV_PATH" --python="$(command -v python3)"
    . "$VIRTUAL_ENV_PATH/bin/activate"
    pip install youtube-dl
}

actual_filename(){
    name="$1"
    name="${name%.*}"
    echo "$(find ./ -type f -name "$name.*")"
}

download_video(){
    dl_link="$1"
    dl_dir="$2"
    yt_dl="$(command -v youtube-dl)"
    log "Video to download: $link"
    dl_filename="$($yt_dl $dl_link --get-filename --restrict-filenames)"
    destination="$dl_dir/$dl_filename"
    log "Saving to file: $destination"
    if [[ -d "$dl_dir" ]]; then
        (
            cd "$dl_dir"
            log "Changed to $(pwd). Five-second sleep and initiating download"
            sleep 5
            "$yt_dl" "$dl_link" --restrict-filenames
            ffmpeg_path="$(command -v ffmpeg)"
            mp3_filename="${dl_filename%.*}.mp3"
            actual_downloaded_file="$(actual_filename "$dl_filename")"
            "$ffmpeg_path" -loglevel panic -i "$actual_downloaded_file" "$mp3_filename"
            rm -v "$actual_downloaded_file"
            rm -rf "$VIRTUAL_ENV_PATH"
        )
    fi
}

if (( $# == 0 )); then
    show_help;
    exit 1;
fi

while getopts "l:d:h" opt; do
    case "$opt" in
        "l")
            link="$OPTARG"
            ;;
        "d")
            dl_dir="$OPTARG"
            ;;
       "h")
            show_help;
            exit;
            ;;
        "*")
            show_help;
            exit 1;
            ;;
    esac
done
shift $((OPTIND-1))

setup_env
download_video "$link" "${dl_dir:-.}"

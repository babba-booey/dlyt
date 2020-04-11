# What is this?

dlyt is a simple wrapper script over youtube-dl, virtualenv, and ffmpeg


# What does this do?

The script does these things:
- Takes a YouTube URL
- Downloads the video
- Converts the downloaded video to mp3
- Removes the downloaded video

# How is the script invoked?

Here's how:

```
dlyt.sh - downloads videos from YouTube and converts them to mp3

usage: dlyt.sh [-h] [-d download-directory] -l youtube-link 
```

# What problem does this solve?

- I'm a bassist, and I use this program called Transcribe to slow down and listen to songs by ear. 
- Transcribe takes in MP3 files.
- This program downloads youtube files, converts them to mp3 for me, and lets me use them with Transcribe


# How do I make use of this file?

1. Clone this repository
2. `cd` into it
3. Execute these statements:
```
chmod +x ./dlyt.sh;
cp dlyt.sh /usr/local/bin/dlyt
```
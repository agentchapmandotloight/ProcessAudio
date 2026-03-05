#!/bin/bash
# You'll need FFmpeg to run the `process_audio.sh` script - install via `brew install ffmpeg`
# Example Usage:
# ./process_audio.sh hint1.wav

# Check if an audio file was provided
if [ $# -eq 0 ]; then
    echo "Usage: $0 <input_audio_file>"
    echo "Example: $0 hint1.wav"
    exit 1
fi

INPUT_AUDIO="$1"
# Extract filename without extension to name output
BASENAME=$(basename "$INPUT_AUDIO" | cut -d. -f1)
OUTPUT_IMAGE="${BASENAME}_spectrogram.png"

echo "Generating spectrogram for $INPUT_AUDIO..."
ffmpeg -i "$INPUT_AUDIO" -lavfi showspectrumpic=s=800x400:mode=separate "$OUTPUT_IMAGE"

if [ $? -eq 0 ]; then
    echo "Success! Spectrogram saved as $OUTPUT_IMAGE"
else
    echo "Error generating spectrogram."
fi

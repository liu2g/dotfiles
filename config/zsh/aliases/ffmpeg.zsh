# FFmpeg aliases
alias ffmpeg="ffmpeg -hide_banner"
alias ffprobe="ffprobe -hide_banner"
alias ffplay="ffplay -hide_banner"

ffcompress () {
    filename=$(basename -- "$1")
    extension="${filename##*.}"
    filename="${filename%.*}"
    if [ -z "$2" ]; then
        outfile="${filename}_compressed.${extension}"
    else
        outfile="$2"
    fi
    ffmpeg -hide_banner -i "$1" -vcodec libx264 -crf 20 "${outfile}"
}

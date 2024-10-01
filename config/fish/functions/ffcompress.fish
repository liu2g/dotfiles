function ffcompress --description 'Compress a video file using FFmpeg'
    argparse 'f/file=' 'r/resolution=' 'c/crf=' -- $argv

    # parse file
    if not set -q _flag_file
        echo "Usage: ffcompress -f <file> [-r w:h] [-c <crf>]"
        return 1
    end
    set infile (basename -- "$_flag_file")
    set name (string replace -r '\.[^.]*$' '' -- "$infile")
    set extension (string match -r '\.[^.]*$' -- "$infile")
    set outfile "$name"_compressed"$extension"

    # parse resolution
    if set -q _flag_resolution
        set resolution "scale=$_flag_resolution"
    else
        set resolution "scale=-1:-1"
    end

    # parse crf
    if set -q _flag_crf
        set crf "$_flag_crf"
    else
        set crf "20"
    end

    ffmpeg -hide_banner -i "$_flag_file" -vcodec libx264 -vf $resolution -crf $crf "$outfile"
end
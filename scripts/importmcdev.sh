set -euo pipefail
        sed 's/\r$//' "$base" > "$target"
(
    files=$(cat "$basedir/patches/server/"* | grep "+++ b/src/main/java/net/minecraft/server/" | sort | uniq | sed 's/\+\+\+ b\/src\/main\/java\/net\/minecraft\/server\///g' | sed 's/.java//g')
    # Maybe "create mode " is correct here, probably not though
    nonnms=$(grep -R "new file mode" -B 1 "$basedir/patches/server/" | grep -v "new file mode" | grep -oE "net\/minecraft\/server\/.*.java" | grep -oE "[A-Za-z]+?.java$" --color=none | sed 's/.java//g')

    for f in $files; do
        containsElement "$f" ${nonnms[@]}
        if [ "$?" == "1" ]; then
            if [ ! -f "$basedir/Paper/Paper-Server/src/main/java/net/minecraft/server/$f.java" ]; then
                if [ ! -f "$decompiledir/$nms/$f.java" ]; then
                    echo "$(bashColor 1 31) ERROR!!! Missing NMS$(bashColor 1 34) $f $(bashColorReset)";
                else
                    import $f || exit 1
                fi
    done
) || true

)
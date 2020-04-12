# Copied from https://github.com/PaperMC/Paper/blob/089d83568b6876cd01eacdbe49aba34e14336ccf/scripts/importmcdev.sh
# License from Paper applies to this file
(
set -e
basedir="$(cd "$1" && pwd -P)"
source "$basedir/scripts/functions.sh"
gitcmd="git -c commit.gpgsign=false"
echo "Importing mc-dev files..."

workdir="$basedir/Paper/work"
minecraftversion=$(cat "$basedir/Paper/work/BuildData/info.json" | grep minecraftVersion | cut -d '"' -f 4)
decompiledir="$workdir/Minecraft/$minecraftversion/spigot"
    file="$1.java"
    cd "$basedir/Paper/Paper-Server/"
    lastlog=$($gitcmd log -1 --oneline)
        $gitcmd reset --hard HEAD^
# Maybe "create mode " is correct here, probably not though
########################################################
########################################################
########################################################
#                   NMS IMPORTS
# Temporarily add new NMS dev imports here before you run paper patch
# but after you have paper rb'd your changes, remove the line from this file before committing.
#
# import FileName


# TODO figure out what and why this is here
    cd "$basedir/Paper/Paper-Server/"
    $gitcmd add src -A
    echo -e "$FORK_NAME-Extra mc-dev Imports\n\n$MODLOG" | $gitcmd commit src -F -
# This last echo is needed so the script doesn exit 1 and crash
echo "Import mc-dev finished"
) || exit 1
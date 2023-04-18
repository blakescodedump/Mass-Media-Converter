#!/bin/bash

main() {
    echo "" #Welcome Message
    echo "Welcome to Mass Media Converter, a bash script that converts media in bulk using FFMPEG."
    echo "WARNING: FFMPEG needs to be installed for this script to function properly."
    echo ""
    if hash ffmpeg 2> /dev/null #Checks if ffmpeg is installed.
    then #Asks a bunch of questions regarding bulk conversion.
        echo "Type your input file extension, and be sure to include the . at the beginning."
        read -r inputff
        echo ""
        echo "Type your output file extension, and be sure to include the . at the beginning."
        read -r outputff
        echo ""
        echo "Which directory do you want to do this in? (Don't add quotes around spaced words)"
        read -r dir
        echo ""
        echo "Do you want the old files deleted? [y/N]"
        read -r del
        echo "" #Verifies if everything was correct.
        echo "You want to convert all" "$inputff" "files in" "$dir" "to" "$outputff" "files."
        echo "Delete Old Files set to:" "$del""."
        echo "Is this correct? [y/N]"
        read -r confirm
        wkdir=$(pwd)
        cd "$dir" || exit
        if [ "$confirm" == y ] || [ "$confirm" == Y ] #Checks for yes or no for confirmation.
        then
            for f in *"$inputff" #Loops for all files in a directory.
            do
                    ffmpeg -i "$f" -vn "$(basename "$f" "$inputff")""$outputff""" #Bulk converts the files.
                if [ "$del" == y ] || [ "$del" == Y ] #Checks if you want to delete the old files.
                then
                    rm "$f" #Deletes all old files.
                fi
            done
            cd "$wkdir" || exit #Goes back to working directory.
            echo ""
            echo "If there are no errors, the operation was successful."
            exit
        else
            main #Restarts the questions if you aren't sure.
        fi
    else
        echo "" #Shows message and stops script if ffmpeg isn't found.
        echo "FFMPEG could not be found. Stopping."
        exit
fi
}

main #Just calls the main function.
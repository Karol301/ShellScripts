#!/bin/bash
#
#This script is printing up to 10 files per type with their names and sizes. 
#If the directory does not exist or no argument is provided, it shows an error message.
#
if [ $# -eq 1 ]; then
        if [ -e "$1" ]; then
                txt_files=0
                sh_files=0
                log_files=0

                txt_header_printed=0
                sh_header_printed=0
                log_header_printed=0

                echo "Direcotry to sort: $1"
                for file in "$1"/*; do
                        if [ -f "$file" ]; then
                                if [[ "$file" == *.txt ]]; then
					if [ $txt_files -ge 10 ]; then
        					continue
    					fi
					if [ $txt_header_printed -eq 0 ]; then
                                                echo "Text files"
                                                txt_header_printed=1
                                        fi
                                        echo "File name: $(basename "$file") | Size: $(ls -l "$file" | cut -d' ' -f5) bytes"
					((txt_files++))
                                fi
                                if [[ "$file" == *.sh ]]; then
                                	if [ $sh_files -ge 10 ]; then
                                                continue
                                        fi
					if [ $sh_header_printed -eq 0 ]; then
                                                echo "Shell script files"
                                                sh_header_printed=1
                                        fi
                                        echo "File name: $(basename "$file") | Size: $(ls -l "$file" | cut -d' ' -f5) bytes"
                                        ((sh_files++))
                                fi
                                if [[ "$file" == *.log ]]; then
                                	if [ $log_files -ge 10 ]; then
                                                continue
                                        fi
					if [ $log_header_printed -eq 0 ]; then
                                                echo "Logs files"
                                                log_header_printed=1
                                        fi
                                        echo "File name: $(basename "$file") | Size: $(ls -l "$file" | cut -d' ' -f5) bytes"
                                        ((log_files++))
                                fi
                        fi
                done
        else
                echo "Directory which you provided doesn't exist"
        fi
else
        echo "You didn't provide a directory to sort"
fi


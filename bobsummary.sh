#!/bin/bash

# Check if a file name was provided as a command line argument
if [ $# -eq 0 ]; then
  echo "Usage: $0 <pdf_file_to_split_and_summarize>"
  exit 1
fi

# Create the summary directory if it doesn't exist yet
#filename=/home/john/Desktop/file.sh
# basename "${filename%.*}"
[ ! -d ./summary ] && mkdir -p summary

# Convert the PDF file to a single text file
pdftotext "$1" original.txt

# Split the text file into multiple files with no more than 1000 words/lines/bytes? each
# I think split is better instead of csplit regex
# csplit --prefix=csplit --digits=4 original.txt "/a-zA-Z /" "{100}"
# csplit --prefix=csplit --keep-files --digits=4 original.txt '/cat/' '{100}' 
# csplit input-file.txt '/([\w.,;]+\s+){500}/' ??????
# none of these seem to work for word counts. may have to estimate using the number of lines
# split --additional-suffix=.txt --suffix-length=4 --numeric-suffixes=1 --bytes 2000 original.txt summary/original_
split --additional-suffix=.txt --suffix-length=4 --numeric-suffixes=1 --lines 10 original.txt summary/original_

echo "Summary files created in summary directory."

echo "creatings summaries for $0..." 
# iterate through split original files and generate a split summary file
for FILE in ./summary/original_*.txt; 
do
  base_file_name=$(basename "$FILE")
  base_directory=${FILE%/*} # Get the base directory
  echo  "processing $base_directory/$base_file_name"
  echo "For the following text create a summary:\n" | cat - $FILE | cat - >"./$base_directory/summary_$base_file_name"
  # echo "chatgpt split summary completed for $FILE with return code $?"
done

echo "ALL DONE" 
#reassemble logic for summaries...
#ls orig*.txt | sort -n  | xargs cat > x.txt


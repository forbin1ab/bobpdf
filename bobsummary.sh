#!/bin/bash

# Check if a file name was provided as a command line argument
if [ $# -eq 0 ]; then
  echo "Usage: $0 <pdf_file_to_split_and_summarize>"
  exit 1
fi

# Create the summary directory if it doesn't exist yet
[ ! -d ./summary ] && mkdir -p summary

# Convert the PDF file to a single text file, save in top directory for now??
pdftotext "$1" original.txt

# Split the text file into multiple files with no more than 50 words/lines/bytes? each
# TODO need better splitting logic based on words NOT lines
split --additional-suffix=.txt --suffix-length=4 --numeric-suffixes=1 --lines 50 original.txt summary/original_
echo "Chunked sequential files of original created in summary directory."

echo "creatings summaries for $0..." 
# iterate through split sequential original files and generate split sequential summary files
for FILE in ./summary/original_*.txt; 
do
  # may need throttling logic to deal with sgpt rate limiting
  base_file_name=$(basename "$FILE")
  base_directory=${FILE%/*} # Get the base directory
  echo  "processing $base_directory/$base_file_name"
  # fix line below to call sgpt instead of 2nd cat we are using to simulate
  echo "For the following text create a summary:\n" | cat - $FILE | cat - >"./$base_directory/summary_$base_file_name"
  # echo "For the following text create a summary:\n" | cat - $FILE | sgpt - >"./$base_directory/summary_$base_file_name"
  # echo "chatgpt split summary completed for $FILE with return code $?"
done

echo "ALL DONE" 
#TODO reassemble logic for summaries...
#ls orig*.txt | sort -n  | xargs cat > x.txt

# Prompt used to create template
create a bash shell script called bobsummary.
The bash shell script does the following: 
Using the name of the pdf file provided as a command line argument first convert this into one large text file named summary.txt.
Then split this file into multiple sequentially numbered text files with each file containing no more than 1000 lines as determined by using wc command. These should also be placed in the summary directory.
For each of the sequentially numbered text files use the linux touch command on them.

# Description
converts a pdf file provided as a parameter to one big text file 
then uses a linux command to break the text file into smaller text files
uses chatpgt to create summary files for each of the smaller text files
concantenate summary files?

# Bash syntax notes
$var substitutes var with string variable var
This substitution occurs in "" strings but does NOT occur in '' strings
Note try to use "" where ever possible since weird stuff can happen in strings that have embedded spaces or other chars if you dont...
If your substitution variable butts up against another literal use {} as in {$file}_old.txt
$() is command substitution and takes stdout of prog and inserts it as string, can also use backticks``
  eg. mkdir $(seq 1 5) # makes dirs 1-5
  eg. a=$(echo 'hello' | tr '[:lower:]' '[:upper:]')
  Note that trailing newlines get eliminated
$(( )) is used for basic math
  eg. echo "42 - 10 is...$(( 42 - 10))"
 The global variable IFS is what Bash uses to split a string of expanded into separate words



# Usage
./bobsummary mydocument.pdf

# Notes/TODO/problems
note that this WILL NOT work if pdf is comprised of pages of scanned images
may have to user ocrmypdf to convert to pdf text and then pdftotext to convert this file to text file???

no easy way to split on word count. using line count for now

free version of chatgpt openai is rate limited? or down a lot? Add some sort of delay and run at night?

investigate using the following code with wc to split files better

```
#!/bin/bash

if [ $# -ne 1 ]; then
  echo "Usage: $0 <filename>"
  exit 1
fi

filename=$1
line_count=0
word_count=0
file_count=1

while read line; do
  echo $line >> file_$file_count.txt
  line_count=$((line_count+1))
  words=$(echo $line | wc -w)
  word_count=$((word_count+words))
  if [ $line_count -eq 100 ]; then
    echo "File file_$file_count.txt has 100 lines and $word_count words."
    line_count=0
    word_count=0
    file_count=$((file_count+1))
  fi
done < $filename

if [ $line_count -gt 0 ]; then
  echo "File file_$file_count.txt has $line_count lines and $word_count words."
fi
```

potential logic for sequence numbers
'''
    if [ -f "$file" ]; then
        # Get the file extension
        extension="${file##*.}"
        # Generate the new filename with the 4-digit sequence number
        new_filename="$(printf "%04d" $seq).${file%.*}.${extension}"
        # Rename the file
        mv "$file" "$new_filename"
        # Increment the sequence number
        seq=$((seq+1))
    fi
'''


# Environment prep
Need pdftotext which is in poppler-utils

```
sudo apt update && sudo apt upgrade
sudo apt install poppler-utils split
```

There are several openai chatgpt command line tools available. 
We are going to try ShellGPT
https://www.makeuseof.com/use-chatgpt-from-ubuntu-terminal-using-shellgpt/

These commands setup a virtual environment off of your home directory, switches to it and installs sgpt 

```
sudo apt install python3-venv -y # on windows might need to change this to 3.10 version
# create virtual environment in our home directory
python3 -m venv ~/shellgpt-env
#activate it
source ~/shellgpt-env/bin/activate
# install shellgpt so that we can get sgpt command
pip3 install shell-gpt
```

Need API key that you generated at openai to be setup in environment variable
Note that when generating key you will be shown it ONCE. Save it somewhere safe. The name you give it does not matter.
```
# create environment variable to hold api key so that sgpt can authenticate whenever it executes
export OPENAI_API_KEY=your very long api key that you copied from openai 
# you may want to put this in ~/.bashrc so that it is always set on terminal startup
# you can use env command to see it was set properly
env
```




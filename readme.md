# Prompt
create a bash shell script called bobsummary.
The bash shell script does the following: 
Using the name of the pdf file provided as a command line argument first convert this into one large text file named summary.txt.
Then split this file into multiple sequentially numbered text files with each file containing no more than 1000 lines as determined by using wc command. These should also be placed in the summary directory.
For each of the sequentially numbered text files use the linux touch command on them.

# Instructions
convert a pdf file provided as a paramert an input file nameto one big text file 
then use a linux command to break the
note that this WILL NOT work if pdf is comprised of pages of scanned images
may have to user ocrmypdf to convert to pdf text and then pdftotext to convert this file to text file???



./bobsummary mydocument.pdf

# Environment prep
Need pdftotext which is in poppler-utils
```
sudo apt update && sudo apt upgrade
sudo apt install poppler-utils split

```

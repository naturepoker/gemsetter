#!/usr/bin/env bash


#Declaring some variables:

input_post=$1
gem_title=$2
gem_desc=$3
gem_tags=$4
gem_date=$(date +%F)


#Command line help parameter as a function

help()
{
	echo "Welcome to the gemsetter script help"
	echo "	"
	echo "You can use the gemsetter script with below parameters"
	echo "	"
	echo "./gemsetter.sh new-gemlog-file gemlog-title-in-quotes description-in-double-quotes comma-separated-tags-in-double-quotes"
	echo "	"
	echo "The script will format and copy the new post into ./gemset/gemlog directory"
	echo "and update the main index.gmi file in ./gemset with a link, date stamp and the description"
	echo "Please make sure your gemlog posts end in the .gmi extension!"
	echo "	"
}


#Using getopts command to look for -h tag

while getopts ":h" option; do
	case $option in
		h) # display Help
			help
			exit;;
	esac
done


#Checking for gemset directory at the current location and creating one if not found
#If gemset directory isn't found, the script will create a helper index.gmi file with examples of gemini formats

if [ -d "./gemset" ]
then
	echo "gemset directory found. Updating index.gmi with the new post and description"
else
	echo "gemset directory not found"
	echo "A gemset directory will be created with a template index.gmi"
	echo "Once the directory is created, please run the script again with your post!"
	mkdir gemset
	cd gemset/
	touch index.gmi
	echo "	" > index.gmi
	echo "Welcome to the gemsetter blank index!" >> index.gmi
	echo "======================================" >> index.gmi
	echo "	" >> index.gmi
	echo "#Header" >> index.gmi
	echo "	" >> index.gmi
	echo "##Sub header" >> index.gmi
	echo "	" >> index.gmi
	echo "Here's how we can format a list:" >> index.gmi
	echo "	" >> index.gmi
	echo "*gemini" >> index.gmi
	echo "*jupiter" >> index.gmi
	echo "*mars" >> index.gmi
	echo "	" >> index.gmi
	echo "And we can link with:" >> index.gmi
	echo "=> gemini://sweet.url Nice gemini capsule!" >> index.gmi
	echo "	" >> index.gmi
	echo "Block quote is done through:" >> index.gmi
	echo "> This is a gem capsule blockquote" >> index.gmi
	echo "	" >> index.gmi
	exit
fi


#Compiling the gemini link structure for the gemlog post, to be placed on the bottom of the index.gmi file
#Don't forget to swap out the your-url-and-dir portion in line with whatever the hosting solution in use

gem_link=$(echo $input_post | sed 's/^/=> */g' | sed 's/*/gemini:\/\/your-url-and-dir\/gemlog_/g' | sed "s/$/ $gem_date/g" | sed "s/$/ $gem_desc/g")
cd gemset
echo $gem_link >> index.gmi
cd ..

#gemlog content formatting
#Header portion with title, tags and post date

touch header.tmp
echo "#" $gem_title > header.tmp
echo "###" $gem_desc >> header.tmp
echo "### tags:" $gem_tags >> header.tmp
echo "###" $gem_date >> header.tmp
echo "  " >> header.tmp
echo "  " >> header.tmp

#Footer portion with end format and CC-BY-SA 4.0 license
touch footer.tmp
echo "  " > footer.tmp
echo "  " >> footer.tmp
echo "_________" >> footer.tmp
echo "###CC-BY-SA 4.0" >> footer.tmp
echo "  " >> footer.tmp

cat header.tmp ${input_post} footer.tmp > gemlog_$input_post
mv gemlog_${input_post} ./gemset
rm *.tmp


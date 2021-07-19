# gemsetter

Bash based tool for formatting gemlog posts with an index file. Produces date-coded, tagged posts linked to the main index file. The script is intended for people who live in the commandline, and intends to use built in 'nix system tools to organize and write their gem capsule content i.e. below comment would get you a comma separated list of all tags used across your gemlogs, which can be used with any number of other downstream processes.  

```
find . -type f -name "*.gmi" | xargs grep "tags:" | cut -d ':' -f 3-
```

When the script is run for the first time, it will create a gemset directory with a template index.gmi file- which currently simply lists the markdown-like syntax with some examples. The expectation is for the users to write and format their own index file. Running the gemsetter script after the index file has been formatted will produce date marked, tagged headers for both the individual gemlog .gmi and a link to them on the main index page. 

There is a section in the code where the writer needs to write in a sed friendly url format, which would have to depend on whatever the hosting solution in use. This part will simply determine formatting of the link leading to gemlog posts at the bottom of the index file. 

An example usage scenario is (also available for review with ./gemsetter -h) :

```
./gemsetter.sh newpost.gmi "New post title" "Short description for the new post" "comma,separated,list,of,tags,for,the,post"
```

Default setting will add a following header to the top of the post

```
# Title provided as an argument with the script
### Description provided as an argument with the script
### tags: comma,separated,tags,as,argument
### date-mark
```

And the following footer to the end of the post

```
_________
###CC-BY-SA 4.0
```

The final result will be an index file and gemlog posts in the gemset directory, with gemlog posts appended with prefix "gemlog_" for later archiving or processing. 

---
layout: page
title: Basic Linux commands
description: Basic Linux commands
---

Using the computer clusters requires familiarity with basic Linux commmands. 
After logging into your cluster account, you are facing a 
<a href="http://en.wikipedia.org/wiki/Unix_shell">Linux shell</a>, 
which takes commands and performs certain tasks. 
If you have been used to a graphical point-click interface this might seem daunting.
However once you get familiar with the commands you'll find it
extremely powerful and convenient. I think there are only 
20 or so important commands one needs to know in order to perform
most of the tasks. Here is a list of them with VERY brief explanations.
Each of these commands takes tons of options, but only
a few of them are frequently used. For more detailed 
explanations please refer to the manual pages. 

- **man**: to get help for a command. This is short for `manual`.
For example to get the complete help page for `ls` command, type
`man ls` at the command line. 

- **ls**: get a list of the directory contents. Most common option is `ls -l`, which list the contents in long format 
(one line per item showing file modes, owner, time accessed, size, etc). 
Other options I often use are `ls -rtl`, which list files in 
long format and sorted by time 
with the latest file at the bottom, and `ls -rSl`, 
which list files in long format and sorted by size with the largest file at the bottom. 

- **cp**: copy files. Typical usage is 
`cp source_dir/source_file target_dir/target_file`.
An frequently used option is `-r`, which copies 
directories. For example, 
`cp -r * target_dir/</tt>` copies all contents including 
sub directories into folder named `target_dir`.


- **scp**: secure copy files from/to a remote file system (such as the cluster).
For example, 
``scp source_file hwu30@cluster.sph.emory.edu:~``
copies `source_file` to the home directory of user `hwu30` at 
`cluster.sph.emory.edu`. Conversely, 
``scp -r hwu30@cluster.sph.emory.edu:~/* target_dir``
copies everything in <tt>hwu30</tt>'s home directory at 
<tt>cluster.sph.emory.edu</tt> to local directory <tt>target_dir</tt>.
Note that <tt>scp</tt> and <tt>cp</tt> share many parameters.

<li><b><tt>mv</tt></b>: move/rename files. 
Typical usage is 
<ul><tt>mv source_dir/source_file target_dir/target_file</tt></ul>
Differences between cp and mv are (1) after "<tt>mv</tt>" the source file will 
be deleted, and (2) time stamp for the source file will be perserved 
in the target file.

<li><b><tt>rm</tt></b>: remove (delete) files. <tt>rm target_dir/target_file</tt>.
This should be used in caution because usually one cannot undelete a file or folder
once they are rm'ed. Frequently used option is "<tt>-r</tt>" for removing a directory. 

<li><b><tt>mkdir/rmdir</tt></b>: make/remove directories. For example 
<tt>mkdir dir1</tt> makes a subdirectory called "dir1" in current directory.
<tt>rmdir</tt> can only delete an empty directory. 
To delete a directory with contents use "<tt>rm -r</tt>".

<li><b><tt>cd</tt></b>: change directory. For example: <tt>cd dir1/subdir2/subsubdir3/</tt>.

<li><b><tt>pwd</tt></b>: shows the path of current directory.

<li><b><tt>more/less</tt></b>: to view a text file. This is extremely useful in viewing
large text files for that they don't open and load the whole file into memory,
which makes it very fast. <tt>more</tt> and <tt>less</tt> are pretty similar, 
you can pick one your like. Within the program some useful commands are:
<ul>
<li>space: go one page down.
<li><tt>b</tt>: go one page up.
<li><tt>/pattern</tt>: search for <tt>pattern</tt> in the text file.
<li><tt>q</tt>: quit to the shell.
</ul>


<li><b><tt>head/tail</tt></b>: to show the start or end a few lines of a text file. 
For example "<tt>head -5 file.txt</tt>" shows the first 5 lines of file.txt.

<li><b><tt>wc</tt></b>: counting number of words and lines of a file. 
For example if "<tt>wc file.txt</tt>" returns 
<ul><tt>25700  777244 8974608 file.txt</tt></ul>
It means file.txt has 25700 lines, 777244 words and 8974608 bytes.

<li><b><tt>zip/unzip</tt></b>: To compress/expand files. 
Typical usage is 
<ul><tt>zip target.zip *.txt</tt>,</ul> 
which compresses all txt files into one zip file called <tt>target.zip</tt>.
To extract them type <tt>unzip target.zip</tt>.

<li><b><tt>gzip/gunzip</tt></b>: To compress/expand files. 
gzip can only compress one file at a time, that's why 
it's always used with <tt>tar</tt>, which concatenate multiple files 
into one (without compressing). For example, 
<tt>gzip file.txt</tt> generates <tt>file.txt.gz</tt> and deletes 
the original <tt>file.txt</tt>. To decompress, simply
type <tt>gunzip file.txt.gz</tt>. 

<li><b><tt>tar</tt></b>: manipulate tar balls (one big file contains many little files).
There's no compulsive reason of creating a <tt>tar</tt> if one can use <tt>zip</tt>
in these days. However very often the Linux based software are distributed as .tar.gz
files, which is a gzipped tar ball. It's useful to know how to extract the whole thing,
which is <tt>tar xvfz software.tar.gz</tt>. 

<li><b><tt>du</tt></b>: display disk usage. For example 
"<tt>du -h</tt>" shows total disk usage in current directory. 
If there are many subdirectories it will print out a long list 
of usages. In this case "<tt>du --max-depth=1 -h</tt>"
is useful, which only shows one level down of the subdirectories.

<li><b><tt>grep</tt></b>: look for pattern matching from files. 
"<tt>grep apattern *.txt</tt>" searches for all txt files in current directory
and show the lines containing "apattern". 
"<tt>grep</tt>" is a complicated command taking tons of options. 
"<tt>grep</tt>" is a  very powerful command (100 times better than the little dog in Windows!)
if you know how to use it. For example:
<tt>grep -r --include="*.R" apattern *</tt> recursively searches all R files 
under current directory (including all subdirectories) looking for lines with "apattern". 
The search pattern takes 
<a href="http://en.wikipedia.org/wiki/Regular_expression">
regular expression</a>.

<li><b><tt>find</tt></b>: find file(s) within a directory and all sub-directories. For example, if I want to find all R files in a directory, I can do
``
find . -name "*.R"
``

</ol>


### Other useful tips on a linux system
<ul>
<li>Press "TAB" key to complete the name of a command, a file or a directory when typing. 
For example is there is a file called "reallylongfilename.txt". You can type in "really"
(or the first a few letters) then press TAB, and the file name will be completed automatically.
<li>Press up/down arrow one can find previously typed commands in terminal.
<li>By default the terminal takes Emacs hotkeys: Ctrl-A moves the cursor  to the beginning of line, 
Ctrl-E moves to the end of the line, Ctrl-R searches commands backward, etc. Once you get used to
this you will find it extremely convenient. 
<li>Using greater than signs ("<tt>></tt>") can write the standard output 
(things printed on the screen) to a file. 
For example, "<tt>ls -l > dirls.txt</tt>" writes the directory listing to
a file named "<tt>dirls.txt</tt>".
This with less than sign ("<tt><</tt>") and vertical bars ("<tt>|</tt>")
are used in the powerful Linux 
<a href="http://en.wikipedia.org/wiki/Redirection_(computing)#Piping">piping</a>,
which means the output from one process becomes the input of another one. 
<li>Descriptions of some other useful (but a little advanced) commands 
(xargs, awk, cut, sort, sed) can be found at 
<a href="http://lh3lh3.users.sourceforge.net/biounix.shtml">here</a>.
</ul>

That's it! I suggest you buy a 
<a href="http://www.thinkgeek.com/tshirts-apparel/xkcd/dabb/">
Linux cheat shirt</a>, which will greatly help memorizing these commands.
<p>


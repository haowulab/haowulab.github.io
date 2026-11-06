---
layout: page
title: Schedule for week 2
---

### Homework

For the homework, you need to submit two files: a markdown file named homework2.md, and an R file named  homework2.R. 

In **homework2.md**, answer following questions: 

- Describe the meaning of median and variance, using your own word. 
- What's the difference between list and data frame in R?
- Show the R codes and figures you generated for histogram, boxplot, barplot, and scatter plot. 
- Provide a brief summary of the COVID-19 data set. 
	- What information does it contain? 
	- How many rows and columns are there? 
	- How many countries does it have? 
	- How many days does it have? 
 

In **homework2.R**:

1. Compute the mean, median, variance, and standard deviation of integers from 1 to 10.
2. Take a look at the `mtcars` data in R. It is a dataset came with R. Just type `mtcars` in R. Type `?mtcars` in R to read the description of the data. Then do the following
	- What is the class of `mtcars`, i.e., is it a data frame or matrix? 
	- Convert `mtcars` into a matrix. 
	- Take out all the numbers for `Lincoln Continental` from the matrix. 
	- How many horsepowers does `Honda Civic` have? 
	- How many cars have horsepowers greater than 100? What are they? 
	- How many cars have automatic transmission? What are they? 
3. Run following code to create a list 

	```
	family1 = list(husband="Fred", wife="Wilma", numofchildren=3,
					agesofkids=c(8,11,14))
	```
	- How many fields are there in the list?
	- What are the names of the fields?
	- Take out the `agesofkids` field from the list, using at least 2 different methods. 
	- Produce a vector out of the list, using `unlist` function.
	- Add the following two new fields to the list: `numofcar=2`, `ageofcar=c(5, 10)`. Note you cannot recreate the list, rather you need to append these fields to the existing list.               
	
4. Practice using R base graphics to generate histogram, boxplot, barplot, and scatter plot. We will use the `mtcars` data in R for these tasks. 
	- Make histogram for horsepowers for all cars. Use different numbers of breaks to see the difference in appearences. Use a meaningful figure title.
	- Make side-by-side boxplot for horsepowers vs. number of cylinders. 
	- Make side-by-side boxplot for mpg vs. number of cylinders. 
	- Compute the number of cars with different number of cylinders. Hint: you need to use the `table` function. Use barplot to show the results. 
	- Make scatterplot between mpg and horsepowers. Use meaningful figure title and x-/y-axis labels. Try to play with different styles of figures by changing point types, colors, etc. 
	- In the above scatterplot between mpg and horsepowers, use different colors and point type for cars with different number of cylinders. Can you see any pattern from the figure? 
	- Save all figures you made in pdf of size 5x5 inches. 
	
5. Read the [COVID-19 data](data/covid_19_clean_complete.csv) into R as a data frame. Conduct explorative analysis of the data, and answer questions listed for homework2.md. 

***

### A small project - to analyze the match results for the "Big three" tennis players


The Wimbledon final will be played tomorrow (July 11, 2021). Novak Djokovic will chase his 20th Grand Slam title, tying Rafeal Nadal and Roger Federer. With the continous debate on who's the GOAT tennis player, we will analyze the career tennis match results from these big three. 

First, obtain the career match results for the three players from the links below. These are csv files I downloaded from [https://www.ultimatetennisstatistics.com](https://www.ultimatetennisstatistics.com). These are results until July 7, 2021.

- [Federer career results](data/Federer_career_results.csv)
- [Nadal career results](data/Nadal_career_results.csv)
- [Djokovic career results](data/Djokovic_career_results.csv)

Secondly, read these files into R as data frames (using the `read.csv` function). Carefully examine the data frame to get familiar with the content of the data, such as the column names and their meanings. 

Write codes to answer following questions, from easy to difficult

1. Compute the career winning percentage for each player. 
2. Compute the career winning percentage for each player at the grand slams. **Note**: you need to first extract the rows for grand slam matches.
3. Compute the career winning percentage for each player at the grand slams for each year. **Note**: This can be tricky. You can do it for each year seperately (the lazy approach), or write a loop (a little better). More advanced and cleaner way is to use functions in `dplyr` package. You can google `conditional means dplyr` for that if interested.  
4. Compute the head-to-head winning percentage among the big three. 
5. Compute the head-to-head winning percentage among the big three in each year. There might be years that they don't play each other. Maybe a better way to do this is to compute their head-to-head winning percentage at every 5-year interval.
6. Compute the head-to-head winning percentage among the big three in grand slams. 
7. Compute the head-to-head winning percentage among the big three in grand slams at every 5-year interval. 
8. I'm also interested in their records against other players.  Summarize and compare that in some interesting and intuitive way. For example, by some manual search on atptour.com, I found that against Stan Wawarinka, Nadal is 19-3, Federer is 23-3, Djokovic is 19-6. You can generate these numbers for all their opponents. 


After obtaining all these results, interpret them in an intuitive way. Present the results using tables, figures, and language. Write an article about your analyses. 


***

### Day 1: Review, basic statistics
- [https://www.guru99.com/r-data-types-operator.html](https://www.guru99.com/r-data-types-operator.html)
- [http://www.sthda.com/english/wiki/easy-r-programming-basics](http://www.sthda.com/english/wiki/easy-r-programming-basics), the first 7 sections (up to **Factors**)
- Review R matrix [https://www.guru99.com/r-matrix-tutorial.html](https://www.guru99.com/r-matrix-tutorial.html).
- Learn to use the row and column names for matrix: [https://www.c-sharpcorner.com/article/matrix-in-r-naming-cloumn-using-colames-function-and-accessing-matrix-elemen/](https://www.c-sharpcorner.com/article/matrix-in-r-naming-cloumn-using-colames-function-and-accessing-matrix-elemen/).
- Understand the meaning of important statistics quatities: mean, median, variance, and standard deviation. Google the internet for these definition. You can read wikipedia, the beginning section for each. In addition, [https://www.mathsisfun.com](https://www.mathsisfun.com/mean.html) seems to be easier to read. 
- Learn to use R to compute the important statistics: functions are ``mean``, ``median``, ``var``, ``sd``. Read the function helps and play with the examples. 

***

### Day 2: R coding style, R package, and markdown
- Learn good R coding style. Read [http://adv-r.had.co.nz/Style.html](http://adv-r.had.co.nz/Style.html). A longer, more detailed version of this is at [https://style.tidyverse.org/index.html](https://style.tidyverse.org/index.html). Read the long version too if you have time. 
- Read [https://www.datacamp.com/community/tutorials/r-packages-guide](https://www.datacamp.com/community/tutorials/r-packages-guide).
- Install following packages in your R: **ggplot2**, **vioplot**, **dplyr**, **data.table**.
- Check what packages have vignette, by using the `vignette()` function. 
- Open some vignette to take a look, by using `browseVignettes` and `vignette` functions. For example, do `browseVignettes("dplyr")` and `vignette("dplyr")`. Remember, a package "vignette" is the package manual. You'll learn how to write one later using Rmarkdown. 
- Review how to insert figure in markdown [https://www.markdowntutorial.com/lesson/4/](https://www.markdowntutorial.com/lesson/4/). 

***

### Day 3: R data frame and list 
**List**:

- Read [http://www.sthda.com/english/wiki/easy-r-programming-basics#lists](http://www.sthda.com/english/wiki/easy-r-programming-basics#lists). 
- Read [https://www.guru99.com/r-lists-create-select.html](https://www.guru99.com/r-lists-create-select.html). 

**Data frame**:

- Read [http://www.sthda.com/english/wiki/easy-r-programming-basics#data-frames](http://www.sthda.com/english/wiki/easy-r-programming-basics#data-frames), 
- Read [https://www.guru99.com/r-data-frames.html](https://www.guru99.com/r-data-frames.html). 

***

### Day 4: R file I/O

- Understand the tab-delimited and csv file format: read [https://en.wikipedia.org/wiki/Delimiter-separated_values](https://en.wikipedia.org/wiki/Delimiter-separated_values). 
- Learn to read in files to R: [https://www.guru99.com/r-import-data.html](https://www.guru99.com/r-import-data.html). 
- Read the [COVID-19 data](data/covid_19_clean_complete.csv) into R. 
- Learn to save and load objects in R [http://www.sthda.com/english/wiki/saving-data-into-r-data-format-rds-and-rdata](http://www.sthda.com/english/wiki/saving-data-into-r-data-format-rds-and-rdata). 

***

### Day 5: Basic R graphics

- Learn to use R to create [histogram](https://www.statmethods.net/graphs/density.html), [boxplot](https://www.statmethods.net/graphs/boxplot.html), [scatter plot](https://www.statmethods.net/graphs/scatterplot.html), [bar plot](https://www.statmethods.net/graphs/bar.html). 
- Learn to save R plots in files: [http://www.sthda.com/english/wiki/creating-and-saving-graphs-r-base-graphs](http://www.sthda.com/english/wiki/creating-and-saving-graphs-r-base-graphs). 
- Understand the meaning of each figure. Read the function helps for these functions, and play with the examples. Have a rough idea of the function parameters (what you can control for the figures).
- Browse [https://www.r-graph-gallery.com](https://www.r-graph-gallery.com) to see what type of figures R can generate. 
- Play with the plot functions by looking at the examples. Run following in R to see what R can plot:

	```
	example(plot)
	example(barplot)
	example(hist)
	example(points)
	```


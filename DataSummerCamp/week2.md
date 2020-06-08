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


---
layout: page
title: Schedule for week 4
---

### Homework

**homework4.Rmd**: All answers to the questions, codes and results (figures, tables) should be included in this single file. 

1. Generate the mathematical notations listed in [https://www.calvin.edu/%7Erpruim/courses/s341/S17/from-class/MathinRmd.html](https://www.calvin.edu/%7Erpruim/courses/s341/S17/from-class/MathinRmd.html). 
2. Generate 100 random numbers from **uniform distribution** ranging from 0 to 10. 
	- Draw the histogram of the numbers.
	- Compute the mean, median, variance, and standard deviation of these numbers. 
3. Generate 100 random numbers from **normal distribution** with mean 10 and standard deviation 2. 
	- Draw the histogram of the numbers.
	- Compute the mean, median, variance, and standard deviation of these numbers. 
4. Coint toss simulation: 
	- Simulate 100 random coin tosses for a fair coin, using the `sample` function.  How many heads do you get? How many do you expect to get? 
	- Repeat the above (100 random coin tosses) for 1000 times, that is, in a trial, you toss the coin for 100 times and record the number of heads. You do it again and again for 1000 times (so in total you'll toss the coin for 100,000 times). At the end, you will have 1000 numbers (for the numbers of heads in each trial). You can do this in a loop, and call `sample` function in the loop.
	-  Draw the histogram for the numbers of heads from all trials. Does it look similar? Yes, it looks like the bell-shaped curve (normal distribution). This is the amazing [_law of the large number_](https://en.wikipedia.org/wiki/Law_of_large_numbers), i.e., the means of a group of numbers (whatever it is) converges to a normal distribution.
5. Dice rolling simulation:
	- Assume you have a fair dice (six sides with numbers 1-6). Simulate 100 dice rolling, using `sample` function. Report the number of times you see each side (using the `table` function). 
	- Assume you have two fair dice. You roll them at the same time and record the sum of the numbers from both dice. Simulate 100 such throwing, and report the numbers you get. 
6. Based on the `mtcars` data frame, 
	- Generate one figure with 2 panels for mpg vs hp and mpg vs wt. I expect to see a figure like the following
	
	![](mtcars-scatter-2panel.pdf)
	
	- Use different colors in the above figure for cars with different numbers of cyl. I want you to play with different color options, but finally use some transparent color in solid points (hint, the point type is `pch=19`). I expect to see something like the following (colors don't have to be exactly the same): 
	
	![](mtcars-scatter-2panel-color.pdf)

	- Generate a figure with 4 panels in a 2x2 layout. I expect to see a figure like the following: 

	![](mtcars-scatter-4panel.pdf)



***

### Day 1: Review

- Re-read R control statements: [https://www.guru99.com/r-if-else-elif-statement.html](https://www.guru99.com/r-if-else-elif-statement.html),  [https://www.guru99.com/r-for-loop.html](https://www.guru99.com/r-for-loop.html), 
[https://www.guru99.com/r-while-loop.html](https://www.guru99.com/r-while-loop.html). 
- Review math notations in Latex and R-markdown: [http://www.math.mcgill.ca/yyang/regression/RMarkdown/example.html](http://www.math.mcgill.ca/yyang/regression/RMarkdown/example.html), [https://www.calvin.edu/~rpruim/courses/s341/S17/from-class/MathinRmd.html](https://www.calvin.edu/~rpruim/courses/s341/S17/from-class/MathinRmd.html).
- Do question 1 in the homework. 



### Day 2: Random number generator in R

- Understand the concept of random variable and probability distribution and density:
	- [https://mathinsight.org/definition/random_variable](https://mathinsight.org/definition/random_variable)
	- [https://mathinsight.org/probability_distribution_idea](https://mathinsight.org/probability_distribution_idea). 
- Simple random generator functions in R: [https://www.datamentor.io/r-programming/examples/random-number/](https://www.datamentor.io/r-programming/examples/random-number/).
- Learn the `sample` function for random sampling: [https://www.gastonsanchez.com/packyourcode/intro.html](https://www.gastonsanchez.com/packyourcode/intro.html). 
- Do quesions 2-3. 

### Day 3: Random number generator in R

- Learn the `sample` function for random sampling: [https://www.gastonsanchez.com/packyourcode/intro.html](https://www.gastonsanchez.com/packyourcode/intro.html). 
- Understand **binomial** and **multinomial** distribution: https://www.mathsisfun.com/data/binomial-distribution.html), [https://www.ck12.org/book/ck-12-basic-probability-and-statistics-a-full-course/section/3.3/](https://www.ck12.org/book/ck-12-basic-probability-and-statistics-a-full-course/section/3.3/). 
- Do quesions 4 and 5. 


### Day 4: A little bit more advanced R base graphics 

- Multiple panels in one figure: [https://www.statmethods.net/advgraphs/layout.html](https://www.statmethods.net/advgraphs/layout.html). **Note**, the `par` function in R is comprehensive. You might want to take a look `?par` and play with the examples. 
- Plotting multiple lines in a figure: 
[http://www.sthda.com/english/wiki/line-plots-r-base-graphs](http://www.sthda.com/english/wiki/line-plots-r-base-graphs).
- Control colors in R: [https://bookdown.org/rdpeng/exdata/plotting-and-color-in-r.html](https://bookdown.org/rdpeng/exdata/plotting-and-color-in-r.html). 
- Do question 6.


### Day 5: Review

Review all contents for this week, especially the day 2 and 3 stuff. The simulation question in the homework might be a little complicated. Talk to me if necessary. 



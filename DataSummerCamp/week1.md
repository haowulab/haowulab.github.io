---
layout: page
title: Schedule for week 1
---

### Homework

I will list the homework at the begining of each weekly schedule, so that you have a better idea of what you need to do. 

For the homework, you need to submit two files: a markdown file named homework1.md, and an R file named  homework1.R. 

In **homework1.md**, answer following questions: 

1. What Markdown editor did you choose, and why?
2. Write a summary of what you learned this week, using markdown. Name the file homework1.md. Using different type of fonts, and ordered/unordered list. 

In **homework1.R**:

Write R program to do the following. _NOTE: if you haven't learned, the functions for computing sum and mean of vector/matrix is ``sum`` and ``mean``. Look at their function helps if needed._ 

1. Compute the sum and mean of integers from 1 to 10.
2. Create a vector of 5 elements, you can put in some random numbers in the vector. Take out the 2nd **to** 4th elements, and compute their sum and mean. 
3. Create a vector of 5 elements, you can put in some random numbers in the vector. Take out the 2nd **and** 4th elements, and compute their sum and mean. 
4. Create a 3x3 matrix, you can put in some random numbers in the matrix. Compute the sum and mean of each row and column.
5. Create two vectors, each with 3 elements. Compute the sum and difference of each element in the vector.
6. Create two vectors, each with 3 elements, combine them into one vector of 6 elements. 
7. Create two vectors, each with 3 elements, (1) combine them into a 2x3 matrix; (2) combine them into a 3x2 matrix.
8. Run following code to create a string: `string = "This is a string"`
	- How many characters are there in the string? 
	- Return the first 10 characters in the string.
	- how many words are there in the string?
	- Return the first two words in the string. 
	- Replace `This` by `That` in the string. 
	- Remove all spaces in the string. 
9. Run following code to create a vector of strings `sample(c("car", "truck", "plane"), 100, replace=TRUE)` 
	- Convert the string vector to factors. 
	- How many levels are there in the factor? 
	- How many items are there for each level? 
	- Replace all `car` by `bike` in the vector, by changing the level of the factor. 
	- After above step, change the factor back to string vector. See what you get. 	
10. Initialize the vector x using the following commands. Present a one line R statement that will count the total numbers that are evenly divisible by 15 and 25. The answer will be a single number.

	```
	set.seed(222)
	x = floor(rnorm(300, 200, 90))
	```
11. Given the following vector provide a one line command that computes the sum of all element values that are within 5 of the maximum number of this vector. The correct answer is 599.0835. You must present a one line R statement that issues this response. Hint, using the absolute function will be useful.

	```
	set.seed(123)
	x = rnorm(100, 100, 10)
	```
***


### Extra practices

#### Vector and matrix indexing
1. Create a 4x3 matrix, you can put in some random numbers in the matrix (for example, simply use 1 to 12). 
	- Return the first and third row
	- Return the first and second column
	- Return a submatrix containing the first and third row and the first and second column.
2. `seq` is a useful function to create a sequence of numbers in a vector. Read the function help for `seq`.
	- Create a sequence of even numbers from 1 to 50.  
	- Create a sequence of add numbers from 1 to 50.  


#### Comparison

Read the section for logical operators again at [https://www.guru99.com/r-data-types-operator.html#5](https://www.guru99.com/r-data-types-operator.html#5). Note, R has ability to compare a vector or matrix to a single element. In that case, each elemenet in the vector or matrix will be compared to the single element, and the return will be a logical vector/matrix. 

1. How many numbers in 1:100 can be evenly divided by 3? 
2. The comparison can be performed on characters too. Run following code to create a vector of strings 
	```
	sample(c("car", "truck", "plane"), 100, replace=TRUE)
	```
	
	- How many items are "car" in this vector of string? 
	- How many items are **NOT** "truck" in this vector of string? 

3. How many numbers in 1:100 are greater than 20?
4. How many numbers in 1:100 are greater than 20 **AND** smaller than 50? 
5. How many numbers in 1:100 are smaller than 20 **OR** or greater than 50? 

#### Combination of comparison and indexing
Use a combination of comparison and indexing can extract uesful information from 
a large dataset. Here let's do something a little interesting. I obtained the career regular season statistics for Shaquille O'Neal. You can read them into R using

```
shaqStat = read.csv("http://www.haowulab.org/DataSummerCamp/data/shaqStat.csv")
```

What you read in is a `data frame`, similar to a matrix. We will learn it next week. Take a look at `shaqStat` in R. Let's do some simple practice

- Return the statistics for Shaq when he played at ORL.
- Return the following statistics for Shaq when he plays at ORL: G, FG, FGA
- Can you compute the overall FG% when Shaq played at Orlando?
- Repeat the above, but only for the statsitics when Shaq played at LAL. 





	
	


### Day 1: R and R studio
- Read [https://www.guru99.com/r-programming-introduction-basics.html](https://www.guru99.com/r-programming-introduction-basics.html). 
- Install R and Rstuido, following [http://www.sthda.com/english/wiki/installing-r-and-rstudio-easy-r-programming](http://www.sthda.com/english/wiki/installing-r-and-rstudio-easy-r-programming). And watch [https://www.youtube.com/watch?v=lVKMsaWju8w](https://www.youtube.com/watch?v=lVKMsaWju8w). 
- Play with Rstudio to get to know the menu items. 

***

### Day 2: Markdown day
- Install a Markdown editor. I use MacDown on Mac, not sure about on Windows. Do some search, try different ones, and pick the one your like. 
- Watch [https://www.youtube.com/watch?v=6A5EpqqDOdk](https://www.youtube.com/watch?v=6A5EpqqDOdk) for markdown. 
- Start to learn markdown at [https://www.markdowntutorial.com/](https://www.markdowntutorial.com/). 
- Write a simple markdown document. 

***

### Day 3: R and R studio
- Understand the "directory" on computer. Setup your R working directory by reading [http://www.sthda.com/english/wiki/running-rstudio-and-setting-up-your-working-directory-easy-r-programming](http://www.sthda.com/english/wiki/running-rstudio-and-setting-up-your-working-directory-easy-r-programming). 
- Start to learn R programming language: [https://www.guru99.com/r-data-types-operator.html](https://www.guru99.com/r-data-types-operator.html). Play the examples in R by copying/pasting the command into R and see the results. 
- Learn how to get function helps in R by reading [http://www.sthda.com/english/wiki/getting-help-with-functions-in-r-programming](http://www.sthda.com/english/wiki/getting-help-with-functions-in-r-programming). 

***

### Day 4: R programming 
<!-- - Review basic R programming: read [http://www.sthda.com/english/wiki/easy-r-programming-basics](http://www.sthda.com/english/wiki/easy-r-programming-basics), the first 5 sections (up to **Vectors**). Play with the examples. -->
- Understand the concept of matrix. If you don't know it, google "matrix" and look it up. 
- Learn R matrix at [https://www.guru99.com/r-matrix-tutorial.html](https://www.guru99.com/r-matrix-tutorial.html).
- Watch the first quarter of [https://www.youtube.com/watch?v=lL0s1coNtRk](https://www.youtube.com/watch?v=lL0s1coNtRk). 
- Under stand R characters: read [http://www.r-tutor.com/r-introduction/basic-data-types/character](http://www.r-tutor.com/r-introduction/basic-data-types/character), and [https://data-flair.training/blogs/r-string-manipulation/](https://data-flair.training/blogs/r-string-manipulation/). 

***


### Day 5: R programming, review and homework


- Understand factors: read [http://www.sthda.com/english/wiki/easy-r-programming-basics#factors](http://www.sthda.com/english/wiki/easy-r-programming-basics#factors), and [https://www.guru99.com/r-factor-categorical-continuous.html](https://www.guru99.com/r-factor-categorical-continuous.html). 
- Review all materials learned this week. 
- Do homework. 



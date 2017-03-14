###### 1. read in and get basic summaries
genes=read.table("hg18genes.txt", comment="", header=TRUE)
## total number of genes
nrow(genes)
## summarizes number of genes on each chromosome
table(genes$chrom)
## summarizes number of +/- genes
table(genes$strand)


####### 2. Explore gene lengths
geneLen=genes$txEnd-genes$txStart
## histogram of gene length
hist(geneLen,50, main="Gene lengths", xlab="base pairs")
## histogram of log gene length - a clear bimodal distribution.
hist(log(geneLen),50, main="log(Gene lengths)", xlab="base pairs")
## look at gene length distribution stratified by strand
boxplot(geneLen~genes$strand) ## this doesn't show very well
## use log gene length
boxplot(log(geneLen)~genes$strand) ## no difference
## Hypothesis testing on whether gene length are difference on different strand
## write yourself.


## now look at gene lengths distributions on different chromosomes
boxplot(geneLen ~ genes$chrom)
## exclude the random and hap chromosomes, then plot log gene length on chromosomes
idx=c(grep("random", genes$chrom), grep("hap", genes$chrom))
par(las=3)
boxplot(log(geneLen[-idx]) ~ as.character(genes$chrom[-idx]))

## what's the longest gene?
idx=which.max(geneLen)
genes[idx, ]

####### 3. now look at number of exons
nExon=genes$exonCount
hist(nExon,40, main="Number of exons", xlab="Exon count")
## which gene has the most exon?
idx=which.max(nExon)



## look at correlation of gene length and number of exons
plot(geneLen, nExon, pch=".", xlab="Gene length", ylab="Number of exons")
cor(nExon, geneLen) ## weak correlation, need to run a test (lm or glm).




######### 4. Gene density
## chrosome length:
chrlen=c(247249719,242951149,199501827,191273063,180857866,170899992,158821424,
  146274826,140273252,135374737,134452384,132349534,114142980,106368585,100338915,
  88827254,78774742,76117153,63811651,62435964,46944323,49691432,154913754,57772954)
names(chrlen)=paste("chr",c(1:22,"X","Y"),sep="")

## number of genes per Mega basepairs on each chromosome



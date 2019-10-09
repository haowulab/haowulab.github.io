#### example scripts for BIOS555 lab3, updated 10/9/2019

##############################################
## using Rsubread for sequence alignment
##############################################
library(Rsubread)
## build reference
buildindex(basename="phage",reference="phage-ref.fa")
## alignment
align.stat <- align(index="phage",readfile1="phage-reads.fa",
                    output_file="phage-reads.bam",type='dna')
align.stat  # check the mapping results


##############################################
## Joint analysis for RNA- and ChIP-seq
##############################################
library(GenomicRanges)
library(GenomicFeatures)
library(Rsamtools)

## first get gene information from UCSC. This will take 2 minutes or so.
## Or you can download knowngene.hg18.sqlite from class site and do
## gene.hg18=loadDb("knowngene.hg18.sqlite")

gene.hg18 = makeTxDbFromUCSC(genom="hg18",tablename="knownGene")
allgenes = genes(gene.hg18)
allgenes.chr22 = allgenes[seqnames(allgenes)=="chr22"] ## genes on  chr 22

## Read in RNA-seq bam file
what = c("rname", "strand", "pos", "qwidth")
TSS.counts = NULL
param = ScanBamParam(what = what)
bam = scanBam("K562_RNAseq_chr22.bam", param=param)[[1]]
IRange.reads = GRanges(seqnames=Rle(bam$rname),
                       ranges=IRanges(bam$pos, width=bam$qwidth))

## get RNA-seq counts within gene bodies -
## should obtain exon counts and sum up. I'm approximating the process here.
counts.RNAseq = countOverlaps(allgenes.chr22, IRange.reads)

## get Cmyc binding around TSS
## first get region around TSS (+/- 1000 bp). This is a little tricky, be careful in strands directions.
strands = strand(allgenes.chr22)
ix.gene.minus = which(strands=="-")
TSS = start(allgenes.chr22)
TSS[ix.gene.minus] = end(allgenes.chr22)[ix.gene.minus]
ext = 1000
TSS.GRanges = GRanges(seqnames=Rle("chr22", length(allgenes.chr22)),
                      ranges=IRanges(start=TSS-ext, end=TSS+ext))
bam = scanBam("K562Cmyc_chr22.bam", param=param)[[1]]
IRange.reads = GRanges(seqnames=Rle(bam$rname),
                       ranges=IRanges(bam$pos, width=bam$qwidth))
counts.Cmyc = countOverlaps(TSS.GRanges, IRange.reads)

## see if there's any correlation of gene expression and Cmyc binding.
cor(log(counts.Cmyc+1), log(counts.RNAseq+1)) ## pretty good correlation in log scale
plot(counts.Cmyc, counts.RNAseq, log="xy", xlab="Cmyc binding", ylab="Gene expression")

## Another practice: get window counts for Cmyc binding: counts in 50 bp windows around TSS
## This can show the peak shapes at binding sites
## take TSS +/- 1000 bp and cut into 50bp windows
ext = 1000
winsize = 50
allss = sapply(TSS, function(x) seq(x-ext, x+ext-1, by=winsize))
## create GRanges
allchrs = as.character(seqnames(allgenes.chr22))
allseq = Rle(allchrs,rep(ext/winsize*2,length(allchrs)))
allrange = IRanges(start=allss, end=allss+winsize-1)
TSS.GRanges = GRanges(seqnames=allseq, ranges=allrange)
tmp = countOverlaps(TSS.GRanges, IRange.reads)
counts.Cmyc.win = matrix(tmp, ncol=40, byrow=TRUE)
plot(colMeans(counts.Cmyc.win), type="b", xaxt="n", xlab="position", ylab="Average Cmyc binding")
axis(1, c(1, 10,20, 30,40), labels=c("-500", "-200", "TSS", "250", "500"))

####################################################################
## DE test for RNA-seq data
####################################################################
library(DESeq2)
library(edgeR)
load("X.rda")
nreps=ncol(X)/2

## DESeq2
library(DESeq2)
condition <- as.factor(c(rep(0,nreps),rep(1,nreps)))
dds <- DESeqDataSetFromMatrix(X, DataFrame(condition), ~ condition)
dds <- DESeq(dds)
res <- results(dds)
pval.DEseq <- res$pvalue

## edgeR
library(edgeR)
d=DGEList(counts=X, group=conds)
d <- calcNormFactors(d)
d=estimateCommonDisp(d)
d=estimateTagwiseDisp(d)
fit.edgeR <- exactTest(d)
pval.edgeR <- fit.edgeR$table$PValue

## DSS
library(DSS)
seqData=newSeqCountSet(X, conds)
seqData=estNormFactors(seqData)
seqData=estDispersion(seqData)
result=waldTest(seqData, 0, 1, equal.var=FALSE)
pval.DSS=result$pval
pval.DSS[result$geneIndex]=result$pval

## compare pvalues
plot(pval.DEseq, pval.edgeR, pch=".", xlab="DEseq", ylab="edgeR")
plot(pval.DEseq, pval.DSS, pch=".", xlab="DEseq", ylab="DSS")
plot(pval.edgeR, pval.DSS, pch=".", xlab="edgeR", ylab="DSS")


## look at ROC curve - almost identical
library(ROCR)
ROC.DE <- function(DE.gs, pval) {
  pred = prediction(1-pval, DE.gs)
  perf = performance(pred,"tpr","fpr")
  perf
}
roc.DEseq=ROC.DE(flag, pval.DEseq)
roc.edgeR=ROC.DE(flag, pval.edgeR)
roc.DSS=ROC.DE(flag, pval.DSS)

xlim=c(0,1)
plot(roc.DEseq, xlim=xlim)
plot(roc.edgeR, add=TRUE, col="red", lty=1)
plot(roc.DSS, add=TRUE, col="blue", lty=1)

legend("bottomright", legend=c("DEseq", "edgeR", "DSS"),col=c("black","red", "blue"), lty=1)

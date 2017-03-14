#### example scripts to play with BAM files.
library(GenomicRanges)
library(GenomicFeatures)
library(Rsamtools)

## first get gene information from UCSC. This will take 2 minutes or so.
## Or if you have these saved you can load them in using: refGene.hg18=loadFeatures("refGene.hg18.GR.sqlite")
refGene.hg18=makeTranscriptDbFromUCSC(genom="hg18",tablename="refGene")
tx=transcripts(refGene.hg18)
tx.chr22=tx[seqnames(tx)=="chr22"] ## genes on  chr 22

## get RNA-seq counts within gene bodies
what=c("rname", "strand", "pos", "qwidth")
TSS.counts=NULL
param=ScanBamParam(what = what)
bam=scanBam("K562_RNAseq_chr22.bam", param=param)[[1]]
IRange.reads=GRanges(seqnames=Rle(bam$rname),
    ranges=IRanges(bam$pos, width=bam$qwidth))
counts.RNAseq=countOverlaps(tx.chr22, IRange.reads)

## get Cmyc binding around TSS
## first get region around TSS (+/- 1000 bp), be careful in strands.
strands=strand(tx.chr22)
ix.gene.minus=which(strands=="-")
TSS=start(tx.chr22)
TSS[ix.gene.minus]=end(tx.chr22)[ix.gene.minus]
ext=1000
TSS.GRanges=GRanges(seqnames=Rle("chr22", length(tx.chr22)),
    ranges=IRanges(start=TSS-ext, end=TSS+ext))
bam=scanBam("K562Cmyc_chr22.bam", param=param)[[1]]
IRange.reads=GRanges(seqnames=Rle(bam$rname),
    ranges=IRanges(bam$pos, width=bam$qwidth))
counts.Cmyc=countOverlaps(tx.chr22, IRange.reads)

## see if there's any correlation of gene expression and Cmyc binding.
cor(log(counts.Cmyc+1), log(counts.RNAseq+1)) ## pretty good correlation in log scale
plot(counts.Cmyc, counts.RNAseq, log="xy", xlab="Cmyc binding", ylab="Gene expression")

## Another practice: get window counts for Cmyc binding: counts in 50 bp windows around TSS
## This can show the peak shapes at binding sites
## take TSS +/- 1000 bp and cut into 50bp windows
ext=1000
winsize=50
allss=sapply(TSS, function(x) seq(x-ext, x+ext-1, by=winsize))
## create GRanges
allchrs=as.character(seqnames(tx.chr22))
allseq=Rle(allchrs,rep(ext/winsize*2,length(allchrs)))
allrange=IRanges(start=allss, end=allss+winsize-1)
TSS.GRanges=GRanges(seqnames=allseq, ranges=allrange)
tmp=countOverlaps(TSS.GRanges, IRange.reads)
counts.Cmyc.win=matrix(tmp, ncol=40, byrow=TRUE)
plot(colMeans(counts.Cmyc.win), type="b", xaxt="n", xlab="position", ylab="Average Cmyc binding")
axis(1, c(1, 10,20, 30,40), labels=c("-500", "-200", "TSS", "250", "500"))

####################################################################
## part II. DE test for RNA-seq data
####################################################################
library(DESeq)
library(edgeR)
load("X.rda")
nreps=ncol(X)/2

##  DEseq
library(DESeq)
conds=c(rep(0,nreps),rep(1,nreps))
cds <- newCountDataSet(X, conds )
cds <- estimateSizeFactors( cds )
cds <- estimateVarianceFunctions( cds )
fit.DEseq <- nbinomTest( cds, 0,1)
pval.DEseq=fit.DEseq$pval
pval.DEseq[is.na(pval.DEseq)]=1

## edgeR
library(edgeR)
d=DGEList(counts=X, group=conds)
d <- calcNormFactors(d)
d=estimateCommonDisp(d)
d=estimateTagwiseDisp(d,trend=TRUE)
fit.edgeR <- exactTest(d)
pval.edgeR <- fit.edgeR$table$p.value

## compare pvalues
plot(pval.DEseq, pval.edgeR, pch=".", xlab="DEseq", ylab="edgeR")

## look at ROC curve
library(ROCR)
ROC.DE <- function(DE.gs, pval) {
  pred = prediction(1-pval, DE.gs)
  perf = performance(pred,"tpr","fpr")
  perf
}
roc.DEseq=ROC.DE(flag, pval.DEseq)
roc.edgeR=ROC.DE(flag, pval.edgeR)
xlim=c(0,1)
plot(roc.DEseq, xlim=xlim)
plot(roc.edgeR, add=TRUE, col="red", lty=1)
legend("bottomright", legend=c("DEseq", "edgeR"),col=c("black","red"), lty=1)

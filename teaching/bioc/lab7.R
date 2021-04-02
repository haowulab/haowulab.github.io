## look at Cmyc chip-seq data
library(GenomicRanges)
library(GenomicFeatures)
library(Rsamtools)

## read in BAM file
what=c("rname", "strand", "pos", "qwidth")
param=ScanBamParam(what = what)
bam=scanBam("K562Cmyc_chr22.bam", param=param)[[1]]
IRange.reads.Cmyc=GRanges(seqnames=Rle(bam$rname),
  ranges=IRanges(bam$pos, width=bam$qwidth))
bam=scanBam("K562Pol2_chr22.bam", param=param)[[1]]
IRange.reads.Pol2=GRanges(seqnames=Rle(bam$rname),
  ranges=IRanges(bam$pos, width=bam$qwidth))

## compute coverage
cov.Cmyc=coverage(IRange.reads.Cmyc)$chr22
cov.Pol2=coverage(IRange.reads.Pol2)$chr22

## a naive peak calling method: keep regions with high coverage
peaks.Cmyc=slice(cov.Cmyc, lower=20)
peaks.Pol2=slice(cov.Pol2, lower=20)

## take a look at the peaks - Pol2 and Cmyc peaks greatly overlap
idx=17763562:17801974
par(mfrow=c(2,1))
plot(idx, cov.Cmyc[idx], type="h", ylab="Cmyc", xlab="chr22")
plot(idx, cov.Pol2[idx], type="h", ylab="Pol2", xlab="chr22")

## summarize counts into genes
## Or if you have these saved you can load them in using: refGene.hg18=loadFeatures("refGene.hg18.GR.sqlite")
refGene.hg18=makeTranscriptDbFromUCSC(genom="hg18",tablename="refGene")
tx=unique(transcripts(refGene.hg18))
tx.chr22=tx[seqnames(tx)=="chr22"] ## genes on  chr 22

## get promoter regions
ix.gene.minus=as.vector(strand(tx.chr22)=="-")
TSS=start(tx.chr22)
TSS[ix.gene.minus]=end(tx.chr22)[ix.gene.minus]
ss=ee=TSS
ss[ix.gene.minus]=TSS[ix.gene.minus]-100
ss[!ix.gene.minus]=TSS[!ix.gene.minus]-1000
ee[ix.gene.minus]=TSS[ix.gene.minus]+1000
ee[!ix.gene.minus]=TSS[!ix.gene.minus]+100
TSS.GRanges=GRanges(seqnames=Rle("chr22", length(tx.chr22)),
      ranges=IRanges(start=ss, end=ee))

## counts at promoter regions
counts.Cmyc=countOverlaps(TSS.GRanges, IRange.reads.Cmyc)
counts.Pol2=countOverlaps(TSS.GRanges, IRange.reads.Pol2)
cor(counts.Cmyc, counts.Pol2, method="spear")
plot(counts.Cmyc, counts.Pol2, log="xy") ## read counts for Cmyc and Pol2 highly correlated at promoter regions

## look at their correlation with gene expression
bam=scanBam("K562_RNAseq_chr22.bam", param=param)[[1]]
IRange.reads=GRanges(seqnames=Rle(bam$rname),
      ranges=IRanges(bam$pos, width=bam$qwidth))
counts.RNAseq=countOverlaps(tx.chr22, IRange.reads)

counts=data.frame(Cmyc=counts.Cmyc, Pol2=counts.Pol2, GE=counts.RNAseq)
plot(log(counts+1))
## there are a few genes with high expression but low Pol2 binding. 


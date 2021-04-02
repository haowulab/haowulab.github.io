
library(BSgenome)
available.genomes()
library(BSgenome.Hsapiens.UCSC.hg19)

#####################################################
## 1. explore sequence composition of human genome
#####################################################
### get sequence for chromosome 1
Seq=Hsapiens[["chr1"]]
Seq # shows some summaries

## get GC content
bases=alphabetFrequency(Seq,baseOnly=TRUE)
bases[1:4]
ntotBases=sum(bases[1:4])
baseFreq=bases[1:4]/ntotBases
GCcontent=baseFreq["C"]+baseFreq["G"]

## look at CG dinucleotide content
cg=matchPattern("CG", Seq)
ncg=length(cg)
## compute the observed to expected ratio
ncg/(baseFreq["C"]*baseFreq["G"]*ntotBases) ## this shows CG rarely stay together.

## compare to the observed to expected ratio of TG
tg=matchPattern("TG", Seq)
ntg=length(tg)
ntg/(baseFreq["T"]*baseFreq["G"]*ntotBases) ## this shows TG presented more than expected.

######### look at GC content and CG dinucleotide distribution in 1000 bp windows in whole genome.
## Note I'm only doing it in chr1 now.
ss=seq(1, length(Seq), by=1000)
ss=ss[-length(ss)] ## remove the last one
Seq.set=DNAStringSet(Seq, start=ss, end=ss+999)
ff=alphabetFrequency(Seq.set, baseOnly=TRUE)
pCG=(ff[,"C"]+ff[,"G"])/rowSums(ff)
hist(pCG[pCG>0],100)

## CG occurance
Seq.set=DNAStringSet(Seq, start=ss, end=ss+999)
nCG=vcountPattern("CG", Seq.set)
obsExp=nCG*1000/(ff[,"C"]*ff[,"G"])
mean(obsExp,na.rm=TRUE)
hist(obsExp,100) ## see a long tail, those are CpG islands

#####################################################################
## 2. Explore GC content at gene TSS (transcriptional starting site),
#####################################################################
## and their overlaps with CpG island.
## first obtain genes from UCSC using GenomicFeatures functions
library(GenomicFeatures)
txdb=makeTxDbFromUCSC(genom="hg19",tablename="knownGene") ## this is slow, take a few minutes.

## If the above command fails, obtain the sqlite file from class webpage, and load in:
# txdb = loadDb("hg19_knownGenes.sqlite")

## get genes from the database
genes.hg19 = genes(txdb)

## get transcriptional start site.
## Note that txEnd is the start site for genes on "-" strand
tss=start(genes.hg19)
idx=which(strand(genes.hg19)=="-")
tss[idx]=end(genes.hg19)[idx]

## create GRanges object for the TSS, remove random and hap chromosomes
allchrs = as.character(seqnames(genes.hg19))
idx=c(grep("random", allchrs),grep("hap", allchrs))
## create ranges with TSS +/- 500 bp
TSS=GRanges(seqnames=Rle(allchrs[-idx]), ranges=IRanges(tss[-idx]-500,tss[-idx]+500))

## get GC contents of TSS for genes on chromosome 1
idx.chr1=seqnames(TSS)=="chr1"
Seq.set=DNAStringSet(Seq, start=start(TSS[idx.chr1]), end=end(TSS[idx.chr1]))
ff=alphabetFrequency(Seq.set, baseOnly=TRUE)
pCG.TSS=(ff[,"C"]+ff[,"G"])/rowSums(ff)
hist(pCG.TSS,50)

## compare with genome wide distribution of GC content
d1=density(pCG[pCG>0])
d2=density(pCG.TSS)
plot(d1, lwd=2)
lines(d2, col="red",lwd=2)
legend("topright", legend=c("Genome", "TSS"), lwd=2, col=c("black", "red"))

## CG dinucleotide around TSS, compute obs/Exp.
nCG=vcountPattern("CG", Seq.set)
obsExp.TSS=nCG*1000/(ff[,"C"]*ff[,"G"])
hist(obsExp.TSS, 50) ## bimodal distribution.

## compare with the genome wide one:
d1=density(obsExp[!is.na(obsExp)])
d2=density(obsExp.TSS)
plot(d1, lwd=2, xlim=c(0,1.5), main="Observed to expected CG ratio")
lines(d2, col="red",lwd=2)
legend("topright", legend=c("Genome", "TSS"), lwd=2, col=c("black", "red"))

#####################################################################
## 3.  Overlaps of  CpG island and TSS
#####################################################################
## Read in CpG island file on class website (hg19_CGI.txt),
## create GRanges object and compute the percentage of TSS covered by CGI.
## This part is to be finished by students.



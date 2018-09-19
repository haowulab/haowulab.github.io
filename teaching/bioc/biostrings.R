#####################################################
## scripts for some basic bioc packages
#####################################################

#####################################################
## Biostrings
#####################################################

library(Biostrings)

## BString basic operations
a=BString("I am a string!")
a
length(a)
a[1:4]
subseq(a,1,4)
subseq(a, end=4)
rev(a)

a=="I am"
a[1:4]=="I am"
toString(a)
class(a)
class(toString(a))

## DNA/RNAString
IUPAC_CODE_MAP
DNA_ALPHABET
DNA_BASES
RNA_ALPHABET
RNA_BASES

a=DNAString("I am a string")
a=DNAString("ATTGCC")
a
b=RNAString("ATTGCC")
b=RNAString("AUUGCC")
b=RNAString(a)

b
length(a)
a[1:3]

## frequencies
alphabetFrequency(a)
alphabetFrequency(a, baseOnly=TRUE)

letterFrequency(a,"C")
letterFrequency(a,"CG")

## complements
complement(a)
reverseComplement(a)

######## String matching
a=DNAString("ACGTACGTACGC")
matchPattern("CGT", a)
matchPattern("CGT", a, max.mismatch=1)

m=matchPattern("CGT", a, max.mismatch=1)
start(m)
end(m)
length(m)
countPattern("CGT", a, max.mismatch=1)

## multiple matching
a=DNAString("ACGTACGTACGC")
dict0=PDict(c("CGT","ACG"))
mm=matchPDict(dict0, a)
mm[[1]]
mm[[2]]

## matching using PWM
motif=matrix(c(0.97,0.01,0.01,0.01,0.1,0.5,0.39,0.01,0.01,0.05,0.5,0.44), nrow=4)
rownames(motif)=c("A","C","G","T")
motif

a=DNAString("ACGTACGTACTC")
matchPWM(motif, a)
countPWM(motif, a)
PWMscoreStartingAt(motif, a, 1:10)

######### multiple strings: XStringViews
a=DNAString("ACGTACGTACTC")
a2=Views(a, start=c(1,5,8), end=c(3,8,12))
a2
subject(a2)
length(a2)
start(a2)
end(a2)
alphabetFrequency(a2, baseOnly=TRUE)
a2==DNAString("ACGT")
toString(a2)

## DNAStringSet
a=DNAString("ACGTACGTACTC")
a2=DNAStringSet(a, start=c(1,5,9), end=c(4,8,12))
a2
a2[[1]]
alphabetFrequency(a2, baseOnly=TRUE)

###### Operations only allowed for StringSet but not StringViews
a=DNAString("ACGTACGTACTC")
a1=DNAStringSet(a, start=c(1,5,9), end=c(4,8,12))
a1
unique(a1)
a2=Views(a, start=c(1,5,9), end=c(4,8,12))
unique(a2)


a1=Views(a, start=c(1,9), end=c(4,12))
a1
a2=Views(a, start=c(1), end=c(4))
a2
setdiff(a1,a2) ## this will generate error
union(a1, a2)

### set operations are allowed for StringSet
a1=DNAStringSet(a, start=c(1,9), end=c(4,12))
a1
a2=DNAStringSet(a, start=c(1), end=c(4))
a2
setdiff(a1,a2)
union(a1,a2)


####### matching for multiple strings
a=DNAString("ACGTACGTACTC")
a2=DNAStringSet(a, start=c(1,5,9), end=c(4,8,12))
vv=vmatchPattern("CG", a2)
vv
vv[[1]]

## doesn't work for Views
a2=Views(a, start=c(1,5,9), end=c(4,8,12))
a2
vv=vmatchPattern("CG", a2)


#####################################################
## Now show BSgenome and data packages
#####################################################
library(BSgenome)
available.genomes()
library(BSgenome.Hsapiens.UCSC.hg18)
ls("package:BSgenome.Hsapiens.UCSC.hg18")
Hsapiens
Hsapiens$chr1

seqnames(Hsapiens)
seqlengths(Hsapiens)

alphabetFrequency(Hsapiens$chr1, baseOnly=TRUE)
alphabetFrequency(Hsapiens$chr1, baseOnly=TRUE) / length(Hsapiens$chr1)
mm=matchPattern("CG", Hsapiens$chr1)
length(mm)
mm



###### SNPs
available.SNPs()
installed.SNPs()
library(BSgenome.Hsapiens.UCSC.hg19)
library(SNPlocs.Hsapiens.dbSNP144.GRCh37)

## inject SNPs into reference genome
SnpHsapiens <- injectSNPs(Hsapiens, "SNPlocs.Hsapiens.dbSNP144.GRCh37")
SnpHsapiens

## number of SNPs
snps <- SNPlocs.Hsapiens.dbSNP144.GRCh37
snpcount(snps)

## SNP locations on chr22
snpsBySeqname(snps, "22")

## get SNPs by overlap
snpsByOverlaps(snps, "22:33.63e6-33.64e6")

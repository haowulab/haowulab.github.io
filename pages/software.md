---
layout: page
title: Software
description: Hao Wu's software 
---

Here is a list of software packages developed by our lab. 
<br>

#### Bioconductor packages 

- [DSS](http://www.bioconductor.org/packages/release/bioc/html/DSS.html) (**D**ispersion **S**hrinakge for **S**equencing): differential analysis for count-based sequencing data. It detectes differentially expressed genes (DEGs) from RNA-seq, and differentially methylated loci or regions (DML/DMRs) from bisulfite sequencing (BS-seq). 

- [TOAST](http://www.bioconductor.org/packages/devel/bioc/html/TOAST.html) (**TO**ols for the **A**nalysis of heterogeneou**S** **T**issues): designed for the analyses of high-throughput data from heterogeneous tissues that are mixtures of different cell types. TOAST offers functions for detecting cell-type specific differential expression (csDE) or differential methylation (csDM), as well as improved reference-free deconvolution for mixing proportion estimation. 

- [FEAST](http://bioconductor.org/packages/release/bioc/html/FEAST.html): (FEAture SelcTion (FEAST) for Single-cell clusterin): FEAST is an R package for selecting most representative features before performing the core of scRNA-seq clustering. It can be used as a plug-in for the etablished clustering algorithms such as SC3, TSCAN, SHARP, SIMLR, and Seurat. The core of FEAST algorithm includes three steps: 1. consensus clustering; 2. gene-level significance inference; 3. validation of an optimized feature set.

- [POWSC](http://bioconductor.org/packages/release/bioc/html/POWSC.html): 
Simulation, power evaluation, and sample size recommendation for single cell RNA-seq. POWSC is a simulation-based method to provide power evaluation and sample size recommendation for single-cell RNA sequencing differential expression analysis. POWSC consists of a data simulator that creates realistic expression data, and a power assessor that provides a comprehensive evaluation and visualization of the power and sample size relationship.

- [PROPER](https://bioconductor.org/packages/release/bioc/html/PROPER.html) (**PRO**spective **P**ower **E**valuation for **R**NAseq): simulation based methods for evaluating the statistical power in differential expression analysis from RNA-seq data. 

- [ChIPComp](https://bioconductor.org/packages/release/bioc/html/ChIPComp.html): Differential protein binding analysis for ChIP-seq data. The package can potentially be used for Differential analyses from other capture sequencing data with controls such as m6A capture or Ribo-seq data. 
- [maanova](https://bioconductor.org/packages/release/bioc/html/maanova.html): Differential expression analysis of N-dye microarray experiments using mixed model effect. 

<br>
#### Other non-bioconductor software

- [Wind](https://github.com/haowulab/Wind): weighted indexes for evaluating clustering results. 

- [SC2P](https://github.com/haowulab/SC2P): two-phase differential expression for single-cell RNA-seq.

- [JAMIE](http://www.biostat.jhsph.edu/~hji/jamie/): **J**oint **A**nalysis of **M**ultiple **I**P **E**xperiments.

- [makeCGI](../software/makeCGI/index.html): finding [CpG islands](http://en.wikipedia.org/wiki/CpG_island) (CGIs) from DNA sequences.

- [polyaPeak](../software/polyaPeak.html): ranking ChIP-seq peaks with shape information.


- [R/qtl](http://www.rqtl.org): mapping quantitative trait loci (QTL) in experimental crosses. This package is mainly develope by [Karl Broman](https://kbroman.org). I helped him and wrote several core functions with C engines when I worked as a software developer at The Jackson Lab. 

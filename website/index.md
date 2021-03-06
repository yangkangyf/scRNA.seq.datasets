## Introduction

This website contains a collection of publicly available datasets used by the [Hemberg Group](http://www.sanger.ac.uk/science/groups/hemberg-group) at the [Sanger Institute](http://www.sanger.ac.uk/).

## scater

We use [scater toolkit](http://bioconductor.org/packages/scater/) for quality control of scRNA-Seq data. For each dataset you can find both a scater object and a scater report.

## Contributions

We welcome contributions to our collection. Please create a pull request to our [GitHub repository](https://github.com/hemberg-lab/public-scrnaseq-datasets) providing the following information:

* `bash` script with downloading and processing instructions named as the first author's surname.
* `R` script file with the instruction on how to create a scater object named as the first author's surname.

!!! note
    The cell type information must be located in the `cell_type1` column of the `phenoData` slot of the `scater` object. If there are more than one cell type hierarchies please use `cell_type2`, `cell_type3` etc.

* Metadata information about the dataset: publication reference, accession, protocol and size of the dataset. These should be added in `markdown` format to the existing files in the `website` folder or by creating a new `markdown` file.

## scmap

Some of the dataset hosted here are used as references for <a href="http://www.hemberg-lab.cloud/scmap/">scmap</a>, our web-based application for fast unsupervised projection of single cell RNA-seq data.

## Contacts

Please send you feedback/comments/suggestions to <a href="mailto:vladimir.yu.kiselev@gmail.com">Vladimir Kiselev</a>.


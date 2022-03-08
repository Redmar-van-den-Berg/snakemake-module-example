[![Continuous Integration](https://github.com/Redmar-van-den-Berg/snakemake-module-example/actions/workflows/ci.yml/badge.svg)](https://github.com/Redmar-van-den-Berg/snakemake-module-example/actions/workflows/ci.yml)
[![PEP compatible](http://pepkit.github.io/img/PEP-compatible-green.svg)](http://pepkit.github.io)
![GitHub release](https://img.shields.io/github/v/release/redmar-van-den-berg/snakemake-module-example)
![Commits since latest release](https://img.shields.io/github/commits-since/redmar-van-den-berg/snakemake-module-example/latest)

# snakemake-module-example
Example of a snakemake project using [snakemake
modules](https://snakemake.readthedocs.io/en/v6.14.0/snakefiles/modularization.html#modules).


## Explanation
This project consists of three different Snakefiles, two of which are used as
modules by the third. Each of the Snakefiles are fully fledged pipelines, that
can be executed independenly as well as be used as modules.

### qc-seq
Firstly, there is the qc-seq Snakefile, which runs cutadapt on two input fastq
files. You can run this Snakemake pipeline directly with
```bash
snakemake  -j1 --use-singularity --config forward=tests/data/micro_rg1_R1.fq.gz reverse=tests/data/micro_rg1_R1.fq.gz -s modules/qc-seq/Snakefile
```
This will produce two trimmed fastq files in your working directory,
`trimmed_R1.fastq.gz` and `trimmed_R2.fastq.gz`.

### alignment
The second Snakefile has a workflow to map reads to the reference, producing a
bam file. This pipeline can be run directly with
```bash
snakemake -j1 --use-singularity --config forward=tests/data/micro_rg1_R1.fq.gz reverse=tests/data/micro_rg1_R1.fq.gz reference=tests/data/reference/ref.fa -s modules/align/Snakefile
```
This produces the file `alignment.sorted.bam` in the current working directory.

### The main pipeline
The main pipeline does not have any rules of it's own, but combines the rules
from the qc-seq and alignment modules together to produce its output files. You
can run the main pipeline with
```bash
snakemake -j1 --use-singularity --config forward=tests/data/micro_rg1_R1.fq.gz reverse=tests/data/micro_rg1_R1.fq.gz reference=tests/data/reference/ref.fa -s Snakefile
```
This will produce the file `from-main.bam` in the current working directory.
Please see the `Snakefile` in the top level folder to see how the two modules
are connected together.


## Installation
Download the repository from github
```bash
git clone https://github.com/Redmar-van-den-Berg/snakemake-module-example.git
```

Install and activate the
[conda](https://docs.conda.io/en/latest/miniconda.html)
environment.
```bash
conda env create --file environment.yml
conda activate snakemake-module-example
```

## Settings
There are three levels where configuration options are set, in decreasing order
of priority.
1. Flags passed to snakemake using `--config`, or in the specified
   `--configfile`.
2. Setting specified in the PEP project configuration, under the key
   `snakemake-module-example`
3. The default settings for the pipeline, as specified in the `common.smk` file

## Tests
You can run the tests that accompany this pipeline with the following commands

```bash
# Check if requirements are installed, and run linting on the Snakefile
pytest --kwd --tag sanity

# Test the pipeline settings in dry-run mode
pytest --kwd --tag dry-run

# Test the performance of the pipeline by running on the test data
pytest --kwd --tag integration
```

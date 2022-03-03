[![Continuous Integration](https://github.com/Redmar-van-den-Berg/snakemake-project/actions/workflows/ci.yml/badge.svg)](https://github.com/Redmar-van-den-Berg/snakemake-project/actions/workflows/ci.yml)
[![PEP compatible](http://pepkit.github.io/img/PEP-compatible-green.svg)](http://pepkit.github.io)
![GitHub release](https://img.shields.io/github/v/release/redmar-van-den-berg/snakemake-project)
![Commits since latest release](https://img.shields.io/github/commits-since/redmar-van-den-berg/snakemake-project/latest)

# snakemake-project
Example of a snakemake project

## Installation
Download the repository from github
```bash
git clone https://github.com/Redmar-van-den-Berg/snakemake-project.git
```

Install and activate the
[conda](https://docs.conda.io/en/latest/miniconda.html)
environment.
```bash
conda env create --file environment.yml
conda activate snakemake-project
```

## Settings
There are three levels where configuration options are set, in decreasing order
of priority.
1. Flags passed to snakemake using `--config`, or in the specified
   `--configfile`.
2. Setting specified in the PEP project configuration, under the key
   `snakemake-pipeline`
3. The default settings for the pipeline, as specified in the `common.smk` file

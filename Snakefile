include: "common.smk"


rule all:
    input:
        bamfile="from-main.bam",


module qc_seq_module:
    snakefile:
        "modules/qc-seq/Snakefile"
    config:
        config


use rule * from qc_seq_module as qc_seq_*


# Import all tasks from align module
module alignment_module:
    snakefile:
        "modules/align/Snakefile"
    config:
        config


use rule * from alignment_module as align_*


# Overwrite the input and output of the align rule, to inject the trimmed fastq
# file from qc_seq.cutadapt
use rule bwa_mem2 from alignment_module as align_bwa_mem2 with:
    input:
        f=rules.qc_seq_cutadapt.output.f,
        r=rules.qc_seq_cutadapt.output.r,
        ref=config["reference"],
    output:
        bam="from-main.bam",

include: "common.smk"


rule all:
    input:
        bamfile="from-main.bam",


# Define the qc_seq module
module qc_seq_module:
    snakefile:
        "modules/qc-seq/Snakefile"
    config:
        config


# Pull in the rules from the qc_seq module, using "qc_seq_" as a prefix for all
# rule names, to prevent collisions
use rule * from qc_seq_module as qc_seq_*


# Define the alignment module
module alignment_module:
    snakefile:
        "modules/align/Snakefile"
    config:
        config


# Pull in the rules from the alignment module, using "align_" as a prefix for
# all rule names, to prevent collisions
use rule * from alignment_module as align_*


# Overwrite the input section of the align rule, to use the trimmed fastq
# file outputs from qc_seq.cutadapt as input for bwa-mem2
# We also overwrite the output filename so that it matches the expected output
# from the "all" rule defined above.
use rule bwa_mem2 from alignment_module as align_bwa_mem2 with:
    input:
        f=rules.qc_seq_cutadapt.output.f,
        r=rules.qc_seq_cutadapt.output.r,
        ref=config["reference"],
    output:
        bam="from-main.bam",

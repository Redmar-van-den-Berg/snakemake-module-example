include: "common.smk"


module qc_seq:
    snakefile:
        "modules/qc-seq/Snakefile"
    config:
        config


use rule * from qc_seq as qc_seq_*

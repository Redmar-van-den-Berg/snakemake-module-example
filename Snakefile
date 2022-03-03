include: "common.smk"


pepfile: config["pepfile"]


# Apply the settings from the pepfile, overwriting the default ones
default.update(pep.config.get("snakemake-module-example", dict()))

# Apply the options specified to snakemake, overwriting the default settings
# and the settings from the PEP file
default.update(config)

# Set the updated dict as the configuration for the pipeline
config = default


rule all:
    input:
        outfile=get_outfile(),
        settings="settings.txt",


rule example:
    output:
        get_outfile(),
    log:
        "log/stdout.txt",
    container:
        containers["debian"]
    shell:
        """
        echo "Hello world!" > {output} 2> {log}
        """


rule settings:
    output:
        "settings.txt",
    params:
        s1=config["setting1"],
        s2=config["setting2"],
        s3=config["setting3"],
    log:
        "log/settings.txt",
    container:
        containers["debian"]
    shell:
        """
        echo {params.s1} {params.s2} {params.s3} > {output}
        """

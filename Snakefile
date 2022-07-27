import glob


configfile: "config.json"

PATIENTS, = glob_wildcards(config['haplohiv_folder']+"haplohiv{id,\d?}")

def get_haplohivfiles(wildcards):
    patient = wildcards.patient
    prefix = config['haplohiv_folder']
    return glob.glob(prefix+"haplohiv"+patient+"/patient"+patient+"_out/check_for_repeats/*.fa")

def get_consensusfiles(wildcards):
    patient = wildcards.patient
    prefix = config['output_dir']
    return glob.glob(prefix+"/patient"+patient+"/consensus/*.fa")


rule all:
    input:
        expand("{prefix}/patient{patient}/consensus/masterconsensus_{patient}_consensus.fa", prefix=config['output_dir'], patient=PATIENTS)

rule concatenate:
    input:
        get_haplohivfiles
    output:
        config['output_dir']+"/patient{patient}/consensus/masterconsensus_{patient}_concat.fa"
    params:
        dir = config['output_dir']+"/patient{patient}/consensus/"
    shell:
        """
        mkdir -p {params.dir}
        for file in {input}
        do
            cp ${{file}} {params.dir}
            base=${{file##*/}}
            sed -i "1s/.*/>${{base%.fa}}/" {params.dir}${{base}}
        done
        cd {params.dir}
        cat * > {output}
        """ 

rule dealign:
    input:
        "{prefix}/patient{patient}/consensus/masterconsensus_{patient}_concat.fa"
    output:
        "{prefix}/patient{patient}/consensus/masterconsensus_{patient}_dealigned.fa"
    shell:
        "seqkit seq -g {input} > {output}" 

rule align:
    input:
        "{prefix}/patient{patient}/consensus/masterconsensus_{patient}_dealigned.fa"
    output:
        "{prefix}/patient{patient}/consensus/masterconsensus_{patient}_aligned.fa"
    shell:
        "mafft --globalpair --maxiterate 500 {input} > {output}"

rule consensus:
    input:
        "{prefix}/patient{patient}/consensus/masterconsensus_{patient}_aligned.fa"
    output:
        "{prefix}/patient{patient}/consensus/masterconsensus_{patient}_consensus.fa"
    shell:
        """
        cons -sequence {input} -outseq {output} -name {wildcards.patient} -plurality 1
        bwa index {output}
        """

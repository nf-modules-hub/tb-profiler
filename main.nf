#!/usr/bin/env nextflow

/*
################
params
################
*/


params.saveBy = 'copy'
params.trimmed= true


/*
###############
Tb-profiler
###############
*/

inputUntrimmedRawFilePattern = "./*_{R1,R2}.fastq.gz"

inputTrimmedRawFilePattern = "./*_{R1,R2}.p.fastq.gz"

inputRawFilePattern = params.trimmed ? inputTrimmedRawFilePattern : inputUntrimmedRawFilePattern


Channel.fromFilePairs(inputFilePattern)
        .into {  ch_tbProfiler_in }



process tbProfiler {
    publishDir 'results/tbProfiler', mode: params.saveBy
    container 'quay.io/biocontainers/tb-profiler:2.8.6--pypy_0'

    input:
    tuple genomeName, file(genomeReads) from ch_tbProfiler_in

    output:
    tuple  path(fq_1_paired), path(fq_2_paired) into ch_tbProfiler_out

    script:

    """
    tb-profiler profile -1 ${genomeReads[0]} -2 ${genomeReads[1]}  -t 4 -p $genomeName
    """
    
    
}

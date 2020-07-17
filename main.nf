#!/usr/bin/env nextflow

/*
################
params
################
*/

ch_refFILE = Channel.value("$baseDir/refFILE")

inputFilePattern = "./*_{R1,R2}.fastq.gz"
Channel.fromFilePairs(inputFilePattern)
        .into {  ch_in_PROCESS }



process process {
#    publishDir 'results/PROCESS'
#    container 'PROCESS_CONTAINER'


    input:
    set genomeFileName, file(genomeReads) from ch_in_PROCESS

    output:
    path("""${PROCESS_OUTPUT}""") into ch_out_PROCESS


    script:
    #FIXME
    genomeName= genomeFileName.toString().split("\\_")[0]
    
    """
    CLI PROCESS
    """
}

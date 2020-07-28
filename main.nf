#!/usr/bin/env nextflow

/*
#==============================================
code documentation
#==============================================
*/


/*
#==============================================
params
#==============================================
*/

params.resultsDir = 'results/tbProfiler'
params.saveBy = 'copy'
params.collate = false
params.filePattern = "./*_{R1,R2}.fastq.gz"

/*
#==============================================
tb-profiler
#==============================================
*/

Channel.fromFilePairs(params.filePattern)
        .into {  ch_in_tbProfiler }


process tbProfiler {
    /*
     The downstream process `tb-profiler collate` expects all individual results to be in
     a folder called results
     */
    publishDir """${params.resultsDir}/results""", mode: params.saveBy
    container 'quay.io/biocontainers/tb-profiler:2.8.6--pypy_0'

    when:
    !params.collate

    input:
    tuple genomeName, file(genomeReads) from ch_in_tbProfiler

    output:
    path("""${genomeName}.results.json""") into ch_out_tbProfiler


    script:

    """
    tb-profiler profile -1 ${genomeReads[0]} -2 ${genomeReads[1]}  -t 4 -p $genomeName
    cp results/${genomeName}.results.json .
    """

}


Channel.fromPath("""${params.resultsDir}/results""")
        .into { ch_in_tbProfiler_collate }

process tbProfiler_collate {
    publishDir params.resultsDir, mode: params.saveBy
    container 'quay.io/biocontainers/tb-profiler:2.8.6--pypy_0'

    when:
    params.collate

    input:
    path("""${params.resultsDir}/results""") from ch_in_tbProfiler_collate

    output:
    tuple path("""tbprofiler.dr.indiv.itol.txt"""),
            path("""tbprofiler.dr.itol.txt"""),
            path("""tbprofiler.json"""),
            path("""tbprofiler.lineage.itol.txt"""),
            path("""tbprofiler.txt"""),
            path("""tbprofiler.variants.txt""") into ch_out_tbProfiler_collate


    script:

    """
    tb-profiler update_tbdb
    tb-profiler collate
    """
}


/*
#==============================================
# extra
#==============================================
*/

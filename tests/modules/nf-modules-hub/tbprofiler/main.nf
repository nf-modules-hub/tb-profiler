#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

include { TBPROFILER } from '../../../../modules/nf-modules-hub/tbprofiler/main.nf'

workflow test_tbprofiler {
    
    input = [
        [ id:'test', single_end:false ], // meta map
        file(params.test_data['sarscov2']['illumina']['test_paired_end_bam'], checkIfExists: true)
    ]

    TBPROFILER ( input )
}

# Nextflow wrapper for `tb-profiler` process.

## Pre-requisites

- Nextflow
- Docker 

**NOTE** If you plan to setup a basic server, then you can refer [minimal-nextflow-setup](https://github.com/nextflow-hub/minimal-nextflow-setup)

## Usage

```
nextflow run https://github.com/nextflow-hub/tb-profiler
```

## Options


- `collate`

For collating the individual results obtained by running `tb-profiler` you can set pass this option.

```
nextflow run https://github.com/nextflow-hub/tb-profiler --collate
```

- `saveBy`

By default, the pipeline publishes the results in the `resultsDir` by copying the relevant output.

- `resultsDir`

By default, it stores the result files locally inside the `results` directory.

## Customizing the script

The sole purpose of process wrappers in `nextflow-hub` is to keep the code small, clean and hackable with some  basic knowledge of `nextflow` scripting is required in this case.

If you have specific requirements, you are encouraged to fork/clone and update your version to accomodate your needs. 

## Contribution

Contribution, in all forms, is most welcome!

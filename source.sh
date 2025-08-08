#!/bin/bash
#
# =================================================================
# source.sh
# =================================================================
#
# Author: Rodrigo Barreiro
# Date: July 30, 2025
#
#
# =================================================================

WD=$(pwd)

# --- Helper Functions ---
print_header() {
    # Print header
    printf "\n\n"
    echo "================================================================"
    printf "  Running: ${COLOR}${BASH_SOURCE[0]}${RESET}\n"
    echo "================================================================"
    printf "\n"
}

print_footer() {
    # Print footer
    set +x # Disable command printing
    local duration=$SECONDS
    printf "\n${COLOR2}----------------------------------------------------------------${RESET}\n"
    printf "  Execution Time: $(($duration / 60))m $(($duration % 60))s | $(date)\n"
    echo "================================================================"
    printf "\n"
}

# --- Script Options and Error Handling ---
# | Option          | Description                                                                                             |
# | :-------------- | :------------------------------------------------------------------------------------------------------ |
# | `set -e`        | Exit immediately if a command exits with a non-zero status.                                             |
# | `set -u`        | Treat unset variables as an error when substituting.                                                    |
# | `set -o pipefail` | The return value of a pipeline is the status of the last command to exit with a non-zero status.      |
set -euo pipefail

# --- Custom command printing (PS4) ---
COLOR='\033[0;33m'
COLOR2='\033[0;30m'
RESET='\033[0m'
export PS4="\[${COLOR2}\]- \t \${LINENO} \[${COLOR}\]\${FUNCNAME[0]}\[${RESET}\] "

# --- Main Function ---
main() {
    # --- Starting ---
    print_header
    set -x # Start command printing
    # mkdir -p ${WD}/input
    mkdir -p ${WD}/steps
    # mkdir -p ${WD}/scripts

    # --- Functions ---
    step01_download_fastq
    step02_head_fastq
    step03_download_fastqc
    step04_run_fastqc
    step05_remove_raw_fastq
    step06_download_exome_fastq
    step07_run_fastqc_exome
    step08_unzip_fastqc_report
    step09_collect_fastqc_data
    step10_add_quarto_iconify

    # --- Ending ---
    mkdir -p ${WD}/output
    mkdir -p ${WD}/output/fastqc_reports
    cp ${WD}/steps/step09_collect_fastqc_data/*.txt ${WD}/output/fastqc_reports/

    set +x # End command printing
    print_footer
}


# --- Step Functions ---
step01_download_fastq(){
    # Download example data
    my_dir=${WD}/steps/step01_download_fastq
    mkdir -p ${my_dir}

    wget -O ${my_dir}/SRR622457_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR622/SRR622457/SRR622457_1.fastq.gz
    wget -O ${my_dir}/SRR622457_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR622/SRR622457/SRR622457_2.fastq.gz
}

step02_head_fastq(){
    # Cut 100,000 lines from the fastq file
    my_dir=${WD}/steps/step02_head_fastq
    mkdir -p ${my_dir}

    for gzip_file in ${WD}/steps/step01_download_fastq/*.fastq.gz; do
        # Extract the filename without the path and extension
        filename=$(basename "$gzip_file" .fastq.gz)
        
        # Use zcat to read the gzipped file, head to limit lines, and gzip to compress again
        zcat "$gzip_file" | head -n 10000000 | gzip > "${my_dir}/${filename}.fastq.gz" || true
    done
}

step03_download_fastqc(){
    # Download FastQC
    my_dir=${WD}/steps/step03_download_fastqc
    mkdir -p ${my_dir}

    wget -O ${my_dir}/fastqc_v0.12.1.zip  https://www.bioinformatics.babraham.ac.uk/projects/fastqc/fastqc_v0.12.1.zip 
    unzip ${my_dir}/fastqc_v0.12.1.zip  -d ${my_dir}
    chmod +x ${my_dir}/FastQC/fastqc
}

step04_run_fastqc(){
    # Run FastQC
    my_dir=${WD}/steps/step04_run_fastqc
    mkdir -p ${my_dir}

    # Run FastQC on the downloaded fastq files
    ${WD}/steps/step03_download_fastqc/FastQC/fastqc \
        -o ${my_dir} \
        ${WD}/steps/step02_head_fastq/*.fastq.gz
}

step05_remove_raw_fastq(){
    # Remove raw fastq files
    my_dir=${WD}/steps/step05_remove_raw_fastq
    mkdir -p ${my_dir}

    rm -rf ${WD}/steps/step01_download_fastq
}

step06_download_exome_fastq(){
    # Download exome fastq files

    # PCR-free high coverage data FastQs were very wierd. 
    my_dir=${WD}/steps/step06_download_exome_fastq
    mkdir -p ${my_dir}

    wget -O ${my_dir}/SRR1517848_1.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR151/008/SRR1517848/SRR1517848_1.fastq.gz
    wget -O ${my_dir}/SRR1517848_2.fastq.gz ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR151/008/SRR1517848/SRR1517848_2.fastq.gz
}

step07_run_fastqc_exome(){
    # Run FastQC on exome fastq files
    my_dir=${WD}/steps/step07_run_fastqc_exome
    mkdir -p ${my_dir}

    ${WD}/steps/step03_download_fastqc/FastQC/fastqc \
        -o ${my_dir} \
        ${WD}/steps/step06_download_exome_fastq/*.fastq.gz
}

step08_unzip_fastqc_report(){
    # Unzip FastQC report
    my_dir=${WD}/steps/step08_unzip_fastqc_report
    mkdir -p ${my_dir}

    for zip_file in ${WD}/steps/step07_run_fastqc_exome/*.zip; do
        unzip $zip_file -d ${my_dir}
    done
}

step09_collect_fastqc_data(){
    # Collect FastQC fasqc_data.txt files
    my_dir=${WD}/steps/step09_collect_fastqc_data
    mkdir -p ${my_dir}

    for fastqcdata_file in $(find ${WD}/steps/step08_unzip_fastqc_report -name "fastqc_data.txt"); do
        # Extract the filename without the path

        # Capture the last directory name
        fastqc_name=$(basename $(dirname "$fastqcdata_file"))
        
        # Copy the file to the target directory
        cp "$fastqcdata_file" "${my_dir}/${fastqc_name}.txt"
        
    done
}

step10_add_quarto_iconify(){
    quarto add mcanouil/quarto-iconify
}



# --- Run Main ---
main "$@"

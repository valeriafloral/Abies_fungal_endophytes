#!/bin/sh

#Valeria Flores
#Remove Mus musculus reads with BWA

#Make index
bwa index -a bwtsw ../../metadata/Mmusculus_genome/mouse_cds.fa
samtools faidx ../../metadata/Mmusculus_genome/mouse_cds.fa
makeblastdb -in ../../metadata/Mmusculus_genome/mouse_cds.fa -dbtype nucl

#Perform alignments for reads with BWA and filter out any reads that align to our database with Samtools (using the output from bwa, not blat)
bwa mem -t 4 ../../metadata/Mmusculus_genome/mouse_cds.fa ../../data/trimmed/mouse1_univec_bwa.fastq > ../../data/trimmed/mouse1_mouse_bwa.sam

#Convert .sam to .bam using samtools
samtools view -bS ../../data/trimmed/mouse1_mouse_bwa.sam > ../../data/trimmed/mouse1_mouse_bwa.bam

#Generate fastq outputs for all reads that mapped to the host reference genome (-F 4)
samtools fastq -n -F 4 -0 ../../data/trimmed/mouse1_mouse_bwa_contaminats.fastq ../../data/trimmed/mouse1_mouse_bwa.bam

#Generate fastq outputs for all reads that did not map to the host reference genome (-f 4)
samtools fastq -n -f 4 -0 ../../data/trimmed/mouse1_mouse_bwa.fastq ../../data/trimmed/mouse1_mouse_bwa.bam

#Statistics
samtools flagstat ../../data/trimmed/mouse1_mouse_bwa.bam > ../../data/reports/hostmap.txt

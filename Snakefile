import os 
import pandas as pd
from os.path import join
from snakemake.remote.GS import RemoteProvider as GSRemoteProvider
GS = GSRemoteProvider()
GS_PREFIX = "bkt-test-926"

""" Snakefile for running 10x alevin pipeline """

configfile: "config.yaml"

DATA =          config["DATA"]
RESULTS =       config["RESULTS"]
GEX_INDEX =     config["GEX_INDEX"]
FEATURE_INDEX = config["FEATURE_INDEX"]
GEX =           config["GEX"]
ADT =           config["ADT"]
FASTQS =        config["FASTQS"]
CAPTURES =      config["CAPTURES"]
WHITELIST_V2 =  config["WHITELIST_V2"]
WHITELIST_V3 =  config["WHITELIST_V3"]
FASTP_ADAPTERS = config["FASTP_ADAPTERS"]
SAMPLES_DF =    pd.read_csv(FASTQS, sep = "\t")
CAPTURES_DF =   pd.read_csv(CAPTURES, sep = "\t")

rule all:
    input:
      # generate gex counts (no BAM)
      expand("{results}/gex/{sample}/{sample}_Solo.out/Barcodes.stats", results = RESULTS, sample = GEX),
      # generate adt counts
      expand("{results}/{lib}/{sample}/{sample}_Solo.out/Barcodes.stats", results = RESULTS, sample = ADT, lib = "adt"),
      # generate dropkick h5ad
      expand("{results}/dropkick/{sample}_dropkick.h5ad", results = RESULTS, sample = GEX),
      # generate dropkick qc
      expand("{results}/dropkick/{sample}-qc.png", results = RESULTS, sample = GEX),
      # run fastp on each FASTQ pair
      expand("{results}/fastp/{fastq}.html", results = RESULTS, fastq = SAMPLES_DF.basename)

include: "rules/cutadapt_star.snake"

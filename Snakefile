import os 
import pandas as pd
from os.path import join
from snakemake.remote.GS import RemoteProvider as GSRemoteProvider
GS = GSRemoteProvider()
GS_PREFIX = "bkt-test-926"

""" Snakefile for running 10x alevin pipeline """

configfile: "config.yaml"

DATA = GS_PREFIX+config["DATA"]
RESULTS = GS_PREFIX+config["RESULTS"]
GEX_INDEX = GS_PREFIX+config["GEX_INDEX"]
FEATURE_INDEX = GS_PREFIX+config["FEATURE_INDEX"]
GEX = config["GEX"]
ADT = config["ADT"]
FASTQS = config["FASTQS"]
CAPTURES = config["CAPTURES"]
WHITELIST_V2 = GS_PREFIX+config["WHITELIST_V2"]
WHITELIST_V3 = GS_PREFIX+config["WHITELIST_V3"]
SAMPLES_DF = pd.read_csv(FASTQS, sep = "\t")
CAPTURES_DF = pd.read_csv(CAPTURES, sep = "\t")
FASTQS = SAMPLES_DF.fastqs

rule all:
    input:
      # generate gex counts (no BAM)
      expand("{results}/gex/{sample}/{sample}_Solo.out/Barcodes.stats", results = RESULTS, sample = GEX)
      # generate adt counts
      #expand("{results}/{lib}/{sample}/{sample}_Solo.out/Barcodes.stats", results = RESULTS, sample = ADT, lib = "adt")

include: "rules/cutadapt_star.snake"

# Replication Package for "Real-time Hurricane Damage Nowcasts"
Andrew B. Martinez

Overview & contents

The code in this replication material generates the 2 equations, 6 figures and 6 tables for the paper "Real-time Hurricane Damage Nowcasts". Each figure and table is generated separately by its corresponding script file Figure_[xx]_*.* or Table_[xx]_*.*, respectively.

The main contents of the repository are the following:

Data/: folder of underlying data files
Figure_[xx]_*.*: R or Ox scripts to create the respective figures
Table_[xx]_*.*: R or Ox scripts to create the respective tables
Equation_[xx]_*.Ox: Ox scripts to replicate the respective equations


Instructions & computational requirements.
All file paths are relative to the root of the replication package. Please set your working directory accordingly.

The analysis files can be run individually, in any order.

These analyses were run on R 4.5.0 and Ox 9.3, and I explicitly use the following R packages in the analysis files: readxl (1.4.5), tidyverse (2.0.0), lmtest (0.9.40), sandwich (3.1.1),.

A comprehensive list of dependencies can be found in the renv.lock file. For a convenient setup in a (local) R session, we recommend using the renv package. The following steps are required once:

Note that the code is a mix of R code and Ox code (which requires Ox Professional to run some of the packages).

The data underyling the analysis is in the data folder. Some of the data processing is done in the codes here but generating of the real-time vintages and cleaning of them was done elsewhere.

If any of the data in this repository is used elsewhere then please be sure and cite the original paper. See the paper as well as Martinez (2020) for details on the data descriptions.



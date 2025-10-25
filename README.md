# Replication Package for "Real-time Hurricane Damage Nowcasts"
Andrew B. Martinez

## Overview & contents

The code in this replication material generates the 2 equations, 6 figures and 6 tables for the paper "Real-time Hurricane Damage Nowcasts". Each figure and table is generated separately by its corresponding script file Figure_[xx]_*.* or Table_[xx]_*.*, respectively.

The main contents of the repository are the following:

Data/: folder of underlying data files

Figure_[xx]_*.*: R or Ox scripts to create the respective figures

Table_[xx]_*.*: R or Ox scripts to create the respective tables
ß
Equation_[xx]_*.Ox: Ox scripts to replicate the respective equations


## Instructions & computational requirements.
All file paths are relative to the root of the replication package. Please set your working directory accordingly.

The analysis files can be run individually, in any order.

These analyses were run on R 4.5.0 and Ox 9.3, and I explicitly use the following R packages in the analysis files: readxl (1.4.5), tidyverse (2.0.0), lmtest (0.9.40), and sandwich (3.1.1).

Note that some parts of the Ox code requires an Ox Professional license to run. 

## Data availability 

The data underyling the analysis is in the data folder. Some of the data processing is done in the code here but the real-time vintages were generated  and cleaned elsewhere.

### Commercial Damage Nowcasts

These were collected through a number of sources and is meant to be as comprehensive as possible for the storms that we consider. My aims is to update this at least once per hurricane season. As described in the paper the main source is through news article searches in LexisNexis as well as alternative catastrophe modeler websites. However a fairly good recent source is Artemis.bm (https://www.artemis.bm/) which generally tracks commercial model estimates as they are released. 

### Official Damages

These primarily come from NOAA's Tropical Cyclone Reports released for each hurricane in the months after it occurs (https://www.nhc.noaa.gov/data/tcr/). Additionally, while it was still being updated NOAA's NCEI Billion Dollar Disaster database was used which feeds directed in the the Tropical Cyclone reports and provides uncertainty about the estimates (https://www.ncei.noaa.gov/access/billions/). This is no longer being updated but the data is still available. Real-time vintages for the Billion Dollar Disasters database was obtained from NOAA (https://www.ncei.noaa.gov/access/metadata/landing-page/bin/iso?id=gov.noaa.nodc%3A0209268) and was converted from real to nominal damages using the appropriate CPI vintage obtained from ALFRED (https://alfred.stlouisfed.org/series?seid=CPIAUCSL). Additional data on damages was obtained from the EM-DAT database (https://www.emdat.be/)

### Real-time Hazards 

The hazard data is almost exclusively obtained from  NOAA's Tropical Cyclone Reports released for each hurricane in the months after it occurs (https://www.nhc.noaa.gov/data/tcr/) which provides information on central pressure, storm surge and rainfall. Additionally, real-time vintages of storm surge, rainfall and central pressure were obtained from regular storm advisories as close to landfall as possible (https://www.nhc.noaa.gov/archive/2025/). This archive also provides the historical information on the forecasts and location of the storm. Additional official rainfall data was obtained from NOAA's Tropical Cyclone Rainfall data (https://www.wpc.ncep.noaa.gov/tropical/rain/tcrainfall.html) as well as near-real time data from CoCoRaHS (https://www.cocorahs.org/) which helps inform the NOAA data.

### Real-time Vulnerabilities

The vulnerability data is obtained from a mixture of sources from the Bureau of Economic Analysis and Census. The BEA's real-time vintage data on personal income and population by county (https://www.bea.gov/data/income-saving/personal-income-county-metro-and-other-areas) serves as the backbone of the analysis and is supplemented by there real-time vintages of state-level and national income and population data. The housing unit and area data is obtained directly from Census (https://www.census.gov/data/tables/time-series/demo/popest/2020s-total-housing-units.html).

## References

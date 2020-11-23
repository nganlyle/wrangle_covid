## LTC homes analysis
**1. Webscraping for LTC Homes Data**

Type | Name | Details
--|--|--
Script | webscrape_ltc_general_database.ipynb
Input files | None
Output file | webscrape_ltc_general_database.csv

A database of LTC homes in Ontario was created by webscraping the website   [Reports on Long-Term Care Homes](http://publicreporting.ltchomes.net/en-ca/Default.aspx).
The following information was scraped:

  A. Home profile information

        1. Name
        2. Address
        3. LHIN
        4. Licensee
        5. Management
        6. Home Type (For-profit, Non-profit, Municipal)
        7. Number of Beds
        8. Approved short stay beds
        9. Residents' Council
        10. Family Council
        11. Accreditation

  B. Home inspections information

        1. Total number of inspections
            - Total available
            - Total in the last 5 years (since January 1, 2015)
            - Total in the last 2 years (since January 1, 2018)
        2. Total number of complaints inspections
            - Total available
            - Total in the last 5 years (since Dec 31, 2014)
            - Total in the last 2 years (since Dec 31, 2017)
        3. Total number of critical incident inspections
            - Total available
            - Total in the last 5 years (since Dec 31, 2014)
            - Total in the last 2 years (since Dec 31, 2017)
        4. Total number of inspections accompanied by an order(s) of the inspector
            - Total available
            - Total in the last 5 years (since Dec 31, 2014)
            - Total in the last 2 years (since Dec 31, 2017)
        5. Date of the first inspection report

On initial webscraping 651 homes were identified. Subsequently, 26 homes were removed (leaving 625) as follows:

        1. Closed, 20
        2. Merged with another home, 1
        3. Missing all profile information, 2
        4. No inspections for for 2 years, 3

**2. ODHF Data Preparation**

Type | Name | Details
--|--|--
Script | ODHF_preparation.ipynb
Input files | odhf_v1.csv | Downloaded from [Open Database of Healthcare Facilities](https://www.statcan.gc.ca/eng/lode/databases/odhf) at Statistics Canada. Re-save as CSV UTF-8.
Output file | odhf_v1_ontario.csv

The ODHF data was filtered for facilities in Ontario only.

**3. COVID Data Preparation**

The COVID data were downloaded from the Ontario [Data Catalogue](https://data.ontario.ca/dataset/long-term-care-home-covid-19-data). The data consist of 2 csv files - one with homes with active outbreaks and another with homes with resolved outbreaks. The data are essentially daily snapshots of the website listing homes with an active or resolved outbreak on any given day.

- Data for filtered for observations up through to and including July 31, 2020.
- Censored values <5 were replaced with 1
- Extracted maximum values of resident cases, resident deaths (which are cumulative), and staff cases along with the dates when these occurred
- Extracted dates when a home first appeared on the active and resolved lists

Type | Name
--|--
Script | outbreaks_0731.ipynb
Input files |  <ul><li>activeltcoutbreak_oct8.csv</li><li>resolvedltc_oct8.csv</li>
Output file | ltc_outbreaks0731.csv

**4. Merge LTC Homes Datasets**

Type | Name
--|--
Script | merge_genLTC_covidLTC_odhf.ipynb
Input files |  <ul><li>webscrape_ltc_general_database.csv</li><li>*merged_ltc.csv (scraped in May 13, 2020)*</li><li>*merged_ltc_secondScrape.csv (scraped Jun 5, 2020)*</li><li>ltc_outbreaks0731.csv</li><li>ohdf_v1_ontario.csv</li>
Output file | merged_LTC_odhf.csv

In this step the general LTC homes data was merged with the COVID LTC homes data and the ODHF.

**5. LTC Home Quality Data**

1. Data Preparation

The file `hqo-2020-long-term-care-indicators.xlsx` was downloaded from [Health Quality Ontario](https://www.hqontario.ca/System-Performance/Long-Term-Care-Home-Performance). The data was opened in Microsoft Excel where headers where removed and the sheet containing data about specific long term care homes was saved as a CSV UTF-8 file `hqo-2020-quality.csv`.

2. Data Cleaning and Merging

Type | Name
--|--
Script | merge_LTC_odhf_WITHquality.ipynb
Input files |  <ul><li>hqo-2020-quality.csv</li><li>merged_LTC_odhf.csv</li></ul>
Output file | merged_LTC_odhf_quality.csv

Note for 10 homes:
  - 4 homes did not have any quality data
  - 6 homes had incomplete quality data

# Housing Dataset Data Cleaning Project

## Table of Contents
1. [Introduction](#introduction)
2. [Initial Data Inspection](#initial-data-inspection)
3. [Data Cleaning Steps](#data-cleaning-steps)
    - [Address NULL Values Correction](#address-null-values-correction)
    - [Splitting Property Address](#splitting-property-address)
    - [Splitting Owners Address](#splitting-owners-address)
    - [Standardizing 'Sold as Vacant' Column](#standardizing-sold-as-vacant-column)
    - [Removing Duplicates](#removing-duplicates)
    - [Removing Unused Columns](#removing-unused-columns)
4. [Conclusion](#conclusion)

## Introduction
The Housing Dataset Data Cleaning project aims to ensure data consistency, accuracy, and reliability within the "Housing" dataset. The dataset underwent various cleaning procedures to ensure its optimal use for subsequent analysis.

## Initial Data Inspection
The first step involved a thorough inspection of the dataset to understand its structure and anomalies. This helped in identifying the specific areas that required data cleaning.

## Data Cleaning Steps

### Address NULL Values Correction
Several properties had NULL values in their Address column. Through our inspection, we found that the 'Parcel Id' column can be used to deduce the missing Address values. We executed queries to fetch these addresses using the associated 'Parcel Id' and populated the missing values accordingly.

### Splitting Property Address
The original dataset had the property's address and city integrated into a single column. We divided this into two distinct columns - 'Address' and 'City' - for a clearer and structured representation.

### Splitting Owners Address
Unlike the property address, the owner's address included the address, city, and state all in one column. We employed a different method from the previous step to separate these values into three new columns: 'Address', 'City', and 'State'.

### Standardizing 'Sold as Vacant' Column
The 'Sold as Vacant' column contained multiple representations for the same data (Y, N, Yes, No). To achieve consistency, we converted all values to a standardized format: 'Yes' and 'No'.

### Removing Duplicates
To ensure data integrity, we identified and removed duplicate entries from the dataset. This was achieved by creating a Common Table Expression (CTE) to identify duplicates and subsequently deleting them.

### Removing Unused Columns
After all the cleaning processes, some columns became obsolete. We executed queries to identify and delete these columns to keep the dataset lean and focused.

## Conclusion
This data cleaning project has transformed the initial "Housing" dataset into a cleaned, consistent, and reliable version, ready for further analysis. Ensuring such a high-quality dataset is fundamental for deriving accurate insights in any data-driven decision-making process.

Happy analyzing!

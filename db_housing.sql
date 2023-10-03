-- Reviewing the whole data
SELECT *
FROM db_housing; 


-- Adding values to the Null Property Addresses, taking into account the Parcel Id.
SELECT 
    a.ParcelID, 
    a.PropertyAddress, 
    b.ParcelID, 
    b.PropertyAddress,
    ISNULL(a.PropertyAddress, b.PropertyAddress)
FROM db_housing a
JOIN db_housing b 
    ON a.ParcelID = b.ParcelID 
    AND a.UniqueID <> b.UniqueID
WHERE a.PropertyAddress IS NULL;

UPDATE a
SET PropertyAddress = ISNULL(a.PropertyAddress, b.PropertyAddress)
FROM db_housing a
JOIN db_housing b 
    ON a.ParcelID = b.ParcelID AND a.UniqueID <> b.UniqueID
WHERE a.PropertyAddress IS NULL;


-- Splitting Property Address into multiple columns (Address and City) using Substrings.
SELECT PropertyAddress
FROM db_housing;

SELECT
    SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1) AS Address,
    SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) +2, LEN(PropertyAddress)) AS City
FROM db_housing;

ALTER TABLE db_housing
    ADD Address NVARCHAR(255);

UPDATE db_housing
SET Address = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1);

ALTER TABLE db_housing
    ADD City NVARCHAR(255);

UPDATE db_housing
SET City = SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) +2, LEN(PropertyAddress));

SELECT *
FROM db_housing;


-- Splitting Owner Address into multiple columns (Address, City and State) using ParseName.
SELECT OwnerAddress
FROM db_housing;

SELECT
    PARSENAME(REPLACE(OwnerAddress, ',', '.'), 3) AS OwAddress,
    PARSENAME(REPLACE(OwnerAddress, ',', '.'), 2) AS OwCity,
    PARSENAME(REPLACE(OwnerAddress, ',', '.'), 1) AS OwState
FROM db_housing;

ALTER TABLE db_housing
    ADD Owner_Address NVARCHAR(255);

UPDATE db_housing
SET Owner_Address = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 3);

ALTER TABLE db_housing
    ADD Owner_City NVARCHAR(255);

UPDATE db_housing
SET Owner_City = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 2);

ALTER TABLE db_housing
    ADD Owner_State NVARCHAR(255);

UPDATE db_housing
SET Owner_State = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 1);


-- Change the results of the Sold as Vacant column to only be Yes and No.
SELECT DISTINCT SoldAsVacant
FROM db_housing;

SELECT
    SoldAsVacant,
    CASE WHEN SoldAsVacant = 'Y' THEN 'Yes'
         WHEN SoldAsVacant = 'N' THEN 'No'
         ELSE SoldAsVacant
    END
FROM db_housing;

UPDATE db_housing
SET SoldAsVacant =  CASE WHEN SoldAsVacant = 'Y' THEN 'Yes'
                        WHEN SoldAsVacant = 'N' THEN 'No'
                        ELSE SoldAsVacant
                    END;


-- Remove Duplicates.
WITH CTE_Row_Number AS(
SELECT 
    *,
    ROW_NUMBER() OVER (PARTITION BY ParcelID, PropertyAddress, SaleDate, SalePrice, LegalReference ORDER BY UniqueID) AS row_num
FROM db_housing
)

DELETE
FROM CTE_Row_Number
WHERE row_num > 1;


-- Delete unused columns.
ALTER TABLE db_housing
DROP COLUMN OwnerAddress, PropertyAddress;

SELECT *
FROM db_housing;
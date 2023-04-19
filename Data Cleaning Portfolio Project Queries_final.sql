/* Cleaning Data in SQL Queries */

Select * From NashvilleHousing

-- Standardize Date Format

SELECT SaleDate FROM NashvilleHousing

Select SaleDate, CONVERT(Date,SaleDate) AS ConvertedSaleDate
From NashvilleHousing

Update NashvilleHousing
SET SaleDate = CONVERT(Date,SaleDate)

-- If it doesn't Update properly

ALTER TABLE NashvilleHousing
Add SaleDateConverted Date;

Update NashvilleHousing
SET SaleDateConverted = CONVERT(Date,SaleDate)

SELECT SaleDateConverted FROM NashvilleHousing

--------------------------------------------------------------------------------------------------------------------------

-- Populate Property Address data

Select * From NashvilleHousing
--Where PropertyAddress is null
ORDER BY ParcelID


Select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress,b.PropertyAddress)
From NashvilleHousing a
JOIN NashvilleHousing b
	on a.ParcelID = b.ParcelID
	AND a.[UniqueID ] <> b.[UniqueID ]
Where a.PropertyAddress is null


Update a
SET PropertyAddress = ISNULL(a.PropertyAddress,b.PropertyAddress)
From NashvilleHousing a
JOIN NashvilleHousing b
	on a.ParcelID = b.ParcelID
	AND a.[UniqueID ] <> b.[UniqueID ]
Where a.PropertyAddress is null

--------------------------------------------------------------------------------------------------------------------------

-- Breaking out Address (Property and Owner) into Individual Columns (Address, City, State)

Select PropertyAddress From NashvilleHousing
--Where PropertyAddress is null
--order by ParcelID

SELECT
SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1 ) as Address,
SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1 , LEN(PropertyAddress)) as Address
From NashvilleHousing


ALTER TABLE NashvilleHousing
Add PropertySplitAddress Nvarchar(255);

SELECT PropertySplitAddress FROM NashvilleHousing

Update NashvilleHousing
SET PropertySplitAddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1 )


ALTER TABLE NashvilleHousing
Add PropertySplitCity Nvarchar(255);

Update NashvilleHousing
SET PropertySplitCity = SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) + 1 , LEN(PropertyAddress))

SELECT PropertySplitCity FROM NashvilleHousing

Select * From NashvilleHousing

Select OwnerAddress From NashvilleHousing

Select
PARSENAME(REPLACE(OwnerAddress, ',', '.') , 3) AS OwnerSplitAddress,
PARSENAME(REPLACE(OwnerAddress, ',', '.') , 2) AS OwnerSplitCity,
PARSENAME(REPLACE(OwnerAddress, ',', '.') , 1) AS OwnerSplitState
From NashvilleHousing



ALTER TABLE NashvilleHousing
Add OwnerSplitAddress Nvarchar(255);

Update NashvilleHousing
SET OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 3)


ALTER TABLE NashvilleHousing
Add OwnerSplitCity Nvarchar(255);

Update NashvilleHousing
SET OwnerSplitCity = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 2)


ALTER TABLE NashvilleHousing
Add OwnerSplitState Nvarchar(255);

Update NashvilleHousing
SET OwnerSplitState = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 1)

--------------------------------------------------------------------------------------------------------------------------

-- Change "Y" and "N" to "Yes" and "No" in "Sold as Vacant" field


Select Distinct(SoldAsVacant), Count(SoldAsVacant) AS #SoldAsVacant
From NashvilleHousing
Group by SoldAsVacant
order by 2


Select SoldAsVacant,
CASE
	When SoldAsVacant = 'Y' THEN 'Yes'
	When SoldAsVacant = 'N' THEN 'No'
	ELSE SoldAsVacant
END AS WhereToUpdate
From NashvilleHousing


Update NashvilleHousing
SET SoldAsVacant =
CASE
	When SoldAsVacant = 'Y' THEN 'Yes'
	When SoldAsVacant = 'N' THEN 'No'
	ELSE SoldAsVacant
END

-----------------------------------------------------------------------------------------------------------------------------------------------------------

-- Remove Duplicates
-- First, let's check which duplicates we have, considering these are the ones which the rows are identical

WITH RowNumCTE AS(
Select *, ROW_NUMBER() OVER (
	PARTITION BY ParcelID,
		PropertyAddress,
		SalePrice,
		SaleDate,
		LegalReference
	ORDER BY UniqueID) row_num
From NashvilleHousing)
Select * From RowNumCTE
Where row_num > 1
Order by PropertyAddress

-- Let's now delete the identified duplicate rows

WITH RowNumCTE AS(
Select *, ROW_NUMBER() OVER (
	PARTITION BY ParcelID,
		PropertyAddress,
		SalePrice,
		SaleDate,
		LegalReference
	ORDER BY UniqueID) row_num
From NashvilleHousing)
DELETE From RowNumCTE
Where row_num > 1

---------------------------------------------------------------------------------------------------------

-- Delete Unused Columns
-- NOTE: Be cautions when doing this because, in general, this is not a good practice to delete/change raw data, it is just for demonstration purposes only

Select * From NashvilleHousing
Select OwnerAddress, TaxDistrict, PropertyAddress, SaleDate From NashvilleHousing

ALTER TABLE NashvilleHousing
DROP COLUMN OwnerAddress, TaxDistrict, PropertyAddress, SaleDate

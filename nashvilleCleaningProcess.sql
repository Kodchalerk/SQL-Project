#Overview data
Select
*
from
new_project.`nashville housing data for data cleaning`; 

#Change format of Saledate
SELECT
*,
cast(str_to_date(SaleDate,'%M %d,%Y') as date) as date
FROM new_project.`nashville housing data for data cleaning`;

#Create New table
CREATE TABLE
nashville1
SELECT
*,
cast(str_to_date(SaleDate,'%M %d,%Y') as date) as date
FROM new_project.`nashville housing data for data cleaning`;

#Working with new table
Select
*
from
nashville1;

## Looking at propertyaddress
	## Checking for Null values
Select
PropertyAddress
from
nashville1
where
PropertyAddress is null or
PropertyAddress = ' ';
	##Extract Address
select
	substring_index(PropertyAddress, ',' , 1 ) as Address1,
	substring_index(PropertyAddress, ',' , -1 ) as Address2
from
	nashville1;
## Add Adress column to the current table
Alter table
	nashville1
Add column
	Address1 nvarchar(255);
    
Alter table
	nashville1
Add column
	Address2 nvarchar(255);
## Update column
Update nashville1
SET Address1 = substring_index(PropertyAddress, ',' , 1);

Update nashville1
SET Address2 = substring_index(PropertyAddress, ',' , -1);


## Extract Owner Address and update table
Select
	substring_index(OwnerAddress, ',' , 1),
    substring_index(OwnerAddress, ',' , -1),
	substring_index(substring_index(OwnerAddress, ',' , 2), ',', 1)
from
	nashville1;
	##Create column
Alter table
	nashville1
Add column
	OwnerAddress1 nvarchar(255);

Alter table
	nashville1
Add column
	OwnerAddress2 nvarchar(255);

Alter table
	nashville1
Add column
	OwnerAddress3 nvarchar(255);
    
    ##Update column
Update nashville1
SET OwnerAddress1 = substring_index(OwnerAddress, ',' , 1);

Update nashville1
SET OwnerAddress3 = substring_index(OwnerAddress, ',' , -1);

Update nashville1
SET OwnerAddress2 = substring_index(substring_index(OwnerAddress, ',' , 2), ',', 1);

## Change Y and N to Yes and No for consistency in SoldAsVacant
select
distinct(SoldAsVacant), count(SoldAsVacant)
from
nashville1
group by
SoldAsVacant
order by
2;

Select
	SoldAsVacant,
    Case when SoldAsVacant = 'Y' then 'Yes'
	when SoldAsVacant = 'N' then 'No'
    else SoldAsVacant
    end as SoldAsVacant1
from
nashville1;

Update Nashville1
set SoldAsVacant = Case when SoldAsVacant = 'Y' then 'Yes'
					when SoldAsVacant = 'N' then 'No'
					else SoldAsVacant
					end;

## Remove duplicates
With nashville2 as (
Select
	*,
    row_number() over (
    partition by ParcelID,
				 PropertyAddress,
                 SalePrice,
                 SaleDate,
                 LegalReference
                 order by
                 UniqueID) as row_num
from
	nashville1
)
Select
*
from
nashville2;
## Deleting duplicate in CTE
-- DELETE
-- from
-- nashville1 using nashville1 Join RowNumCTE
-- on nashville1.UniqueID = RowNumCTE.UniqueID
-- where
-- RowNumCTE.row_num > 1;

##Create and new table nashvillecleanded
CREATE table nashvilleCleaned (
With nashville2 as (
Select
	*,
    row_number() over (
    partition by ParcelID,
				 PropertyAddress,
                 SalePrice,
                 SaleDate,
                 LegalReference
                 order by
                 UniqueID) as row_num
from
	nashville1
)
Select
*
from
nashville2
);

## drop unused column
Alter table nashvillecleaned
drop column OwnerAddress,
drop column TaxDistrict,
drop column PropertyAddress;

Alter table nashvillecleaned
rename column date to SaleDate;










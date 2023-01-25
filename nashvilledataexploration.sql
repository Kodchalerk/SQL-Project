## Link to Visualization
https://public.tableau.com/app/profile/kodchalerk.moolkul/viz/PropertySoldRecordofTenneseeOwners/Dashboard2


## Overview data
select
*
from
nashvillecleaned;

--------
select
SoldAsVacant, count(SoldAsVacant)
from
nashvillecleaned
group by
SoldAsVacant;

select
UniqueID, (SalePrice - TotalValue) as Profit
from
nashvillecleaned
order by
2 DESC;


###Table1 number of buildings sold in each yearbuilt 

select
YearBuilt, count(YearBuilt)
from
nashvillecleaned
group by
YearBuilt
order by
1;

###Table2 number of buildings sold in each year

Select
Year(SaleDate) as s, count(Year(SaleDate))
from
nashvillecleaned
group by
s
order by
s;

###Table 3 Property Address
Select
PropertyAddress2, count(PropertyAddress2)
from
nashvillecleaned
group by
PropertyAddress2
order by
2 DESC;

## Table 4 Number of property types
Select
LandUse, count(LandUse)
from
nashvillecleaned
group by
LandUse
order by
2 DESC;
## Table 5Average sale price for each type of property (without the property that has less than 5)
select
LandUse, avg(SalePrice)
from
nashvillecleaned
where
LandUse <> 'PARSONAGE' and
LandUse <> 'GREENBELT' and
LandUse <> 'FOREST' and 
LandUse <> 'OFFICE BLDG (ONE OR TWO STORIES)' and
LandUse <> 'MOBILE HOME' and
LandUse <> 'DAY CARE CENTER' and
LandUse <> 'TERMINAL/DISTRIBUTION WAREHOUSE' and
LandUse <> 'APARTMENT: LOW RISE (BUILT SINCE 1960)' and
LandUse <> 'NON-PROFIT CHARITABLE SERVICE' and
LandUse <> 'GREENBELT/RES' and
LandUse <> 'CLUB/UNION HALL/LODGE' and
LandUse <> 'LIGHT MANUFACTURING' and
LandUse <> 'CONVENIENCE MARKET WITHOUT GAS' and
LandUse <> 'STRIP SHOPPING CENTER' and
LandUse <> 'ONE STORY GENERAL RETAIL STORE'
group by
LandUse
order by
2 DESC;

### Table 6 Average LandValue and Building Value in each city
select
PropertyAddress2, AVG(LandValue), AVG(BuildingValue)
from
nashvillecleaned
group by
PropertyAddress2;

##
Select
OwnerAddress3, count(OwnerAddress3)
from
nashvillecleaned
group by
OwnerAddress3;



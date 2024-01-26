--district names group by year
select 
Year,
Dist_Name
from dbo.[ICRISAT-District Level farm harvest prices]
group by Year,Dist_Name
order by Year desc

--in which year rice harvest price was the highest in howrah
select 
Year,
avg(rice_harvest_price_rs_per_quintal) as max_price
from dbo.[ICRISAT-District Level farm harvest prices]
group by Year
order by max_price desc,Year desc

--unpivot of farm harvest prices table (top 5 crops)

with cte as (
select
Year,
Dist_Name,
avg(RICE_HARVEST_PRICE_Rs_per_Quintal) as rice,
avg(PADDY_HARVEST_PRICE_Rs_per_Quintal) as paddy,
avg(WHEAT_HARVEST_PRICE_Rs_per_Quintal)as wheat,
avg(PIGEONPEA_HARVEST_PRICE_Rs_per_Quintal)as pigeon_pea,
avg(BARLEY_HARVEST_PRICE_Rs_per_Quintal) as barley,
avg(CHICKPEA_HARVEST_PRICE_Rs_per_Quintal) as chick_pea,
avg(RAPE_AND_MUSTARD_HARVEST_PRICE_Rs_per_Quintal) as rm,
avg(SUGARCANE_GUR_HARVEST_PRICE_Rs_per_Quintal) as sugarcane

from dbo.[ICRISAT-District Level farm harvest prices]
group by Dist_Name,Year
)

select
top 5
crop,
avg(production) as avg_production
from cte
unpivot (
production for crop in (
rice,paddy,wheat,barley,chick_pea,rm,sugarcane,pigeon_pea)
) as unpivoted
where production >= 1
group by crop
order by avg_production desc;
 

 alter table [ICRISAT-District Level farm harvest prices]
 alter column PADDY_HARVEST_PRICE_Rs_per_Quintal float;

 alter table [ICRISAT-District Level farm harvest prices]
 alter column PIGEONPEA_HARVEST_PRICE_Rs_per_Quintal float;
 
 --unpivot of farm harvest table (top 5 district)
with cte as (
select
Year,
Dist_Name,
avg(RICE_HARVEST_PRICE_Rs_per_Quintal) as rice,
avg(PADDY_HARVEST_PRICE_Rs_per_Quintal) as paddy,
avg(WHEAT_HARVEST_PRICE_Rs_per_Quintal)as wheat,
avg(PIGEONPEA_HARVEST_PRICE_Rs_per_Quintal)as pigeon_pea,
avg(BARLEY_HARVEST_PRICE_Rs_per_Quintal) as barley,
avg(CHICKPEA_HARVEST_PRICE_Rs_per_Quintal) as chick_pea,
avg(RAPE_AND_MUSTARD_HARVEST_PRICE_Rs_per_Quintal) as rm,
avg(SUGARCANE_GUR_HARVEST_PRICE_Rs_per_Quintal) as sugarcane

from dbo.[ICRISAT-District Level farm harvest prices]
group by Dist_Name,Year
)

select
top 5
Dist_Name,
max(crop) as print_purpose,
avg(production) as avg_production_price
from cte
unpivot (
production for crop in (
rice,paddy,wheat,barley,chick_pea,rm,sugarcane,pigeon_pea)
) as unpivoted
where production >= 1
group by Dist_Name
order by avg_production_price desc;
 
 --unpivot of farm harvest table (top 5 year)
with cte as (
select
Year,
Dist_Name,
avg(RICE_HARVEST_PRICE_Rs_per_Quintal) as rice,
avg(PADDY_HARVEST_PRICE_Rs_per_Quintal) as paddy,
avg(WHEAT_HARVEST_PRICE_Rs_per_Quintal)as wheat,
avg(PIGEONPEA_HARVEST_PRICE_Rs_per_Quintal)as pigeon_pea,
avg(BARLEY_HARVEST_PRICE_Rs_per_Quintal) as barley,
avg(CHICKPEA_HARVEST_PRICE_Rs_per_Quintal) as chick_pea,
avg(RAPE_AND_MUSTARD_HARVEST_PRICE_Rs_per_Quintal) as rm,
avg(SUGARCANE_GUR_HARVEST_PRICE_Rs_per_Quintal) as sugarcane

from dbo.[ICRISAT-District Level farm harvest prices]
group by Dist_Name,Year
)

select
top 5
YEAR,
max(crop) as print_purpose,
avg(production) as avg_production_price
from cte
unpivot (
production for crop in (
rice,paddy,wheat,barley,chick_pea,rm,sugarcane,pigeon_pea)
) as unpivoted
where production >= 1
group by year
order by avg_production_price desc;
 


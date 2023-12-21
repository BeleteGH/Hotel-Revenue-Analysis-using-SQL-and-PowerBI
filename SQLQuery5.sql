/*
Hotel Data Analysis to understand if revenue is increasing and see the trends

Skills applied: creatng database, import excel data, aggregate functions, Window functions, CTE, Joins, link with PowerBI, dashboard using PowerBI

and we will build visual data story using PowerBI

*/

--- First lets check the data from each table 

Select * from Hotel2018 
Select * from Hotel2019
Select * from Hotel2020

--- Lets combine all the three data sets 
Select * from Hotel2018 
union 
Select * from Hotel2019
union 
Select * from Hotel2020
--- now we can see the number of rows has increased as we have appended all the three files 

/* Exploratory Data Analysis
Is the hotel revenue increasing?  from the data, revenue is number of days multiplied by daily rate. 
Lets first create temporary table using CTE 
*/

With Hotels as
(
Select * from Hotel2018 
union 
Select * from Hotel2019
union 
Select * from Hotel2020
)
select hotel, (stays_in_weekend_nights+stays_in_week_nights)* adr as Revenue from Hotels 

--- we need to check the revenue by year 
With Hotels as
(
Select * from Hotel2018 
union 
Select * from Hotel2019
union 
Select * from Hotel2020
)
select arrival_date_year, (stays_in_weekend_nights+stays_in_week_nights)* adr as Revenue 
from Hotels --- this shows the year and revenue for each row. 

--- we need to summarize revenue by year using group by 
With Hotels as
(
Select * from Hotel2018 
union 
Select * from Hotel2019
union 
Select * from Hotel2020
)
select 
arrival_date_year, 
sum((stays_in_weekend_nights+stays_in_week_nights)* adr) as Revenue 
from Hotels
group by arrival_date_year

--- lets check the revenue by hotel types 
With Hotels as
(
Select * from Hotel2018 
union 
Select * from Hotel2019
union 
Select * from Hotel2020
)
select 
arrival_date_year, 
hotel,
sum((stays_in_weekend_nights+stays_in_week_nights)* adr) as Revenue 
from Hotels
group by arrival_date_year, hotel;
--- this result shows the revenue by hotel type, by year. 

---lets check the market segment data 
select * from dbo.market_segment$; --- this shows the table with the discount amount for each market segment 

--- lets merge the market segment and meal cost tables  wth the combned table to capture the discount and meal cost to the revenue calculation
With Hotels as (
Select * from Hotel2018
union 
Select * from Hotel2019
union 
Select * from Hotel2020)

select * from Hotels
left join dbo.market_segment$
on hotels.market_segment = market_segment$.market_segment
left join dbo.meal_cost$
on meal_cost$.meal = hotels.meal 





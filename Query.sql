/* Accident */

-- total accidents, casualties
select
	count(*) as total_accidents,
	sum(number_of_casualties) as total_casualties 
from accidents

-- Total severity of accidents by month
select
	month(date) as month_no,
	datename(month, date) as month_name,
	accident_severity as Severity,
	count(accident_severity) as Total_accidents,
	sum(number_of_casualties) as total_casualties
from Accidents
group by
	accident_severity,
	month(date),
	datename(month, date)
order by month_no, Severity


-- What are the most common days and hours for accidents?
select -- days and hours
	month(date) as month_no,
	datename(month, date) as month_name,
	datepart(weekday, date) as day_no,
	datename(weekday,date) as day_of_week,
	datepart(hour, time) as hour,
	accident_severity,
	count(*) as total_accidents
from accidents
group by
	month(date),
	datename(month, date),
	datename(weekday,date), 
	datepart(weekday, date), 
	datepart(hour, time),
	accident_severity
order by
	month_no,
	day_no,
	hour,
	accident_severity

select
	journey_purpose_of_driver,
	datepart(hour, time) as hour,
	count(*) as count_drivers
from vehicles v
left join accidents a on a.accident_reference=v.accident_reference
where journey_purpose_of_driver !='Not known'
group by journey_purpose_of_driver, datepart(hour, time)
order by journey_purpose_of_driver, hour

-- Do roads and junctions play a role?
select -- road type
	road_type,
	accident_severity,
	junction_detail,
	junction_control,
	count(*) as total_accidents
from accidents
where road_type != 'unknown'
group by 
	road_type,
	accident_severity,
	junction_detail,
	junction_control
order by road_type, accident_severity


-- Do surrounding environmental factors affect accidents?
select
	light_conditions,
	weather_conditions,
	road_surface_conditions,
	urban_or_rural_area,
	count(*) as total_accidents
from accidents
where
	light_conditions != 'Data missing' and
	weather_conditions != 'Unknown' and
	road_surface_conditions != 'Data missing' and
	urban_or_rural_area != 'Unallocated'
group by
	light_conditions,
	weather_conditions,
	road_surface_conditions,
	urban_or_rural_area
order by 
	light_conditions,
	weather_conditions,
	road_surface_conditions,
	urban_or_rural_area


/* Vehicles */

-- Which vehicles are involved in most accidents?
select
	vehicle_type,
	skidding_and_overturning,
	journey_purpose_of_driver,
	age_band_of_driver,
	sex_of_driver,
	count(*) as total_vehicle
from vehicles
where
	vehicle_type !='Data missing' and 
	skidding_and_overturning !='Data missing' and
	age_band_of_driver !='Data missing' and
	sex_of_driver !='Not known'
group by
	vehicle_type,
	skidding_and_overturning,
	journey_purpose_of_driver,
	age_band_of_driver,
	sex_of_driver
order by
	vehicle_type,
	skidding_and_overturning,
	journey_purpose_of_driver,
	age_band_of_driver,
	sex_of_driver

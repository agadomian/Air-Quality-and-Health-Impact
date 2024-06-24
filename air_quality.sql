-- let's first check all of the variables and a simple mim, avg and max values to see if they make sense and there's no odd values

-- AQI
select 
min(aqi)
, avg(aqi)
, max(aqi)
from 
air_quality.air_quality_health_impact_data; -- values between 0 and 500

-- PM10 
select 
min(PM10)
, avg(PM10)
, max(PM10)
from 
air_quality.air_quality_health_impact_data; -- values between 0 and 300

-- PM2_5 
select 
min(PM2_5)
, avg(PM2_5)
, max(PM2_5)
from 
air_quality.air_quality_health_impact_data; -- values between 0 and 200

-- NO2 
select 
min(NO2)
, avg(NO2)
, max(NO2)
from 
air_quality.air_quality_health_impact_data; -- values between 0 and 200

-- SO2 
select 
min(SO2)
, avg(SO2)
, max(SO2)
from 
air_quality.air_quality_health_impact_data; -- values between 0 and 100

-- O3 
select 
min(O3)
, avg(O3)
, max(O3)
from 
air_quality.air_quality_health_impact_data; -- values between 0 and 300

-- Temperature
select 
min(Temperature)
, avg(Temperature)
, max(Temperature)
from 
air_quality.air_quality_health_impact_data; -- values between -10 and 40

-- Humidity
select 
min(Humidity)
, avg(Humidity)
, max(Humidity)
from 
air_quality.air_quality_health_impact_data; -- values between 10 and 100

-- WindSpeed
select 
min(WindSpeed)
, avg(WindSpeed)
, max(WindSpeed)
from 
air_quality.air_quality_health_impact_data; -- values between 0 and 20

-- RespiratoryCases
select 
min(RespiratoryCases)
, avg(RespiratoryCases)
, max(RespiratoryCases)
from 
air_quality.air_quality_health_impact_data; -- values between 1 and 23 

-- CardiovascularCases
select 
min(CardiovascularCases)
, avg(CardiovascularCases)
, max(CardiovascularCases)
from 
air_quality.air_quality_health_impact_data; -- values between 0 and 14

-- HospitalAdmissions
select 
min(HospitalAdmissions)
, avg(HospitalAdmissions)
, max(HospitalAdmissions)
from 
air_quality.air_quality_health_impact_data; -- values between 0 and 12

-- HealthImpactScore
select 
min(HealthImpactScore)
, avg(HealthImpactScore)
, max(HealthImpactScore)
from 
air_quality.air_quality_health_impact_data; -- values between 22 and 100

-- HealthImpactClass
select 
min(HealthImpactClass)
, avg(HealthImpactClass)
, max(HealthImpactClass)
from 
air_quality.air_quality_health_impact_data; -- values between 0 and 4

/* since all the variables seem logical and there's no unusual values (e.g. temeperature of 200 degrees celcius), let's proceed to dive into a deeper analysis

 let's first see for each of the health class:
 -  number of hispital addmisions 
 - number of respirtory/cardiovascular cases admitted 
 - average health score */

select 
HealthImpactClass as health_class
, avg(HealthImpactScore) as average_health_score
, sum(RespiratoryCases) as respiratory_cases 
, sum(CardiovascularCases) as cardiovascular_cases 
, sum(HospitalAdmissions) as hospital_admissions 
from 
air_quality.air_quality_health_impact_data aqhid
group by 1;

/* the averages for class 2 and class 3 look odd. class 2 should be withing range 40-60, and class 3 should be within range 20-40, howeber, both of them have an averag>60.
   let's see what could have gone wrong */

select
HealthImpactClass as health_class 
, min(HealthImpactScore) as min_score
, max(HealthImpactScore) as max_score
, sum(case 
	when HealthImpactClass=0 and (HealthImpactScore<80) then 1
	when HealthImpactClass=1 and (HealthImpactScore>=80 or HealthImpactScore<60) then 1
	when HealthImpactClass=2 and (HealthImpactScore>=60 or HealthImpactScore<40) then 1 
	when HealthImpactClass=3 and (HealthImpactScore>=40 or HealthImpactScore<20) then 1 
	when HealthImpactClass=4 and (HealthImpactScore>=20) then 1
	else 0 end) as outside_of_range
, (sum(case 
	when HealthImpactClass=0 and (HealthImpactScore<80) then 1
	when HealthImpactClass=1 and (HealthImpactScore>=80 or HealthImpactScore<60) then 1
	when HealthImpactClass=2 and (HealthImpactScore>=60 or HealthImpactScore<40) then 1 
	when HealthImpactClass=3 and (HealthImpactScore>=40 or HealthImpactScore<20) then 1 
	when HealthImpactClass=4 and (HealthImpactScore>=20) then 1
	else 0 end)/count(*))*100 as outside_of_range_pct
, count(*)
from 
air_quality.air_quality_health_impact_data aqhid 
group by 1;

/* the HealthImpactClass seems to have some incorrect records, hence it will be ignored for now and substituted with a corrected version */

select 
case 
	when (HealthImpactScore>=80) then 0
	when (HealthImpactScore<80 and HealthImpactScore>=60) then 1
	when (HealthImpactScore<60 and HealthImpactScore>=40) then 2
	when (HealthImpactScore<40 and HealthImpactScore>=20) then 3 
	when (HealthImpactScore<20) then 4
	end as health_class
, avg(HealthImpactScore) as average_health_score
, sum(RespiratoryCases) as respiratory_cases 
, sum(CardiovascularCases) as cardiovascular_cases 
, sum(HospitalAdmissions) as hospital_admissions 
from 
air_quality.air_quality_health_impact_data aqhid
group by 1;

/* now let's look at the geogical split.
   some of the questions that come to mind are:
   - does are quality index have some strong indicators among geological metrics? 
   - is there a connection between air quality and number of hospital admissions?
 */

select 
case 
	when (HealthImpactScore>=80) then 0
	when (HealthImpactScore<80 and HealthImpactScore>=60) then 1
	when (HealthImpactScore<60 and HealthImpactScore>=40) then 2
	when (HealthImpactScore<40 and HealthImpactScore>=20) then 3 
	when (HealthImpactScore<20) then 4
	end as health_class
, avg(aqi) as avg_aqi
, min(aqi) as min_aqi
, max(aqi) as max_aqi
, avg(Temperature) as temperature
, avg(Humidity) as humidity 
, avg(WindSpeed) as wind_speed
, sum(RespiratoryCases) as respiratory_cases 
, sum(CardiovascularCases) as cardiovascular_cases 
, sum(HospitalAdmissions) as hospital_admissions 
from 
air_quality.air_quality_health_impact_data aqhid
group by 1; 

/*there doesn't seem to be much difference between temperatures, humidity abd wind speed and the health clas.
  there is, however, a correlation between health class and the average air quality index. 
  that makes sense - the better the air quality, the highest the health class, the lower the hispital admission numbers.
 */
 
-- let's look at the concetrations of different particules and their impact on air quality, hence air 

select 
case 
	when (HealthImpactScore>=80) then 0
	when (HealthImpactScore<80 and HealthImpactScore>=60) then 1
	when (HealthImpactScore<60 and HealthImpactScore>=40) then 2
	when (HealthImpactScore<40 and HealthImpactScore>=20) then 3 
	when (HealthImpactScore<20) then 4
	end as health_class
, avg(aqi) as AQI 
, avg(pm10) as PM10
, avg(PM2_5) as PM2_5 
, avg(no2) as NO2 
, avg(so2) as SO2
, avg(o3) as O3
from 
air_quality.air_quality_health_impact_data aqhid 
group by 1;

select 
case
	when Temperature<0 then 1
	when Temperature>=0 and Temperature<15 then 2
	when Temperature>=15 and Temperature<25 then 3
	when Temperature>=25 then 4
	else '?'
	end as temperature_rank
, case 
	when Temperature<0 then '<0'
	when Temperature>=0 and Temperature<15 then '0-15'
	when Temperature>=15 and Temperature<25 then '15-25'
	when Temperature>=25 then '>25'
	else '?'
	end as temperature
, avg(pm10) as PM10
, avg(PM2_5) as PM2_5 
, avg(no2) as NO2 
, avg(so2) as SO2
, avg(o3) as O3
from 
air_quality.air_quality_health_impact_data aqhid
group by 1,2
order by 1 asc;

select 
case
	when Humidity<20 then 1
	when Humidity>=20 and Humidity<50 then 2
	when Humidity>=50 and Humidity<80 then 3
	when Humidity>=80 then 4
	else '?'
	end as humidity_rank
, case
	when Humidity<20 then '10-20%'
	when Humidity>=20 and Humidity<50 then '20-50%'
	when Humidity>=50 and Humidity<80 then '50-80%'
	when Humidity>=80 then '80-100%'
	else '?'
	end as humidity
, avg(pm10) as PM10
, avg(PM2_5) as PM2_5 
, avg(no2) as NO2 
, avg(so2) as SO2
, avg(o3) as O3
from 
air_quality.air_quality_health_impact_data aqhid
group by 1,2
order by 1 asc;
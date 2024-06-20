-- let's first check all of the variables and a simple mim, avg and max values to see if they make sense and there's no odd values

-- AQI
select 
min(aqi)
, avg(aqi)
, max(aqi)
from 
air_quality.air_quality_health_impact_data; -- seems ok 

-- PM10 
select 
min(PM10)
, avg(PM10)
, max(PM10)
from 
air_quality.air_quality_health_impact_data; -- seems ok 

-- PM2_5 
select 
min(PM2_5)
, avg(PM2_5)
, max(PM2_5)
from 
air_quality.air_quality_health_impact_data; -- seems ok 

-- NO2 
select 
min(NO2)
, avg(NO2)
, max(NO2)
from 
air_quality.air_quality_health_impact_data; -- seems ok 

-- SO2 
select 
min(SO2)
, avg(SO2)
, max(SO2)
from 
air_quality.air_quality_health_impact_data; -- seems ok 

-- O3 
select 
min(O3)
, avg(O3)
, max(O3)
from 
air_quality.air_quality_health_impact_data; -- seems ok 

-- Temperature
select 
min(Temperature)
, avg(Temperature)
, max(Temperature)
from 
air_quality.air_quality_health_impact_data; -- seems ok 

-- Humidity
select 
min(Humidity)
, avg(Humidity)
, max(Humidity)
from 
air_quality.air_quality_health_impact_data; -- seems ok 

-- WindSpeed
select 
min(WindSpeed)
, avg(WindSpeed)
, max(WindSpeed)
from 
air_quality.air_quality_health_impact_data; -- seems ok 

-- RespiratoryCases
select 
min(RespiratoryCases)
, avg(RespiratoryCases)
, max(RespiratoryCases)
from 
air_quality.air_quality_health_impact_data; -- seems ok 

-- CardiovascularCases
select 
min(CardiovascularCases)
, avg(CardiovascularCases)
, max(CardiovascularCases)
from 
air_quality.air_quality_health_impact_data; -- seems ok 

-- HospitalAdmissions
select 
min(HospitalAdmissions)
, avg(HospitalAdmissions)
, max(HospitalAdmissions)
from 
air_quality.air_quality_health_impact_data; -- seems ok 

-- HealthImpactScore
select 
min(HealthImpactScore)
, avg(HealthImpactScore)
, max(HealthImpactScore)
from 
air_quality.air_quality_health_impact_data; -- seems ok 

-- HealthImpactClass
select 
min(HealthImpactClass)
, avg(HealthImpactClass)
, max(HealthImpactClass)
from 
air_quality.air_quality_health_impact_data; -- seems ok 

-- since all the variables seem logical and there's no unusual values (e.g. temeperature of 200 degrees celcius), let's proceed to a deeper analysis

-- let's first see for each of the health class:
-- number of hispital addmisions 
-- number of respirtory/cardiovascular cases admitted 
-- average health score

select
HealthImpactClass as health_class
, avg(HealthImpactScore) as average_health_score
, sum(RespiratoryCases) as respiratory_cases 
, sum(CardiovascularCases) as cardiovascular_cases 
, sum(HospitalAdmissions) as hospital_admissions 
from 
air_quality.air_quality_health_impact_data aqhid
group by 1;

select * from air_quality.summary;
/* interestingly, the average health score is very similar for 'very low' class and 'very high' class
   that might indicate how important and influencial air quality & other factors are on our health */

-- now let's look at the geogical split

select 
HealthImpactClass as health_class
, avg(Temperature) as temperature
, avg(Humidity) as humidity 
, avg(WindSpeed) as wind_speed
from 
air_quality.air_quality_health_impact_data aqhid
group by 1;

/* there doesn't seem to be a big difference between all health classes.
   maybe later on, when looking at the air quality metrics, something new will come up */

select 
HealthImpactClass 
, min(AQI) as min_aqi
, max(AQI) as max_aqi
, avg(AQI) as avg_aqi
from 
air_quality.air_quality_health_impact_data aqhid;

/* the range of AQI is between 0 and 500 */

select 
HealthImpactClass 
, avg(AQI) as avg_aqi
, sum(RespiratoryCases) as respiratory_cases 
, sum(CardiovascularCases) as cardiovascular_cases 
, sum(HospitalAdmissions) as hospital_admissions 
from 
air_quality.air_quality_health_impact_data aqhid
group by 1;

select 
HealthImpactClass 
, min(AQI) as min_aqi
, max(AQI) as max_aqi
, avg(HealthImpactScore)
, min(HealthImpactScore)
, max(HealthImpactScore)
from air_quality.air_quality_health_impact_data aqhid 
group by 1;

select 
*
from air_quality.air_quality_health_impact_data aqhid ;
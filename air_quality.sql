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
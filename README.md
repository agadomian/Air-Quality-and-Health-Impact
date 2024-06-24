# Air Quality and Health Impact Dataset Analysis
  This dataset contains comprehensive information on the air quality and its impact on public health for 5,811 records. 
First, I'll dive into the data using SQL to get a better understanding of it. That will come in hand when building a dashboard in Tableau. 

### 1. Data Analysis

  Number of columns: 15                 
Number of rows: 5,811

#### Columns:

    1. RecordID - unique ID 
    2. AQU - Air Quality Index, a measure of how polluted the air currently is or how polluted it is forecast to become.
    3. PM10 - Concentration of particulate matter less than 10 micrometers in diameter (μg/m³).
    4. PM2_5 - Concentration of particulate matter less than 2.5 micrometers in diameter (μg/m³).
    5. NO2 - Concentration of nitrogen dioxide (ppb).
    6. SO2 - Concentration of sulfur dioxide (ppb).
    7. O3 - Concentration of ozone (ppb).
    8. Temperature - Temperature in degrees Celsius (°C).
    9. Humidity - Humidity percentage (%).
    10. WindSpeed - Wind speed in meters per second (m/s).
    11. RespiratoryCases - Number of respiratory cases reported.
    12. CardiovascularCases - Number of cardiovascular cases reported.
    13. HospitalAdmissions - Number of hospital admissions reported.
    14. HealthImpactScore - A score indicating the overall health impact based on air quality and other related factors [0 to 100].
    15. HealthImpactClass (Target Variable)* - Classification of the health impact based on the health impact score:
                    0: 'Very High' (HealthImpactScore >= 80)
                    1: 'High' (60 <= HealthImpactScore < 80)
                    2: 'Moderate' (40 <= HealthImpactScore < 60)
                    3: 'Low' (20 <= HealthImpactScore < 40)
                    4: 'Very Low' (HealthImpactScore < 20)


# Analysis 

Interesting findings:
1. Although, according to the definition, the HealthImpactClass variable is classified according to the HealthImpactScore, there are some discripencies. The average health score for health class 2 and 3 are outside of their ranges.

![342479229-d290a71a-6f9f-458b-aa64-909f298bc9b6](https://github.com/agadomian/Air-Quality-and-Health-Impact/assets/100043908/5afb3740-de5a-4051-b5e7-8ac114cfcb3a)

Looking further, we can see that there are more cases of incorrect classification present in the data.

![Screenshot 2024-06-24 at 21 32 20](https://github.com/agadomian/Air-Quality-and-Health-Impact/assets/100043908/83357c2f-0cc4-4249-9284-521bbc923164)

So, all health classes have record that have health scores outside of their range. For health class 4, it is all the variables that have been incorrectly classified. Assuming that the health score has been correctly assigned to each record, we can proceed with the analysis and ignore the HealthImpactClass for now. 

*Air quality data analysis using SQL.*

# Air Quality and Health Impact Dataset Analysis
  This dataset contains comprehensive information on the air quality and its impact on public health for 5,811 records.

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

### Interesting findings:
1. Although, according to the definition, the HealthImpactClass variable is classified according to the HealthImpactScore, there are some discripencies. The average health score for health class 2 and 3 are outside of their ranges.

![342479229-d290a71a-6f9f-458b-aa64-909f298bc9b6](https://github.com/agadomian/Air-Quality-and-Health-Impact/assets/100043908/5afb3740-de5a-4051-b5e7-8ac114cfcb3a)

Looking further, we can see that there are more cases of incorrect classification present in the data.

![Screenshot 2024-06-24 at 21 32 20](https://github.com/agadomian/Air-Quality-and-Health-Impact/assets/100043908/83357c2f-0cc4-4249-9284-521bbc923164)

So, all health classes have record that have health scores outside of their range. For health class 4, it is all the variables that have been incorrectly classified. Assuming that the health score has been correctly assigned to each record, we can proceed with the analysis and ignore the HealthImpactClass for now. Instead, let's replicate that variable, but this time assigning the class correctly. 

![Screenshot 2024-06-24 at 21 49 56](https://github.com/agadomian/Air-Quality-and-Health-Impact/assets/100043908/43d9734b-69eb-4ca0-b7ed-820d35d76c7c)

Now we can see that the averages make sense. Also, it's very interesting that the respiratory cases, cardiovascular cases and hostpital admissions seem to allign according tot he health score ranking. Before corrections, the numbers didn't make much sense and seemed to be random. There is a clear trend - worse health impact score means more hospital admissions and more respiratory/cardiovascular cases registered. Unofrtuantely, there is not a single record indicating very low health impact. 

2. Average Air Quality Index seems to follow the Health Class variable pretty well.
   The better the air quality, the better the health class - hence, less hospital admissions or health issues reported.
   
![Screenshot 2024-06-24 at 22 03 12](https://github.com/agadomian/Air-Quality-and-Health-Impact/assets/100043908/78ed4dec-9c8b-4fb5-873f-d0d42211b475)

It is by no means a perfect indicator. We can see that there are cases where the AQI is almost equal to 0, but the health score is classified as very impactful. 

![Screenshot 2024-06-24 at 22 12 09](https://github.com/agadomian/Air-Quality-and-Health-Impact/assets/100043908/8e751b10-495c-44f4-a22d-e38e81464445)

The concentration of particule matter (both PM10 and PM2_5) seem to be indicating well the AQI variable. The higher concentration, the worse the air quality. Moreover, the concentration of nitrogen dioxide (NO2) and ozone (O3) also seem to be playing a role. The higher those concetrations, the better the quality of air. There is no strong indicator when it comes to sulfur dioxide (SO2) concetrations.


Furthermore, the temperature doesn't seem to influence the air quality metrics but humidity shows a small similarities with PM10 variable. The higher the humidity, the more concentrated PM10. That is a very subtle trend, so of course, it could be random. To undersdtand it, we'd need more data.

![Screenshot 2024-06-24 at 22 27 59](https://github.com/agadomian/Air-Quality-and-Health-Impact/assets/100043908/4bde0fad-e762-40a4-9cfb-f16080abd51f)

![Screenshot 2024-06-24 at 22 27 45](https://github.com/agadomian/Air-Quality-and-Health-Impact/assets/100043908/cd63569d-f3d6-47eb-b97d-e2f7f8bc87bb)

The code used to produce the summaries can be found above. 
After finishing the analysis, I created a dashboard in Power BI. The file can be found above, but here's a quick view:


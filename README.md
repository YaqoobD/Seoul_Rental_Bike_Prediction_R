# Seoul Rental Bike Prediction in R 🚲📈

## Problem Statement 🎯
The Idea of a bike-sharing system is almost 50 years old. First presented in Ernest Callenbach’s
utopian novel Ecotopia(1975) illustrates the idea of a society that survives without using any
fossil fuel. Currently, almost every developed urban city has a very advanced bike-sharing
system. It not only has a very positive impact on the financial and transport system of the cities,
but it also has a tremendously significant impact on the environment. As always, benefits come
with significant challenges. It is always a challenge to have enough bikes that can facilitate all
the citizens and have fewer waiting times regardless of the weather or traffic conditions.
Therefore, it is essential to predict the bike count each hour for a stable supply of rented bikes.

## Data Description 📊
The dataset contains weather information (Temperature, Humidity, Windspeed, Visibility,
Dewpoint, Solar radiation, Snowfall, Rainfall), the number of bikes rented per hour, and date
information.

## Dataset 📊
For this project, Seoul Bike Share program data is used. This dataset contains the total count of
rented bikes at each hour, the date of observation, and meteorological information (Humidity,
Snowfall, Rainfall, Temperature Season, and so on) for that hour.
The observations were recorded over 365 days, from December 2017 to November 2018.

## Data Information 📝
• Dataset contains 8760 rows and 14 columns.
• Dataset contains 0 Duplicate rows.
• This Dataset contains four categorical and ten numerical variables.
• It contains 0 missing values.

### Dependent Variable 🎯
• Rented Bike count - Count of bikes rented at each hour

### Independent Variables 📊
• Date: year-month-day
• Hour - Hour of the day
• Temperature-Temperature in Celsius
• Humidity - %
• Windspeed - m/s
• Visibility - 10m
• Dew point temperature - Celsius
• Solar radiation - MJ/m2
• Rainfall - mm
• Snowfall - cm
• Seasons - Winter, Spring, Summer, Autumn
• Holiday - Holiday/No holiday
• Functional Day - NoFunc(Non-Functional Hours), Fun(Functional hours)

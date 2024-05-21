## Analysis of Flight Delays and Cancellation during COVID-19 in United States

Analyzing flight delay and cancellation metrics can provide insights into the factors contributing to disruptions in airline operations. The dataset is provided by The United States Department of Transportation's (DOT) Bureau of Transportation Statistics tracks on the on-time performance of domestic flights operated by large air carriers. The data collected is from January - June 2020. The data set was sourced [here](https://www.kaggle.com/datasets/akulbahl/covid19-airline-flight-delays-and-cancellations/data?select=jantojun2020.csv)

## Used Technologies

The following tools were used for this project:
- Docker - for Containerization
- Mage.ai - for orchestration;
- Google Cloud Storage (GCS) - for storage as Data Lake;
- Google BigQuery - for the project Data Warehouse;
- dbt - for the transformation of raw data into refined data (staging and core);
- Google Looker studio - for visualizations.

![Data Architecture](img/Slide1.PNG)

## Problem Description
I analyzed the impact of COVID-19 on flight delays and cancellations during the peak eras of the virus with available datasets from January to June 2020. By understanding the root causes of delays and cancellations, airlines can implement strategies to minimize their impact on customer satisfaction and operational performance.


## Data Warehouse
Kimball's approach to data engineering was implemented based on the concepts of dimensional modeling and the star schema. The data was structured into fact and dimensional tables. kindly go to https://github.com/Phemaries/DEZoomcamp_Project/tree/Phemaries-patch-1 for dbt codes

![Schema](img/US_Transport_Schema.jpg)



## Data Visualization


### Cancelled Flights Visualization
![Data Architecture](img/US_Airline_Cancelled_Looker-1.png)



### Delay Flights Visualization
![Data Architecture](img/US_Airline_Delays_Looker-1.png)
![Data Architecture](img/US_Airline_Delays_Looker-2.png)

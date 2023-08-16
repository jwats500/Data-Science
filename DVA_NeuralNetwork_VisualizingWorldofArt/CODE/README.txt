DESCRIPTION:

IF USING AT A LATER DATE, THE CLOUD PLATFORM IS LIKELY OFF THUS THE APPLICATION CAN NO LONGER LOAD CORRECTLY
Please consider viewing the demo: https://youtu.be/3_SwnWsA92M
*************************************************************************************************
This package contains team067's Final Project for CSE6242 for the Spring 2022 semester.
The team members are: Xin Guo, Yan Sheng, Jesse Watson, Cody Westgard, Tianhua Zhu

The web application developed as part of this project is an artwork recommendation
system (specifically paintings), developed in Python using Streamlit. It features
a choropleth map and stacked bar chart.

The user can input an image of their choice and our algorithm will return the most similar
paintings from our dataset. There are also options to filter the dataset, viewing only Asian
or European works, including or excluding works from certain countries, or limiting the results
to a specific time period.

Dataset:
The dataset was obtained via open-access API from the The Met Collection:
https://metmuseum.github.io/
and The National Palace Museum of Taiwan:
https://openapiweb.npm.gov.tw/APP_Prog/eng/overview_eng.aspx

The total dataset has 2500+ images and thus is too large to include in this folder.

INSTALLATION:
*************************************************************************************************
The required files in the local directory are:
1) VGG_features.npy
2) streamlit_app.py
3) key3.json
4) image_matching.py
5) countries.geojson
6) cleaned_data.csv
7) .gitattributes.txt
8) test_images folder (which contains 5 sample paintings the user may try)
9) dva_paintings (an empty folder which will temporarily hold user images)

EXECUTION:
*************************************************************************************************
Please make sure all necessary python packages have been installed:
pandas
numpy
json
streamlit
folium
streamlit_folium
google-api-core
google-cloud-storage
google-cloud-bigquery
db-dtypes
Pillow
sewar
matplotlib
TensorFlow
keras
sklearn
geojson
opencv-python-headless

In command prompt, set the working directory to folder containing the document
(example: cd Desktop\team067final\Code)
Execute "streamlit run streamlit_app.py"


Demo link: https://youtu.be/3_SwnWsA92M

alternatively you may try the application hosted on streamlit: 
https://share.streamlit.io/diealittle1996/dva_project/main/try_streamlit.py

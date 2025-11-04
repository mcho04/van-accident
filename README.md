# 🚗 Vancouver Traffic Accident Analysis (2018 – 2022)

Author: Min Cho (He/Him)
Tools Used: Tableau Public • PostgreSQL • SQL • VS Code

📊 Project Overview

This project analyzes five years of Vancouver-area traffic accident data (2018 – 2022) to identify key trends, high-risk areas, and time-based crash patterns.
The dataset was cleaned and processed using SQL before being visualized in Tableau Public.

🧹 Data Preparation

The raw dataset (van_accidents_raw.csv) was cleaned and transformed into van_accidents_cleaned.csv using PostgreSQL.
Key cleaning steps included:

- Handled missing (NULL) values to ensure data consistency

- Removed duplicate records and redundant columns for cleaner structure

- Standardized categorical values for uniform analysis

- Derived a new Season column based on crash dates to capture seasonal trends

👉 SQL scripts for data cleaning can be found in
van-accident-cleaning.sql.

📈 Key Insights (Tableau Dashboard)

Dashboard Link: [View on Tableau Public](https://public.tableau.com/views/Van-Map2018-2022/Overview?:language=en-US&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link)

## 📊 Dashboard Overview

### Overview Page
![Overview Dashboard](Tableau%20Visualizations/Overview.png)

### Map Visualization
![Crash Map](Tableau%20Visualizations/Map.png)

### Charts Section
![Crash Trends](Tableau%20Visualizations/Charts.png)

1️⃣ Overview Page

Total Crashes: 335,811

Total Victims: 215,781

YoY % Change – Crashes & Victims: yearly trends (2018 – 2022)

Top 5 Crash Locations: Hwy 1, 152 St, Lougheed Hwy, King George Blvd, Kingsway

Fatal vs Non-Fatal Crashes: 56.8 % non-fatal | 43.2 % fatal

Peak Crash Time: 3 – 6 PM

2️⃣ Map Page

Interactive map showing crash density by municipality and region

3️⃣ Charts Page

Crashes by Time of Day: highlights rush-hour peaks

Crashes by Month: visualizes seasonal trends

💾 Repository Structure
Van-Accident/
├── data/
│   ├── van_accidents_cleaned.csv      # cleaned dataset (ignored in Git)
│   ├── van_accidents_raw.csv          # raw dataset (ignored in Git)
│   └── Archive.zip                    # compressed data files
├── Tableau Visualizations/
│   ├── Overview.png
│   ├── Map.png
│   ├── Charts.png
│   └── Van-Map 2018-2022.twb
├── van-accident-cleaning.sql          # SQL cleaning script
├── README.md
└── .gitignore

🧪 Data Source
https://www.kaggle.com/datasets/tcashion/icbc-vehicle-crash-dataset

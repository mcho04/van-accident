-- Step 1: Identify columns containing NULL values 
-- (notably municipality_name, longitude, and latitude)
SELECT 
    COUNT(*) FILTER (WHERE crash_breakdown IS NULL) AS crash_breakdown_nulls,
    COUNT(*) FILTER (WHERE year IS NULL) AS year_nulls,
    COUNT(*) FILTER (WHERE animal_involved IS NULL) AS animal_involved_nulls,
    COUNT(*) FILTER (WHERE crash_severity IS NULL) AS crash_severity_nulls,
    COUNT(*) FILTER (WHERE cyclist_involved IS NULL) AS cyclist_involved_nulls,
    COUNT(*) FILTER (WHERE day_of_week IS NULL) AS day_of_week_nulls,
    COUNT(*) FILTER (WHERE derived_crash_config IS NULL) AS derived_crash_config_nulls,
    COUNT(*) FILTER (WHERE heavy_vehicle_involved IS NULL) AS heavy_vehicle_involved_nulls,
    COUNT(*) FILTER (WHERE intersection_crash IS NULL) AS intersection_crash_nulls,
    COUNT(*) FILTER (WHERE month IS NULL) AS month_nulls,
    COUNT(*) FILTER (WHERE motorcycle_involved IS NULL) AS motorcycle_involved_nulls,
    COUNT(*) FILTER (WHERE municipality_ifnull IS NULL) AS municipality_ifnull_nulls,
    COUNT(*) FILTER (WHERE parked_vehicle_involved IS NULL) AS parked_vehicle_involved_nulls,
    COUNT(*) FILTER (WHERE parking_lot_crash IS NULL) AS parking_lot_crash_nulls,
    COUNT(*) FILTER (WHERE municipality_name IS NULL) AS municipality_name_nulls,
    COUNT(*) FILTER (WHERE pedestrian_involved IS NULL) AS pedestrian_involved_nulls,
    COUNT(*) FILTER (WHERE region IS NULL) AS region_nulls,
    COUNT(*) FILTER (WHERE street_full IS NULL) AS street_full_nulls,
    COUNT(*) FILTER (WHERE total_crashes IS NULL) AS total_crashes_nulls,
    COUNT(*) FILTER (WHERE total_victims IS NULL) AS total_victims_nulls,
    COUNT(*) FILTER (WHERE latitude IS NULL) AS latitude_nulls,
    COUNT(*) FILTER (WHERE longitude IS NULL) AS longitude_nulls
FROM accidents;

-- Step 2: Create a new working table to store cleaned data 
-- This table will be used for analysis and Tableau visualization
CREATE TABLE accidents_cleaned AS 
SELECT * FROM accidents;

-- Step 3: Delete rows with NULL values
DELETE FROM accidents_cleaned
WHERE municipality_name IS NULL
   OR TRIM(municipality_name) = ''
   OR municipality_name ILIKE 'Unknown'
   OR street_full IS NULL
   OR TRIM(street_full) = ''
   OR street_full ILIKE 'Unknown'
   OR latitude IS NULL
   OR longitude IS NULL;

-- Step 3: Preview standardized categorical columns (using INITCAP and TRIM for formatting)
SELECT 
  INITCAP(TRIM(crash_severity))        AS cleaned_crash_severity,
  INITCAP(TRIM(day_of_week))           AS cleaned_day_of_week,
  INITCAP(TRIM(month))                 AS cleaned_month,
  INITCAP(TRIM(region))                AS cleaned_region,
  INITCAP(TRIM(municipality_name))     AS cleaned_municipality_name,
  crash_severity                       AS original_crash_severity,
  day_of_week                          AS original_day_of_week,
  month                                AS original_month,
  region                               AS original_region,
  municipality_name                    AS original_municipality_name
FROM accidents;

SELECT 
  CASE
    WHEN COUNT(*) = COUNT(*) FILTER (WHERE street_full = street_full_ifnull OR (street_full IS NULL AND street_full_ifnull IS NULL))
    THEN '✅ Columns are identical'
    ELSE '❌ Columns differ'
  END AS comparison_result
FROM accidents;

SELECT 
  COUNT(*) AS total_rows,
  COUNT(*) FILTER (WHERE street_full = street_full_ifnull OR (street_full IS NULL AND street_full_ifnull IS NULL)) AS same_rows,
  COUNT(*) FILTER (WHERE NOT (street_full = street_full_ifnull OR (street_full IS NULL AND street_full_ifnull IS NULL))) AS different_rows
FROM accidents;


crash_breakdown, crash_severity, day_of_week, derived_crash_config, month, municipality_ifnull, region, street_full_ifnull, 
municipality_name, street_full, cross_street_full_name, municipality_with_boundary

-- Step 4: Add and preview a derived column "season" for seasonal analysis
SELECT 
  month,
  CASE
    WHEN month IN ('December', 'January', 'February') THEN 'Winter'
    WHEN month IN ('March', 'April', 'May') THEN 'Spring'
    WHEN month IN ('June', 'July', 'August') THEN 'Summer'
    WHEN month IN ('September', 'October', 'November') THEN 'Fall'
    ELSE 'Unknown'
  END AS temp
FROM accidents
LIMIT 20;









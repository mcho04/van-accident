-- Step 1: Identify columns containing NULL values 
-- (notably municipality_name, street_full, cross_street_full_name, longitude,latitude, and municipality_with_boundary)
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
    COUNT(*) FILTER (WHERE pedestrian_involved IS NULL) AS pedestrian_involved_nulls,
    COUNT(*) FILTER (WHERE region IS NULL) AS region_nulls,
    COUNT(*) FILTER (WHERE street_full_ifnull IS NULL) AS street_full_ifnull_nulls,
    COUNT(*) FILTER (WHERE time_category IS NULL) AS time_category_nulls,
    COUNT(*) FILTER (WHERE municipality_name IS NULL) AS municipality_name_nulls,
    COUNT(*) FILTER (WHERE road_location_description IS NULL) AS road_location_description_nulls,
    COUNT(*) FILTER (WHERE street_full IS NULL) AS street_full_nulls,
    COUNT(*) FILTER (WHERE metric_selector IS NULL) AS metric_selector_nulls,
    COUNT(*) FILTER (WHERE total_crashes IS NULL) AS total_crashes_nulls,
    COUNT(*) FILTER (WHERE total_victims IS NULL) AS total_victims_nulls,
    COUNT(*) FILTER (WHERE cross_street_full_name IS NULL) AS cross_street_full_name_nulls,
    COUNT(*) FILTER (WHERE latitude IS NULL) AS latitude_nulls,
    COUNT(*) FILTER (WHERE longitude IS NULL) AS longitude_nulls,
    COUNT(*) FILTER (WHERE mid_block_crash IS NULL) AS cross_street_full_name_nulls, 
    COUNT(*) FILTER (WHERE municipality_with_boundary IS NULL) AS municipality_with_boundary_nulls
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
   OR longitude IS NULL
   OR cross_street_full_name IS NULL
   OR municipality_with_boundary IS NULL;

-- Step 4: Double check if NULLs are gone
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
    COUNT(*) FILTER (WHERE pedestrian_involved IS NULL) AS pedestrian_involved_nulls,
    COUNT(*) FILTER (WHERE region IS NULL) AS region_nulls,
    COUNT(*) FILTER (WHERE street_full_ifnull IS NULL) AS street_full_ifnull_nulls,
    COUNT(*) FILTER (WHERE time_category IS NULL) AS time_category_nulls,
    COUNT(*) FILTER (WHERE municipality_name IS NULL) AS municipality_name_nulls,
    COUNT(*) FILTER (WHERE road_location_description IS NULL) AS road_location_description_nulls,
    COUNT(*) FILTER (WHERE street_full IS NULL) AS street_full_nulls,
    COUNT(*) FILTER (WHERE metric_selector IS NULL) AS metric_selector_nulls,
    COUNT(*) FILTER (WHERE total_crashes IS NULL) AS total_crashes_nulls,
    COUNT(*) FILTER (WHERE total_victims IS NULL) AS total_victims_nulls,
    COUNT(*) FILTER (WHERE cross_street_full_name IS NULL) AS cross_street_full_name_nulls,
    COUNT(*) FILTER (WHERE latitude IS NULL) AS latitude_nulls,
    COUNT(*) FILTER (WHERE longitude IS NULL) AS longitude_nulls,
    COUNT(*) FILTER (WHERE mid_block_crash IS NULL) AS cross_street_full_name_nulls, 
    COUNT(*) FILTER (WHERE municipality_with_boundary IS NULL) AS municipality_with_boundary_nulls
FROM accidents_cleaned;

-- Step 5: Standardize and clean categorical text columns in the working table
UPDATE accidents_cleaned
SET
  crash_severity = INITCAP(TRIM(crash_severity)),
  day_of_week = INITCAP(TRIM(day_of_week)),
  month = INITCAP(TRIM(month)),
  region = INITCAP(TRIM(region)),
  municipality_name = INITCAP(TRIM(municipality_name)),
  crash_breakdown = INITCAP(TRIM(crash_breakdown)),
  derived_crash_config = INITCAP(TRIM(derived_crash_config)),
  municipality_ifnull = INITCAP(TRIM(municipality_ifnull)),
  street_full_ifnull = INITCAP(TRIM(street_full_ifnull)),
  street_full = INITCAP(TRIM(street_full)),
  cross_street_full_name = INITCAP(TRIM(cross_street_full_name)),
  municipality_with_boundary = INITCAP(TRIM(municipality_with_boundary));

-- Step 6: Check if there are duplicate columns
-- Conclusion: street_full = street_full_ifnull and municipality_name = municipality_ifnull, 
-- while municipality_name differs from municipality_with_boundary
SELECT 
  CASE
    WHEN COUNT(*) = COUNT(*) FILTER (WHERE street_full = street_full_ifnull)
    THEN '✅ Columns are identical'
    ELSE '❌ Columns differ'
  END AS comparison_result
FROM accidents_cleaned;

SELECT 
  CASE
    WHEN COUNT(*) = COUNT(*) FILTER (WHERE municipality_name = municipality_ifnull)
    THEN '✅ Columns are identical'
    ELSE '❌ Columns differ'
  END AS comparison_result
FROM accidents_cleaned;

SELECT 
  CASE
    WHEN COUNT(*) = COUNT(*) FILTER (WHERE municipality_name = municipality_with_boundary)
    THEN '✅ Columns are identical'
    ELSE '❌ Columns differ'
  END AS comparison_result
FROM accidents_cleaned;

-- Step 7: Drop duplicate columns
ALTER TABLE accidents_cleaned
DROP COLUMN IF EXISTS street_full_ifnull,
DROP COLUMN IF EXISTS municipality_ifnull;

-- Step 8: Preview Cleaned Data
SELECT * FROM accidents_cleaned
LIMIT 100;

-- Step 9: Add and preview a derived column "season" for seasonal analysis
ALTER TABLE accidents_cleaned
ADD COLUMN season TEXT;

UPDATE accidents_cleaned
SET season = CASE
  WHEN month IN ('December', 'January', 'February') THEN 'Winter'
  WHEN month IN ('March', 'April', 'May') THEN 'Spring'
  WHEN month IN ('June', 'July', 'August') THEN 'Summer'
  WHEN month IN ('September', 'October', 'November') THEN 'Fall'
  ELSE 'Unknown'
END;

-- Step 10: Preview Fully Cleaned Data
SELECT * FROM accidents_cleaned

-- Step 11: Export the cleaned dataset to a local CSV file for Tableau visualization
-- Export using: \copy accidents_cleaned TO 'your_desired_path_file' DELIMITER ',' CSV HEADER;
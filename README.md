# Vancouver Accident Visualization

## 🔧 Data Cleaning Process in PostGreSQL

To ensure accurate analysis, I cleaned the traffic dataset as follows:

| Column Name       | Issue Detected                      | Action Taken                                           | Justification                          |
|------------------|-------------------------------------|--------------------------------------------------------|----------------------------------------|
| `crash_breakdown_2`        | None      | None                              | None       |
| `speed`          | NULL values in 8% of rows           | Replaced with mean speed (`45.2 km/h`)                 | Mean imputation to preserve row count  |
| `accident_cause` | 12% NULL                            | Excluded from model training                           | Avoided bias from unreliable imputation|


See `data_cleaning_log.csv` for full details.

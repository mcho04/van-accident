# Vancouver Accident Visualization

### 🧪 Data Source
https://www.kaggle.com/datasets/tcashion/icbc-vehicle-crash-dataset

## 🔧 Data Cleaning Process in PostgreSQL

To ensure accurate analysis, I cleaned the traffic dataset as follows:

| Column Name     | Issue Detected  | Action Taken   | Justification |
|-----------------|------------------|-----------------|-----------------|
| `crash_breakdown_2`| None | None | None |
| `date_of_loss_year`          | None | None | None |
| `animal_involved` | None | None | None|
| `crash_severity` | None | None | None |
| `cyclist_involved` | None | None | None |
| `day_of_week` | None | None | None |
| `derived_crash_configuration` | Some values are recorded as 'UNDETERMINED' | Replaced those values with 'Unknown' | Allows users to filter and visualize unknown categories rather than ignoring them | 


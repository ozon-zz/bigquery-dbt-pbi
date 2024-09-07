-- models/cleaned_data.sql

WITH raw AS (
    SELECT * 
    FROM {{ source('mkt', 'traffics') }}
),

-- Extract the header row and make it the column names
header_row AS (
    SELECT 
        string_field_0 AS Date,
        string_field_1 AS Source,
        string_field_2 AS Site,
        string_field_3 AS Traffics,
        string_field_4 AS New_Users,
        string_field_5 AS Returning_Users
    FROM raw
    LIMIT 1
),

-- Remove the header row from the dataset
data_rows AS (
    SELECT *
    FROM raw
    WHERE string_field_0 != 'Date'
),

-- Select columns based on the header and cast types
cleaned_data AS (
    SELECT 
        CAST(string_field_0 AS DATE) AS Date,
        string_field_1 AS Source,
        string_field_2 AS Site,
        CAST(string_field_3 AS INT64) AS Traffics,
        CAST(string_field_4 AS INT64) AS New_Users,
        CAST(string_field_5 AS INT64) AS Returning_Users
    FROM data_rows
)

SELECT * FROM cleaned_data
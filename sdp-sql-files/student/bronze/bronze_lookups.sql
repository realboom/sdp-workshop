CREATE STREAMING TABLE <YOUR_SCHEMA>.bronze_lookups
  COMMENT "Code lookups accross tables"
AS 
SELECT 
  * 
  ,current_timestamp as insert_timestamp
  ,_metadata
FROM STREAM read_files(
  "${volume_path}/lookups/*",
  format => 'csv',
  inferColumnTypes => false
);
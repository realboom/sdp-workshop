CREATE STREAMING TABLE <YOUR_SCHEMA>.bronze_icd_codes
  COMMENT "Lookups for icd9 codes"
AS 
SELECT
  * 
  ,current_timestamp as insert_timestamp
  ,_metadata
FROM STREAM read_files(
  "${volume_path}/icd_codes/*",
  format => 'csv',
  inferColumnTypes => false
);
CREATE STREAMING TABLE bronze.inpatient_claims
  COMMENT "raw data for inpatient claim transactions"
AS 
SELECT 
  * 
  ,current_timestamp as insert_timestamp
  ,_metadata
FROM STREAM read_files(
  "${volume_path}/inpatient_claims/*",
  format => 'csv',
  inferColumnTypes => false
);
CREATE STREAMING TABLE <YOUR_SCHEMA>.bronze_outpatient_claims
  COMMENT "raw data for outpatient claim transactions"
AS 
SELECT 
  * 
  ,current_timestamp as insert_timestamp
  ,_metadata
FROM STREAM read_files(
  "${volume_path}/outpatient_claims/*",
  format => 'csv',
  inferColumnTypes => false
);
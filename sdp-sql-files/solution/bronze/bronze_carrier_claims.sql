CREATE STREAMING TABLE bronze.carrier_claims
  COMMENT "raw data for carrier claim transactions"
AS 
SELECT 
  * 
  ,current_timestamp as insert_timestamp
  ,_metadata
FROM STREAM read_files(
  "${volume_path}/carrier_claims/*",
  format => 'csv',
  inferColumnTypes => false
);
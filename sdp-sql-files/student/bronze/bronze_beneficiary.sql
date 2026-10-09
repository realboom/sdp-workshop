CREATE STREAMING TABLE <YOUR_SCHEMA>.bronze_beneficiary
  COMMENT "raw data for summaries of beneficiaries"
AS 
SELECT 
  * 
  ,current_timestamp as insert_timestamp
  ,_metadata
FROM STREAM read_files(
  "${volume_path}/beneficiary/*",
  format => 'csv',
  inferColumnTypes => false
);
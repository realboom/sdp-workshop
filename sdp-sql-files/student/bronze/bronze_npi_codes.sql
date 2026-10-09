CREATE STREAMING TABLE bronze.npi_codes
  COMMENT "Lookups for National Provider Identifier Number"
AS 
SELECT
  * 
  ,current_timestamp as insert_timestamp
  ,_metadata
FROM STREAM read_files(
  "${volume_path}/npi_codes/*",
  format => 'csv',
  inferColumnTypes => false
);
/************************************************************************
INSTRUCTIONS:

Afer this comment, write code to create a new bronze table with the
following requirements.

Table name: <YOUR_SCHEMA>.bronze_prescription_drug_events
File Path: prescription_drug_events in the folder defined by the ${volume_path} variable
Format: CSV
Do no infer column types

bring back:
- all fields in the CVS file
- the current timestamp in a field named insert_timestamp
- medatada from the source file
************************************************************************/

CREATE STREAMING TABLE <YOUR_SCHEMA>.bronze_prescription_drug_events
  COMMENT "raw data for prescription drug events"
AS 
SELECT 
  * 
  ,current_timestamp as insert_timestamp
  ,_metadata
FROM STREAM read_files(
  "${volume_path}/prescription_drug_events/*",
  format => 'csv',
  inferColumnTypes => false
);
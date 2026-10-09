--create insert-only table with all the business logic
CREATE STREAMING TABLE silver.icd_codes_insert
  (
    CONSTRAINT `Diagnosis code is not null`    EXPECT (diagnosis_code is not null) ON VIOLATION DROP ROW
  )
AS
SELECT
   uuid() as icd_codes_insert_key
  ,md5(DiagnosisCode) as icd_codes_key
  ,DiagnosisCode as diagnosis_code
  ,LongDescription as diagnosis_long_description
  ,ShortDescription as diagnosis_short_description
  ,current_timestamp as insert_timestamp
FROM stream(bronze.icd_codes) i;

--create the merged silver table
CREATE STREAMING TABLE silver.icd_codes;

CREATE FLOW silver_icd_codes AS AUTO CDC 
  INTO silver.icd_codes
FROM
  stream(silver.icd_codes_insert)
KEYS
  (icd_codes_key)
SEQUENCE BY
  (insert_timestamp)
COLUMNS * EXCEPT
  (icd_codes_insert_key)
STORED AS
  SCD TYPE 1;
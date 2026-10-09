CREATE MATERIALIZED VIEW <YOUR_SCHEMA>.gold_dim_diagnosis
AS
SELECT 
   icd_codes_key as dim_diagnosis_key
  ,diagnosis_code
  ,diagnosis_long_description
  ,diagnosis_short_description
FROM <YOUR_SCHEMA>.silver_icd_codes
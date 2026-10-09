CREATE MATERIALIZED VIEW gold.dim_diagnosis
AS
SELECT 
   icd_codes_key as dim_diagnosis_key
  ,diagnosis_code
  ,diagnosis_long_description
  ,diagnosis_short_description
FROM silver.icd_codes
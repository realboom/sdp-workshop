/*****************************************************************************************
We will build the Fact Tables as materilized views.

We are using these instead of streaming tables as it's possible that data may be updated 
or deleted and we want to refelect that easily in the fact tables. We will be relying on 
Enzyme to find the most performative way to update these tables.

We are unpivoting the carrier claims from many columns to many rows. 
This fact table will use the UNPIVOT SQL clause.
(https://docs.databricks.com/aws/en/sql/language-manual/sql-ref-syntax-qry-select-unpivot) 
******************************************************************************************/


CREATE MATERIALIZED VIEW  gold.fact_carrier_claims
CLUSTER BY (beneficiary_key,claim_start_date)
AS
SELECT
   carrier_claims_key
  ,cc.claim_id
  ,db.beneficiary_key
  ,cc.claim_start_date
  ,cc.claim_end_date
  ,md5(line_icd9_diagnosis_code) as line_diagnosis_key
  ,md5(claim_diagnosis_code_1) as diagnosis_key_1
  ,md5(claim_diagnosis_code_2) as diagnosis_key_2
  ,md5(claim_diagnosis_code_3) as diagnosis_key_3
  ,md5(claim_diagnosis_code_4) as diagnosis_key_4
  ,md5(claim_diagnosis_code_5) as diagnosis_key_5
  ,md5(claim_diagnosis_code_6) as diagnosis_key_6
  ,md5(claim_diagnosis_code_7) as diagnosis_key_7
  ,md5(claim_diagnosis_code_8) as diagnosis_key_8
  ,md5(provider_physician_npi_1) as provider_key_1
  ,md5(provider_physician_npi_2) as provider_key_2
  ,md5(provider_physician_npi_3) as provider_key_3
  ,md5(provider_physician_npi_4) as provider_key_4
  ,md5(provider_physician_npi_5) as provider_key_5
  ,cast(cc.claim_end_date - cc.claim_start_date as int) + 1 as claim_days
  ,cast(line_number as int) as line_number
  ,nch_payment_amount
  ,line_beneficiary_part_b_deductable_amount
  ,line_beneficiary_primary_payer_paid_amount
  ,line_coinsurance_amount
  ,line_allowed_charge_amount
  ,line_processing_indicator_code
FROM silver.carrier_claims cc 
LEFT JOIN gold.dim_beneficiary db on cc.beneficiary_code = db.beneficiary_code 
  AND year(cc.claim_start_date) >= db.__START_AT
  AND year(cc.claim_start_date) < coalesce(db.__END_AT,9999)  
UNPIVOT ((nch_payment_amount,line_beneficiary_part_b_deductable_amount,line_beneficiary_primary_payer_paid_amount,line_coinsurance_amount,line_allowed_charge_amount,line_processing_indicator_code,line_icd9_diagnosis_code)
  FOR line_number in ((nch_payment_amount_1,line_beneficiary_part_b_deductable_amount_1,line_beneficiary_primary_payer_paid_amount_1,line_coinsurance_amount_1,line_allowed_charge_amount_1,line_processing_indicator_code_1,line_icd9_diagnosis_code_1) as `1`
                     ,(nch_payment_amount_2,line_beneficiary_part_b_deductable_amount_2,line_beneficiary_primary_payer_paid_amount_2,line_coinsurance_amount_2,line_allowed_charge_amount_2,line_processing_indicator_code_2,line_icd9_diagnosis_code_2) as `2`
                     ,(nch_payment_amount_3,line_beneficiary_part_b_deductable_amount_3,line_beneficiary_primary_payer_paid_amount_3,line_coinsurance_amount_3,line_allowed_charge_amount_3,line_processing_indicator_code_3,line_icd9_diagnosis_code_3) as `3`
                     ,(nch_payment_amount_4,line_beneficiary_part_b_deductable_amount_4,line_beneficiary_primary_payer_paid_amount_4,line_coinsurance_amount_4,line_allowed_charge_amount_4,line_processing_indicator_code_4,line_icd9_diagnosis_code_4) as `4`
                     ,(nch_payment_amount_5,line_beneficiary_part_b_deductable_amount_5,line_beneficiary_primary_payer_paid_amount_5,line_coinsurance_amount_5,line_allowed_charge_amount_5,line_processing_indicator_code_5,line_icd9_diagnosis_code_5) as `5`
                     ,(nch_payment_amount_6,line_beneficiary_part_b_deductable_amount_6,line_beneficiary_primary_payer_paid_amount_6,line_coinsurance_amount_6,line_allowed_charge_amount_6,line_processing_indicator_code_6,line_icd9_diagnosis_code_6) as `6`
                     ,(nch_payment_amount_7,line_beneficiary_part_b_deductable_amount_7,line_beneficiary_primary_payer_paid_amount_7,line_coinsurance_amount_7,line_allowed_charge_amount_7,line_processing_indicator_code_7,line_icd9_diagnosis_code_7) as `7`
                     ,(nch_payment_amount_8,line_beneficiary_part_b_deductable_amount_8,line_beneficiary_primary_payer_paid_amount_8,line_coinsurance_amount_8,line_allowed_charge_amount_8,line_processing_indicator_code_8,line_icd9_diagnosis_code_8) as `8`
                     ,(nch_payment_amount_9,line_beneficiary_part_b_deductable_amount_9,line_beneficiary_primary_payer_paid_amount_9,line_coinsurance_amount_9,line_allowed_charge_amount_9,line_processing_indicator_code_9,line_icd9_diagnosis_code_9) as `9`
                     ,(nch_payment_amount_10,line_beneficiary_part_b_deductable_amount_10,line_beneficiary_primary_payer_paid_amount_10,line_coinsurance_amount_10,line_allowed_charge_amount_10,line_processing_indicator_code_10,line_icd9_diagnosis_code_10) as `10`
                     ,(nch_payment_amount_11,line_beneficiary_part_b_deductable_amount_11,line_beneficiary_primary_payer_paid_amount_11,line_coinsurance_amount_11,line_allowed_charge_amount_11,line_processing_indicator_code_11,line_icd9_diagnosis_code_11) as `11`
                     ,(nch_payment_amount_12,line_beneficiary_part_b_deductable_amount_12,line_beneficiary_primary_payer_paid_amount_12,line_coinsurance_amount_12,line_allowed_charge_amount_12,line_processing_indicator_code_12,line_icd9_diagnosis_code_12) as `12`
                     ,(nch_payment_amount_13,line_beneficiary_part_b_deductable_amount_13,line_beneficiary_primary_payer_paid_amount_13,line_coinsurance_amount_13,line_allowed_charge_amount_13,line_processing_indicator_code_13,line_icd9_diagnosis_code_13) as `13`
                     ))
WHERE (nch_payment_amount <> 0 
     OR line_beneficiary_part_b_deductable_amount <> 0
     OR line_beneficiary_primary_payer_paid_amount <> 0
     OR line_coinsurance_amount <> 0
     OR line_allowed_charge_amount <> 0
     OR line_processing_indicator_code <> 0
     OR line_icd9_diagnosis_code <> 0
      )
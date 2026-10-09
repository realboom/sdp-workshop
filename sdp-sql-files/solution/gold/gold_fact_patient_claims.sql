/*****************************************************************************************
We will build the Fact Tables as materilized views.

We are using these instead of streaming tables as it's possible that data may be updated 
or deleted and we want to refelect that easily in the fact tables. We will be relying on 
Enzyme to find the most performative way to update these tables.
******************************************************************************************/

CREATE MATERIALIZED VIEW  gold.fact_patient_claims
AS
SELECT
   c.patient_claims_key
  ,c.claim_id
  ,db.beneficiary_key
  ,claim_type
  ,md5(c.attending_physician_npi) as attending_physician_provider_key
  ,md5(c.operating_physician_npi) as operating_physician_provider_key
  ,md5(c.other_physician_npi) as other_physician_provider_key
  ,c.claim_line_segment
  ,c.claim_start_date
  ,c.claim_end_date
  ,c.inpatient_admission_date
  ,c.claim_payment_amount
  ,c.primary_payer_claim_paid_amount
  ,md5(c.icd9_diagnosis_code_1) as diagnosis_key_1
  ,md5(c.icd9_diagnosis_code_2) as diagnosis_key_2
  ,md5(c.icd9_diagnosis_code_3) as diagnosis_key_3
  ,md5(c.icd9_diagnosis_code_4) as diagnosis_key_4
  ,md5(c.icd9_diagnosis_code_5) as diagnosis_key_5
  ,md5(c.icd9_procedure_code_1) as procedure_key_1
  ,md5(c.icd9_procedure_code_2) as procedure_key_2
  ,md5(c.icd9_procedure_code_3) as procedure_key_3
  ,md5(c.icd9_procedure_code_4) as procedure_key_4
  ,md5(c.icd9_procedure_code_5) as procedure_key_5
  ,md5(c.icd9_admitting_diagnosis_code) as admitting_key
FROM silver.patient_claims c
LEFT JOIN gold.dim_beneficiary db on c.beneficiary_code = db.beneficiary_code 
  AND year(c.claim_start_date) >= db.__START_AT
  AND year(c.claim_start_date) < coalesce(db.__END_AT,9999)
CREATE MATERIALIZED VIEW <YOUR_SCHEMA>.gold_rpt_patient_claims
AS
select
   b.*
  ,p.*
  ,c.claim_id
  ,c.claim_type
  ,c.claim_start_date
  ,c.claim_end_date
  ,c.inpatient_admission_date
  ,c.claim_payment_amount
  ,c.primary_payer_claim_paid_amount
from <YOUR_SCHEMA>.gold_fact_patient_claims c
join <YOUR_SCHEMA>.gold_dim_beneficiary b on c.beneficiary_key = b.beneficiary_key
join <YOUR_SCHEMA>.gold_dim_provider p on c.attending_physician_provider_key = p.provider_key
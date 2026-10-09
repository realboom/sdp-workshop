/************************************************************************
INSTRUCTIONS:

Afer this comment, write code to create a new gold table with the
following requirements.

Table Name: <YOUR_SCHEMA>.gold_fact_prescription_drug_events
Table Type: Materalized View
Primary Table: <YOUR_SCHEMA>.silver_prescription_drug_events

- this should look up the beneficiary_key from the table <YOUR_SCHEMA>.gold_dim_beneficiary
- use the rx_service_date to determine what record to pull from dim_beneficiary
************************************************************************/

CREATE MATERIALIZED VIEW  <YOUR_SCHEMA>.gold_fact_prescription_drug_events
AS
SELECT
   prescription_drug_events_key
  ,ccw_part_d_event_number
  ,db.beneficiary_key
  ,rx_service_date
  ,product_service_id
  ,quantity_dispensed
  ,days_supply
  ,patient_pay_amount
  ,gross_drug_cost
FROM <YOUR_SCHEMA>.silver_prescription_drug_events p
LEFT JOIN <YOUR_SCHEMA>.gold_dim_beneficiary db on p.beneficiary_code = db.beneficiary_code 
  AND year(p.rx_service_date) >= db.__START_AT
  AND year(p.rx_service_date) < coalesce(db.__END_AT,9999)
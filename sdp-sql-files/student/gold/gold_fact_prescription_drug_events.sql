/************************************************************************
INSTRUCTIONS:

Afer this comment, write code to create a new gold table with the
following requirements.

Table Name: gold.fact_prescription_drug_events
Table Type: Materalized View
Primary Table: silver.prescription_drug_events

- this should look up the beneficiary_key from the table gold.dim_beneficiary
- use the rx_service_date to determine what record to pull from dim_beneficiary
************************************************************************/

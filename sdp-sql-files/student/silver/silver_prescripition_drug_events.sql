/************************************************************************
INSTRUCTIONS:

Afer this comment, write code to create a new silver table with the
following requirements.

Table Name: silver.prescription_drug_events_insert
Table Type: Streaming
Source Table: bronze.prescription_drug_events

Fields
- prescription_drug_events_insert_key = uuid
- prescription_drug_events_key = a md5 hash of DESYNPUF_ID, SRVC_DT, PROD_SRVC_ID
- beneficiary_code = DESYNPUF_ID
- ccw_part_d_event_number = PDE_ID, set as string
- rx_service_date = SRVC_DT, set as a date from a format of yyyMMdd to_date(<field>, 'yyyyMMdd')
- product_service_id set as PROD_SRVC_ID, set as a string
- quantity_dispensed set as QTY_DSPNSD_NUM, set as a double
- days_supply set as DAYS_SUPLY_NUM, set as an int
- patient_pay_amount set as PTNT_PAY_AMT, set as a double
- gross_drug_cost set as TOT_RX_CST_AMT, set as a double
- insert_timestamp set as current_timestamp

************************************************************************/





/************************************************************************
INSTRUCTIONS:

Afer this comment, write code to create a new silver table with the
following requirements.

Table Name: silver.prescription_drug_events
Table Type: Streaming
Source Table: silver.prescription_drug_events_insert

- This table should show the latest version of each record using a
SCD type 1
- use prescription_drug_events_key to identify a unique record
- use insert_timestamp to identify the latest record
- reference all columns ecept for prescription_drug_events_insert_key

************************************************************************/

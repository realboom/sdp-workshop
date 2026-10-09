/************************************************************************
INSTRUCTIONS:

Afer this comment, write code to create a new silver table with the
following requirements.

Table Name: silver_prescription_drug_events_insert
Table Type: Streaming
Source Table: <YOUR_SCHEMA>.bronze_prescription_drug_events

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
CREATE TEMPORARY VIEW silver_prescription_drug_events_insert
AS
SELECT
    uuid() as prescription_drug_events_insert_key
   ,md5(pde.DESYNPUF_ID ||pde.SRVC_DT ||pde.PROD_SRVC_ID) as prescription_drug_events_key
  ,pde.DESYNPUF_ID as beneficiary_code
  ,cast(pde.PDE_ID as string) as ccw_part_d_event_number
  ,to_date(pde.SRVC_DT,'yyyyMMdd') as rx_service_date
  ,cast(pde.PROD_SRVC_ID as string) as product_service_id
  ,cast(pde.QTY_DSPNSD_NUM as double) as quantity_dispensed
  ,cast(pde.DAYS_SUPLY_NUM as int) as days_supply
  ,cast(pde.PTNT_PAY_AMT as double) as patient_pay_amount
  ,cast(pde.TOT_RX_CST_AMT as double) as gross_drug_cost
  ,current_timestamp as insert_timestamp
FROM stream(<YOUR_SCHEMA>.bronze_prescription_drug_events) pde;


/************************************************************************
INSTRUCTIONS:

Afer this comment, write code to create a new silver table with the
following requirements.

Table Name: <YOUR_SCHEMA>.silver_prescription_drug_events
Table Type: Streaming
Source Table: silver_prescription_drug_events_insert

- This table should show the latest version of each record using a
SCD type 1
- use prescription_drug_events_key to identify a unique record
- use insert_timestamp to identify the latest record
- reference all columns except for prescription_drug_events_insert_key

************************************************************************/
CREATE STREAMING TABLE <YOUR_SCHEMA>.silver_prescription_drug_events;

CREATE FLOW silver_prescription_drug_events AS AUTO CDC 
  INTO <YOUR_SCHEMA>.silver_prescription_drug_events
FROM
  stream(silver_prescription_drug_events_insert)
KEYS
  (prescription_drug_events_key)
SEQUENCE BY
  (insert_timestamp)
COLUMNS * EXCEPT
  (prescription_drug_events_insert_key)
STORED AS
  SCD TYPE 1;
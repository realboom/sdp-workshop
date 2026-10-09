/*****************************************************************************************
In silver, we will be combining the inpatient and outpatient claims into the same
"patient claims" table. This will allow us to do analysis on both inpatient and outpatient
claims in the same table.

In this scenario we are assuming that both of these sources is "insert only", meaning that 
there will be no updates or deletes to the source records. This allows for a streaming table 
to be created. As the data comes from two sources, we are able to use a flow to load from two 
seperate queries.

If the sources could be modified, then it would be more approprate to create a materialized 
view instead of the table. This materialized fiew would have been a union query of the two 
sources. This is the most realistic "real world" example of how to do this. We are including 
this example do display how a flow will work.
******************************************************************************************/


--create the table both sources
CREATE STREAMING TABLE silver.patient_claims_insert;

--create flow for inpatient claims
CREATE FLOW 
  inpatient_claims_insert
AS INSERT INTO
  silver.patient_claims_insert BY NAME
SELECT
   uuid() as patient_claims_insert_key
  ,md5(ic.DESYNPUF_ID ||ic.CLM_ID ||ic.SEGMENT) as patient_claims_key
  ,ic.DESYNPUF_ID as beneficiary_code
  ,'Inpatient' as claim_type
  ,ic.CLM_ID as claim_id
  ,cast(ic.SEGMENT as int) as claim_line_segment
  ,to_date(ic.CLM_FROM_DT,'yyyyMMdd') as claim_start_date
  ,to_date(ic.CLM_THRU_DT,'yyyyMMdd') as claim_end_date
  ,cast(ic.PRVDR_NUM as string) as provider_instituation_code
  ,cast(CLM_PMT_AMT as double) as claim_payment_amount
  ,cast(NCH_PRMRY_PYR_CLM_PD_AMT as double) as primary_payer_claim_paid_amount
  ,cast(AT_PHYSN_NPI as string) as attending_physician_npi
  ,cast(OP_PHYSN_NPI as string) as operating_physician_npi
  ,cast(OT_PHYSN_NPI as string) as other_physician_npi
  ,to_date(ic.CLM_ADMSN_DT,'yyyyMMdd') as inpatient_admission_date
  ,cast(ADMTNG_ICD9_DGNS_CD as string) as icd9_admitting_diagnosis_code
  ,cast(CLM_PASS_THRU_PER_DIEM_AMT as double) as claim_pass_through_per_diem_amount
  ,coalesce(cast(NCH_BENE_IP_DDCTBL_AMT as double),0.0) as beneficiary_inpatient_deductible_amount
  ,cast(ic.NCH_BENE_PTA_COINSRNC_LBLTY_AM as double) as nch_beneficiary_part_a_coinsurance_liability_limit
  ,cast(ic.NCH_BENE_BLOOD_DDCTBL_LBLTY_AM as double) as hch_beneficiary_blood_deductible_liabiliy_limit
  ,cast(ic.CLM_UTLZTN_DAY_CNT as int) as claim_utilization_day_count
  ,to_date(ic.NCH_BENE_DSCHRG_DT,'yyyyMMdd') as inpatient_discharged_date
  ,cast(ic.CLM_DRG_CD as string) as diagnosis_related_group_code
  ,cast(ic.ICD9_DGNS_CD_1 as string) as icd9_diagnosis_code_1
  ,cast(ic.ICD9_DGNS_CD_2 as string) as icd9_diagnosis_code_2
  ,cast(ic.ICD9_DGNS_CD_3 as string) as icd9_diagnosis_code_3
  ,cast(ic.ICD9_DGNS_CD_4 as string) as icd9_diagnosis_code_4
  ,cast(ic.ICD9_DGNS_CD_5 as string) as icd9_diagnosis_code_5
  ,cast(ic.ICD9_DGNS_CD_6 as string) as icd9_diagnosis_code_6
  ,cast(ic.ICD9_DGNS_CD_7 as string) as icd9_diagnosis_code_7
  ,cast(ic.ICD9_DGNS_CD_8 as string) as icd9_diagnosis_code_8
  ,cast(ic.ICD9_DGNS_CD_9 as string) as icd9_diagnosis_code_9
  ,cast(ic.ICD9_DGNS_CD_10 as string) as icd9_diagnosis_code_10
  ,cast(ic.ICD9_PRCDR_CD_1 as string) as icd9_procedure_code_1  
  ,cast(ic.ICD9_PRCDR_CD_2 as string) as icd9_procedure_code_2
  ,cast(ic.ICD9_PRCDR_CD_3 as string) as icd9_procedure_code_3
  ,cast(ic.ICD9_PRCDR_CD_4 as string) as icd9_procedure_code_4 
  ,cast(ic.ICD9_PRCDR_CD_5 as string) as icd9_procedure_code_5 
  ,cast(ic.ICD9_PRCDR_CD_6 as string) as icd9_procedure_code_6
  ,cast(ic.HCPCS_CD_1 as string) as hcfa_procedure_code_1
  ,cast(ic.HCPCS_CD_2 as string) as hcfa_procedure_code_2
  ,cast(ic.HCPCS_CD_3 as string) as hcfa_procedure_code_3
  ,cast(ic.HCPCS_CD_4 as string) as hcfa_procedure_code_4
  ,cast(ic.HCPCS_CD_5 as string) as hcfa_procedure_code_5
  ,cast(ic.HCPCS_CD_6 as string) as hcfa_procedure_code_6
  ,cast(ic.HCPCS_CD_7 as string) as hcfa_procedure_code_7
  ,cast(ic.HCPCS_CD_8 as string) as hcfa_procedure_code_8
  ,cast(ic.HCPCS_CD_9 as string) as hcfa_procedure_code_9
  ,cast(ic.HCPCS_CD_10 as string) as hcfa_procedure_code_10
  ,cast(ic.HCPCS_CD_11 as string) as hcfa_procedure_code_11
  ,cast(ic.HCPCS_CD_12 as string) as hcfa_procedure_code_12
  ,cast(ic.HCPCS_CD_13 as string) as hcfa_procedure_code_13
  ,cast(ic.HCPCS_CD_14 as string) as hcfa_procedure_code_14
  ,cast(ic.HCPCS_CD_15 as string) as hcfa_procedure_code_15
  ,cast(ic.HCPCS_CD_16 as string) as hcfa_procedure_code_16
  ,cast(ic.HCPCS_CD_17 as string) as hcfa_procedure_code_17
  ,cast(ic.HCPCS_CD_18 as string) as hcfa_procedure_code_18
  ,cast(ic.HCPCS_CD_19 as string) as hcfa_procedure_code_19
  ,cast(ic.HCPCS_CD_20 as string) as hcfa_procedure_code_20
  ,cast(ic.HCPCS_CD_21 as string) as hcfa_procedure_code_21
  ,cast(ic.HCPCS_CD_22 as string) as hcfa_procedure_code_22
  ,cast(ic.HCPCS_CD_23 as string) as hcfa_procedure_code_23
  ,cast(ic.HCPCS_CD_24 as string) as hcfa_procedure_code_24
  ,cast(ic.HCPCS_CD_25 as string) as hcfa_procedure_code_25
  ,cast(ic.HCPCS_CD_26 as string) as hcfa_procedure_code_26
  ,cast(ic.HCPCS_CD_27 as string) as hcfa_procedure_code_27
  ,cast(ic.HCPCS_CD_28 as string) as hcfa_procedure_code_28
  ,cast(ic.HCPCS_CD_29 as string) as hcfa_procedure_code_29
  ,cast(ic.HCPCS_CD_30 as string) as hcfa_procedure_code_30
  ,cast(ic.HCPCS_CD_31 as string) as hcfa_procedure_code_31
  ,cast(ic.HCPCS_CD_32 as string) as hcfa_procedure_code_32
  ,cast(ic.HCPCS_CD_33 as string) as hcfa_procedure_code_33
  ,cast(ic.HCPCS_CD_34 as string) as hcfa_procedure_code_34
  ,cast(ic.HCPCS_CD_35 as string) as hcfa_procedure_code_35
  ,cast(ic.HCPCS_CD_36 as string) as hcfa_procedure_code_36
  ,cast(ic.HCPCS_CD_37 as string) as hcfa_procedure_code_37
  ,cast(ic.HCPCS_CD_38 as string) as hcfa_procedure_code_38
  ,cast(ic.HCPCS_CD_39 as string) as hcfa_procedure_code_39
  ,cast(ic.HCPCS_CD_40 as string) as hcfa_procedure_code_40
  ,cast(ic.HCPCS_CD_41 as string) as hcfa_procedure_code_41
  ,cast(ic.HCPCS_CD_42 as string) as hcfa_procedure_code_42
  ,cast(ic.HCPCS_CD_43 as string) as hcfa_procedure_code_43
  ,cast(ic.HCPCS_CD_44 as string) as hcfa_procedure_code_44
  ,cast(ic.HCPCS_CD_45 as string) as hcfa_procedure_code_45
  ,current_timestamp as insert_timestamp
FROM stream(bronze.inpatient_claims) ic;

--create flow for outpatient claims
CREATE FLOW 
  outpatient_claims
AS INSERT INTO
  silver.patient_claims_insert BY NAME
SELECT
   uuid() as patient_claims_insert_key
  ,md5(oc.DESYNPUF_ID ||oc.CLM_ID ||oc.SEGMENT) as patient_claims_key
  ,oc.DESYNPUF_ID as beneficiary_code
  ,'Outpatient' as claim_type
  ,oc.CLM_ID as claim_id
  ,cast(oc.SEGMENT as int) as claim_line_segment
  ,to_date(oc.CLM_FROM_DT,'yyyyMMdd') as claim_start_date
  ,to_date(oc.CLM_THRU_DT,'yyyyMMdd') as claim_end_date
  ,cast(oc.PRVDR_NUM as string) as provider_instituation_code
  ,cast(oc.CLM_PMT_AMT as double) as claim_payment_amount
  ,cast(oc.NCH_PRMRY_PYR_CLM_PD_AMT as double) as primary_payer_claim_paid_amount
  ,cast(oc.AT_PHYSN_NPI as string) as attending_physician_npi
  ,cast(oc.OP_PHYSN_NPI as string) as operating_physician_npi
  ,cast(oc.OT_PHYSN_NPI as string) as other_physician_npi
  ,cast(oc.NCH_BENE_BLOOD_DDCTBL_LBLTY_AM as double) as hch_beneficiary_blood_deductible_liabiliy_limit
  ,cast(oc.ICD9_DGNS_CD_1 as string) as icd9_diagnosis_code_1
  ,cast(oc.ICD9_DGNS_CD_2 as string) as icd9_diagnosis_code_2
  ,cast(oc.ICD9_DGNS_CD_3 as string) as icd9_diagnosis_code_3
  ,cast(oc.ICD9_DGNS_CD_4 as string) as icd9_diagnosis_code_4
  ,cast(oc.ICD9_DGNS_CD_5 as string) as icd9_diagnosis_code_5
  ,cast(oc.ICD9_DGNS_CD_6 as string) as icd9_diagnosis_code_6
  ,cast(oc.ICD9_DGNS_CD_7 as string) as icd9_diagnosis_code_7
  ,cast(oc.ICD9_DGNS_CD_8 as string) as icd9_diagnosis_code_8
  ,cast(oc.ICD9_DGNS_CD_9 as string) as icd9_diagnosis_code_9
  ,cast(oc.ICD9_DGNS_CD_10 as string) as icd9_diagnosis_code_10
  ,cast(oc.ICD9_PRCDR_CD_1 as string) as icd9_procedure_code_1  
  ,cast(oc.ICD9_PRCDR_CD_2 as string) as icd9_procedure_code_2
  ,cast(oc.ICD9_PRCDR_CD_3 as string) as icd9_procedure_code_3
  ,cast(oc.ICD9_PRCDR_CD_4 as string) as icd9_procedure_code_4 
  ,cast(oc.ICD9_PRCDR_CD_5 as string) as icd9_procedure_code_5 
  ,cast(oc.ICD9_PRCDR_CD_6 as string) as icd9_procedure_code_6
  ,cast(oc.NCH_BENE_PTB_DDCTBL_AMT as double) as nch_beneficiary_part_b_deductable_amount
  ,cast(oc.NCH_BENE_PTB_COINSRNC_AMT as double) as nch_beneficiary_part_b_coinsurance_amount
  ,cast(oc.ADMTNG_ICD9_DGNS_CD as string) as icd9_admitting_diagnosis_code
  ,cast(oc.HCPCS_CD_1 as string) as hcfa_procedure_code_1
  ,cast(oc.HCPCS_CD_2 as string) as hcfa_procedure_code_2
  ,cast(oc.HCPCS_CD_3 as string) as hcfa_procedure_code_3
  ,cast(oc.HCPCS_CD_4 as string) as hcfa_procedure_code_4
  ,cast(oc.HCPCS_CD_5 as string) as hcfa_procedure_code_5
  ,cast(oc.HCPCS_CD_6 as string) as hcfa_procedure_code_6
  ,cast(oc.HCPCS_CD_7 as string) as hcfa_procedure_code_7
  ,cast(oc.HCPCS_CD_8 as string) as hcfa_procedure_code_8
  ,cast(oc.HCPCS_CD_9 as string) as hcfa_procedure_code_9
  ,cast(oc.HCPCS_CD_10 as string) as hcfa_procedure_code_10
  ,cast(oc.HCPCS_CD_11 as string) as hcfa_procedure_code_11
  ,cast(oc.HCPCS_CD_12 as string) as hcfa_procedure_code_12
  ,cast(oc.HCPCS_CD_13 as string) as hcfa_procedure_code_13
  ,cast(oc.HCPCS_CD_14 as string) as hcfa_procedure_code_14
  ,cast(oc.HCPCS_CD_15 as string) as hcfa_procedure_code_15
  ,cast(oc.HCPCS_CD_16 as string) as hcfa_procedure_code_16
  ,cast(oc.HCPCS_CD_17 as string) as hcfa_procedure_code_17
  ,cast(oc.HCPCS_CD_18 as string) as hcfa_procedure_code_18
  ,cast(oc.HCPCS_CD_19 as string) as hcfa_procedure_code_19
  ,cast(oc.HCPCS_CD_20 as string) as hcfa_procedure_code_20
  ,cast(oc.HCPCS_CD_21 as string) as hcfa_procedure_code_21
  ,cast(oc.HCPCS_CD_22 as string) as hcfa_procedure_code_22
  ,cast(oc.HCPCS_CD_23 as string) as hcfa_procedure_code_23
  ,cast(oc.HCPCS_CD_24 as string) as hcfa_procedure_code_24
  ,cast(oc.HCPCS_CD_25 as string) as hcfa_procedure_code_25
  ,cast(oc.HCPCS_CD_26 as string) as hcfa_procedure_code_26
  ,cast(oc.HCPCS_CD_27 as string) as hcfa_procedure_code_27
  ,cast(oc.HCPCS_CD_28 as string) as hcfa_procedure_code_28
  ,cast(oc.HCPCS_CD_29 as string) as hcfa_procedure_code_29
  ,cast(oc.HCPCS_CD_30 as string) as hcfa_procedure_code_30
  ,cast(oc.HCPCS_CD_31 as string) as hcfa_procedure_code_31
  ,cast(oc.HCPCS_CD_32 as string) as hcfa_procedure_code_32
  ,cast(oc.HCPCS_CD_33 as string) as hcfa_procedure_code_33
  ,cast(oc.HCPCS_CD_34 as string) as hcfa_procedure_code_34
  ,cast(oc.HCPCS_CD_35 as string) as hcfa_procedure_code_35
  ,cast(oc.HCPCS_CD_36 as string) as hcfa_procedure_code_36
  ,cast(oc.HCPCS_CD_37 as string) as hcfa_procedure_code_37
  ,cast(oc.HCPCS_CD_38 as string) as hcfa_procedure_code_38
  ,cast(oc.HCPCS_CD_39 as string) as hcfa_procedure_code_39
  ,cast(oc.HCPCS_CD_40 as string) as hcfa_procedure_code_40
  ,cast(oc.HCPCS_CD_41 as string) as hcfa_procedure_code_41
  ,cast(oc.HCPCS_CD_42 as string) as hcfa_procedure_code_42
  ,cast(oc.HCPCS_CD_43 as string) as hcfa_procedure_code_43
  ,cast(oc.HCPCS_CD_44 as string) as hcfa_procedure_code_44
  ,cast(oc.HCPCS_CD_45 as string) as hcfa_procedure_code_45
  ,current_timestamp as insert_timestamp
FROM stream(bronze.outpatient_claims) oc;


--create the merged version of the table
CREATE STREAMING TABLE silver.patient_claims;

CREATE FLOW silver_patient_claims AS AUTO CDC 
  INTO silver.patient_claims
FROM
  stream(silver.patient_claims_insert)
KEYS
  (patient_claims_key)
SEQUENCE BY
  (insert_timestamp)
COLUMNS * EXCEPT
  (patient_claims_insert_key)
STORED AS
  SCD TYPE 1;
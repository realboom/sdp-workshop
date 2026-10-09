/********************************************************************
Beneficiary Insert:

The code block below will build the silver table with data transformations necessary for the dataset. This will insert into the first silver table.

Key Concepts in the table:
- Data is read form the source table with the stream() syntax to bring in only the latest copy of the source table since the last load
- This will join multiple times to the table bronze.lookups. This table contains descriptions for various fields to transform a code into something that an analyst would understand.
- Data is typed using case statements to move the data to the desiered format as the bronze tables store everything as strings
********************************************************************/
CREATE STREAMING TABLE silver.beneficiary_insert
AS
SELECT
     uuid() as beneficiary_insert_key
    ,md5(bs.DESYNPUF_ID) as beneficiary_unique_key
    ,bs.DESYNPUF_ID as beneficiary_code
    ,cast(substring(bs._metadata.file_name,7,4) as int) as year
    ,to_date(bs.BENE_BIRTH_DT,'yyyyMMdd') as date_of_birth
    ,to_date(bs.BENE_DEATH_DT,'yyyyMMdd') as date_of_death
    ,cast(l_BENE_SEX_IDENT_CD.label as string) as gender
    ,cast(l_BENE_RACE_CD.label as string) as race
    ,CASE WHEN to_date(bs.BENE_DEATH_DT,'yyyyMMdd') IS NULL THEN 0 ELSE 1 END as deceased_flag
    ,CASE WHEN BENE_ESRD_IND IN ('Yes', 'Y') THEN 1 ELSE 0 END as esrd_flag
    ,cast(l_SP_STATE_CODE.label as string) as state
    ,bs.BENE_COUNTY_CD as county_code
    ,cast(bs.BENE_HI_CVRAGE_TOT_MONS as int) as part_a_coverage_months
    ,cast(bs.BENE_SMI_CVRAGE_TOT_MONS as int) as part_b_coverage_months
    ,cast(bs.BENE_HMO_CVRAGE_TOT_MONS as int) as hmo_coverage_months
    ,cast(bs.PLAN_CVRG_MOS_NUM as int) as part_d_coverage_months
    ,CASE WHEN l_SP_ALZHDMTA.label IN ('Yes', 'Y') THEN 1 ELSE 0 END as alzheimers_or_related_flag
    ,CASE WHEN l_SP_CHF.label IN ('Yes', 'Y') THEN 1 ELSE 0 END as heart_failure_flag
    ,CASE WHEN l_SP_CHRNKIDN.label IN ('Yes', 'Y') THEN 1 ELSE 0 END as cronic_kidney_disease_flag
    ,CASE WHEN l_SP_CNCR.label IN ('Yes', 'Y') THEN 1 ELSE 0 END as cancer_flag
    ,CASE WHEN l_SP_COPD.label IN ('Yes', 'Y') THEN 1 ELSE 0 END as copd_flag
    ,CASE WHEN l_SP_DEPRESSN.label IN ('Yes', 'Y') THEN 1 ELSE 0 END as depression_flag
    ,CASE WHEN l_SP_DIABETES.label IN ('Yes', 'Y') THEN 1 ELSE 0 END as diabetes_flag
    ,CASE WHEN l_SP_ISCHMCHT.label IN ('Yes', 'Y') THEN 1 ELSE 0 END as ischemic_heart_disease_flag
    ,CASE WHEN l_SP_OSTEOPRS.label IN ('Yes', 'Y') THEN 1 ELSE 0 END as osteoporosis_flag
    ,CASE WHEN l_SP_RA_OA.label IN ('Yes', 'Y') THEN 1 ELSE 0 END as rheumatoid_arthritis_flag
    ,CASE WHEN l_SP_STRKETIA.label IN ('Yes', 'Y') THEN 1 ELSE 0 END as stroke_transient_ischemic_attack_flag
    ,cast(MEDREIMB_IP as double) as inpatient_annual_medicare_reimbursement_amount
    ,cast(BENRES_IP as double) as inpatient_annual_beneficiary_responsibility_amount
    ,cast(PPPYMT_IP as double) as inpatient_annual_payer_reimbursement_amount
    ,cast(MEDREIMB_OP as double) as outpatient_institutional_annual_medicare_reimbursement_amount
    ,cast(BENRES_OP as double) as outpatient_institutional_annual_beneficiary_responsibiliy_amount
    ,cast(PPPYMT_OP as double) as outpatient_institutional_annual_primary_payer_reimbursement_amount
    ,cast(MEDREIMB_CAR as double) as carrier_annual_medicare_reimbursement_amount
    ,cast(BENRES_CAR as double) as carrier_annual_beneficiary_responsiblity_amount
    ,cast(PPPYMT_CAR as double) as carrier_annual_primary_payer_reimbursement_amount
    ,current_timestamp as insert_timestamp 
FROM 
stream(bronze.beneficiary) bs
left join bronze.lookups l_BENE_SEX_IDENT_CD on bs.BENE_SEX_IDENT_CD = l_BENE_SEX_IDENT_CD.code and l_BENE_SEX_IDENT_CD.variable = 'BENE_SEX_IDENT_CD'
left join bronze.lookups l_BENE_RACE_CD on bs.BENE_RACE_CD = l_BENE_RACE_CD.code and l_BENE_RACE_CD.variable = 'BENE_RACE_CD'
left join bronze.lookups l_SP_STATE_CODE on bs.SP_STATE_CODE = l_SP_STATE_CODE.code and l_SP_STATE_CODE.variable = 'SP_STATE_CODE'
left join bronze.lookups l_SP_ALZHDMTA on bs.SP_ALZHDMTA = l_SP_ALZHDMTA.code and l_SP_ALZHDMTA.variable = 'SP_ALZHDMTA'
left join bronze.lookups l_SP_CHF on bs.SP_CHF = l_SP_CHF.code and l_SP_CHF.variable = 'SP_CHF'
left join bronze.lookups l_SP_CHRNKIDN on bs.SP_CHRNKIDN = l_SP_CHRNKIDN.code and l_SP_CHRNKIDN.variable = 'SP_CHRNKIDN'
left join bronze.lookups l_SP_CNCR on bs.SP_CNCR = l_SP_CNCR.code and l_SP_CNCR.variable = 'SP_CNCR'
left join bronze.lookups l_SP_COPD on bs.SP_COPD = l_SP_COPD.code and l_SP_COPD.variable = 'SP_COPD'
left join bronze.lookups l_SP_DEPRESSN on bs.SP_DEPRESSN = l_SP_DEPRESSN.code and l_SP_DEPRESSN.variable = 'SP_DEPRESSN'
left join bronze.lookups l_SP_DIABETES on bs.SP_DIABETES = l_SP_DIABETES.code and l_SP_DIABETES.variable = 'SP_DIABETES'
left join bronze.lookups l_SP_ISCHMCHT on bs.SP_ISCHMCHT = l_SP_ISCHMCHT.code and l_SP_ISCHMCHT.variable = 'SP_ISCHMCHT'
left join bronze.lookups l_SP_OSTEOPRS on bs.SP_OSTEOPRS = l_SP_OSTEOPRS.code and l_SP_OSTEOPRS.variable = 'SP_OSTEOPRS'
left join bronze.lookups l_SP_RA_OA on bs.SP_RA_OA = l_SP_RA_OA.code and l_SP_RA_OA.variable = 'SP_RA_OA'
left join bronze.lookups l_SP_STRKETIA on bs.SP_STRKETIA = l_SP_STRKETIA.code and l_SP_STRKETIA.variable = 'SP_STRKETIA';


/********************************************************************
The table is then merged into the deduplicate version of the table using the auto-cdc syntax. This will perform a merge based on the key(s) provided. It has the following components.

- FROM: This is the source table, which will be streamed into this statement.
- KEYS: This is a list of keys that are used to identify a unique record so it knows if the record exists to determine if it should be inserted or updated
- SEQUENCE BY: This will allow the system to determine what is the most recent record. In this case, we are using year, but if there are multiple records for the same year, it will use insert_timestamp next.
- COLUMNS * EXCEPT: This will insert all columns from the source except the ones listed
- STORED AS: This will determine if we are using SCD Type 1 (merge to the latest reocrd) or SCD Type 2 (tracks changes in the table). In this scenario, we are using type 1.
********************************************************************/

CREATE OR REFRESH STREAMING TABLE silver.beneficiary;

CREATE FLOW silver_beneficiary AS AUTO CDC 
  INTO silver.beneficiary
FROM
  stream(silver.beneficiary_insert)
KEYS
  (beneficiary_unique_key)
SEQUENCE BY
  (year,insert_timestamp)
COLUMNS * EXCEPT
  (beneficiary_insert_key)
STORED AS
  SCD TYPE 1;
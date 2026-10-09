/*****************************************************************************************
One key differences is the use of a CONSTRAINT as we want to impliment a data quality rule 
to make sure that the beneficiary code is not null. As we didn't include additional logic 
to to drop the row or stop the pipeline, so this will just set a warning if this contraint is 
not met.
******************************************************************************************/

--create insert-only table with all the business logic
CREATE STREAMING TABLE silver.carrier_claims_insert(
  CONSTRAINT `Beneficiary code is not null`    EXPECT (beneficiary_code is not null)
)
AS
SELECT
   uuid() as carrier_claims_insert_key
  ,md5(cc.CLM_ID) as carrier_claims_key
  ,cc.DESYNPUF_ID as beneficiary_code
  ,cc.CLM_ID as claim_id
  ,to_date(CLM_FROM_DT,'yyyyMMdd') as claim_start_date
  ,to_date(CLM_THRU_DT,'yyyyMMdd') as claim_end_date
  ,cc.ICD9_DGNS_CD_1 as claim_diagnosis_code_1
  ,cc.ICD9_DGNS_CD_2 as claim_diagnosis_code_2
  ,cc.ICD9_DGNS_CD_3 as claim_diagnosis_code_3
  ,cc.ICD9_DGNS_CD_4 as claim_diagnosis_code_4
  ,cc.ICD9_DGNS_CD_5 as claim_diagnosis_code_5
  ,cc.ICD9_DGNS_CD_6 as claim_diagnosis_code_6
  ,cc.ICD9_DGNS_CD_7 as claim_diagnosis_code_7
  ,cc.ICD9_DGNS_CD_8 as claim_diagnosis_code_8
  ,cc.PRF_PHYSN_NPI_1 as provider_physician_npi_1
  ,cc.PRF_PHYSN_NPI_2 as provider_physician_npi_2
  ,cc.PRF_PHYSN_NPI_3 as provider_physician_npi_3
  ,cc.PRF_PHYSN_NPI_4 as provider_physician_npi_4
  ,cc.PRF_PHYSN_NPI_5 as provider_physician_npi_5
  ,cc.PRF_PHYSN_NPI_6 as provider_physician_npi_6
  ,cc.PRF_PHYSN_NPI_7 as provider_physician_npi_7
  ,cc.PRF_PHYSN_NPI_8 as provider_physician_npi_8
  ,cc.PRF_PHYSN_NPI_9 as provider_physician_npi_9
  ,cc.PRF_PHYSN_NPI_10 as provider_physician_npi_10
  ,cc.PRF_PHYSN_NPI_11 as provider_physician_npi_11
  ,cc.PRF_PHYSN_NPI_12 as provider_physician_npi_12
  ,cc.PRF_PHYSN_NPI_13 as provider_physician_npi_13
  ,cc.TAX_NUM_1 as provider_insitution_tax_number_1
  ,cc.TAX_NUM_2 as provider_insitution_tax_number_2
  ,cc.TAX_NUM_3 as provider_insitution_tax_number_3
  ,cc.TAX_NUM_4 as provider_insitution_tax_number_4
  ,cc.TAX_NUM_5 as provider_insitution_tax_number_5
  ,cc.TAX_NUM_6 as provider_insitution_tax_number_6
  ,cc.TAX_NUM_7 as provider_insitution_tax_number_7
  ,cc.TAX_NUM_8 as provider_insitution_tax_number_8
  ,cc.TAX_NUM_9 as provider_insitution_tax_number_9
  ,cc.TAX_NUM_10 as provider_insitution_tax_number_10
  ,cc.TAX_NUM_11 as provider_insitution_tax_number_11
  ,cc.TAX_NUM_12 as provider_insitution_tax_number_12
  ,cc.TAX_NUM_13 as provider_insitution_tax_number_13
  ,cc.HCPCS_CD_1 as hcpcs_code_1
  ,cc.HCPCS_CD_2 as hcpcs_code_2
  ,cc.HCPCS_CD_3 as hcpcs_code_3
  ,cc.HCPCS_CD_4 as hcpcs_code_4
  ,cc.HCPCS_CD_5 as hcpcs_code_5
  ,cc.HCPCS_CD_6 as hcpcs_code_6
  ,cc.HCPCS_CD_7 as hcpcs_code_7
  ,cc.HCPCS_CD_8 as hcpcs_code_8
  ,cc.HCPCS_CD_9 as hcpcs_code_9
  ,cc.HCPCS_CD_10 as hcpcs_code_10
  ,cc.HCPCS_CD_11 as hcpcs_code_11
  ,cc.HCPCS_CD_12 as hcpcs_code_12
  ,cc.HCPCS_CD_13 as hcpcs_code_13
  ,cast(cc.LINE_NCH_PMT_AMT_1 as double) as nch_payment_amount_1
  ,cast(cc.LINE_NCH_PMT_AMT_2 as double) as nch_payment_amount_2
  ,cast(cc.LINE_NCH_PMT_AMT_3 as double) as nch_payment_amount_3
  ,cast(cc.LINE_NCH_PMT_AMT_4 as double) as nch_payment_amount_4
  ,cast(cc.LINE_NCH_PMT_AMT_5 as double) as nch_payment_amount_5
  ,cast(cc.LINE_NCH_PMT_AMT_6 as double) as nch_payment_amount_6
  ,cast(cc.LINE_NCH_PMT_AMT_7 as double) as nch_payment_amount_7
  ,cast(cc.LINE_NCH_PMT_AMT_8 as double) as nch_payment_amount_8
  ,cast(cc.LINE_NCH_PMT_AMT_9 as double) as nch_payment_amount_9
  ,cast(cc.LINE_NCH_PMT_AMT_10 as double) as nch_payment_amount_10
  ,cast(cc.LINE_NCH_PMT_AMT_11 as double) as nch_payment_amount_11
  ,cast(cc.LINE_NCH_PMT_AMT_12 as double) as nch_payment_amount_12
  ,cast(cc.LINE_NCH_PMT_AMT_13 as double) as nch_payment_amount_13
  ,cast(cc.LINE_BENE_PTB_DDCTBL_AMT_1 as double) as line_beneficiary_part_b_deductable_amount_1
  ,cast(cc.LINE_BENE_PTB_DDCTBL_AMT_2 as double) as line_beneficiary_part_b_deductable_amount_2
  ,cast(cc.LINE_BENE_PTB_DDCTBL_AMT_3 as double) as line_beneficiary_part_b_deductable_amount_3
  ,cast(cc.LINE_BENE_PTB_DDCTBL_AMT_4 as double) as line_beneficiary_part_b_deductable_amount_4
  ,cast(cc.LINE_BENE_PTB_DDCTBL_AMT_5 as double) as line_beneficiary_part_b_deductable_amount_5
  ,cast(cc.LINE_BENE_PTB_DDCTBL_AMT_6 as double) as line_beneficiary_part_b_deductable_amount_6
  ,cast(cc.LINE_BENE_PTB_DDCTBL_AMT_7 as double) as line_beneficiary_part_b_deductable_amount_7
  ,cast(cc.LINE_BENE_PTB_DDCTBL_AMT_8 as double) as line_beneficiary_part_b_deductable_amount_8
  ,cast(cc.LINE_BENE_PTB_DDCTBL_AMT_9 as double) as line_beneficiary_part_b_deductable_amount_9
  ,cast(cc.LINE_BENE_PTB_DDCTBL_AMT_10 as double) as line_beneficiary_part_b_deductable_amount_10
  ,cast(cc.LINE_BENE_PTB_DDCTBL_AMT_11 as double) as line_beneficiary_part_b_deductable_amount_11
  ,cast(cc.LINE_BENE_PTB_DDCTBL_AMT_12 as double) as line_beneficiary_part_b_deductable_amount_12
  ,cast(cc.LINE_BENE_PTB_DDCTBL_AMT_13 as double) as line_beneficiary_part_b_deductable_amount_13
  ,cast(cc.LINE_BENE_PRMRY_PYR_PD_AMT_1 as double) as line_beneficiary_primary_payer_paid_amount_1
  ,cast(cc.LINE_BENE_PRMRY_PYR_PD_AMT_2 as double) as line_beneficiary_primary_payer_paid_amount_2
  ,cast(cc.LINE_BENE_PRMRY_PYR_PD_AMT_3 as double) as line_beneficiary_primary_payer_paid_amount_3
  ,cast(cc.LINE_BENE_PRMRY_PYR_PD_AMT_4 as double) as line_beneficiary_primary_payer_paid_amount_4
  ,cast(cc.LINE_BENE_PRMRY_PYR_PD_AMT_5 as double) as line_beneficiary_primary_payer_paid_amount_5
  ,cast(cc.LINE_BENE_PRMRY_PYR_PD_AMT_6 as double) as line_beneficiary_primary_payer_paid_amount_6
  ,cast(cc.LINE_BENE_PRMRY_PYR_PD_AMT_7 as double) as line_beneficiary_primary_payer_paid_amount_7
  ,cast(cc.LINE_BENE_PRMRY_PYR_PD_AMT_8 as double) as line_beneficiary_primary_payer_paid_amount_8
  ,cast(cc.LINE_BENE_PRMRY_PYR_PD_AMT_9 as double) as line_beneficiary_primary_payer_paid_amount_9
  ,cast(cc.LINE_BENE_PRMRY_PYR_PD_AMT_10 as double) as line_beneficiary_primary_payer_paid_amount_10
  ,cast(cc.LINE_BENE_PRMRY_PYR_PD_AMT_11 as double) as line_beneficiary_primary_payer_paid_amount_11
  ,cast(cc.LINE_BENE_PRMRY_PYR_PD_AMT_12 as double) as line_beneficiary_primary_payer_paid_amount_12
  ,cast(cc.LINE_BENE_PRMRY_PYR_PD_AMT_13 as double) as line_beneficiary_primary_payer_paid_amount_13
  ,cast(cc.LINE_COINSRNC_AMT_1 as double) as line_coinsurance_amount_1
  ,cast(cc.LINE_COINSRNC_AMT_2 as double) as line_coinsurance_amount_2
  ,cast(cc.LINE_COINSRNC_AMT_3 as double) as line_coinsurance_amount_3
  ,cast(cc.LINE_COINSRNC_AMT_4 as double) as line_coinsurance_amount_4
  ,cast(cc.LINE_COINSRNC_AMT_5 as double) as line_coinsurance_amount_5
  ,cast(cc.LINE_COINSRNC_AMT_6 as double) as line_coinsurance_amount_6
  ,cast(cc.LINE_COINSRNC_AMT_7 as double) as line_coinsurance_amount_7
  ,cast(cc.LINE_COINSRNC_AMT_8 as double) as line_coinsurance_amount_8
  ,cast(cc.LINE_COINSRNC_AMT_9 as double) as line_coinsurance_amount_9
  ,cast(cc.LINE_COINSRNC_AMT_10 as double) as line_coinsurance_amount_10
  ,cast(cc.LINE_COINSRNC_AMT_11 as double) as line_coinsurance_amount_11
  ,cast(cc.LINE_COINSRNC_AMT_12 as double) as line_coinsurance_amount_12
  ,cast(cc.LINE_COINSRNC_AMT_13 as double) as line_coinsurance_amount_13
  ,cast(cc.LINE_ALOWD_CHRG_AMT_1 as double) as line_allowed_charge_amount_1
  ,cast(cc.LINE_ALOWD_CHRG_AMT_2 as double) as line_allowed_charge_amount_2
  ,cast(cc.LINE_ALOWD_CHRG_AMT_3 as double) as line_allowed_charge_amount_3
  ,cast(cc.LINE_ALOWD_CHRG_AMT_4 as double) as line_allowed_charge_amount_4
  ,cast(cc.LINE_ALOWD_CHRG_AMT_5 as double) as line_allowed_charge_amount_5
  ,cast(cc.LINE_ALOWD_CHRG_AMT_6 as double) as line_allowed_charge_amount_6
  ,cast(cc.LINE_ALOWD_CHRG_AMT_7 as double) as line_allowed_charge_amount_7
  ,cast(cc.LINE_ALOWD_CHRG_AMT_8 as double) as line_allowed_charge_amount_8
  ,cast(cc.LINE_ALOWD_CHRG_AMT_9 as double) as line_allowed_charge_amount_9
  ,cast(cc.LINE_ALOWD_CHRG_AMT_10 as double) as line_allowed_charge_amount_10
  ,cast(cc.LINE_ALOWD_CHRG_AMT_11 as double) as line_allowed_charge_amount_11
  ,cast(cc.LINE_ALOWD_CHRG_AMT_12 as double) as line_allowed_charge_amount_12
  ,cast(cc.LINE_ALOWD_CHRG_AMT_13 as double) as line_allowed_charge_amount_13
  ,cast(cc.LINE_PRCSG_IND_CD_1 as string) as line_processing_indicator_code_1
  ,cast(cc.LINE_PRCSG_IND_CD_2 as string) as line_processing_indicator_code_2
  ,cast(cc.LINE_PRCSG_IND_CD_3 as string) as line_processing_indicator_code_3
  ,cast(cc.LINE_PRCSG_IND_CD_4 as string) as line_processing_indicator_code_4
  ,cast(cc.LINE_PRCSG_IND_CD_5 as string) as line_processing_indicator_code_5
  ,cast(cc.LINE_PRCSG_IND_CD_6 as string) as line_processing_indicator_code_6
  ,cast(cc.LINE_PRCSG_IND_CD_7 as string) as line_processing_indicator_code_7
  ,cast(cc.LINE_PRCSG_IND_CD_8 as string) as line_processing_indicator_code_8
  ,cast(cc.LINE_PRCSG_IND_CD_9 as string) as line_processing_indicator_code_9
  ,cast(cc.LINE_PRCSG_IND_CD_10 as string) as line_processing_indicator_code_10
  ,cast(cc.LINE_PRCSG_IND_CD_11 as string) as line_processing_indicator_code_11
  ,cast(cc.LINE_PRCSG_IND_CD_12 as string) as line_processing_indicator_code_12
  ,cast(cc.LINE_PRCSG_IND_CD_13 as string) as line_processing_indicator_code_13
  ,cast(cc.LINE_ICD9_DGNS_CD_1 as string) as line_icd9_diagnosis_code_1
  ,cast(cc.LINE_ICD9_DGNS_CD_2 as string) as line_icd9_diagnosis_code_2
  ,cast(cc.LINE_ICD9_DGNS_CD_3 as string) as line_icd9_diagnosis_code_3
  ,cast(cc.LINE_ICD9_DGNS_CD_4 as string) as line_icd9_diagnosis_code_4
  ,cast(cc.LINE_ICD9_DGNS_CD_5 as string) as line_icd9_diagnosis_code_5
  ,cast(cc.LINE_ICD9_DGNS_CD_6 as string) as line_icd9_diagnosis_code_6
  ,cast(cc.LINE_ICD9_DGNS_CD_7 as string) as line_icd9_diagnosis_code_7
  ,cast(cc.LINE_ICD9_DGNS_CD_8 as string) as line_icd9_diagnosis_code_8
  ,cast(cc.LINE_ICD9_DGNS_CD_9 as string) as line_icd9_diagnosis_code_9
  ,cast(cc.LINE_ICD9_DGNS_CD_10 as string) as line_icd9_diagnosis_code_10
  ,cast(cc.LINE_ICD9_DGNS_CD_11 as string) as line_icd9_diagnosis_code_11
  ,cast(cc.LINE_ICD9_DGNS_CD_12 as string) as line_icd9_diagnosis_code_12
  ,cast(cc.LINE_ICD9_DGNS_CD_13 as string) as line_icd9_diagnosis_code_13
  ,current_timestamp as insert_timestamp
FROM stream(bronze.carrier_claims) cc;


--create the merged silver table
CREATE STREAMING TABLE silver.carrier_claims;

CREATE FLOW silver_carrier_claims AS AUTO CDC 
  INTO silver.carrier_claims
FROM
  stream(silver.carrier_claims_insert)
KEYS
  (carrier_claims_key)
SEQUENCE BY
  (insert_timestamp)
COLUMNS * EXCEPT
  (carrier_claims_insert_key)
STORED AS
  SCD TYPE 1;

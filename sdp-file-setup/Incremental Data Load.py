# Databricks notebook source
dbutils.widgets.dropdown("files", "1", ["1", "2", "3", "4", "5", "6","7","8","9","10","11","12","13","14","15","16","17","18","19","20"])

# COMMAND ----------

files_to_process = dbutils.widgets.get("files")
print(files_to_process)

# COMMAND ----------

# DBTITLE 1,Widgets for Root Paths
# Create widget for the common root path
dbutils.widgets.text("volume_root", "/Volumes/cms_source/raw/raw_data", "Volume Root Path")

# Get widget value
volume_root = dbutils.widgets.get("volume_root")

# COMMAND ----------

# DBTITLE 1,Benefit Summary
# 2008 Beneficiary Summary File Sample
dbutils.fs.cp(
    f'{volume_root}/all_data/beneficiary/DE1_0_2008_Beneficiary_Summary_File_Sample_{files_to_process}.csv',
    f'{volume_root}/beneficiary/DE1_0_2008_Beneficiary_Summary_File_Sample_{files_to_process}.csv'
)

# 2009 Beneficiary Summary File Sample
dbutils.fs.cp(
    f'{volume_root}/all_data/beneficiary/DE1_0_2009_Beneficiary_Summary_File_Sample_{files_to_process}.csv',
    f'{volume_root}/beneficiary/DE1_0_2009_Beneficiary_Summary_File_Sample_{files_to_process}.csv'
)

# 2010 Beneficiary Summary File Sample
dbutils.fs.cp(
    f'{volume_root}/all_data/beneficiary/DE1_0_2010_Beneficiary_Summary_File_Sample_{files_to_process}.csv',
    f'{volume_root}/beneficiary/DE1_0_2010_Beneficiary_Summary_File_Sample_{files_to_process}.csv'
)


# COMMAND ----------

# DBTITLE 1,Inpatient Claims
# Inpatient Claims
dbutils.fs.cp(
    f'{volume_root}/all_data/inpatient_claims/DE1_0_2008_to_2010_Inpatient_Claims_Sample_{files_to_process}.csv',
    f'{volume_root}/inpatient_claims/DE1_0_2008_to_2010_Inpatient_Claims_Sample_{files_to_process}.csv'
)

# COMMAND ----------

# DBTITLE 1,Outpatient Claims
dbutils.fs.cp(
    f'{volume_root}/all_data/outpatient_claims/DE1_0_2008_to_2010_Outpatient_Claims_Sample_{files_to_process}.csv',
    f'{volume_root}/outpatient_claims/DE1_0_2008_to_2010_Outpatient_Claims_Sample_{files_to_process}.csv'
)

# COMMAND ----------

# DBTITLE 1,Prescription Drug Events
dbutils.fs.cp(
    f'{volume_root}/all_data/prescription_drug_events/DE1_0_2008_to_2010_Prescription_Drug_Events_Sample_{files_to_process}.csv',
    f'{volume_root}/prescription_drug_events/DE1_0_2008_to_2010_Prescription_Drug_Events_Sample_{files_to_process}.csv'
)

# COMMAND ----------

# DBTITLE 1,Carrier Claims
# Carrier Claims Sample A
dbutils.fs.cp(
    f'{volume_root}/all_data/carrier_claims/DE1_0_2008_to_2010_Carrier_Claims_Sample_{files_to_process}A.csv',
    f'{volume_root}/carrier_claims/DE1_0_2008_to_2010_Carrier_Claims_Sample_{files_to_process}A.csv'
)

# Carrier Claims Sample B
dbutils.fs.cp(
    f'{volume_root}/all_data/carrier_claims/DE1_0_2008_to_2010_Carrier_Claims_Sample_{files_to_process}B.csv',
    f'{volume_root}/carrier_claims/DE1_0_2008_to_2010_Carrier_Claims_Sample_{files_to_process}B.csv'
)
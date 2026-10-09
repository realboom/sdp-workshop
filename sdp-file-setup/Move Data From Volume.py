# Databricks notebook source
#source location widget
dbutils.widgets.text("source_location", "/Volumes/cms_workshop_data/bronze/raw_data")
source_location = dbutils.widgets.get("source_location")

#destination location widget
dbutils.widgets.text("destination_location", "/Volumes/cms_source/raw/raw_data")
destination_location = dbutils.widgets.get("destination_location")

# COMMAND ----------

dbutils.fs.cp(f"{source_location}/all_data/beneficiary/", f"{destination_location}/all_data/beneficiary/", recurse=True)

# COMMAND ----------

dbutils.fs.cp(f"{source_location}/all_data/carrier_claims/", f"{destination_location}/all_data/carrier_claims/", recurse=True)

# COMMAND ----------

dbutils.fs.cp(f"{source_location}/date/",f"{destination_location}/date/", recurse=True)

# COMMAND ----------

dbutils.fs.cp(f"{source_location}/icd_codes/",f"{destination_location}/icd_codes/", recurse=True)

# COMMAND ----------

dbutils.fs.cp(f"{source_location}/all_data/inpatient_claims/",f"{destination_location}/all_data/inpatient_claims/", recurse=True)

# COMMAND ----------

dbutils.fs.cp(f"{source_location}/lookups/",f"{destination_location}/lookups/", recurse=True)

# COMMAND ----------

dbutils.fs.cp(f"{source_location}/npi_codes/",f"{destination_location}/npi_codes/", recurse=True)

# COMMAND ----------

dbutils.fs.cp(f"{source_location}/all_data/outpatient_claims/",f"{destination_location}/all_data/outpatient_claims/", recurse=True)

# COMMAND ----------

dbutils.fs.cp(f"{source_location}/all_data/prescription_drug_events/",f"{destination_location}/all_data/prescription_drug_events/", recurse=True)
-- Databricks notebook source
-- MAGIC %md
-- MAGIC # Start Here — Setup Catalog, Schema, and Volume
-- MAGIC Set the **catalog** widget (first cell) to the catalog you want, then run the rest. This creates
-- MAGIC the catalog/schema/volume and loads the first incremental data batch.
-- MAGIC
-- MAGIC **Prerequisite — upload the CMS data into the volume** at `/Volumes/<catalog>/bronze/raw_data/` in
-- MAGIC this layout (the data lives in the volume; there's no volume-to-volume copy step):
-- MAGIC - `all_data/<table>/…` — **staging**, the full set: `beneficiary`, `carrier_claims`,
-- MAGIC   `inpatient_claims`, `outpatient_claims`, `prescription_drug_events`
-- MAGIC - `date/`, `icd_codes/`, `lookups/`, `npi_codes/` — reference tables, at the volume root
-- MAGIC - leave the per-table landing dirs (`beneficiary/`, `carrier_claims/`, …) **empty** — the
-- MAGIC   `Incremental Data Load` notebook fills them one batch at a time.

-- COMMAND ----------

-- DBTITLE 1,Set your catalog, then run the rest
CREATE WIDGET TEXT catalog DEFAULT 'cms_workshop';

-- COMMAND ----------

CREATE CATALOG IF NOT EXISTS IDENTIFIER(:catalog);
CREATE SCHEMA  IF NOT EXISTS IDENTIFIER(:catalog || '.bronze');
CREATE VOLUME  IF NOT EXISTS IDENTIFIER(:catalog || '.bronze.raw_data');

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Load the first batch. `Incremental Data Load` copies one batch from `all_data/<table>/` into each
-- MAGIC table's landing dir. There are 20 batches — re-run with a higher `files` value during the workshop
-- MAGIC to demonstrate incremental / continuous loads.

-- COMMAND ----------

-- MAGIC %python
-- MAGIC catalog = dbutils.widgets.get("catalog")
-- MAGIC dbutils.notebook.run("./Incremental Data Load", 0, {
-- MAGIC   "Volume Root Path": f"/Volumes/{catalog}/bronze/raw_data",
-- MAGIC   "files": "1"
-- MAGIC })

-- COMMAND ----------

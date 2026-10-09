-- Databricks notebook source
-- MAGIC %md
-- MAGIC Create the catalog, schema, and volume. This is the source location that all students will run from.
-- MAGIC
-- MAGIC The CMS data is uploaded directly into this volume (`/Volumes/cms_source/raw/raw_data`) ahead of the workshop, so there is no data-copy step here — the `all_data/` master stash and the reference folders (`date`, `icd_codes`, `lookups`, `npi_codes`) are expected to already be present under the volume root.

-- COMMAND ----------

CREATE CATALOG IF NOT EXISTS cms_source;
CREATE SCHEMA IF NOT EXISTS cms_source.raw;
CREATE VOLUME IF NOT EXISTS cms_source.raw.raw_data;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Load the first batch of data. There are 20 batches that can be moved over during the workshop if you want to show incremental loads or continuous loads.

-- COMMAND ----------

-- MAGIC %python
-- MAGIC dbutils.notebook.run("./Incremental Data Load", 0, {
-- MAGIC   "Volume Root Path": "/Volumes/cms_source/raw/raw_data",
-- MAGIC   "files": "1"
-- MAGIC })

-- COMMAND ----------

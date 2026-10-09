-- Databricks notebook source
-- MAGIC %md
-- MAGIC Create the catalog, schema, and volume — the source location all students run from.
-- MAGIC Set the **catalog** widget (first cell) to the catalog you want to create/use, then run the rest.

-- COMMAND ----------

-- DBTITLE 1,Set your catalog, then run the rest
CREATE WIDGET TEXT catalog DEFAULT 'cms_workshop';

-- COMMAND ----------

CREATE CATALOG IF NOT EXISTS IDENTIFIER(:catalog);
CREATE SCHEMA  IF NOT EXISTS IDENTIFIER(:catalog || '.raw');
CREATE VOLUME  IF NOT EXISTS IDENTIFIER(:catalog || '.raw.raw_data');

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Move the data from the delta share to the native volume. This helps performance during the workshop.

-- COMMAND ----------

-- MAGIC %python
-- MAGIC catalog = dbutils.widgets.get("catalog")
-- MAGIC dbutils.notebook.run("./Move Data From Volume", 0, {
-- MAGIC   "source_location": "/Volumes/cms_workshop_data/bronze/raw_data",
-- MAGIC   "destination_location": f"/Volumes/{catalog}/raw/raw_data"
-- MAGIC })

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Load the first batch of data. There are 20 batches that can be moved over the workshop to show incremental or continuous loads.

-- COMMAND ----------

-- MAGIC %python
-- MAGIC catalog = dbutils.widgets.get("catalog")
-- MAGIC dbutils.notebook.run("./Incremental Data Load", 0, {
-- MAGIC   "Volume Root Path": f"/Volumes/{catalog}/raw/raw_data",
-- MAGIC   "files": "1"
-- MAGIC })

-- COMMAND ----------

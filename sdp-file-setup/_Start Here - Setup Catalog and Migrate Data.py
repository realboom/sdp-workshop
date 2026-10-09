-- Databricks notebook source
-- MAGIC %md
-- MAGIC Create the catalog schama and volume. This will be the source location that all students will be running from

-- COMMAND ----------

CREATE CATALOG IF NOT EXISTS cms_source;
CREATE SCHEMA IF NOT EXISTS cms_source.raw;
CREATE VOLUME IF NOT EXISTS cms_source.raw.raw_data;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Move the data from the delta share to the native volume. This will help with performance during the workshop

-- COMMAND ----------

-- MAGIC %python
-- MAGIC dbutils.notebook.run("./Move Data From Volume", 0, {
-- MAGIC   "source_location": "/Volumes/cms_workshop_data/bronze/raw_data",
-- MAGIC   "destination_location": "/Volumes/cms_source/raw/raw_data"
-- MAGIC })

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Load the first batch of data. There are 20 batches and move can be moved over the workshop if you want to show incremental loads or continuous loads.

-- COMMAND ----------

-- MAGIC %python
-- MAGIC dbutils.notebook.run("./Incremental Data Load", 0, {
-- MAGIC   "Volume Root Path": "/Volumes/cms_source/raw/raw_data",
-- MAGIC   "files": "1"
-- MAGIC })

-- COMMAND ----------


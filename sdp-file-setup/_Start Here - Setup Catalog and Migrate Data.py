-- Databricks notebook source
-- MAGIC %md
-- MAGIC ### Workshop setup — parameters
-- MAGIC Set the target **catalog** and **schema** for the workshop. The schema defaults to `bronze` (medallion architecture): the raw CMS source files live in a volume `raw_data` under this schema, and the Spark Declarative Pipeline writes its bronze tables into the same schema.

-- COMMAND ----------

CREATE WIDGET TEXT catalog DEFAULT 'cms_source';
CREATE WIDGET TEXT schema DEFAULT 'bronze';

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Create the catalog, schema, and volume. This is the source location that all students will run from.
-- MAGIC
-- MAGIC The CMS data is uploaded directly into this volume (`/Volumes/<catalog>/<schema>/raw_data`) ahead of the workshop, so there is no data-copy step here — the `all_data/` master stash and the reference folders (`date`, `icd_codes`, `lookups`, `npi_codes`) are expected to already be present under the volume root.

-- COMMAND ----------

CREATE CATALOG IF NOT EXISTS IDENTIFIER(:catalog);
CREATE SCHEMA IF NOT EXISTS IDENTIFIER(:catalog || '.' || :schema);
CREATE VOLUME IF NOT EXISTS IDENTIFIER(:catalog || '.' || :schema || '.raw_data');

-- COMMAND ----------

-- MAGIC %md
-- MAGIC Load the first batch of data. There are 20 batches that can be moved over during the workshop if you want to show incremental loads or continuous loads.

-- COMMAND ----------

-- MAGIC %python
-- MAGIC catalog = dbutils.widgets.get("catalog")
-- MAGIC schema = dbutils.widgets.get("schema")
-- MAGIC dbutils.notebook.run("./Incremental Data Load", 0, {
-- MAGIC   "volume_root": f"/Volumes/{catalog}/{schema}/raw_data",
-- MAGIC   "files": "1"
-- MAGIC })

-- COMMAND ----------

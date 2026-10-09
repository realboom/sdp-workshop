/*****************************************************************************************
We want dim_beneficiary to be loaded as a SCD Type 2 dimension, but we need to first modify this data by adding a surrogate key for beneficiary (defined as an uuid or guid) that will be defined as a subquery

We will then take the result to load an SCD Type 2 dimension.
******************************************************************************************/

CREATE STREAMING TABLE gold.dim_beneficiary;

CREATE FLOW gold_dim_beneficiary AS AUTO CDC 
  INTO gold.dim_beneficiary
FROM
  (select 
      uuid() as beneficiary_key
      ,* 
    from stream(silver.beneficiary_insert)
  )
KEYS
  (beneficiary_code)
SEQUENCE BY
  (year)
COLUMNS * EXCEPT
  (beneficiary_insert_key,year, insert_timestamp)
STORED AS
  SCD TYPE 2
TRACK HISTORY ON * EXCEPT 
  (year);
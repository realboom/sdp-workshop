CREATE MATERIALIZED VIEW  gold.dim_date
AS
SELECT
  date
  ,date_num
  ,year
  ,year_month
  ,calendar_quarter
  ,month_num
  ,month_name
  ,month_short_name
  ,week_num
  ,day_num_of_year
  ,day_num_of_month
  ,day_num_of_week
  ,day_name
  ,day_short_name
  ,quarter
  ,year_quarter_num
  ,day_num_of_quarter
FROM read_files('${volume_path}/date/DimDate.csv',
  format => 'csv',
  header => true)
where year in (2008,2009,2010)
CREATE MATERIALIZED VIEW  gold.dim_provider
AS
SELECT 
    npi_codes_key as provider_key
   ,npi_code
   ,entity_type
   ,provider_organization_name
   ,provider_other_organization_name
   ,provider_first_line_business_mailing_address
   ,provider_second_line_business_mailing_address
   ,provider_business_mailing_address_city_name
   ,provider_business_mailing_address_state_name
   ,provider_business_mailing_address_postal_code
   ,provider_business_mailing_address_code_if_outside_us
   ,provider_first_line_business_practice_location
   ,provider_second_line_business_practice_location
   ,provider_business_practice_location_address_city_name
   ,provider_business_practice_location_address_state_name
   ,provider_business_practice_location_address_postal_code
   ,provider_business_practice_location_address_country_code_if_outside_us
FROM silver.npi_codes
--create insert-only table with all the business logic
CREATE STREAMING TABLE silver.npi_codes_insert
AS
SELECT
    uuid() as npi_codes_insert_key
   ,md5(n.npi) as npi_codes_key
  ,cast(n.npi as string) as npi_code
  ,l_entity_type_code.label as entity_type
  ,Replacement_NPI as replacement_npi
  ,Employer_Identification_Number_EIN as employer_identification_number
  ,Provider_Organization_Name_Legal_Business_Name as provider_organization_name
  ,Provider_Last_Name_Legal_Name as provider_last_same
  ,Provider_First_Name as provider_first_name
  ,Provider_Middle_Name as provider_middle_name
  ,Provider_Name_Prefix_Text as provider_name_prefix
  ,Provider_Name_Suffix_Text as provider_name_sufix
  ,Provider_Credential_Text as provider_credential
  ,Provider_Other_Organization_Name as provider_other_organization_name
  ,Provider_Other_Organization_Name_Type_Code as provider_other_organization_name_type_code
  ,Provider_Other_Last_Name as provider_other_last_name
  ,Provider_Other_First_Name as provider_other_first_name
  ,Provider_Other_Middle_Name as provider_other_middle_name
  ,Provider_Other_Name_Prefix_Text as provider_other_name_prefix
  ,Provider_Other_Name_Suffix_Text as provider_other_name_suffix
  ,Provider_Other_Credential_Text as provider_other_credential
  ,Provider_Other_Last_Name_Type_Code as provider_other_last_name_code
  ,Provider_First_Line_Business_Mailing_Address as provider_first_line_business_mailing_address
  ,Provider_Second_Line_Business_Mailing_Address as provider_second_line_business_mailing_address
  ,Provider_Business_Mailing_Address_City_Name as provider_business_mailing_address_city_name
  ,Provider_Business_Mailing_Address_State_Name as provider_business_mailing_address_state_name
  ,Provider_Business_Mailing_Address_Postal_Code as provider_business_mailing_address_postal_code
  ,`Provider_Business_Mailing_Address_Country_Code_If_outside_U.S.` as provider_business_mailing_address_code_if_outside_us
  ,Provider_Business_Mailing_Address_Telephone_Number as provider_business_mailing_address_telephone_number
  ,Provider_Business_Mailing_Address_Fax_Number as provider_business_mailing_address_fax_number
  ,Provider_First_Line_Business_Practice_Location_Address as provider_first_line_business_practice_location
  ,Provider_Second_Line_Business_Practice_Location_Address as provider_second_line_business_practice_location
  ,Provider_Business_Practice_Location_Address_City_Name as provider_business_practice_location_address_city_name
  ,Provider_Business_Practice_Location_Address_State_Name as provider_business_practice_location_address_state_name
  ,Provider_Business_Practice_Location_Address_Postal_Code as provider_business_practice_location_address_postal_code
  ,`Provider_Business_Practice_Location_Address_Country_Code_If_outside_U.S.` as provider_business_practice_location_address_country_code_if_outside_us
  ,Provider_Business_Practice_Location_Address_Telephone_Number as provider_busines_practice_location_address_telephone_number
  ,Provider_Business_Practice_Location_Address_Fax_Number as provider_business_practice_location_address_fax_number
  ,to_date(Provider_Enumeration_Date,'MM/dd/yyyy') as privider_enumeration_date
  ,to_date(Last_Update_Date,'MM/dd/yyyy') as last_update_date
  ,NPI_Deactivation_Reason_Code as npi_deactivation_reason_code
  ,to_date(NPI_Deactivation_Date,'MM/dd/yyyy') as npi_deactivation_date
  ,to_date(NPI_Reactivation_Date,'MM/dd/yyyy') as npi_reactivation_date
  ,l_gender_code.label as provider_gender
  ,Authorized_Official_Last_Name as authorized_official_last_name
  ,Authorized_Official_First_Name as authorized_official_first_name
  ,Authorized_Official_Middle_Name as outhorized_official_middle_name
  ,Authorized_Official_Title_or_Position as authorized_official_title_or_position
  ,Authorized_Official_Telephone_Number as authorized_offiial_telephone_number
  ,Healthcare_Provider_Taxonomy_Code_1 as healthcare_provider_taxonomy_code_1
  ,Provider_License_Number_1 as provider_licence_number_1
  ,Provider_License_Number_State_Code_1 as provider_licene_number_state_code_1
  ,Healthcare_Provider_Primary_Taxonomy_Switch_1 as healthcare_provider_primary_taxonomy_switch_1
  ,Healthcare_Provider_Taxonomy_Code_2 as healthcare_provider_taxonomy_code_2
  ,Provider_License_Number_2 as provider_license_number_2
  ,Provider_License_Number_State_Code_2 as provider_license_number_state_code_2
  ,Healthcare_Provider_Primary_Taxonomy_Switch_2 as healthcare_provider_primary_taxonomy_switch_2
  ,Healthcare_Provider_Taxonomy_Code_3 as healthcare_provider_taxonomy_code_3
  ,Provider_License_Number_3 as provider_license_number_3
  ,Provider_License_Number_State_Code_3 as provider_license_number_state_code_3
  ,Healthcare_Provider_Primary_Taxonomy_Switch_3 as healthcare_provider_primary_taxonomy_switch_3
  ,to_date(Certification_Date,'MM/dd/yyyy') as certification_date
  ,current_timestamp as insert_timestamp
FROM stream(bronze.npi_codes) n
left join bronze.lookups l_entity_type_code on n.entity_type_code = l_entity_type_code.code and l_entity_type_code.variable = 'entity_type_code'
left join bronze.lookups l_gender_code on n.Provider_Gender_Code = l_gender_code.code and l_gender_code.variable = 'gender_code';



--create the merged silver table
CREATE STREAMING TABLE silver.npi_codes;

CREATE FLOW silver_npi_codes AS AUTO CDC 
  INTO silver.npi_codes
FROM
  stream(silver.npi_codes_insert)
KEYS
  (npi_codes_key)
SEQUENCE BY
  (insert_timestamp)
COLUMNS * EXCEPT
  (npi_codes_insert_key)
STORED AS
  SCD TYPE 1;
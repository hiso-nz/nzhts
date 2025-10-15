#Example: expand SNOMED CT NZ Radiology procedures reference set 

vs_url <- "http://snomed.info/sct/21000210109?fhir_vs=refset/121531000210107"

values_table= expand_valueset(
  valueset_url = vs_url,
  client_id = "your_client_id",
  client_secret = "your_client_secret")

dplyr::glimpse(codes)
head(codes)
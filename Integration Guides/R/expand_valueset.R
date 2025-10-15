library(httr)
library(jsonlite)
library(tidyverse)
library(glue)

# Expand a ValueSet from NZHTS, returning a tibble of expansion entries
expand_valueset <- function(
  valueset_url,
  client_id = Sys.getenv("NZHTS_ID"),
  client_secret = Sys.getenv("NZHTS_KEY")
) {
  access_token_url <- "https://authenticate.nzhts.digital.health.nz/auth/realms/nzhts/protocol/openid-connect/token"

  token_response <- POST(
    access_token_url,
    body = list(
      client_id = client_id,
      client_secret = client_secret,
      grant_type = "client_credentials"
    ),
    encode = "form"
  )
  stop_for_status(token_response, "Error on retrieving access token")
  access_token <- content(token_response)$access_token

  get_all_expansion_pages_offset <- function(base_url, token, page_size = 50000) {
    offset <- 0
    result_list <- list()

    repeat {
      paged_url <- glue("{base_url}&offset={offset}")
      message("Fetching offset = ", offset)

      response <- GET(
        url = paged_url,
        add_headers(Authorization = paste("Bearer", token)),
        accept("application/fhir+json")
      )

      stop_for_status(response, "Error on fetching expansion page")
      json_text <- content(response, "text", encoding = "UTF-8")
      json_data <- fromJSON(json_text, simplifyVector = TRUE)
      entries <- json_data$expansion$contains
      if (is.null(entries) || length(entries) == 0) break
      result_list <- append(result_list, list(entries))
      if (nrow(entries) < page_size) {
        message("Final page reached.")
        break
      }
      offset <- as.integer(offset + page_size)
    }
    bind_rows(result_list)
  }

  initial_expand_url <- glue("https://nzhts.digital.health.nz/fhir/ValueSet/$expand?url={valueset_url}&property=*")
  all_codes <- get_all_expansion_pages_offset(initial_expand_url, access_token)

  return(all_codes)
}

# Example: expand SNOMED CT NZ Radiology procedures reference set 

vs_url <- "http://snomed.info/sct/21000210109?fhir_vs=refset/121531000210107"

values_table= expand_valueset(
  valueset_url = vs_url,
  client_id = "your_client_id",
  client_secret = "your_client_secret")

dplyr::glimpse(codes)
head(codes)
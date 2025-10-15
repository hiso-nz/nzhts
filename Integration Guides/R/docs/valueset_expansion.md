# NZHTS ValueSet Expansion Guide

This document describes how to use the **`expand_valueset()`** R helper function to retrieve and combine full ValueSet expansions from the **New Zealand Health Terminology Service (NZHTS)** FHIR API.

---

##  Overview

The `expand_valueset()` function automates the process of:
1. Authenticating against the NZHTS Terminology Server using OAuth2.
2. Expanding a FHIR ValueSet via the `$expand` operation.
3. Handling pagination through the `offset` parameter.
4. Returning the complete set of expansion entries as a tidy data frame (`tibble`).

This enables analysts and developers to easily extract SNOMED CT, LOINC, or other terminology subsets into structured data for analytics, mapping, or validation.

---

## Authentication

The NZHTS API requires client credentials.  
You must obtain a **Client ID** and **Client Secret**.

These values should be stored as environment variables:

```bash
# .Renviron or CI/CD environment
NZHTS_ID=your-client-id
NZHTS_KEY=your-client-secret

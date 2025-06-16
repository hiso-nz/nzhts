# Overview

The following guide describes how to validate terminology in the NZ Edition of SNOMED when building FHIR Implementation Guides (IGs) using the [HL7 java FHIR IG Publisher](https://github.com/HL7/fhir-ig-publisher).

NZHTS has been registered as the authoritative server the IG publisher will use for validating the NZ edition of SNOMED (see [FHIR tx registry docs](https://github.com/FHIR/ig-registry/blob/master/tx-registry-doco.md)). 

This means that once configured, you should be able to include codes from the NZ Edition of SNOMED CT in resources within a FHIR IG, then during the build/validation process, the IG Publisher will route validation requests to NZHTS instead of trying to validate against the international edition (and failing / returning a not found error).

# Prerequisites

- IG Publisher installed and sucessfully building an IG and validating against tx.fhir.org (i.e. with internet access)
- NZHTS access credentials 

# Setup guide

In short, you need to:
1. create (or add to, if already exists) a `fhir-settings.json` file with the NZHTS details/access token
2. add an `exp-params.json` parameter resource to your IG source
3. Run the IG publisher  

#### 1. Add NZHTS to your `fhir-settings.json`

As NZHTS uses authentication, you will need to setup your fhir-settings.json file with a token to allow NZHTS to be used for validation. The fhir-settings.json file is used to configure some aspects of the FHIR java tools such as the IG Publisher and CLI validator. 

Some of these settings are normally set by environment variables used by tool installers as well as manually set environment variables (e.g. system path). but the fhir-settings.json file can provide a definitive setting. By default FHIR Java Tools use several public servers to perform specific tasks like providing terminology services, FHIR package downloads, etc. Users wishing to use other servers, including privately accessible servers, can add entries to the servers list here. 

We will use this file to specify the authentication details for NZHTS. 

By default the location of this file is located at:
* __Windows__: `C:\Users\<username>\.fhir\fhir-settings.json`
* __Unix/Linux/Mac__: `/~/.fhir/fhir-settings.json` 

Full fhir-settings.json documentation here: https://confluence.hl7.org/spaces/FHIR/pages/161072808/Using+fhir-settings.json

You'll neeed to add the following lines, and populate the "token" with a valid bearer token. 

````json
{
  "servers": [
    {
        "url" : "https://nzhts.digital.health.nz/fhir",
        "type" : "fhir",
        "authenticationType" : "token",
        "token" : "generatedtokenforauthentication"
    }
  ]
}
````
Note that the token is the bearer token itself and this means it will expire. NZHTS uses client credentials so you'll want a mechanism to get a token from the endpoint and update the token in the fhir-settings.json file usage beyond testing. 

#### 2. Add an `exp-params.json` to your IG

To ensure codes with a system of `http://snomed.info/sct` are validated against the NZ edition in your IG, you need to add a parameters resource in your IG's folder structure with the following location/name of:  `input/_resources/exp-params.json`

````json
{
  "resourceType": "Parameters",
  "id": "exp-params",
  "parameter": [
    {
      "name": "system-version",
      "valueUri": "http://snomed.info/sct|http://snomed.info/sct/21000210109"
    }
  ]
}
````
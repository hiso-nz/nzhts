# API Guide: Read v2 to SNOMED Concept Mapping using NZHTS


## Overview

The NZ Health Terminology Service (NZHTS) offers an API for mapping Read v2 codes to equivalent SNOMED CT concepts. This guide provides an overview of how to use the NZHTS API for translating Read v2 codes to SNOMED CT using the ConceptMap resource.

### Prerequisites

- You will need access to the NZHTS API endpoint. 
- An API key or appropriate credentials to access licensed content may be required. Please contact us at standards@tewhatuora.govt.nz for an API key

## Endpoint

The base URL for the API call to access the ConceptMap resource is:
https://nzhts.digital.health.nz/fhir/ConceptMap/$translate

The full api call is :
https://nzhts.digital.health.nz/fhir/ConceptMap/$translate?url=https://nzhts.digital.health.nz/fhir/ConceptMap/read-snomed-map&system=http://read.info/readv2&code={your-read-code}

## Key Parameters

- `url`: Specifies the ConceptMap to be used for translation. For Read v2 to SNOMED mappings, use the specific ConceptMap URL provided by NZHTS.  
  Example: `url=https://nzhts.digital.health.nz/fhir/ConceptMap/read-snomed-map`
- `system`: Specifies the coding system of the input code (e.g., Read v2).  
  Example: `system=http://read.info/readv2`
- `code`: The Read v2 code you wish to map.  
  Example: `code=<your-read-code>`


## Example Request

### Mapping a Read v2 Code to a SNOMED Concept (G30..00)

#### Request

```code
https://nzhts.digital.health.nz/fhir/ConceptMap/$translate?url=https://nzhts.digital.health.nz/fhir/ConceptMap/read-snomed-map&system=http://read.info/readv2&code=G30..00
```
<div style="page-break-after: always;"></div>

#### Explanation:
`URL`: This is the ConceptMap for Read v2 to SNOMED CT translation.  
`System`: Specifies the code system for Read v2.  
`Code`: G30..00 (Example Read v2 code representing acute myocardial infarction).  
#### Response
````json
{
    "resourceType": "Parameters",
    "parameter": [
        {
            "name": "result",
            "valueBoolean": true
        },
        {
            "name": "match",
            "part": [
                {
                    "name": "equivalence",
                    "valueCode": "equal"
                },
                {
                    "name": "concept",
                    "valueCoding": {
                        "system": "http://snomed.info/sct",
                        "code": "57054005",
                        "display": "Acute myocardial infarction"
                    }
                },
                {
                    "name": "source",
                    "valueString": "https://nzhts.digital.health.nz/fhir/ConceptMap/read-snomed-map"
                }
            ]
        }
    ]
}

````
#### Explanation:
`equivalence`: Indicates the mapping relationship between the Read v2 code and the SNOMED CT concept.  
`concept`: Contains the mapped SNOMED CT concept with its code and display value.


## Practical Examples
### Example 1: Mapping Read Code with a Valid Match (G33.00 - Angina pectoris)
#### Request:
```code
https://nzhts.digital.health.nz/fhir/ConceptMap/$translate?url=https://nzhts.digital.health.nz/fhir/ConceptMap/read-snomed-map&system=http://read.info/readv2&code=G33..00
```
#### Response:
```json
{
    "resourceType": "Parameters",
    "parameter": [
        {
            "name": "result",
            "valueBoolean": true
        },
        {
            "name": "match",
            "part": [
                {
                    "name": "equivalence",
                    "valueCode": "equal"
                },
                {
                    "name": "concept",
                    "valueCoding": {
                        "system": "http://snomed.info/sct",
                        "code": "194828000",
                        "display": "Angina pectoris"
                    }
                },
                {
                    "name": "source",
                    "valueString": "https://nzhts.digital.health.nz/fhir/ConceptMap/read-snomed-map"
                }
            ]
        }
    ]
}
```
<div style="page-break-after: always;"></div>


### Example 2: Mapping with No Exact Match

#### Request:
```code
https://nzhts.digital.health.nz/fhir/ConceptMap/$translate?url=https://nzhts.digital.health.nz/fhir/ConceptMap/read-snomed-map&system=http://read.info/readv2&code=XYZ..
```
#### Response:
```json
{
    "resourceType": "Parameters",
    "parameter": [
        {
            "name": "result",
            "valueBoolean": false
        },
        {
            "name": "message",
            "valueString": "No mappings could be found for XYZ.. (http://read.info/readv2)"
        }
    ]
}
```

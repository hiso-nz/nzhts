# API Guide: SNOMED ECL Hierarchical Queries with NZHTS
## API Examples

To execute the queries listed in this guide, you will need valid API credentials. If you don't have API
credentials yet, please contact us at standards@tewhatuora.govt.nz to request access.

### 1. Retrieve All Descendants of a Specific Concept
#### Example: All descendants of "Diabetes mellitus (disorder)"
`ECL Query`: <<73211009 |Diabetes mellitus (disorder)|  
`NZHTS API URL`:
```code
https://nzhts.digital.health.nz/fhir/ValueSet/$expand?url=http://snomed.info/sct?fhir_vs=ecl/<<73211009
```
`Explanation`:
The << operator retrieves the specified concept and all its descendants.

### 2. Retrieve All Descendants of Angina
#### Example: All descendants of Angina (194828000)
`ECL Query`: <<73211009 |Angina (disorder)|  
`NZHTS API URL`:
```code
https://nzhts.digital.health.nz/fhir/ValueSet/$expand?url=http://snomed.info/sct?fhir_vs=ecl<<194828000
```
`Explanation`:
The << operator retrieves the specified concept and all its descendants.
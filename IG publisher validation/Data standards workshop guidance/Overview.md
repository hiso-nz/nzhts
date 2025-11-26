# Data Standards Workshop: Using SNOMED national editions with the IG publisher 
aka **Don’t Let Your IG Burn Down: Validating the SNOMED NZ Edition with the IG Publisher and NZHTS**

This track will provide:
- a very brief overview of the FHIR terminology ecosystem (below on this page)
- an example IG using an exp-params.json to ensure a specific authoritative server is used 
- guidance on how to use NZHTS for validation of SNOMED NZ edition

## The FHIR Terminology Ecosystem Framework

The FHIR Terminology Ecosystem provides a standard way for the IG Publisher to discover which FHIR terminology server can validate, expand, or analyze codes from a given CodeSystem or ValueSet. Instead of relying on a single central server, the ecosystem allows many terminology servers, each responsible for different content, to register in a shared registry. A coordination server regularly scans these servers and catalogs which ones support which terminologies, and whether they are considered authoritative sources.

When the IG Publisher needs to validate codes, it queries the coordination server, which responds with the best server(s) to use for the specific terminology and version required. If a server is marked as authoritative for a CodeSystem it is the server used to validate codes from that system. This approach decentralizes terminology management so that tx.fhir.org does not need to know about all of the details of regionalised/localised terminology, to allow it to be validated via the IG publisher. 

### Coordination server background processes to scan registry

Note that currently the tx server registry is manually updated by contributors adding their servers and HL7 (Mostly Grahame managing/approving)

```mermaid
sequenceDiagram
    participant CS as Coordination Server
    participant MR as Master Registry 
    participant SR as Server Registries
    participant TS as Terminology Server (E.g. NZHTS, NCTS)

    CS->>MR: GET tx-servers.json
    MR-->>CS: List of registry sources

    loop each registry
        CS->>SR: GET {registry.url}
        SR-->>CS: List of terminology servers with authoritative and candidate endpoints
    end

    loop each discovered terminology endpoint
        CS->>TS: GET /metadata
        CS->>TS: GET /metadata?mode=terminology
        CS->>TS: GET /ValueSet?_summary=true
        TS-->>CS: CapabilityStatement, TerminologyCapabilities, ValueSet summary
    end
```

### IG Publisher resolution of which terminology server to use
When the IG publisher is run, it queries the Coordination server to find out how to handle a given CodeSystem. The main tx.fhir.org still handles many of the standard bindings, but things like SNOMED national editions have alternative authoratiative servers (such as NCTS for the Australian Edition, and NZHTS for the NZ edition).

```mermaid
sequenceDiagram
    participant IG as IG Publisher
    participant CS as Coordination Server
    participant TS as Terminology Server (e.g. NZHTS, NCTS)

    IG->>CS: GET /tx-reg/resolve?url={code system canonical}&fhirVersion=R4&usage=publication
    CS-->>IG: authoritative[] and candidate[] terminology servers

    IG->>TS: $validate-code request (code and system)
    TS-->>IG: response (code valid or invalid)
```

### Specifying a SNOMED edition for resolution of implicit SNOMED ValueSets in an IG


### Example IG

Link:
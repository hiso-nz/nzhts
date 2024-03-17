# Using Postman with OAuth 2.0 Client Credentials to make your first API request
This document will give you a step by step guidence on making your first API request using Postman with OAuth 2.0 Client Credentials

## Prerequisites
* Postman: Ensure you have Postman installed.

* Client Credentials: You need to have your client_id and client_secret ready.

## Step-by-Step Guide
**1.**  Create a New Request

* Open Postman and click the "New" button.

* Select "HTTP" to create a new request.
* In the new request tab, enter the API endpoint you wish to call in the URL field, e.g.  https://nzhts.digital.health.nz/fhir/ValueSet/$expand?url=http://snomed.info/sct?fhir_vs=ecl/<73211009
and select "Get" as your API operation method.

**2.** Set Up OAuth 2.0
*	In your newly created request, go to the "Authorization" tab.
*	From the "Type" dropdown menu, select "OAuth 2.0".

**3.** Configure Client Credentials

A dialog will appear for you to input your OAuth 2.0 credentials.
*	Token Name: Enter a name for your token.
*	Grant Type: Select "Client Credentials" from the dropdown.
*	Access Token URL: Input the URL https://authenticate.nzhts.digital.health.nz/auth/realms/nzhts/protocol/openid-connect/token
*	Client ID: Enter your client_id.
*	Client Secret: Enter your client_secret.
*	Client Authentication: Select "Send as Basic Auth header"

**4.** Get New Access Token

*	Click the "Get New Access Token" button. Postman will use your client credentials to request an access token.
*	Once the token is received, you'll see it listed under "All Tokens". Click "Use Token" to apply it to your request.
**5.** Make Your API Request
*	With the access token now set, you can proceed to make your API request.
*	Click "Send" to submit the request. You should now be able to access the API using the client credentials OAuth 2.0.
*	After you've sent your API request, the response from the API will appear in the lower section of the Postman interface.

## Additional Tips

### Token Expiration
OAuth 2.0 access tokens typically have a limited lifespan. You will need to repeat the token request process(step 4) when the token expires.

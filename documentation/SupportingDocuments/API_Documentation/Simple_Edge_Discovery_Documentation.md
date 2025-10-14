# Overview
The Simple Edge Discovery API returns the name, provider and UUID of the Edge Cloud Zone closest to a given device. The API call can be made either directly from the device, or from an Internet server. In either case, the device must be currently attached (connected) to the operator network.

# Introduction	
This API provides a simple way to know which Edge Cloud Zone is closest to the customer's device. Typically this Edge Cloud Zone will support the best network performance between client and server, since propgation delay is minimised. Knowing which is the closest Edge Cloud Zone allows:
1. an application client to proceed to connect to any application server hosted on that , for which the IP address was provided when the instance was spun up using the cloud provider tools, 
2. an application developer to spin up an instance of their application server on that Edge Cloud Zone, using their cloud provider tools.

Note that the Simple Edge Discovery API offers an advantage over geolocation. Instead it calculates the shortest network path between the device and the Edge Cloud Zone, which is more accurate and takes into account internal operator network topology (which can vary greatly between networks).

# Quick Start	
1. Make a GET request to `/edge-cloud-zones?filter=closest`
2. Query the JSON response with:
* `$.[0].edgeCloudZoneId` to return the UUID for the closest Edge Cloud Zone
* `$.[0].edgeCloudZoneName` to return the cloud provider's name for the closest Edge Cloud Zone
* `$.[0].edgeCloudProvider` to return the name of the cloud provider for the closest Edge Cloud Zone

# Authentication and/or Authorization		
CAMARA guidelines defines a set of authorization flows which can grant API clients access to the API functionality, as outlined in the document [CAMARA-API-access-and-user-consent.md](https://github.com/camaraproject/IdentityAndConsentManagement/blob/main/documentation/CAMARA-API-access-and-user-consent.md). Which specific authorization flows are to be used will be determined during onboarding process, happening between the API Client and the Telco Operator exposing the API, taking into account the declared purpose for accessing the API, while also being subject to the prevailing legal framework dictated by local legislation.

It is important to remark that in cases where personal user data is processed by the API, and users can exercise their rights through mechanisms such as opt-in and/or opt-out, the use of 3-legged access tokens becomes mandatory. This measure ensures that the API remains in strict compliance with user privacy preferences and regulatory obligations, upholding the principles of transparency and user-centric data control.


# Endpoint definitions	
- Endpoint: `/edge-cloud-zones`
- Method accepted: GET
- Parameters: ?filter=closest*
- HTTP codes: `200 OK`
- HTTP Response body: application/json

## Constraints
The device identified in the API request must be attached to the operator netwotk, otherwise the shortest network path from that device to each edge cloud zone cannot be calculated.

# Errors	
If the mobile subscription parameters contain a formatting error, a `400 INVALID_ARGUMENT` error is returned.

If the authentication token is not valid, a `401 UNAUTHENTICATED` error is returned.

If the API call requires consent and permission hasnot been obtained , a `403 PERMISSION_DENIED` error is returned.

If the mobile subscription cannot be identified from the provided parameters, a `404 NOT_FOUND` error is returned.

Any more general service failures will result in an error in the `5xx` range with an explanation.

Please see the YAML documentation (link below) for a full list of errors

# Code snippets	

`HTTP GET /edge-cloud-zones?filter=closest`

`HTTP 200 OK application/json`

```javascript
[
  {
    "edgeCloudZoneId": "4gt555-6457-7890-d4he-1dc79f44gb66",
    "edgeCloudZoneName": "example zone name",
    "edgeCloudProvider": "example zone provider"
  }
]

```

Response processing:
`$.[0].edgeCloudZoneId` -> "4gt555-6457-7890-d4he-1dc79f44gb66"
`$.[0].edgeCloudZoneName` -> example name"
`$.[0].edgeCloudProvider` -> "example zone provider"

# FAQs	
_Can I use the device GPS to locate the closest MEC?_
_Can I ping the various Edge Cloud Zones and calculate the closest from that?_
The answer to both of these is 'not reliably':
- Each device has an IP 'anchor point' in the operator mobile network which may be a significant distance from the location of the device itself. It is this path - IP anchor to Edge Cloud Zone - that decides the shortest network path and hence shortest propagation delay.
- ping (both ICMP and TCP) fistly requires having deployed endpoints to ping - which may not be the case if the application server has not been deployed on more than on Edge Cloud Zone. Secondly, mobile networks are volatile, and ping results will not give an accurate picture of the static network topology. 

# Release Notes	
v1.0.0 to align with 1.0.0 YAML spec, May 1st 2024

# API Spec
YAML available at: https://github.com/camaraproject/EdgeCloud/blob/main/code/API_definitions/simple_edge_discovery.yaml

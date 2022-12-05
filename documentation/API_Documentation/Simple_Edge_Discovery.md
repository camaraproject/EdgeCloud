# Overview
The Simple Edge Discovery API returns the name of the MEC platform ('operator edge site') closest to device from where the query was made. It requires the device to be connected to edge operator's network.

# Introduction	
This API provides a simple way to know which MEC platform is closest to the customer's device. Typically this MEC platform will support the best network performance between client and server, since propgation delay is minimised. Knowing which is the closest MEC platform allows:
1. an application client to proceed to connect to any application server hosted on that MEC platform, for which the IP address was provided when the instance was spun up using the cloud provider tools, 
2. an application developer to spin up an instance of their application server on that MEC platform, using their cloud provider tools.

Note that the Simple Edge Discovery API offers an advantage over geolocation. Instead it calculates the shortest network path between the device and the MEC platform, which is more accurate and takes into account internal operator network topology (which can vary greatly between networks).

# Quick Start	
1. Make a GET request to the API's /mecplatforms/ resource.
2. Query the JSON response with `$.MECPlatforms[0].ern` to return the cloud provider's name for the closest MEC platform
3. You can also check the status of the MEC platform using `$.MECPlatforms[0].status`

_note, MECPlatforms is an array because the Simple Edge Discovery API is a subset of a more complex CAMARA API, 'MEC Exposure and Experiencve Management'. That API can return an array of MEC Platforms ranked according to proximity, compute resources, and load status. But the Simple Edge API will just return the closest.

# Authentication and/or Authorization		
Please follow the registration process of the operator implementing the API to acquire an authentication key, and bearer token.
'Closest MEC platform' is network information and not considered personally identifiable information (PII) - it is not expected that this API will require user consent.


# Endpoint definitions	
- Endpoint: `/mecplatforms/`
- Method accepted: GET
- Parameters: none*
- HTTP codes: `200 OK`
- HTTP Response body: application/json

## Constraints
The endpoint must be called by an HTTP client hosted by a device that is attached to the operator's network. If the operator only provides a cellular (mobile) edge platform, then the device must be attached to the operator's mobile network with a valid SIM.

# Errors	
`HTTP 401 Unauthorized` - ensure you have a valid API key and/or bearer token (see operator documentation)
`HTTP 404 Not Found` - check the URI for any syntax error

# Code snippets	

`HTTP GET /MECPlatforms`

`HTTP 200 OK application/json`

```javascript
{
  "MECPlatforms": [
    {
      "ern": "example London MEC name from cloud provider",
      "zone": "geographic location of MEC Platform, e.g. London",
      "region": "geographic region of MEC Platform, UK South",
      "status": "active | inactive | unknown",
      "properties": [
        {
          "type": "string"
        }
      ]
    }
  ],
  "links": [
    {
      "link": {
        "rel": "ListMECPlatforms",
        "method": "get",
        "href": "/mecplatforms"
      }
    }
  ]
}

```

Response processing:
`$.MECPlatforms[0].ern` -> "example London MEC name from cloud provider"
`$.MECPlatforms[0].status` -> one of `active`, `inactive`, `unknown`

# FAQs	
_Can I use the device GPS to locate the closest MEC?_
_Can I ping the various MEC platforms and calculate the closest from that?_
The answer to both of these is 'not reliably':
- Each device has an IP 'anchor point' in the operator mobile network which may be a significant distance from the location of the device itself. It is this path - IP anchor to MEC PLatform - that decides the shortest network path and hence shortest propagation delay.
- ping (both ICMP and TCP) fistly requires having deployed endpoints to ping - which may not be the case if the application server has not been deployed on more than on MEC platform. Secondly, mobile networks are volatile, and ping results will not give an accurate picture of the static network topology. 

# Release Notes	
v1.1.2 minor bug fixes with error types

# API Spec
YAML available at: https://github.com/camaraproject/EdgeCloud/blob/main/code/API_definitions/simple_edge_discovery.yaml

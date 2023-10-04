# OPAG-CAMARA Traffic Influence API
## Overview

The reference scenario foresees a Service, composed by one or more Service Producers deployed in different geographical locations on Telco Operator Edge sites (Mobile Edge Computing - MEC sites) or in Cloud. The Service Producer, deployed at the Edge, is referred as Edge Application Server (EAS).
The Traffic Influence API provides the fastest routing from the user Device (e.g. a Smartphone) to the optimal Edge Application Server Instance in a specific geographical location, installed in a Telco Operator Edge site.
If a Service is offered by Cloud Instances and by Edge Instances, the API can be used to route the traffic on the Edge Instances, maybe for a set of users, to get a better latency.

## 1. Introduction

The Traffic Influence API provides the capability to establish the best connectivity, in terms of latency, in a specific geographical area, between the user Device, e.g. the user’s smartphone, and the optimal Edge Application Server instance nearby.
The generic architecture for the Serivice can foresee some Cloud instances of the Application, one or more Edge Instances of the Application. A  component of the Service is the TI API Consumer. This logical component can be integrated in other components of the Service to invoke the TI API, creating a "TrafficInfluence" resource specifying the desired intent.
The TI API Producer implements the intent specified in the "TrafficInfluence" resource.
While the API can be invoked to activate the fastest routing for any user,  it can also be used to request the best routing for a specific user. Invoking the API for each user, many "TrafficInfluence" resources are created for each user to provide the requested routing for a set of users.
The same approach is used for the geographical locations where the influece of the traffic must be applied. Invoking the API without specifying a geographical area activates the optimal routing toward any EAS instance, while invoking the API specifying a geographical area activates the optimal routing only toward the EAS instance located closest to that geographical area. To activate the routing in selected geographical areas, the TI API must be invoked for each geographical area.

## 2. Quick Start
The usage of the Traffic Influence API is based on the management of a "TrafficInfluence" resource, an object containing the intent requested invoking the Traffic Influence API and that is implemented by the platform configuring the Mobile Network for the optimal routing toward the EAS Instance.
The "TrafficInfluence" resource can be created (providing the related parameters that specify the desired intent), queried, modified and deleted.
The API is asynchronous, a notification is available providing information about the status of the requested resource.  
For an Application (identified by "applicationId") many "TrafficInfluence" resources can be created, e.g. to add multiple users, regions or zones.

Before starting to use the API, the developer needs to know about the below specified details:

**Base-Url**
The RESTful Traffic Influence API endpoint, for example [**https://tim-api.developer.tim.it/trafficinfluence**](https://tim-api.developer.tim.it/trafficinfluence)

**Authentication**
Configure security access keys such as OAuth 2.0 client credentials to be used by Client applications which will invoke the Traffic InfluenceAPI.

**TrafficInfluence**
This object represents the resource that carries the requirements from the user to be implemented. The Traffic Influence API is invoked for the life cycle management of this resource (CRUD). The resource contains the intents from the API Consumer. Managing this resource, the developer can specify in which geographical location the routing must be applied, toward which application,  maybe for a specific set of users or for a limited period pf time.

**trafficInfluenceID**
Identifier for the Traffic Influence resource. This parameter is returned by the API and must be used to update it (e.g., adding a Device or deleting it). A different Traffic Influece resource must be created for any Device or Zone or Region. All these resources are reletad to an Application identified by the applicationId.

**apiConsumerId**
Unique identifier for the TI API Consumer.

**region**
The developer can specify in which geographical area he requires the fastest routing toward the nearest application instance. A Region is a wide geographical area and it contains one ore more Zones. A Zone is where the Edge Datacenters are located. Zones and Regions identifiers are defined and provided by the Telco Operator and can also be used or retrieved with other CAMARA APIs ("MEC Exposure & Experience Management API" and "Simple Edge Discovery"). To add more regions the API must be invoked (POST) for each region. New "TrafficInfluence" resources are created (with different "trafficInfluenceID"). All the created resources are aggregated by the Application (identified by "applicationId").

**zone**
The developer can specify in which geographical area he requires the fastest routing toward the nearest application instance. A Zone is a smaller geographical area inside a Region. A Zone is where the Edge Datacenters are located. To add more zones the API must be invoked (POST) for each zone. New "TrafficInfluence" resources are created (with different "trafficInfluenceID"). All the created resources are aggregated by the Application (identified by "applicationId").

**applicationId**
Unique Application identifier inside the Telco Operator Platform. To influece the traffic toward a specific Application. It is the OP that detects the appropriate Application Instance in the selected Region or Zone.

**instanceId**
Unique identifier generated by the partner OP to identify a specific instance of the Application on a specific zone. To influence a traffic toward a specific Application Instance.

**trafficFilters**
The Application can expose different service on different interfaces, with this parameter it is possible to enable just some of those services maybe for different sets of users.

**Device**
A user Device can be provided as an input. To add more users the API must be invoked (POST) of each user Device. New "TrafficInfluence" resources are created (with different "trafficInfluenceID"). All the created resources are aggregated by the Application (identified by "applicationId"). The routing toward the selected Application Instance is only applied for provided user Devices.

**Notification URL and token**
Developers have a chance to specify callback URL on which notifications (eg. session termination) regarding the session can be received from the service provider. This is also an optional parameter.

## 3. Authentication and Authorization
The Traffic Influence API makes use of the client credentials grant which is applicable for server to server use cases involving trusted partners or clients without any protected user data involved.
In this method the API invoker client is registered as a confidential client with an authorization grant type of client\\_credentials [2].

## 4. API Documentation
## 4.1 Details

The Traffic Influence (TI) API is consumed by an Application Function (AF) requesting for the fastest routing of the traffic flow from the User Equipments toward an instance of the Edge Application Server (EAS) in a Telco Operator Edge sites (MEC sites).

When the EAS is onboarded and deployed in the MEC site, the Application is identified with a unique identifier (applicationId).

Using the application identifier ("applicationId") and specifying a Zone or a Region, the Telco Operator Platform, autonomously identifies the best instance of the EAS toward routing the traffic flow and configures the Mobile Network accordingly to get the fastest routing.
If just the application identifier is used, the Telco Operator Platform  identifies all the EAS Instances and activates the optimal routing on the Mobile Network.
If the fastest routing should be available just for a set of users, the API must be invoked for each user creating a new TrafficInfluce resource for each one.
If the Application offers different services on different interfaces a  traffic filter based on IP, Port and Protocol can be used. I this way it is also possible to redirect different users to different interfaces.

Here are some possible intents:

1) activate the optimal routing for any EAS Instance: the API must be invoked with the applicationId. The Telco Operator Platform identifies all the EAS Instances and activates the optimal routing on the Mobile Network.
2) activate the optimal routing in a specific Region or Zone: the API must be invoked with the applicationId and the Zones and Regions identifiers.
3) activate the optimal routing for a specific set of users: the API can also be invoked with a user identifier ("Device"). The same TrafficInfluce resource identifier ("trafficInfluenceID") must be used in each call.

## Version: 0.9.1

**License:** [Apache 2.0](https://www.apache.org/licenses/LICENSE-2.0.html)

[Product documentation at Camara](https://github.com/camaraproject/)
### /traffic-influences

#### GET
##### Summary

Retries existing TrafficInfluence Resources

##### Description

Reads all of the active TrafficInfluence resources owned by the same API Consumer authenticated via oAuth2

##### Parameters

| Name | Located in | Description | Required | Schema |
| ---- | ---------- | ----------- | -------- | ---- |
| applicationId | query | Not required. Used to select traffic influence resources filtered by applicationId | No | string |

##### Responses

| Code | Description |
| ---- | ----------- |
| 200 | Returns the information about existing TrafficInfluence resources. |
| 401 | Unauthorized |
| 403 | Forbidden |
| 500 | An unknow error has occurred |
| 503 | Service unavailable |
| 504 | Connection timeout towards backend service has occurred |

#### POST
##### Summary

Creates a new TrafficInfluence resource

##### Description

Gets in input an object containing the intents from the API Consumer and creates a TrafficInfluence resourse accordingly. The trafficInfluenceID parameter, that is part of the object, must not be valorized when creating a new resource. For this reason the trafficInfluenceID parameter must be avoided in the object, anyway it will be ignored by the API Producer. It is automatically generated by the system and returned in the response.

##### Responses

| Code | Description |
| ---- | ----------- |
| 201 | TrafficInfluence resource created, the related object is returned with the resource ID (trafficInfluenceID) and status (state) valorised, |
| 400 | Invalid input |
| 401 | Unauthorized |
| 403 | Forbidden |
| 500 | An unknow error has occurred |
| 503 | Service unavailable |
| 504 | Connection timeout towards backend service has occurred |

### /traffic-influences/{trafficInfluenceID}

#### GET
##### Summary

read a specific TrafficInfluence resource identified by the trafficInfluenceID value

##### Parameters

| Name | Located in | Description | Required | Schema |
| ---- | ---------- | ----------- | -------- | ---- |
| trafficInfluenceID | path | Identifier of the specific TrafficInfluence resource to be retrieved, modified or deleted. It is the value used to fill trafficInfluenceID parameter | Yes | string |

##### Responses

| Code | Description |
| ---- | ----------- |
| 200 | OK. |
| 401 | Unauthorized |
| 403 | Forbidden |
| 404 | The specified resource was not found |
| 500 | An unknow error has occurred |
| 503 | Service unavailable |
| 504 | Connection timeout towards backend service has occurred |

#### PATCH
##### Summary

updates a specific TrafficInfluence resource, identified by the trafficInfluenceID value

##### Description

The resource identified by the trafficInfluenceID value can be modified

##### Parameters

| Name | Located in | Description | Required | Schema |
| ---- | ---------- | ----------- | -------- | ---- |
| trafficInfluenceID | path | Identifier of the specific TrafficInfluence resource to be retrieved, modified or deleted. It is the value used to fill trafficInfluenceID parameter | Yes | string |

##### Responses

| Code | Description |
| ---- | ----------- |
| 200 | TrafficInfluence resource edited, the related object is returned,  the status (state) is updated. |
| 400 | Invalid input |
| 401 | Unauthorized |
| 403 | Forbidden |
| 404 | The specified resource was not found |
| 500 | An unknow error has occurred |
| 503 | Service unavailable |
| 504 | Connection timeout towards backend service has occurred |

#### DELETE
##### Summary

Delete an existing TrafficInfluence resource

##### Parameters

| Name | Located in | Description | Required | Schema |
| ---- | ---------- | ----------- | -------- | ---- |
| trafficInfluenceID | path | Identifier of the specific TrafficInfluence resource to be retrieved, modified or deleted. It is the value used to fill trafficInfluenceID parameter | Yes | string |
| callbackUrl | query | the location where updated data will be sent.  Must be network accessible by the source server  | No | string (uri) |

##### Responses

| Code | Description |
| ---- | ----------- |
| 202 | The resource delation request has been accepted |
| 401 | Unauthorized |
| 403 | Forbidden |
| 404 | The specified resource was not found |
| 503 | Service unavailable |
| 504 | Connection timeout towards backend service has occurred |

### Models

#### TrafficInfluence

| Name | Type | Description | Required |
| ---- | ---- | ----------- | -------- |
| trafficInfluenceID | string | Identifier for the Traffic Influence resource. This parameter is returned by the API and must be used to update it (e.g., adding new users or deleting it). | No |
| apiConsumerId | string | Unique Identifier of the TI API Consumer. | Yes |
| applicationId | string | Unique ID representing the Edge Application<br>_Example:_ `"Virtual_Reality_Arena"` | Yes |
| instanceId | string | Unique identifier generated by the partner OP to identify an instance of the application on a specific zone. | No |
| region | string | Unique identifier representing a region  | No |
| zone | string | Unique identifier representing a zone  | No |
| device | object | Device identifier | No |
| state | string | it reports the state of the TrafficInfluence resource. When first invoked, the resource is 'ordered'. When the platforms prepares the resource, it is 'created'. When the new routing is enabled in the network, the state is 'active'.  If an error occurs in the resource creation or in its activation, the state is 'error'. When the DELETE method is invoked the state is 'deletion in progress'. After the resource is deleted (as a consequence of the previous invokation of the DELETE method) the state is 'deleted'.<br>_Enum:_ `"ordered"`, `"created"`, `"active"`, `"error"`, `"deletion in progress"`, `"deleted"` | No |
| trafficFilters | [ string ] | Identifies IP packet filters. To be used when a the Application needs a traffic flow towards a specific EAS interface | No |
| notificationUri | string | Defines the callback uri which should be notified in asynchronous way when the state for the requested resources changes (i.e. ordered to activated) | No |
| notificationAuthToken | string | Authentification token for callback API | No |

#### PatchTrafficInfluence

| Name | Type | Description | Required |
| ---- | ---- | ----------- | -------- |
| trafficInfluenceID |  |  | No |
| apiConsumerId |  |  | No |
| applicationId |  |  | No |
| state |  |  | No |

#### PostTrafficInfluence

| Name | Type | Description | Required |
| ---- | ---- | ----------- | -------- |
| trafficInfluenceID |  |  | No |
| state |  |  | No |

#### TrafficInfluenceNotification

| Name | Type | Description | Required |
| ---- | ---- | ----------- | -------- |
| trafficInfluenceChanged | object |  | Yes |

#### TypesZoneId

Unique identifier representing a zone

| Name | Type | Description | Required |
| ---- | ---- | ----------- | -------- |
| TypesZoneId | string | Unique identifier representing a zone  |  |

#### TypesRegionId

Unique identifier representing a region

| Name | Type | Description | Required |
| ---- | ---- | ----------- | -------- |
| TypesRegionId | string | Unique identifier representing a region  |  |

#### Device

Device identifier

| Name | Type | Description | Required |
| ---- | ---- | ----------- | -------- |
| phoneNumber | string | Subscriber number in E.164 format (starting with country code). Optionally prefixed with '+'.<br>_Example:_ `"123456789"` | No |
| networkAccessIdentifier | string | _Example:_ `"123456789@domain.com"` | No |
| ipv4Address | string (ipv4) | IPv4 address may be specified in form <address/mask> as:   - address - an IPv4 number in dotted-quad form 1.2.3.4. Only this exact IP number will match the flow control rule.   - address/mask - an IP number as above with a mask width of the form 1.2.3.4/24.     In this case, all IP numbers from 1.2.3.0 to 1.2.3.255 will match. The bit width MUST be valid for the IP version. <br>_Example:_ `"192.168.0.1/24"` | No |
| ipv6Address |  | IPv6 address, following IETF 5952 format, may be specified in form <address/mask> as:   - address - The /128 subnet is optional for single addresses:     - 2001:db8:85a3:8d3:1319:8a2e:370:7344     - 2001:db8:85a3:8d3:1319:8a2e:370:7344/128   - address/mask - an IP v6 number with a mask:     - 2001:db8:85a3:8d3::0/64     - 2001:db8:85a3:8d3::/64 <br>_Example:_ `"2001:db8:85a3:8d3:1319:8a2e:370:7344"` | No |

#### NetworkAccessIdentifier

| Name | Type | Description | Required |
| ---- | ---- | ----------- | -------- |
| NetworkAccessIdentifier | string |  |  |

**Example**
<pre>123456789@domain.com</pre>

#### PhoneNumber

Subscriber number in E.164 format (starting with country code). Optionally prefixed with '+'.

| Name | Type | Description | Required |
| ---- | ---- | ----------- | -------- |
| PhoneNumber | string | Subscriber number in E.164 format (starting with country code). Optionally prefixed with '+'. |  |

**Example**
<pre>123456789</pre>

#### Ipv4Address

IPv4 address may be specified in form <address/mask> as:

- address - an IPv4 number in dotted-quad form 1.2.3.4. Only this exact IP number will match the flow control rule.
- address/mask - an IP number as above with a mask width of the form 1.2.3.4/24.
    In this case, all IP numbers from 1.2.3.0 to 1.2.3.255 will match. The bit width MUST be valid for the IP version.

| Name | Type | Description | Required |
| ---- | ---- | ----------- | -------- |
| Ipv4Address | string | IPv4 address may be specified in form <address/mask> as:   - address - an IPv4 number in dotted-quad form 1.2.3.4. Only this exact IP number will match the flow control rule.   - address/mask - an IP number as above with a mask width of the form 1.2.3.4/24.     In this case, all IP numbers from 1.2.3.0 to 1.2.3.255 will match. The bit width MUST be valid for the IP version.  |  |

**Example**
<pre>192.168.0.1/24</pre>

#### Ipv6Address

IPv6 address, following IETF 5952 format, may be specified in form <address/mask> as:

- address - The /128 subnet is optional for single addresses:
  - 2001:db8:85a3:8d3:1319:8a2e:370:7344
  - 2001:db8:85a3:8d3:1319:8a2e:370:7344/128
- address/mask - an IP v6 number with a mask:
  - 2001:db8:85a3:8d3::0/64
  - 2001:db8:85a3:8d3::/64

| Name | Type | Description | Required |
| ---- | ---- | ----------- | -------- |
| Ipv6Address | string | IPv6 address, following IETF 5952 format, may be specified in form <address/mask> as:   - address - The /128 subnet is optional for single addresses:     - 2001:db8:85a3:8d3:1319:8a2e:370:7344     - 2001:db8:85a3:8d3:1319:8a2e:370:7344/128   - address/mask - an IP v6 number with a mask:     - 2001:db8:85a3:8d3::0/64     - 2001:db8:85a3:8d3::/64  |  |

**Example**
<pre>2001:db8:85a3:8d3:1319:8a2e:370:7344</pre>

#### InstanceIdentifier

Unique identifier generated by the partner OP to identify an instance of the application on a specific zone.

| Name | Type | Description | Required |
| ---- | ---- | ----------- | -------- |
| InstanceIdentifier | string | Unique identifier generated by the partner OP to identify an instance of the application on a specific zone. |  |

#### ErrResponse

| Name | Type | Description | Required |
| ---- | ---- | ----------- | -------- |
| status | string | _Example:_ `"OK"` | No |
| message | string | _Example:_ `"OK"` | No |

#### ErrorInfo

| Name | Type | Description | Required |
| ---- | ---- | ----------- | -------- |
| code | string | Code given to this error | Yes |
| message | string | Detailed error description | Yes |

### 4.4 Policies

N/A

### 4.5 Code Snippets

N/A
###  4.6 FAQ's

(FAQs will be added in a later version of the documentation)

###  4.7 Terms

N/A

###  4.8 Release Notes

The Traffic Influence API reduces the complexity of the 3GPP Traffic Influence API exposed by the 3GPP Network Exposure Function (NEF) [1]. While the 3GPP TI API offers fastest routing activation and user mobility among different edge sites, this version of the CAMARA Traffic Influence API covers only the fastest routing activation, also for selected users. User mobility will be introduced in a future version. 

Enhancements with respect to the previous release:

 - These release also effects existing PDU sessions.
 - The ueId paramter is renamed into Device
 - The parameter Device, that identifies the User, is now simplified to guarantee the identification of an existing PDU session
 - instanceId added
- trafficFilters description updated
- CAMEL type adopted 
- FlowInfo deleted
- OpenAPI version updated to 3.0.3

##  References

[1] 3GPP TS 23.501: System architecture for the 5G System (5GS); Stage 2 (Release 17), V17.4.0 (2022-03)
[2] CAMARA Commonalities : Authentication and Authorization Concept for Service APIs https://github.com/camaraproject/WorkingGroups/blob/main/Commonalities/documentation/Working/CAMARA-AuthN-AuthZ-Concept.md
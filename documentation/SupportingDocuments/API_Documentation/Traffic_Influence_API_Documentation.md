# OPAG-CAMARA Traffic Influence API
## Overview

The reference scenario foresees a Service, composed by one or more Service Producers deployed in different geographical locations on Edge Cloud Zones (Edge datacentres of Telco Operator) or in Cloud. The Service Producer, deployed at the Edge, is referred as Edge Application Server (EAS).
An Edge Cloud Zone is a platform in the Telco Operator network, offering network, compute and storage resources to developers. A developer can deploy and run applications on an Edge Cloud Zone, meaning reduced latency to end users that are nearby, as the network path is shorter. A network operator's EdgeCloud may comprise multiple Edge Cloud Zones, each in a discrete location to bring latency benefits to end users across a country . The operator can help developers know which of the Edge Cloud Zones will bring the best performance benefit for a given end user and application
The Traffic Influence API (TI API) provides the fastest routing from the user Device (e.g. a Smartphone) to the optimal EAS instance in a specific geographical location, installed in an Edge Cloud Zone.
If a Service is offered by Cloud Instances and by Edge Instances, the TI API can be used get the optimal routing of the traffic to the Edge Instances, maybe for a set of users. Getting the optimal routing can be used to improve latency maybe in combination with other CAMARA APIs such as QoD (Quality On Demand). Providing the optimal routing is indeed an important step to get the optimal latency.
If the TI API is used to get the best routing at the Edge for a Device in a geographical location and the Device moves to another geographical location, the TI API can be invoked to get the optimal routing in the new geographical location for that Device.

## 1. Introduction
The TI API provides the capability to establish the best routing, in terms of latency, in a specific geographical area, between the user Device, e.g. the user’s smartphone, and the optimal EAS instance nearby. If the Device moves in a different geographical location where a more suitable EAS instance is available, the TI API can be invoked to influence the Device connectivity to get the optimal routing to the that local instance. It is important to notice that it is a task of the Application invoking the TI API to detect the changes in the Device location.
The generic architecture for the Service can foresee some Cloud instances of the Application, one or more Edge Instances of the Application. A component of the Service is the TI API Consumer. This logical component can be integrated in other components of the Service to invoke the TI API, creating a "TrafficInfluence" resource specifying the desired intent.
The TI API Producer implements the intent specified in the "TrafficInfluence" resource.
While the TI API can be invoked to activate the fastest routing for any user, it can also be used to request the best routing for a specific user. Invoking the TI API for each user, many "TrafficInfluence" resources are created for each user to provide the requested routing for a set of users.
The same approach is used for the geographical locations where the influence of the traffic must be applied. Invoking the TI API without specifying a geographical area activates the optimal routing toward any EAS instance, while invoking the TI API specifying a geographical area activates the optimal routing only toward the EAS instance located closest to that geographical area. To activate the optimal routing in selected geographical areas, the TI API must be invoked for each geographical area.
The TI API can be used to:
    - optimise the routing when Devices need to consume the service provided by a local EAS Instances.
    - effect an already established Device routing when the Device moves among different geographical locations. When the TI API consumer detects a Device has entered a geographical location where an EAS instance is available, it can invoke the TI API to get the optimal routing toward that EAS instance. If the Device moves to another geographical location, served by another EAS instance, the routing might not be optimal anymore for the new EAS instance. In the case the Application detects a location change, it can invoke the TI API again to request a new routing optimization toward the new EAS instance.

## 2. Quick Start
The usage of the TI API is based on the management of a "TrafficInfluence" resource, an object containing the intent requested invoking the TI API and that is implemented by the platform configuring the Mobile Network for the optimal routing toward the EAS instance.
The "TrafficInfluence" resource can be created (providing the related parameters that specify the desired intent), queried, modified and deleted.
The TI API is asynchronous, a notification is available providing information about the status of the requested resource.  
For an Application (identified by "appId") many "TrafficInfluence" resources can be created, e.g. to add multiple users, regions or zones.

Before starting to use the TI API, the developer needs to know about the below specified details:

**Base-Url**
The RESTful TI API endpoint, for example [**https://tim-api.developer.tim.it/trafficinfluence**](https://tim-api.developer.tim.it/trafficinfluence)

**Authentication**
Configure security access keys such as OAuth 2.0 client credentials to be used by Client applications which will invoke the TI API.

**TrafficInfluence**
This object represents the resource that carries the requirements from the user to be implemented. The TI API is invoked for the life cycle management of this resource (CRUD). The resource contains the intents from the TI API Consumer. Managing this resource, the developer can specify in which geographical location the routing must be applied, toward which application, maybe for a specific set of users or for a limited period of time.

**trafficInfluenceID**
Identifier for the Traffic Influence resource. This parameter is returned by the TI API and must be used to update it (e.g., adding a Device or deleting it). A different Traffic Influence resource must be created for any Device or Zone or Region. All these resources are related to an Application identified by "appId".

**apiConsumerId**
Unique identifier for the TI API Consumer.

**region**
The developer can specify in which geographical area he requires the fastest routing toward the nearest application instance. A "region" is a wide geographical area and it contains one or more "zones". A "zone" is where the Edge Cloud Zone is located. Zones and Regions identifiers are defined and provided by the Telco Operator and can also be used or retrieved with other CAMARA APIs (“MEC Exposure & Experience Management API” and “Simple Edge Discovery”). To add more regions the TI API must be invoked (POST) for each region. New "TrafficInfluence" resources are created (with different "trafficInfluenceID"). All the created resources are aggregated by the Application (identified by "appId").

**zone**
The developer can specify in which geographical area he requires the fastest routing toward the nearest Application instance. A "zone" is a smaller geographical area inside a "region". A "zone" is where the Edge Cloud Zone is located. To add more zones the TI API must be invoked (POST) for each "zone". New "TrafficInfluence" resources are created (with different "trafficInfluenceID"). All the created resources are aggregated by the Application (identified by "appId").

**appId**
A globally unique identifier associated with the application. This identifier is provided during the application onboarding process. To influence the traffic toward a specific Application. It is the Operator Platform that detects the appropriate Application instance in the selected "region" or "zone".

**appInstanceId**
A globally unique identifier generated by the Operator Platform to identify a specific instance of the Application on a specific zone. To influence a traffic toward a specific Application instance.

**trafficFilters**
The Application can expose different service on different interfaces, with this parameter it is possible to enable just some of those services maybe for different sets of users.

**Device**
A user Device can be provided as an input. To add more users the TI API must be invoked (POST) of each user Device. New "TrafficInfluence" resources are created (with different "trafficInfluenceID"). All the created resources are aggregated by the Application (identified by "appId"). The routing toward the selected Application instance is only applied for provided user Devices.

**Notification URL and token**
Developers have a chance to specify call back URL on which notifications (e.g. session termination) regarding the session can be received from the service provider. This is also an optional parameter.

## 3. Authentication and Authorization
The TI API makes use of the client credentials grant which is applicable for server to server use cases involving trusted partners or clients without any protected user data involved.
In this method the TI API invoker client is registered as a confidential client with an authorization grant type of client\\_credentials [2].

## 4. API Documentation
## 4.1 Details

The TI API is consumed by an Application Function (AF) requesting for the optimal routing, in term of latency, for the traffic flow from a Device toward EAS instances in Edge Cloud Zones.
When the Application (the EAS) is onboarded and deployed in the Edge Cloud Zones, the Application is identified with a unique identifier ("appId").
Using the application identifier ("appId") and specifying a Zone or a Region, the Telco Operator Platform, autonomously identifies the best instance of the EAS toward which routing the traffic flow and configures the Mobile Network accordingly to get the fastest routing.
If just the application identifier is used, the Telco Operator Platform identifies all the EAS Instances and activates the optimal routing on the Mobile Network.
If the optimal routing in term of latency should be available just for a set of users, the TI API must be invoked for each user creating a new TrafficInfluce resource for each one.
If the Application offers different services on different interfaces a traffic filter based on IP, Port and Protocol can be used. I this way it is also possible to redirect different users to different interfaces.
Here are some possible intents:

1) activate the optimal routing for any EAS instance: the TI API must be invoked with the "appId". The Telco Operator Platform identifies all the EAS instances and activates the optimal routing on the Mobile Network.
2) activate the optimal routing in a specific Region or Zone: the TI API must be invoked with the "appId" and the Zones and Regions identifiers.
3) activate the optimal routing for a user devices: the TI API can  be invoked with a user Device identifier (“Device”). For each user Device, a TI API invocation is required.

## Version: 0.9.3

**Contact information:**  
project-email@sample.com  

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
| appId | query | Used to select traffic influence resources filtered by appId | No | string (uuid) |

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

Takes as input an object containing the intents from the API Consumer and creates a TrafficInfluence resourse accordingly. The trafficInfluenceID parameter, that is part of the object, must not be valorized when creating a new resource. For this reason the trafficInfluenceID parameter must be avoided in the object, anyway it will be ignored by the API Producer. It is automatically generated by the system and returned in the response.

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

Reads a specific TrafficInfluence resource identified by the trafficInfluenceID value

##### Description

Returns a specific TrafficInfluence resources owned by the same API Consumer authenticated via oAuth2

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

##### Description

invoked by the API Consumer to stop influencing the traffic, deleting a TrafficInfluence resource previously created

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

Resource conteining the informations to influence the traffic from the device to the EAS

| Name | Type | Description | Required |
| ---- | ---- | ----------- | -------- |
| trafficInfluenceID | string | Identifier for the Traffic Influence resource. This parameter is returned by the API and must be used to update it (e.g., adding new users or deleting it). | No |
| apiConsumerId | string | Unique Identifier of the TI API Consumer. | Yes |
| appId | string (uuid) | A globally unique identifier associated with the application. OP generates this identifier when the application is submitted over NBI.<br>_Example:_ `"6B29FC40-CA47-1067-B31D-00DD010662DA"` | Yes |
| appInstanceId | string (uuid) | A globally unique identifier associated with a running instance of an application. OP generates this identifier. | No |
| region | string | Unique identifier representing a region  | No |
| zone | string | Unique identifier representing a zone  | No |
| device | object | Device identifier | No |
| state | string | it reports the state of the TrafficInfluence resource. When first invoked, the resource is 'ordered'. When the platforms prepares the resource, it is 'created'. When the new routing is enabled in the network, the state is 'active'.  If an error occurs in the resource creation or in its activation, the state is 'error'. When the DELETE method is invoked the state is 'deletion in progress'. After the resource is deleted (as a consequence of the previous invokation of the DELETE method) the state is 'deleted'.<br>_Enum:_ `"ordered"`, `"created"`, `"active"`, `"error"`, `"deletion in progress"`, `"deleted"` | No |
| trafficFilters | [ string ] | Identifies IP packet filters. To be used when a the Application needs a traffic flow towards a specific EAS interface | No |
| notificationUri | string | Defines the callback uri which should be notified in asynchronous way when the state for the requested resources changes (i.e. ordered to activated) | No |
| notificationAuthToken | string | Authentification token for callback API | No |

#### PatchTrafficInfluence

inherits from TrafficInfluence and restricts the access to certain parameters. Only some paramter can be indeed modified with the PATCH operation.

| Name | Type | Description | Required |
| ---- | ---- | ----------- | -------- |
| trafficInfluenceID |  |  | No |
| apiConsumerId |  |  | No |
| appId |  |  | No |
| state |  |  | No |

#### PostTrafficInfluence

| Name | Type | Description | Required |
| ---- | ---- | ----------- | -------- |
| trafficInfluenceID |  |  | No |
| state |  |  | No |

#### TrafficInfluenceNotification

Notifican channel for changes in the TrafficInfluence resource

| Name | Type | Description | Required |
| ---- | ---- | ----------- | -------- |
| trafficInfluenceChanged | object | Resource conteining the informations to influence the traffic from the device to the EAS | Yes |

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
| networkAccessIdentifier | string | identifier for the End User formatted as string, it cab be the user's email address<br>_Example:_ `"123456789@domain.com"` | No |
| ipv4Address | string (ipv4) | IP of the device. A single IPv4 address may be specified in dotted-quad form 1.2.3.4. Only this exact IP number will match the flow control rule.<br>_Example:_ `"192.168.0.1"` | No |
| ipv6Address | string (ipv6) | IP of the device. A single IPv6 address, following IETF 5952 format, may be specified like 2001:db8:85a3:8d3:1319:8a2e:370:7344<br>_Example:_ `"2001:db8:85a3:8d3:1319:8a2e:370:7344"` | No |

#### NetworkAccessIdentifier

identifier for the End User formatted as string, it cab be the user's email address

| Name | Type | Description | Required |
| ---- | ---- | ----------- | -------- |
| NetworkAccessIdentifier | string | identifier for the End User formatted as string, it cab be the user's email address |  |

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

IP of the device. A single IPv4 address may be specified in dotted-quad form 1.2.3.4. Only this exact IP number will match the flow control rule.

| Name | Type | Description | Required |
| ---- | ---- | ----------- | -------- |
| Ipv4Address | string | IP of the device. A single IPv4 address may be specified in dotted-quad form 1.2.3.4. Only this exact IP number will match the flow control rule. |  |

**Example**
<pre>192.168.0.1</pre>

#### Ipv6Address

IP of the device. A single IPv6 address, following IETF 5952 format, may be specified like 2001:db8:85a3:8d3:1319:8a2e:370:7344

| Name | Type | Description | Required |
| ---- | ---- | ----------- | -------- |
| Ipv6Address | string | IP of the device. A single IPv6 address, following IETF 5952 format, may be specified like 2001:db8:85a3:8d3:1319:8a2e:370:7344 |  |

**Example**
<pre>2001:db8:85a3:8d3:1319:8a2e:370:7344</pre>

#### AppInstanceId

A globally unique identifier associated with a running instance of an application. OP generates this identifier.

| Name | Type | Description | Required |
| ---- | ---- | ----------- | -------- |
| AppInstanceId | string | A globally unique identifier associated with a running instance of an application. OP generates this identifier. |  |

#### AppId

A globally unique identifier associated with the application. OP generates this identifier when the application is submitted over NBI.

| Name | Type | Description | Required |
| ---- | ---- | ----------- | -------- |
| AppId | string | A globally unique identifier associated with the application. OP generates this identifier when the application is submitted over NBI. |  |

**Example**
<pre>6B29FC40-CA47-1067-B31D-00DD010662DA</pre>

#### ErrResponse

Responce feedback in case of errors

| Name | Type | Description | Required |
| ---- | ---- | ----------- | -------- |
| status | string | status for the error<br>_Example:_ `"OK"` | No |
| message | string | additional message for the error<br>_Example:_ `"OK"` | No |

#### ErrorInfo

Information in case of errors

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

 - These release also effects existing data sessions 
 - These release can be also used to optimize  existing data sessions when a Device moves among geographical areas.
 - The ueId parameter is renamed into Device
 - The parameter Device, that identifies the User, is now simplified to guarantee the identification of an existing data session
 - instanceId added
- trafficFilters description updated
- CAMEL type adopted 
- FlowInfo deleted
- OpenAPI version updated to 3.0.3
- To let the Developer to just work on parameters actually editable, the PUT method is changed into a PATCH method with a limitation on the parameters usable and modifiable. A new resource is created, PatchTrafficInfluence that contains only the editable parameters. The same approach is also adopted for the PUT method and a new resource PostTrafficInfluence was created with just the editable parameters.
- DELETE response code modified as 202. The Deletion request is accepted (not yet completed)
- Added response code 400 (bad request) to POST
- General improvement in documentation
- applicationId changed into appId and instanceId changed into appInstanceId
- alignement of parameters with EdgeCloud_LCM: applicationId changed into appId and instanceId changed into appInstanceId
- modified reference to CAMARA Authorization guidelines link
- Telco Edge Site changed in Edge Cloud Zone
- added: info-contact
- Device: IPV4 and IPV6 changed to represent just one IP. Net mask is no more valid.
- global tags definition
- adopted lowerCamelCase for OperationId
- added descriptions for Delte and Get (for specific resource) methods
- added missing operationid
- improvement of callback definition
- added "description" to the TrafficInfluence resource
- added "description" to the PatchTrafficInfluence resource
- added "description" to TrafficInfluenceNotification
- added "description" to NetworkAccessIdentifier
- added "description" to ErrResponse
- added "description" to message
- added "description" to status
- added "description" to ErrorInfo
- removed unused error code SessionNotFound404

##  References

[1] 3GPP TS 23.501: System architecture for the 5G System (5GS); Stage 2 (Release 17), V17.4.0 (2022-03)
[2] CAMARA Commonalities : Authentication and Authorization Concept for Service APIs https://github.com/camaraproject/IdentityAndConsentManagement/blob/main/documentation/CAMARA-API-access-and-user-consent.md

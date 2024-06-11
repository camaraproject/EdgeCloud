


# Edge Cloud API
## Overview

The reference scenario foresees a distributed Telco Edge Cloud where any Application Delevoper, known as an Application Provider, can host and deploy their application according to their specifications and operational criteria (e.g. within an specific geographical zone for data protection purposes, ensure a minimum QoS for the application clients, etc). Through Telco Edge Cloud services Developers around the globe can be benefit from the traditional Cloud strengths but expertise and advantages of the Mobile Network Operators offering to their users an evolved experience for XR, V2X, Holographic and other new services.

## 1. Introduction
The Edge Cloud LcM API provides capabilities for lifecycle management of application instances and edge discovery.

Lifecycle Management allows Application Provider to onboard their application details to the Operator Platform which do bookkeeping, resource validation and other pre-deployment operations. Application details can contain components network specification , package type (QCOW2, OVA, CONTAINER, HELM), operating system details and respository to download the image of the desired application.

Once the application is available on the Operator Platform, the Application Provider can instantiate the application. OP helps AP to decide where to instantiate the applications allowing them to retrieve a list of Edge Zones that meets the provided criteria. This discovery can be filtered by an specific geographical region (e.g when data residency is need) and by status (active, inactive, unknown).

Application Provider can ask the operator to instantiate the application to one or several Edge Zones that meet the criteria. Typically when more than one Edge Zone is required in the same geographic boundary, AP can define instead the entire Region. AP can retrieve the information of the instances for a given application, the information could be the Edge Zone where the instance is, status (ready, instantiating, failed, terminating, unknown) and endpoint (ip, port, fqdn).

Application Provider can terminate an instance of an application (appInstanceId) or all the instances for a given appId.

## 2. Quick Start

The usage of the Edge Cloud LcM is based on several resources including GSMA Operator Platform, Public Cloud and SDOs, to define a first approach on the lifecycle management of application instances and edge discovery.

Before starting to use the API, the developer needs to know about the below specified details.

Two operations have been defined in Edge Cloud LcM API.

**Application** - The Application Provider submit application metadata to the Operator Platform. The OP generate an appId for that metadata that will be used to instantiate the application within the Edge Cloud Zone.

**Edge Cloud** - Retrieves all the Edge Cloud Zones available according to some defined parameters where an application can be instantiated.


# Introduction
    
**Application**
The Application Provider submit application metadata to the Operator Platform.

**Application Instance**
An Operator Platform instantiate an Application on an Edge Cloud Node when the Application Provider resquest it.

**Edge Cloud information**
Retrieves all the Edge nodes available according to some defined parameters.

# Relevant terms and definitions
This section provides definitions of terminologies commonly referred to throughout the API descriptions.

**Application Provider**
The provider of the application that accesses an OP to deploy its application on the Edge Cloud. An Application Provider may be part of a larger organisation, like an enterprise, enterprise customer of an OP, or be an independent entity.

**Application**
Contains the information about the application to be instantiated. Descriptor, binary image, charts or any other package assosiated with the application. The Application Provider request contains mandatory criteria (e.g. required CPU, memory,storage, bandwidth) defined in an Application.

**Edge Cloud**
Cloud-like capabilities located at the network edge including, from the Application Provider's perspective, access to elastically allocated compute, data storage and network resources.

**Edge Cloud Zone**
An Edge Cloud Zone is the lowest level of abstraction exposed to an Application Provider who wants to deploy an Application on Edge Cloud. Zones exist within a Region.


**OP**
Operator Platform. An Operator Platform (facilitates access to the Edge Cloud and other capabilities of an Operator or federation of Operators and Partners. ^[1]

**Region**
An OP Region is equivalent to a Region on a public cloud. The higher construct in the hierarchy exposed to an Application Provider who wishes to deploy an Application on the Edge Cloud and broadly represents a geography. A Region typically contains one or multiple Zones. A Region exists within an Edge Cloud.

### Application Management

**submitApp**
Submits an application details to an OP. Based on the details provided,  OP shall do bookkeeping, resource validation and other pre-deployment operations.

**deleteApp**
Removes an application from an OP, if there is a running instance of the given application, the request cannot be done.

**getApp**
Retrieves the information of a given application.

### Application Instance Management

**appInstantiation**
Request the OP to instatiate an instance of an application in a given Edge Cloud Zone, if this parameter is not set, the OP will instantiate the applications in all the Edge Cloud Zones available.

**getAppInstance**
Retrieves the list with information of the instances related to a given application.

**deleteAppInstance**
Removes a given application instance from an Edge Cloud Zone.

### Edge Cloud information

**getEdgeCloudZones**
List of the operator’s Edge Cloud Zones and their status, ordering the results by location and filtering by status (active/inactive/unknown).

## Further info and support

(FAQs will be added in a later version of the documentation)

## 3. Authentication and Authorization
TBD

## 4. API Documentation
## 4.1  API Version

0.9.2


**License:** [Apache 2.0](https://www.apache.org/licenses/LICENSE-2.0.html)

[Product documentation at Camara](https://github.com/camaraproject/)
### 

## 4.2  Details

#### POST /app
##### Summary

Submit application metadata to the Operator Platform.

##### Description

The Application Provider request contains in the body an Aplication Manifest see AppManifest in model section.

##### Responses

If the request is correct a 201 code will be obtained along with an appId to be used in other methods to obtain information or to generate app instances.

| Code | Description |
| ---- | ----------- |
| 201 | Application created successfully |
| 400 | Bad request |
| 401 | Unauthorized |
| 403 | Forbidden |
| 409 | Conflict |
| 500 | An unknow error has occurred |
| 501 | Not Implemented 
| 503 | Service unavailable |


#####  GET /app/{appId}/
##### Summary

Ask the OP the information for a given application.

##### Parameters

| Name | Located in | Description | Required | Schema |
| ---- | ---------- | ----------- | -------- | ---- |
| appId| path | A globally unique identifier associated with the application. OP generates this identifier when the application is submitted over NBI | yes | string |

##### Responses

If the request is correct a 200 code will be obtained along with an Aplication Manifest see AppManifest in model section.

| Code | Description |
| ---- | ----------- |
| 200 | OK |
| 401 | Unauthorized |
| 403 | Forbidden |
| 404 | The specified resource was not found |
| 500 | An unknow error has occurred |
| 503 | Service unavailable |


##### DELETE /app/{appId}/
##### Summary

Delete all the information and content related to an Application

##### Parameters

| Name | Located in | Description | Required | Schema |
| ---- | ---------- | ----------- | -------- | ---- |
| appId | path | Identificator of the application to be deleted provided by the OP NBI once the submission was successful | yes | string |

##### Responses

| Code | Description |
| ---- | ----------- |
| 202 | Request accepted |
| 204 | App deleted |
| 400 | Bad request |
| 401 | Unauthorized |
| 403 | Forbidden |
| 404 | Not Found |
| 409 | Conflict |
| 500 | Internal Server Error |
| 503 | Service unavailable |

##### POST /app/{appId}/instance
##### Summary

Ask the OP to instantiate an application to one or several Edge Cloud Zones with an Application as an input and an Application Instance as the output.

##### Description

Details regarding where the application should be instantiated

##### Parameters

| Name | Located in | Description | Required | Schema |
| ---- | ---------- | ----------- | -------- | ---- |
| appId | path | A globally unique identifier associated with the application. OP generates this identifier when the application is submitted over NBI. | yes | string |

##### Responses

| Code | Description |
| ---- | ----------- |
| 202 | Application instantiation accepted |
| 400 | Bad request |
| 401 | Unauthorized |
| 403 | Forbidden |
| 409 | Conflict |
| 500 | An unknow error has occurred |
| 501 | Not Implemented 
| 503 | Service unavailable |


#####  GET /app/{appId}/instance
##### Summary

Ask the OP the information of the instances for a given application.

##### Parameters

| Name | Located in | Description | Required | Schema |
| ---- | ---------- | ----------- | -------- | ---- |
| appId| path | A globally unique identifier associated with the application. OP generates this identifier when the application is submitted over NBI | yes | string |
| appInstanceId| query | A globally unique identifier associated with a running instance of an application. OP generates this identifier. | no | string |
| region| query | Human readable name of the geografical region of the Edge Cloud. Defined by the OP. | no | string |

##### Responses

| Code | Description |
| ---- | ----------- |
| 200 | Information of Aplication Instances |
| 401 | Unauthorized |
| 403 | Forbidden |
| 404 | The specified resource was not found |
| 500 | An unknow error has occurred |
| 503 | Service unavailable |


##### DELETE /app/{appId}/instance
##### Summary

Terminate a running instance of an application within an Edge Cloud Zone

##### Parameters

| Name | Located in | Description | Required | Schema |
| ---- | ---------- | ----------- | -------- | ---- |
| appId | path | Identificator of the application to be deleted provided by the OP NBI once the submission was successful | yes | string |
| appInstanceId | query | Identificator of the specific application instance that will be terminated | no | string |

##### Responses

| Code | Description |
| ---- | ----------- |
| 202 | Request accepted to be processed. It applies for async deletion process |
| 204 | App deleted |
| 400 | Bad request |
| 401 | Unauthorized |
| 403 | Forbidden |
| 404 | Not Found |
| 500 | Internal Server Error |
| 503 | Service unavailable |



#### GET /edge-cloud-zones
##### Summary

Retrieve a list of the operator’s Edge Cloud Zones and their status

##### Description
List of the operator’s Edge Cloud Zones and their status, ordering the results by location and filtering by status (active/inactive/unknown).

##### Parameters

| Name | Located in | Description | Required | Schema |
| ---- | ---------- | ----------- | -------- | ---- |
| region | query | Human readable name of the geografical region of the Edge Cloud. Defined by the OP. | no | string |
| status | query | _Available values_  : active, inactive, unknown Default value  : unknown | no | string |


##### Responses

| Code | Description |
| ---- | ----------- |
| 200 | Available Edge Cloud Zones |
| 401 | Unauthorized |
| 403 | Unauthorized |
| 404 | Not Found |
| 500 | Internal Server Error |
| 503 | Service unavailable |


### Models

#### AppId

| Name | Type | Description | Required |
| ---- | ---- | ----------- | -------- |
| appId | string | A globally unique identifier associated with the application. OP generates this identifier when the application is submitted over NBI. | yes |

#### AppInstanceId

| Name | Type | Description | Required |
| ---- | ---- | ----------- | -------- |
| appInstanceId | string | A globally unique identifier associated with a running instance of an application. OP generates this identifier. | Yes |

#### AppInstantiation

| Name | Type | Description | Required |
| ---- | ---- | ----------- | -------- |
| appInstantiation | string | Attributes with information where to instantiate a given application | yes |
| edgeCloudZone | string | Human readable name of the zone of the Edge Cloud. Defined by the OP. | no |
| region | string | Human readable name of the geografical region of the Edge Cloud. Defined by the OP. | yes |

#### EdgeCloudZone
| Name | Type | Description | Required |
| ---- | ---- | ----------- | -------- |
| name | string | Human readable name of the zone of the Edge Cloud. Defined by the OP. |  no |
|   provider  | integer | Human readable name of the edge cloud provider company (e.g. telco operator, hyperscaler).|  no  |


#### AppManifest

| Name | Type | Description | Required |
| ---- | ---- | ----------- | -------- |
| name | string | Name of the application. |  yes  |
|   version  | integer | Application version information|  no  |
|  packageType  | string |[ QCOW2, OVA, CONTAINER, HELM ] | no |
|  operatingSystem  | string | more details in the specific table| no |
| appRepo | object |more details in the specific table | yes |
| componentSpec | array | Information defined in "appRepo" point to the application descriptor e.g. Helm chart, docker-compose yaml file etc. The descriptor may contain one or more containers and their associated meta-data. A component refers to additional details about these containers to expose the instances of the containers to external client applications. App provider can define one or more components (via the associated network port) in componentSpec corresponding to the containers in helm charts or docker-compose yaml file as part of app descriptors.  | yes|
version | integer | Application version information | no |

#### OperatingSystem

| Name | Type | Description | Required |
| ---- | ---- | ----------- | -------- |
|   arquitecture  | string  | [ x86_64, x86 ]| yes |
|   family       |  string | [ RHEL, UBUNTU, COREOS, WINDOWS, OTHER ]| yes |
|  version      |  string | [OS_VERSION_UBUNTU_2204_LTS, OS_VERSION_RHEL_8, OS_MS_WINDOWS_2022, OTHER]| yes |
|  license      |  string | [OS_LICENSE_TYPE_FREE, OS_LICENSE_TYPE_ON_DEMAND, OTHER ] | yes |

#### AppRepo

| Name | Type | Description | Required |
| ---- | ---- | ----------- | -------- |
| type        | string |  Application repository and image URI information. PUBLICREPO is used of public urls like github, helm repo etc. PRIVATEREPO is used for private repo managed by the application developer. Private repo can be accessed by using the app developer provided userName and password. Password is recommended to be the personal access token created by developer e.g. in Github repo. [ PRIVATEREPO, PUBLICREPO ].          | yes |
| imagePath   | string |   example:  https://charts.bitnami.com/bitnami/helm/example-chart:0.1.0 A Uniform Resource Identifier (URI) as per RFC 3986, identifies the endpoint within an Edge Cloud Zone where the user equipment may connect to the selected application instance| yes |
| userName    | string | Username to acces the Helm chart, docker-compose file or VM image repository  | no |
| credentials | string | maxLength:  128 Password or personal access token created by developer to acces the app repository. API users can generate a personal access token e.g. docker clients to use them as password  | no |
| authType    | string | The credentials can also be formatted as a Basic auth or Bearer auth in HTTP "Authorization" header.[ DOCKER, HTTP_BASIC, HTTP_BEARER, NONE ]   | no  |
| checksum    | string |MD5 checksum for VM and file-based images, sha256 digest for containers | no |

#### ComponentSpec

| Name | Type | Description | Required |
| ---- | ---- | ----------- | -------- |
| componentName     | string  | Component name must be unique with an application                                                                                                                                                                                                                                                                                                                                                          | yes      |
| networkInterfaces | array   | Each application component exposes some ports either for external users or for inter component communication. Application provider is required to specify which ports are to be exposed and the type of traffic that will flow through these ports.The underlying platform may assign a dynamic port against the "extPort" that the application clients will use to connect with edge application instance. | yes      |

#### networkInterfaces

| Name | Type | Description | Required |
| ---- | ---- | ----------- | -------- |
| interfaceId       | string  | Each application component exposes some ports either for external users or for inter component communication. Application provider is required to specify which ports are to be exposed and the type of traffic that will flow through these ports.The underlying platform may assign a dynamic port against the "extPort" that the application clients will use to connect with edge application instance.                                                                                                                                                                                              | yes      |
| protocol          | string  | Defines the IP transport communication protocol i.e., TCP, UDP or ANY                                                                                                                                                                                                                                                                                                                                       | yes      |
| port              | integer | Port number exposed by the component. OP may generate a dynamic port towards the component instance which forwards external traffic to the component port.                                                                                                                                                                                                                                                  | yes      |
| visibilityType    | string  | Defines whether the interface is exposed to outer world or not i.e., external, or internal.If this is set to "external", then it is exposed to external applications otherwise it is exposed internally to edge application components within edge cloud. When exposed to external world, an external dynamic port is assigned for UC traffic and mapped to the extPort                                     | yes  |



#### AppInstanceInfo
Information about the application instance.

| Name | Type | Description | Required |
| ---- | ---- | ----------- | -------- |
| appInstanceId | string | A globally unique identifier associated with a running instance of an application. OP generates this identifier. | no |
| edgeCloudZone | string |Human readable name of the zone of the Edge Cloud. Defined by the OP. | no |
| status | string |Status of the application instance (default is 'unknown')[ ready, instantiating, failed, terminating, unknown ]| no |
| componentEndpointInfo | object |Information about the IP and Port exposed by the OP. Application clients shall use these access points to reach this application instance | no |

#### ComponentEndpointInfo

| Name | Type | Description | Required |
| ---- | ---- | ----------- | -------- |
| interfaceId | string |This is the interface Identifier that app provider defines when application is onboarded. | yes |
| accessPoints | object | object | | yes |

#### AccessPoints

| Name | Type | Description | Required |
| ---- | ---- | ----------- | -------- |
| port | integer | Port number exposed by the component. OP may generate a dynamic port towards the component instance which forwards external traffic to the component port.                                                                                                                                                                                                                                                  | yes   |
| fqdn | string | | yes |  
| ipv4Addr | string | IPv4 address may be specified in form <address/mask> as:   - address - an IPv4 number in dotted-quad form 1.2.3.4. Only this exact IP number will match the flow control rule.   - address/mask - an IP number as above with a mask width of the form 1.2.3.4/24.     In this case, all IP numbers from 1.2.3.0 to 1.2.3.255 will match. The bit width MUST be valid for the IP version.  |  |
| ipv6Addr | string | IPv6 address, following IETF 5952 format, may be specified in form <address/mask> as:   - address - The /128 subnet is optional for single addresses:     - 2001:db8:85a3:8d3:1319:8a2e:370:7344     - 2001:db8:85a3:8d3:1319:8a2e:370:7344/128   - address/mask - an IP v6 number with a mask:     - 2001:db8:85a3:8d3::0/64     - 2001:db8:85a3:8d3::/64  |  |
| anyOf | string | | yes | 

#### ErrorInfo

| Name | Type | Description | Required |
| ---- | ---- | ----------- | -------- |
| status | integer | HTTP status code returned along with this error response | yes |
| code | string | Code given to this error | yes |
| message | string | Detailed error description | yes |

#### EdgeCloudZoneDetails
| Name | Type | Description | Required |
| ---- | ---- | ----------- | -------- |
| edgeCloudZone | string | Human readable name of the zone of the Edge Cloud. Defined by the OP. |  |
| status | string | Status of the Edge Cloud Zone (default is 'unknown')[ active, inactive, unknown ]|  |
| region | string | Human readable name of the geografical region of the Edge Cloud. Defined by the OP. |  |

#### SubmittedApp
Information about the submitted app

| Name | Type | Description | Required |
| ---- | ---- | ----------- | -------- |
| appId | string | A globally unique identifier associated with the application. OP generates this identifier when the application is submitted over NBI. | |

#### Uri
example: https://charts.bitnami.com/bitnami/helm/example-chart:0.1.0

| Name | Type | Description | Required |
| ---- | ---- | ----------- | -------- |
| uri | string | A Uniform Resource Identifier (URI) as per RFC 3986, identifies the endpoint within an Edge Cloud Zone where the user equipment may connect to the selected application instance | |
                                                                                                                                                                                                         
### 4.3 Errors

Since CAMARA Edge Cloud LCM API is based on REST design principles and blueprints, well defined HTTP status codes and families specified by community are followed [[2]](#2).
 
Details of HTTP based error/exception codes for Edge Cloud LCM API are described in Section 4.2 of each API REST based method.
Following table provides an overview of common error names, codes, and messages applicable to Edge Cloud LCM API.
 
| No | Error Name | Error Code | Error Message |
| --- | ---------- | ---------- | ------------- |
|1	|400 |	INVALID_ARGUMENT |	"Client specified an invalid argument, request body or query param" |
|2	|401 |	UNAUTHORIZED |	"Request not authorized due to missing, invalid, or expired credentials" |
|3	|403 |	FORBIDDEN |	"Client does not have sufficient permissions to perform this action" |
|4	|404 |	NOT FOUND |	"The specified resource was not found" |
|5	|409 |	CONFLICT |	"Conflict with an existing resource" |
|6	|500 |	INTERNAL | "Internal Server Error" |
|7	|501 |	NOT_IMPLEMENTED | "Service not implemented" |
|8	|503 |	UNAVAILABLE | "Service unavailable" |
|9	|504 |	TIMEOUT | "Request timeout exceeded. Try later." |

### 4.4 Policies

N/A

### 4.5 Code Snippets

N/A
###  4.6 FAQ's

(FAQs will be added in a later version of the documentation)

###  4.7 Terms

N/A

###  4.8 Release Notes

TBD

##  References

[1] [GSMA OPG Operator Platform Requirements](https://www.gsma.com/futurenetworks/wp-content/uploads/2023/07/OPG.02-v5.0-Operator-Platform-Requirements-and-Architecture.pdf)
[2] [HTTP Status codes spec](https://restfulapi.net/http-status-codes/)

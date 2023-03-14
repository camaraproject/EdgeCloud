| Term | Definition |
|------|------------|
| A    |            |
|API Consumer |	 The entity making an API request. This typically refers to an **Application Client**, but APIs may also be consumed by remote servers.  |
|Application Backend Part |	An architectural part of an application that is to be deployed on public or private (and central) cloud infrastructure.|
|Application Client | A specifically developed client component of an application. |
|Application Edge Part | An architectural part of an **Edge Application** that is to be deployed on edge compute cloudlets. An End-to-End Application may include multiple Application Edge Parts (e.g. microservices).|
|Application Instance | An instantiation of an **Application Edge Part** on a Cloudlet. |
|Application Provider | The provider of the application that accesses the **OP** to deploy its application on the Edge Cloud, thereby using the **Edge Resources** and network resources. An Application Provider may be part of a larger organisation, like an enterprise, enterprise customer of the **OP**, or be an independent entity.|
|Application Service Provider | The developer/publisher who deploys applications on **MEC platforms**. |
| B    |            |
| C    |            |
|Cloudlet| A point of presence for the **Edge Cloud**. It is the point where **Edge Applications** are deployed. A Cloudlet offers a set of resources at a particular location (either geographically or within a network) that would provide a similar set of network performance.|
| D    |            |
|Density |	 Minimum 4G/5G subscriber density in a geographical area, represented as the number of subscribers per square kilometer.|
| E    |            |
|Edge Application | A cloud application that has some services deployed to **MEC Platforms** to take advantage of low latency and high bandwidth when interacting with devices. It may includes one or more Application Edge Parts (e.g. microservices).|
|Edge Cloud |	 A collection of **MEC Platforms**, which may be hosted by one or more **TSPs**|
|Edge Resource |	 An object defined by the service provider representing an edge resource within its network domain, such as a MEC Platform.|
| F    |            |
|Flavour | A set of characteristics for compute instances that define the sizing of the virtualised resources (compute, memory, and storage) required to run an application. Flavours can vary between operator networks.|
| G    |            |
| H    |            |
| I    |            |
| J    |            |
| K    |            |
| L    |            |
| M    |            |
|MEC  |	 Multi-access Edge Computing (MEC), a means of hosting applications within the TSPs core network, reducing propogation delay and hence latency. |
|MEC  Platform |	 A collection of cloud computing resources housed in a **TSP**'s network facility that provides Multi-access Edge Computing (**MEC**) capabilities. |
| N    |            |
|NorthBound Interface | NBI, The interface that exposes the Operator Platform to Application Providers. |
| O    |            |
|Optimal MEC  Platforms |	 A list of one or more optimal **MEC Platforms** to register a **Service Endpoint**, based on the latency and availability of each MEC platform, and optionally also based on various query criteria (Service Profile, Region, subscriber density or UE identity) defined by the API Consumer. |
|Optimal MEC Service Endpoints |	A list of one or more MEC **Service Endpoints** that provide optimal user experience to the API Consumer, based on internal network conditions known to the **MEC Platform**, and also optionally based on various query criteria (Service Profile, Region, subscriber density or UE identity) defined by the API Consumer. |
|Operator Platform | An Operator Platform (**OP**) facilitates access to the Edge Cloud capability of an Operator/**TSP** or federation of Operators and Partners.|
| P    |            |
| Q    |            |
| R    |            |
|Region |	 A **TSP** defined string identifier representing a certain geographical or logical area where MEC resources and services are provided.|
|Registered MEC Hosted Services |	 Applications running on **MEC platforms** which are registered with **Edge Discovery Service** using the service registry APIs.|
| S    |            |
|Service Endpoint | The routable endpoint of the service(s) within a deployed application that clients connect to, where a service is a subcomponent of application|   
|Service Profile |	 Information about the MEC application and the associated service characteristics.|
| T    |            |
|Tenant | The commercial owner of the applications and the associated data.|
|Tenant Space | A Tenant Space is a subset of resources from a **Cloudlet** that are dedicated to a particular tenant. A Tenant Space has one or more Virtual Machines (VMs) running native or containerised applications or cover a complete server.|
| TSP |	 Telecommunications Service Provider, aka network operator   |  
| U    |            |
|UE|	 acronym for **User Equipment**|
|UEIdentity |	 User Equipment identity, which can be a device's IP address, MSISDN, IMEI, MDN, or GPSI.|
|User Client | (term specific to GSMA Edge Cloud API, not used in 5GFF APIs ) Functionality that manages on the user's side the interaction with the OP. The User Client (UC) represents an endpoint of the UNI and is a component on the User Equipment. UCs and Application Clients are deployed on the User Equipment. |
|User Equipment (UE) | Any device with a SIM used directly by an end-user to communicate using Telecom wireless network connectivity , e.g. a smartphone, tablet, e-watch, etc. |
|User-Network Interface (UNI) | (term specific to GSMA Edge Cloud API, not used in 5GFF APIs)  Enables the **UC hosted** in the user equipment to communicate with the OP. |
| V    |            |
| VM   | Virtual Machine            |
| W    |            |
| X    |            |
| Y    |            |
| Z    |            |
|Zone |	 A logical collection of **MEC Platforms** in a telecommunication provider's network. A Zone is part of a **Region**.|

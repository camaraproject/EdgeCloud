| Term | Definition |
|------|------------|
|API Consumer |	 A user or an application consuming the MEC Exposure and Experience Management APIs. |
|Application Service Provider | the developer/publisher who deploys applications on MEC platforms. |
|Density |	 Minimum 4G/5G subscriber density in a geographical area, represented as the number of subscribers per square kilometer.|
|Edge Application | A cloud application that has some services deployed to MEC Platforms to take advantage of low latency and high bandwidth when interacting with devices.|
|Edge Resource |	 An object defined by the sevice provider representing an edge resource within its network domain, such as a MEC Platform.|
|MEC  Platform |	 A collection of cloud computing resources housed in a TSP's network facility that provide Multiaccess Edge Computing (MEC) capabilities. |
|Optimal MEC  Platforms |	 A list of one or more optimal MEC Platforms to register a Service Endpoint, based on the latency and availability of each MEC platform, and optionally also based on various query criteria (Service Profile, Region, subscriber density or UE identity) defined by the API Consumer. |
|Optimal MEC Service Endpoints |	A list of one or more MEC Service Endpoints that provide optimal user experience to the client device, based on internal network conditions known to the MEC Platform, and also optionally based on various query criteria (Service Profile, Region, subscriber density or UE identity) defined by the API Consumer. |
|Region |	 A TSP defined string identifier representing a certain geographical or logical area where MEC resources and services are provided.|
|Registered MEC Hosted Services |	 Applications running on MEC platforms which are registered with Edge Discovery Service using the service registry APIs.|
|Service Endpoint | The routable endpoint of the service(s) within a deployed application that clients connect to, where a service is a subcomponent of application|    
|Service Profile |	 Information about the MEC application and the associated service characteristics.|
|TSP |	 Telecommunications Service Provider.   |   
|UEIdentity |	 User Equipment identity, which can be a device's IP address, MSISDN, IMEI, MDN, or GPSI.|
|Zone |	 A logical collection of MEC Platforms in a telecommunication provider's network. A Zone is part of a Region.|
|Application Backend Part |	An architectural part of an Application that is to be deployed on public or private (and central) cloud infrastructure.|
|Application Client | A specifically developed client component of an application. |
|Application Edge Part | An architectural part of an Edge Application that is to be deployed on edge compute cloudlets. An End-to-End Application may include multiple Application Edge Parts (e.g. microservices).|
|Application Instance | An instantiation of and Application Edge Part on a Cloudlet. |
|Application Provider | The provider of the application that accesses the OP to deploy its application on the Edge Cloud, thereby using the Edge Cloud Resources and Network Resources. An Application Provider may be part of a larger organisation, like an enterprise, enterprise customer of the OP, or be an independent entity.|
|Cloudlet| A point of presence for the Edge Cloud. It is the point where Edge Applications are deployed. A Cloudlet offers a set of resources at a particular location (either geographically or within a network) that would provide a similar set of network performance.|
|Edge Application | An Application whose architecture includes one or more Application Edge Parts (e.g. microservices).|
|Flavour | A set of characteristics for compute instances that define the sizing of the virtualised resources (compute, memory, and storage) required to run an application. Flavours can vary between operator networks.|
|Northbound Interface | NBI, The interface that exposes the Operator Platform to Application Providers.|
|Operator Platform | An Operator Platform (OP) facilitates access to the Edge Cloud capability of an Operator or federation of Operators and Partners.|
|Tenant | A Tenant is the commercial owner of the applications and the associated data.|
|Tenant Space | A Tenant Space is a subset of resources from a Cloudlet that are dedicated to a particular tenant. A Tenant Space has one or more Virtual Machines (VMs) running native or containerised applications or cover a complete server.|
|User Client | Functionality that manages on the user's side the interaction with the OP. The User Client (UC) represents an endpoint of the UNI and is a component on the User Equipment.|
|User Equipment (UE) | Any device with a SIM used directly by an end-user to communicate. UCs and Application Clients are deployed on the User Equipment. By default, the term “UE” means UE with the explicit SIM-based Telecom wireless network connectivity throughout the document.|
|User-Network Interface (UNI) | Enables the UC hosted in the user equipment to communicate with the OP. |

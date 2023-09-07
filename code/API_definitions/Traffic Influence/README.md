# Traffic Influence
The Traffic Influence API provides the ability to ask for better latency in a specific geographical area to enhance the quality of experience leveraging on local instances of and application deployed on the Edge Datacenters provided by a Telco Operator. 
# Description
The Traffic Influence API hides the complexity of the network providing the developer with the possibility to express intents to get the best latency toward geographically distributed instances of an Application. A possible scenario of usage of the API is the following: a Service is usually provided by a Cloud instances of an Application for every standard user. In some specific geographical areas, anyway, the Service can be provided by an edge instance of the Application  for Premium users. The application management and control system invokes the Traffic Influence API to activate the appropriate routing at the Edge of the mobile network toward the local Application Instance for the Premium Users. Premium Users access the service in that geographical area with the best user experience while Standard users get a best effort service provided by the Cloud instances of the Service.
# Intents
The API can be invoked expressing the following intents:
- Enhance the quality for all mobile users consuming the services provided by an application onboarded on the Operator Platform on every local instance that application is deployed
- The intent can also be expressed for specific users or specific geographical areas

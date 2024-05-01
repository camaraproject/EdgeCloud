| Item | Description | Support Qualifier |
|----|----|----|
|Summary|A Service is provided by a Cloud instances of an Application. In a specific geographical area, the Service must be provided by an edge instance of the Application (EAS) for Premium users. The Application Function (AF) of the Service invokes the Traffic Influence API (exposed by the OP) to activate the appropriate routing at the Edge of the mobile network toward the local EAS Instance for the Premium Users. Premium Users access the service in that geographical area with the best user experience while Free users get a best effort service provided by the Cloud instances of the Service.| M |
|Roles, Actor(s) and scope|Application Function: role of Traffic Influence API consumer<br>Operator Platform: role of Traffic Influence API provider<br>User Equipment: role of Service consumer<br>Edge Application Server: role of Service producer<br><br>Scope: B2B use case to activate a specific traffic flow at the Edge toward an existing EAS in the Edge datacenters| M |
|NF Requirements|| O |
|Pre-conditions|• The EAS is deployed in the Edge datacenter<br>• A connectivity between the Telco Edges (where the UPF is located) and the Edge datacenter (where the EAS Instance is located) is in place.| M |
|Begins when|The AF invokes the Traffic Influence API to have the fastest routing toward a specific EAS Instance.| M |
|Step 1|The OP authorizes the request (terminates with a notification to the AF if it is not valid)| M |
|Step 2|The Traffic Influence API Producer validates the request (terminates with a notification to the AF if it is not coherent with the policies)| M|
|Step 3|The API Producer checks for network resources to implement the request (terminates with a notification to the AF if not available)| M |
|Step 4|The API Producer configures the network resources to get the fastest routing toward the requested EAS Instance| M |
|Step 5|The API Producer notifies the AF that the requested routing has been activated. The API Producer returns and Identifier for the created resource| M |
|Step 6|The AF invokes the TI API as many times according to the number of users to be added to the resource (passing the resource identifier) (the cycle goes through Steps 2-3-4-5 each time)| M |
|Ends when|All the users are properly configured| M |
|Post-conditions|The traffic flow is routed from the selected UPF to the requested EAS Instance for the selected users| M |
|Exceptions|Step 4 can generate an exception to be notified to the AF| M | 
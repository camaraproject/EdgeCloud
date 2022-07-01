These APIs are contributed by 5GFF:

# MEC Experience Management and Exposure API
This API allows a developer to:
- discover available MEC platforms, ranked by proximity to a UE.
- read the state (availability and capabilities) of an operator's various MEC platforms.
- register a service profile (a description of the developer's edge service) with the MEC operator
- register the deployed service endpoints with the MEC operator, which allows the closest service endpoint to be discovered at runtime

The API will also support the following capabilities: 
- events(such as change of status of a MEC platform or another event which could affect their service)
- subscription to notification of events.

Since events and subscription notifications can apply to many CAMARA APIs, that part will be defined in the Commonalities working group to ensure consistency.

# Simple Discovery API
This API allows a client application to discover the closest MEC platform to the UE hosting the client application. 'Closest' means 'shorteset network path' as that will give the shortest propogation distance, which is a major factor in latency.

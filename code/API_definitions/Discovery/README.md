# Edge Discovery APIs

## Simple Discovery API
This API allows a client application to discover the closest MEC platform to the UE hosting the client application. 'Closest' means 'shorteset network path' as that will give the shortest propogation distance, which is a major factor in latency.

## MEC Experience Management and Exposure API
This API allows a developer to:
- discover available MEC platforms, ranked by proximity to a UE.
- read the state (availability and capabilities) of an operator's various MEC platforms.
- register a service profile (a description of the developer's edge service) with the MEC operator
- register the deployed service endpoints with the MEC operator, which allows the closest service endpoint to be discovered at runtime

The API will also support the following capabilities: 
- events(such as change of status of a MEC platform or another event which could affect their service)
- subscription to notification of events.

# Mapping to the list of intents

These APIs fulfil the ['discovery' intents](https://github.com/camaraproject/EdgeCloud/blob/main/documentation/SupportingDocuments/Harmonisation%20of%20APIs/describing%20and%20harmonising%20the%20Edge%20APIs.md)

*Simple Edge Discovery* fulfils a single intent,  "4. I can discover the closest MEC platform to a specific terminal (closest in terms of shortest network path)"

*MEC Exposure and Experience Management* is a more comprehensive discovery API and fulfils the following intents:

### Developer intents
#### Provisioning intents 
1.	“I can retrieve a list of the operator’s MECs and their status, ordering the results by location and filtering by status (active/inactive/unknown)”
2.	"I can discover the capabilities/resources available at an operator’s MEC: CPU, Memory, Storage, GPU"
3.	"I can discover the geographical regions covered by the operators MECs"
4.	"I can discover the closest MEC platform to a specific terminal (closest in terms of shortest network path)"

16.	“I can ask the operator to provide the details of all the onboarded applications”
17.	"I can ask the operator to inform about the application instance details e.g., communication endpoints, resource consumed etc"


#### Runtime intents 
19.    "I can discover the closest MEC platform to a particular terminal (closest in terms of shortest network path)"
20.    "I can discover the optimal MEC platform for my application and a particular terminal, taking into account connectivity, shortest network path, cost, network load etc." (`A`)
21.    "I can discover the optimal application service endpoint for a specific terminal, taking into account mobility events, connectivity, shortest network path, cost, network load, MEC platform load etc."

### Operator intents
#### Provisioning intents
23. “I can publish an (ordered, filtered) list of my MECs, their coverage, capabilities and status” _(aligns with 1,2,3 in the developer intents)_ 
24. “I can map an application’s requirements to the best MEC for hosting it, based on application demands for CPU,Memory,Storage,GPU,bandwith,Network forecast, mobility” _(aligns with 4,5,8,9)_ 
#### Runtime intents 
25. “I can inform the developer of any event which changes which MEC is optimal for their application and connected terminals” _(aligns with  6)_

## Notes:

`A` this may not be the closest MEC, rather the 'best MEC for this job' which accounts for current MEC or network load, MEC copmute power and features etc.

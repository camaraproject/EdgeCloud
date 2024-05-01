# CAMARA Edge Cloud

This repository produces APIs allowing interaction with a network's 'edge cloud'. These are compute, storage and other resources placed in the operator network at different zones. 

## Scope

* Service APIs for “Edge Cloud”:  
  * Discover the closest edge cloud zone to a given device.
  * Provide and manage application images to be deployed on resources within the operator network. 
  * Use reserved compute resources within the operator network for the deployment of applications on VMs or containers.  
  * Influence the traffic routing from the user device toward the Edge instance of the Application. 
  * NOTE: The scope of this API family should be limited (at least at a first stage) to 4G and 5G.  
* Describe, develop, document and test the APIs (with 1-2 Telcos)  
* Started: 5th July 2022
* Location: virtually 

# APIs

YAML for all APIs can be found under [API_Definitions](https://github.com/camaraproject/EdgeCloud/tree/main/code/API_definitions)

## Simple Discovery API
This API queries the network to find the closest Edge Cloud Zone to a given user device. 'Closest' means 'shortest network path', and hosting an application server on the closest Edge Cloud Zone will typically provide the lowest latency for that user device.

## Traffic Influence API
The Traffic Influence API hides the complexity of the network providing the developer with the possibility to modify the connection policies of UEs and EAS in terms of how the traffic flows. For a 5G network, the UPF connected to the target Data Network can be updated with new traffic steering rules, for a set of users and for a specific time period. Furthermore, in a UE mobility scenario, the  PDU Session Anchor, may be relocated to a different UPF considering the requirements provided by the AF.

## Edge Cloud LCM (Lifecycle management)
(todo: add text)

# Meetings
* Meetings are held virtually
* Schedule: Tuesdays 16h-17 CET, every two weeks. 
* Meeting link: [LFX Zoom](https://www.google.com/url?q=https://zoom-lfx.platform.linuxfoundation.org/meeting/94237809115?password%3D05fb6d8a-a913-47d8-b003-db75ecdaa5d9&sa=D&source=calendar&ust=1711304713775725&usg=AOvVaw2KsTGn2S2i4Bu5V-nusuUI) 
* Minutes of previous meetings [link](https://wiki.camaraproject.org/display/CAM/Edge+Cloud)

# Contributorship and mailing list

To subscribe / unsubscribe to the mailing list of this Sub Project and thus be / resign as Contributor please visit [https://lists.camaraproject.org/g/sp-edc](https://lists.camaraproject.org/g/sp-edc).

A message to all Contributors of this Sub Project can be sent using [sp-edc@lists.camaraproject.org](sp-edc@lists.camaraproject.org).

CAMARA sp-edge-cloud: [Slack Channel(https://camara-project.slack.com/archives/C062PJNGW9F)

# Results
* Sub Project is in progress


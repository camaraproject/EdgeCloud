
| **Field** | Description | 
| ---- | ----- |
| API name | Traffic Influence |
| API owner | TIM |
| API summary | 
||For Services that have latency requirements, especially when they are deployed at the Edge of the network, covering specific geographical areas with specific Service instances (Edge Application Servers),  the Traffic Influence API provides an intent-based interface to request the best possible latency.<br><br>The Traffic Influence API hides the complexity of the network providing the developer with the possibility to modify the connection policies of UEs and EASs in terms of how the traffic flows . The API is exposed as server-to-server, it is indeed consumed by an Application Function (AF).<br><br>For a 5G network, the UPF connected to the target Data Network can be updated with new traffic steering rules. Furthermore, in a UE mobility scenario, the PDU Session Anchor, may be relocated to a different UPF considering the requirements provided by the AP Consumer.<br><br>A basic scenario foresees  the AF requesting the connection of an EAS Instance to the Core Network user plane, typically at the Edge. Local Breakout - LBO (on 4G or 5G networks) on the closest UPF must be implemented.<br><br>A further scenario foresees the UE moving from one geographical area to another. The AF could request to move the application session from one EAS in one Edge Data Network to another EAS in another Edge Data Network. Therefore, a new UPF could be selected as PDU session anchor.|
| Technical viability | • NEF (Rel-15)<br>• UDM (Rel-15)<br>• TDF (Rel-11)
| Commercial viability | --|
| YAML code available? | YES (for the basic scenario)|
| Validated in lab/productive environments? | YES  (for the basic scenario). On a production network trial |
| Validated with real customers? | NO|
| Validated with operators? | YES, with  TIM|
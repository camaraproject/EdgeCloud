# Discovery UNI API

Thu, Aug 4, 2022 7:26 AM

This Pull Request is to open a debate on whether the UNI interface for Edge Node Discovery should be an API defined in CAMARA or should be defined in 3GPP

## **Current Alternatives**

* UNI APIs that are defined in 3GPP TS 24.558

1. Registration, Authentication and Discovery

• APIs developed and provided by

1. MEC Exposure and Experience Management
2. Simple MEC Discovery

<br>
<br>
[UNI API Analysis](https://github.com/camaraproject/EdgeCloud/blob/main/documentation/Contributions/Images/Discover%20UNI%20API.png)

<br>
## High Level Comparison
<br>
3GPP - Pros:

1. Standardized solution. Easier to have massive availability in OEMs.
2. Includes registration and authentication mechanisms

<br>
3GPP - Cons:

1. How to expose the API internally from the OS to apps, which may lead to delays in terms of availability. Use an SDK or toolkit as alternative.
2. Understand parameters the APIs use to compare with the typical Telco Edge criteria.
3. They do not specify selection logic for Discovery procedures.

<br>
5GFF - Pros:

1. Not clear yet, to check with 5GFF

<br>
5GFF - Cons:

1. It does not define the authentication mechanism against the platform from the device/app.
2. The Simple MEC Discovery API just gives you a list of nodes.
3. Not clear the selection logic.
4. Integration would have to be done at the application level or pushed by Camara to the manufacturers.
5. Non 3GPP Access.

<br>
## Summary
<br>
1. Try to avoid fragmentation within UNI APIs, the scope towards NBI should be limited.
2. Registration, authentication and authorisation mechanisms are required (being covered in 3GPP)
3. It might be posible to expose an Edge Discovery API at the NBI for developer.
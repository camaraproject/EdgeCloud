Feature: CAMARA Traffic Influence API, vWIP - Operation traffic-influeces
  # Input to be provided by the implementation to the tester
  #
  # Implementation indications:
  #
  # Testing assets:
  # * A device object which the optimal routing must be activated
  #
  Background: Common traffic-influences setup
    Given the path "/traffic-influences"
    And the header "Content-Type" is set to "application/json"
    And the header "Authorization" is set to a valid access token
    And the header "x-correlator" is set to a UUID value
    And the request body is set by default to a request body compliant with the schema
  
  # Happy path scenarios

  # Mandatory valid paramenters 
  @TI_Resource_LCM_Mandatory_Parameters_Valid
  Scenario: Manage Traffic Influence (TI) Resource with mandatory parameters
    When creating a new TI Resource, with POST, with mandatory parameters ("$.apiConsumerId", "$.applicationId")
    Then it should be created a new TI Resource and the optimal routing will be activated for any user on any location
    And Response Code is 201 
    And response contains the TI Resource with the resource identifier ("$.trafficInfluenceID") valorised with a unique value, the status of the request ("$.state=ordered") and the previously used parameters valorised as in the POST request
    When asking for a previously created TI Resource, with GET, with the parameter "$.trafficInfluenceID" valorised with the reponse of the previous POST
    Then Response code is 200
    And response contains a TI Resource with a potentially updated status ("$.state") reporting the current status of the traffic influece configuration (ordered, created, active, error, deleted)
  	When deleting an existing TI Resource, with DELETE, with the parameter "$.trafficInfluenceID" valorised with the reponse of the previous POST
    Then Response Code is 202 and the response message is Accepted meaning that the resource deletion is accepted and in progress. The satus update can be retrived with the GET method on that TI Resource. The final value of the parameter "state" is "deleted".
	
  # Optional valid paramenters  
  @TI_Resource_LCM_Optional_Parameters_Valid
  Scenario: Manage Traffic Influence (TI) Resource with also optional parameters
    Given the usage of the Traffic Influece API URL
    When creating a new TI Resource, with POST, with mandatory parameters ("$.apiConsumerId", "$.applicationId") and any other optional parameters (e.g. "$.instanceId", "$.zone" etc.)
    Then it should be created a new TI Resource and the optimal routing will be activated according to the optional paramters specified (e.g. only in a specific zone or for a specific user)
    And Response Code is 201 
    And response contains the TI Resource with the resource identifier ("$.trafficInfluenceID"), the status of the request ("$.state=ordered") and the previously used parameters valorised as in the POST request
    When asking for a previously created TI Resource, with GET, with the parameter "$.trafficInfluenceID" valorised with the reponse of the previous POST
    Then Response code is 200
    And response contains a TI Resource with the a potentially updated status ("$.state") reporting the current status of the traffic influece configuration (ordered, created, active, error, deleted)
    When updating an existing TI Resource, with, PATCH, with the parameter "$.trafficInfluenceID" valorised with the reponse of the previous POST and with some of the optional parameters updated (the madatory parameters can not be updated) and, potentially, some of the optional parameters still having the same value as before
    Then the TI Resource is modified
    And Response Code is 200
    And response contains the TI Resource with the resource identifier ("$.trafficInfluenceID"), the status of the request ("$.state=ordered") and the previously used paramters valorised as in the PATCH request
    When deleting an existing TI Resource, with DELETE, with the parameter "$.trafficInfluenceID" valorised with the reponse of the previous POST
    Then Response Code is 202 and the responce message is Accepted meaning that the resource deletion is accepted and in progress. The satus update can be retrived with the GET method on that TI Resource. The final value of the parameter "$.state" is "deleted".

  # Invalid paramenters  	
  @TI_Resource_LCM_Invalid_Parameters
  Scenario: Manage Traffic Influence Resource with invalid paramters
    Given the usage of the Traffic Influence API URL
    When creating a new TI Resource, with POST, with invalid parameters (mandatory or optionals)
    Then no new TI Resource is created and no optimal routing will be activated
    And Response Code is 400 
    When asking for a previously created TI Resource, with GET, with an invalid parameter "$.trafficInfluenceID"
    Then Response code is 404
    When updating an existing TI Resource, with, PATCH, with invalid an invalid parameter "$.trafficInfluenceID"
    Then Response Code is 404
    When updating an existing TI Resource, with, PATCH, with invalid parameters (with the exclusion of "$.trafficInfluenceID")
    Then Response Code is 400
    When deleting an existing TI Resource, with DELETE, with an invalid parameter "$.trafficInfluenceID"
    Then Response Code is 400 
	
  # Mandatory paramenter are valid but not all provided
  @TI_Incomplete_Parameters_TI_Creation
  Scenario: Creation of new TI Resource without all the mandatory parameters
    Given the usage of the Traffic Influece API URL
    When creating a new TI Resource, with POST, without all the mandatory parameters ("$.apiConsumerId", "$.applicationId")
    Then no new TI Resource is created and no optimal routing will be activated
    And Response Code is 400  
	
  # User Mobility
  @TI_Resource_LCM_Modify_Resource_User_Mobility
  Scenario: Modify an already created Traffic Influence (TI) Resource when a Device moves to another geographical area
    Given the usage of the Traffic Influece API URL
    When modifiyng a existing TI Resource, with PATCH, with mandatory parameters ("$.apiConsumerId", "$.applicationId"), with the identifier for the existing resource ("$.trafficInfluenceID") and other optional, editable, parameters (e.g. "$.instanceId", "$.zone" etc.) to identify a new Edge Application instance closer to the Device that has moved in a new geographical area. 
    Then it should be modified the TI Resource and the new optimal routing will be activated according to the optional paramters specified (e.g. in a new zone)
    And Response Code is 201 
    And response contains the original TI Resource with the resource identifier ("$.trafficInfluenceID") unmodified, the status of the request ("$.state=ordered"), the new parameters valorised as in the PATCH request and the other original paramenters unmodified.

  # Error path scenarios
  TBD

   


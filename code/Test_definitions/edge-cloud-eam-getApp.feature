Feature: CAMARA Edge Application Management API, vwip - Operation getApp
  # Input to be provided by the implementation to the tester
  #
  # Implementation indications:
  # * apiRoot: API root of the server URL
  #
  # Testing assets:
  # * An appId of a submitted application and the values used in the submitApp operation.
  #

  # References to OAS spec schemas refer to schemas specified in edge-application-management.yaml

  Background: Common getApp setup
    Given an environment at "apiRoot"
    And the resource "/edge-application-management/vwip/apps/{appId}"
    And the header "Content-Type" is set to "application/json"
    And the header "Authorization" is set to a valid access token
    And the header "x-correlator" complies with the schema at "#/components/schemas/XCorrelator"


  # Success scenarios

  @EdgeCloud_EAM_getApp_01_generic_success_scenario
  Scenario: Get information of an existing application
    Given there is an application submitted by operation submitApp
    And the path parameter "$.appId" is set to a valid application ID
    When the request "getApp" is sent
    Then response code is 200
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body complies with the OAS schema at "/components/schemas/AppManifest"
    And the response property "$name" has the value provided for submitApp
    And the response property "$appProvider" has the value provided for submitApp
    And the response property "$version" has the value provided for submitApp
    And the response property "$packageType" has the value provided for submitApp
    And the response property "$appRepo" has the value provided for submitApp
    And the response property "$requiredResources" has the value provided for submitApp
    And the response property "$componentSpec" has the value provided for submitApp
    And the response property "$operatingSystem" exists only if provided for submitApp and with the same value


  # Errors

  # Error 404

  @EdgeCloud_EAM_getApp_404.1_app_not_found
  Scenario: appId of a non-existing application
    Given the path parameter "appId" is set to a random UUID
    When the request "getApp" is sent
    Then response code is 404
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response header "Content-Type" is "application/json"
    And the response property "$.status" is 404
    And the response property "$.code" is "NOT_FOUND"
    And the response property "$.message" contains a user friendly text

  # Errors 403

  @EdgeCloud_eam_getApp_403.1_missing_access_token_scope
  Scenario: Missing access token scope
    Given the header "Authorization" is set to an access token that does not include the required scope
    When the request "getApp" is sent
    Then the response status code is 403
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response header "Content-Type" is "application/json"
    And the response property "$.status" is 403
    And the response property "$.code" is "PERMISSION_DENIED"
    And the response property "$.message" contains a user friendly text
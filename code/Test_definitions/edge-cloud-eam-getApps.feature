Feature: CAMARA Edge Application Management API, vwip - Operations getApps
  # Input to be provided by the implementation to the tester
  #
  # Implementation indications:
  # * apiRoot: API root of the server URL
  #
  # Testing assets:
  # * Several Apps submitted in the edge cloud.
  #

  # References to OAS spec schemas refer to schemas specified in edge-application-management.yaml

  Background: Common getApps setup
    Given an environment at "apiRoot"
    And the resource "/edge-application-management/vwip/apps"
    And the header "Content-Type" is set to "application/json"
    And the header "Authorization" is set to a valid access token
    And the header "x-correlator" complies with the schema at "#/components/schemas/XCorrelator"
    

  # Success scenarios

  @EdgeCloud_EAM_getApps_01_generic_success_scenario
    Scenario: Get information of all existing applications
        Given there are applications submitted by operation submitApp
        When the request "getApps" is sent
        Then response code is 200
        And the response header "Content-Type" is "application/json"
        And the response header "x-correlator" has same value as the request header "x-correlator"
        And A list of applications with information of them is returned
        And the response body complies with the OAS schema at "/components/schemas/AppManifest"

  
  # Errors

  # Error 404

  @EdgeCloud_EAM_getApps_404.1_apps_not_found
    Scenario: Get a list of application that the user has permission to view
        Given there are not any application submitted by operation submitApp
        When the request "getApps" is sent
        Then response code is 404
        And the response header "x-correlator" has same value as the request header "x-correlator"
        And the response header "Content-Type" is "application/json"
        And the response property "$.status" is 404
        And the response property "$.code" is "NOT_FOUND"
        And the response property "$.message" contains a user friendly text

  # Errors 403

    @EdgeCloud_eam_getApps_403.1_missing_access_token_scope
    Scenario: Missing access token scope
        Given the header "Authorization" is set to an access token that does not include the required scope
        When the request "getApps" is sent
        Then the response status code is 403
        And the response header "x-correlator" has same value as the request header "x-correlator"
        And the response header "Content-Type" is "application/json"
        And the response property "$.status" is 403
        And the response property "$.code" is "PERMISSION_DENIED"
        And the response property "$.message" contains a user friendly text


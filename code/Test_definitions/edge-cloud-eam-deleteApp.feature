Feature: CAMARA Edge Application Management API, vwip - Operation deleteApp
    # Input to be provided by the implementation to the tester
    #
    # Implementation indications:
    # * apiRoot: API root of the server URL
    #
    # Testing assets:
    # * An appId of a submitted application and the values used in the submitApp operation.
    #

    # References to OAS spec schemas refer to schemas specified in edge-application-management.yaml

    Background: Common deleteApp setup
        Given an environment at "apiRoot"
        And the resource "/edge-application-management/vwip/apps/{appId}"
        And the header "Content-Type" is set to "application/json"
        And the header "Authorization" is set to a valid access token
        And the header "x-correlator" complies with the schema at "#/components/schemas/XCorrelator"


    # Success scenarios

    @EdgeCloud_EAM_deleteApp_01_generic_success_scenario
    Scenario: Delete all the information and content related to an Application with mandatory parameter ("appId")
        Given there are no running instances of the app
        And the path parameter "$.appId" is set to a valid application ID
        When the request "deleteApp" is sent
        Then response code is 202
        And the response header "Content-Type" is "application/json"
        And the response header "x-correlator" has same value as the request header "x-correlator"
        And the application information is deleted


    # Errors
    # Error 409
    @EdgeCloud_EAM_deleteApp_409.1_conflict
    Scenario: Error response for deleting an application with a running instance
        Given there is at least one running instance of the app
        And the path parameter "$.appId" is set to a valid application ID
        When the request "deleteApp" is sent
        Then response code is 409
        And the response header "x-correlator" has same value as the request header "x-correlator"
        And the response header "Content-Type" is "application/json"
        And the response property "$.status" is 409
        And the response property "$.code" is "CONFLICT"
        And the response property "$.message" contains a user friendly text
    
    # Error 404
    @EdgeCloud_EAM_deleteApp_404.1_invalid_parameter
    Scenario: Error response for deleting a non-existing app
        Given there are running instances of the app
        And the path parameter "$.appId" is set to an invalid application ID
        When the request "deleteApp" is sent
        Then response code is 404
        And the response header "x-correlator" has same value as the request header "x-correlator"
        And the response header "Content-Type" is "application/json"
        And the response property "$.status" is 404
        And the response property "$.code" is "NOT_FOUND"
        And the response property "$.message" contains a user friendly text

    # Errors 403
    @EdgeCloud_eam_deleteApp_403.1_missing_access_token_scope
    Scenario: Missing access token scope
        Given the header "Authorization" is set to an access token that does not include the required scope
        When the request "deleteApp" is sent
        Then the response status code is 403
        And the response header "x-correlator" has same value as the request header "x-correlator"
        And the response header "Content-Type" is "application/json"
        And the response property "$.status" is 403
        And the response property "$.code" is "PERMISSION_DENIED"
        And the response property "$.message" contains a user friendly text
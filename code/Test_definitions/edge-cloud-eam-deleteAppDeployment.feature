Feature: CAMARA Edge Application Management API, vwip - Operation deleteAppDeployment
    # Input to be provided by the implementation to the tester
    #
    # Implementation indications:
    # * apiRoot: API root of the server URL
    #
    # Testing assets:
    # * An appId of a submitted application and the values used in the submitApp operation.
    # * A deployment instantiated by createAppDeployment operation.
    #

    # References to OAS spec schemas refer to schemas specified in edge-application-management.yaml

    Background: Common deleteAppDeployment setup
        Given an environment at "apiRoot"
        And the resource "/edge-application-management/vwip/deployment/{appDeploymentId}"
        And the header "Content-Type" is set to "application/json"
        And the header "Authorization" is set to a valid access token
        And the header "x-correlator" complies with the schema at "#/components/schemas/XCorrelator"


    # Success scenarios

    @EdgeCloud_EAM_deleteAppDeployment_01_generic_success_scenario_async
    Scenario: Delete a running instance of an application within an Edge Cloud Zone with mandatory parameter ("appDeploymentId")
        Given there are application instances running
        And the request path parameter "$.appDeploymentIdd" is set to a valid application ID
        When the request "deleteApp" is sent
        Then response code is 202
        And the response header "Content-Type" is "application/json"
        And the response header "x-correlator" has same value as the request header "x-correlator"
        And the application instance termination initiated

    # Errors

    # Error 404

    @EdgeCloud_EAM_deleteAppDeployment_404.1_invalid_parameter
    Scenario: Delete a running instance of an application within an Edge Cloud Zone with mandatory, and non-existing, parameter ("appDeploymentId")
        Given there are application instances running
        And the path parameter "$.appDeploymentId" is set to an invalid application instance ID
        When the request "deleteAppDeployment" is sent
        Then response code is 404
        And the response header "x-correlator" has same value as the request header "x-correlator"
        And the response header "Content-Type" is "application/json"
        And the response property "$.status" is 404
        And the response property "$.code" is "NOT_FOUND"
        And the response property "$.message" contains a user friendly text

    # Error 403
    @EdgeCloud_eam_deleteAppDeployment_403.1_missing_access_token_scope
    Scenario: Missing access token scope
        Given the header "Authorization" is set to an access token that does not include the required scope
        When the request "deleteAppDeployment" is sent
        Then the response status code is 403
        And the response header "x-correlator" has same value as the request header "x-correlator"
        And the response header "Content-Type" is "application/json"
        And the response property "$.status" is 403
        And the response property "$.code" is "PERMISSION_DENIED"
        And the response property "$.message" contains a user friendly text

    # Error 410
    @EdgeCloud_eam_deleteAppDeployment_410.1_gone
    Scenario: Delete an already removed deployment
        Given the request path parameter "$.appDeploymentId" is set to an already removed Deployment ID
        When the request "deleteAppDeployment" is sent
        Then response code is 410
        And the response header "x-correlator" has same value as the request header "x-correlator"
        And the response header "Content-Type" is "application/json"
        And the response property "$.status" is 410
        And the response property "$.code" is "GONE"
        And the response property "$.message" contains a user friendly text
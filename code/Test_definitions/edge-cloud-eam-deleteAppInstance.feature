Feature: CAMARA Edge Application Management API, vwip - Operation deleteAppInstance
    # Input to be provided by the implementation to the tester
    #
    # Implementation indications:
    # * apiRoot: API root of the server URL
    #
    # Testing assets:
    # * An appId of a submitted application and the values used in the submitApp operation.
    # * An Application instantiated by createAppInstance operation.
    #

    # References to OAS spec schemas refer to schemas specified in edge-application-management.yaml

    Background: Common deleteAppInstance setup
        Given an environment at "apiRoot"
        And the resource "/edge-application-management/vwip/appinstances"
        And the header "Content-Type" is set to "application/json"
        And the header "Authorization" is set to a valid access token
        And the header "x-correlator" complies with the schema at "#/components/schemas/XCorrelator"


    # Success scenarios

    @EdgeCloud_EAM_deleteAppInstance_01_generic_success_scenario_async
    Scenario: Delete a running instance of an application within an Edge Cloud Zone with mandatory parameter ("appInstanceId")
        Given there are application instances running
        And the request path parameter "$.appInstanceId" is set to a valid application ID
        When the request "deleteApp" is sent
        Then response code is 202
        And the response header "Content-Type" is "application/json"
        And the response header "x-correlator" has same value as the request header "x-correlator"
        And the application instance termination initiated

    @EdgeCloud_EAM_deleteAppInstance_02_generic_success_scenario_sync
    Scenario: Delete a running instance of an application within an Edge Cloud Zone with mandatory parameter ("appInstanceId")
        Given there are application instances running
        And the request path parameter "$.appInstanceId" is set to a valid application ID
        When the request "deleteApp" is sent
        Then response code is 204
        And the response header "Content-Type" is "application/json"
        And the response header "x-correlator" has same value as the request header "x-correlator"
        And the application instance is deleted

    # Errors

    # Error 404

    @EdgeCloud_EAM_deleteAppInstance_404.1_invalid_parameter
    Scenario: Delete a running instance of an application within an Edge Cloud Zone with mandatory, and non-existing, parameter ("appInstanceId")
        Given there are application instances running
        And the path parameter "$.appInstanceId" is set to an invalid application instance ID
        When the request "deleteAppInstance" is sent
        Then response code is 404
        And the response header "x-correlator" has same value as the request header "x-correlator"
        And the response header "Content-Type" is "application/json"
        And the response property "$.status" is 404
        And the response property "$.code" is "NOT_FOUND"
        And the response property "$.message" contains a user friendly text

    # Error 403
    @EdgeCloud_eam_deleteAppInstance_403.1_missing_access_token_scope
    Scenario: Missing access token scope
        Given the header "Authorization" is set to an access token that does not include the required scope
        When the request "deleteAppInstance" is sent
        Then the response status code is 403
        And the response header "x-correlator" has same value as the request header "x-correlator"
        And the response header "Content-Type" is "application/json"
        And the response property "$.status" is 403
        And the response property "$.code" is "PERMISSION_DENIED"
        And the response property "$.message" contains a user friendly text
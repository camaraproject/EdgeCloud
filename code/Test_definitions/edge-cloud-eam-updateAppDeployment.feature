Feature: CAMARA Edge Application Management API, vwip - Operation updateAppDeployment
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

    Background: Common updateAppDeployment setup
        Given an environment at "apiRoot"
        And the resource "/edge-application-management/vwip/deployment/{appDeploymentId}"
        And the header "Content-Type" is set to "application/json"
        And the header "Authorization" is set to a valid access token
        And the header "x-correlator" complies with the schema at "#/components/schemas/XCorrelator"
        # Properties not explicitly overwritten in the Scenarios can take any values compliant with the schema
        And the request body is set by default to a request body compliant with the schema at "/components/schemas/AppDeploymentManifest"


    # Success scenarios

    @EdgeCloud_EAM_updateAppDeployment_01_generic_success_scenario
    Scenario: Update a running instance of an application within an Edge Cloud Zone with mandatory parameter ("appDeploymentId")
        Given there are application instances running
        And the request path parameter "$.appDeploymentIdd" is set to a valid application ID
        And the body property "$.appDeploymentName" is set to a valid name
        When the request "deleteApp" is sent
        Then response code is 200
        And the response header "Content-Type" is "application/json"
        And the response header "x-correlator" has same value as the request header "x-correlator"
        And the response body complies with the OAS schema at "/components/schemas/AppInstanceInfo"

    # Errors

    # Error 404

    @EdgeCloud_EAM_updateAppDeployment_404.1_invalid_parameter
    Scenario: Update a running instance of an application within an Edge Cloud Zone with mandatory, and non-existing, parameter ("appDeploymentId")
        Given there are application instances running
        And the path parameter "$.appDeploymentId" is set to an invalid application instance ID
        When the request "updateAppDeployment" is sent
        Then response code is 404
        And the response header "x-correlator" has same value as the request header "x-correlator"
        And the response header "Content-Type" is "application/json"
        And the response property "$.status" is 404
        And the response property "$.code" is "NOT_FOUND"
        And the response property "$.message" contains a user friendly text

    # Error 403
    @EdgeCloud_eam_updateAppDeployment_403.1_missing_access_token_scope
    Scenario: Missing access token scope
        Given the header "Authorization" is set to an access token that does not include the required scope
        When the request "updateAppDeployment" is sent
        Then the response status code is 403
        And the response header "x-correlator" has same value as the request header "x-correlator"
        And the response header "Content-Type" is "application/json"
        And the response property "$.status" is 403
        And the response property "$.code" is "PERMISSION_DENIED"
        And the response property "$.message" contains a user friendly text


    # Error 409, Conflict: What is the required scenario to get this error?

    # Error 410
    @EdgeCloud_eam_updateAppDeployment_410.1_gone
    Scenario: Update an already removed deployment
        Given the request path parameter "$.appDeploymentId" is set to an already removed Deployment ID
        When the request "updateAppDeployment" is sent
        Then response code is 410
        And the response header "x-correlator" has same value as the request header "x-correlator"
        And the response header "Content-Type" is "application/json"
        And the response property "$.status" is 410
        And the response property "$.code" is "GONE"
        And the response property "$.message" contains a user friendly text
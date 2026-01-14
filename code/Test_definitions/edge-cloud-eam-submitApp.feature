Feature: CAMARA Edge Application Management API, vwip - Operation submitApp
    # Input to be provided by the implementation to the tester
    #
    # Implementation indications:
    # * apiRoot: API root of the server URL
    #
    # Testing assets:
    # * An AppManifest object applicable for being submitted and deployed in the edge cloud.
    #

    # References to OAS spec schemas refer to schemas specified in edge-application-management.yaml

    Background: Common submitApp setup
        Given an environment at "apiRoot"
        And the resource "/edge-application-management/vwip/apps"
        And the header "Content-Type" is set to "application/json"
        And the header "Authorization" is set to a valid access token
        And the header "x-correlator" complies with the schema at "#/components/schemas/XCorrelator"
        # Properties not explicitly overwritten in the Scenarios can take any values compliant with the schema
        And the request body is set by default to a request body compliant with the schema at "/components/schemas/AppManifest"

    # Success scenarios

    @edgeCloud_eam_submitApp_01_generic_success_scenario
    Scenario: Common validations for any success scenario. Submit an App with mandatory parameters
        # Valid testing device and default request body compliant with the schema
        Given A valid application to be submitted
        And the request body property "$.name" is set to a valid name
        And the request body property "$.appPorvider" is set to a application provider
        And the request body property "$.version" is set to a valid version
        And the request body property "$.packageType" is set to a valid package type
        And the request body property "$.appRepo" is set to a valid repository
        And the request body property "$.requiredResources" is set to a valid required resources object
        And the request body property "$.componentSpect" is set to a valid object
        When the request "submitApp" is sent
        Then response code is 201
        And the response header "Content-Type" is "application/json"
        And the response header "x-correlator" has the same value as the request header "x-correlator"
        And the response body complies with the OAS schema at "/components/schemas/SubmittedApp"
        And the response property "$.appId" is returned

    # Error scenarios

    # Error 409

    @EdgeCloud_eam_submitApp_409.1_conflict
    Scenario: Error response when an application is already submitted
        Given an AppManifest request body referencing an already submitted application
        And the request body property "$.name" is set to an existing application name
        And the request body property "$.version" is set to the same version of the existing application
        When invoking with the POST method to submit an app with all required parameters
        Then response code is 409
        And the response header "x-correlator" has same value as the request header "x-correlator"
        And the response header "Content-Type" is "application/json"
        And the response property "$.code" is "CONFLICT"
        And the response property "$.message" contains a user friendly text

    # Error 400

    @EdgeCloud_eam_submitApp_400.1_schema_not_compliant
    Scenario: Invalid Argument. Generic Syntax Exception
        Given the request body is set to any value which is not compliant with the schema at "/components/schemas/AppManifest"
        When the request "submitApp" is sent
        Then the response status code is 400
        And the response header "x-correlator" has same value as the request header "x-correlator"
        And the response header "Content-Type" is "application/json"
        And the response property "$.status" is 400
        And the response property "$.code" is "INVALID_ARGUMENT"
        And the response property "$.message" contains a user friendly text

    @EdgeCloud_eam_submitApp_400.2_no_request_body
    Scenario: Missing request body
        Given the request body is not included
        When the request "submitApp" is sent
        Then the response status code is 400
        And the response header "x-correlator" has same value as the request header "x-correlator"
        And the response header "Content-Type" is "application/json"
        And the response property "$.status" is 400
        And the response property "$.code" is "INVALID_ARGUMENT"
        And the response property "$.message" contains a user friendly text

    @EdgeCloud_eam_submitApp_400.3_empty_request_body
    Scenario: Empty object as request body
        Given the request body is set to {}
        When the request "submitApp" is sent
        Then the response status code is 400
        And the response header "x-correlator" has same value as the request header "x-correlator"
        And the response header "Content-Type" is "application/json"
        And the response property "$.status" is 400
        And the response property "$.code" is "INVALID_ARGUMENT"
        And the response property "$.message" contains a user friendly text

    @EdgeCloud_eam_submitApp_400.4_empty_property
    Scenario: Error response for empty property in request body
        Given the request body property "<required_property>" is set to {}
        When the request "submitApp" is sent
        Then the response status code is 400
        And the response header "x-correlator" has same value as the request header "x-correlator"
        And the response header "Content-Type" is "application/json"
        And the response property "$.status" is 400
        And the response property "$.code" is "INVALID_ARGUMENT"
        And the response property "$.message" contains a user friendly text

    # Errors 403

    @EdgeCloud_eam_submitApp_403.1_missing_access_token_scope
    Scenario: Missing access token scope
        Given the header "Authorization" is set to an access token that does not include the required scope
        When the request "submitApp" is sent
        Then the response status code is 403
        And the response header "x-correlator" has same value as the request header "x-correlator"
        And the response header "Content-Type" is "application/json"
        And the response property "$.status" is 403
        And the response property "$.code" is "PERMISSION_DENIED"
        And the response property "$.message" contains a user friendly text






Feature: CAMARA Edge Application Management API, vwip - Operation createAppInstance
    # Input to be provided by the implementation to the tester
    #
    # Implementation indications:
    # * apiRoot: API root of the server URL
    #
    # Testing assets:
    # * An AppId of an application already submited by the operation submitApp
    # * An edgeCloudZoneId available to deploy the application
    #

    # References to OAS spec schemas refer to schemas specified in edge-application-management.yaml

    Background: Common createAppInstance setup
        Given an environment at "apiRoot"
        And the resource "/edge-application-management/vwip/appinstances"
        And the header "Content-Type" is set to "application/json"
        And the header "Authorization" is set to a valid access token
        And the header "x-correlator" complies with the schema at "#/components/schemas/XCorrelator"
        # Properties not explicitly overwritten in the Scenarios can take any values compliant with the schema
        And the request body is set by default to a request body compliant with the schema at "/components/schemas/AppInstanceManifest"

    # Success scenarios

    @EdgeCloud_EAM_createAppInstance_01_generic_success_scenario
    Scenario: Instantiate an Application with just mandatory parameters ("name", "appId" and "edgeCloudZoneId" in body)
        Given an application has already been submitted by operation submitApp
        And the request body property "$.name" is set to a valid name
        And the request body property "$.appId" is set to a valid application ID
        And the request body property "$.edgeCloudZoneId" is set to a valid edge zone id 
        When the request "createApp" is sent
        Then response code is 202
        And the response header "Content-Type" is "application/json"
        And the response header "x-correlator" has the same value as the request header "x-correlator"
        And the response body complies with the OAS schema at "/components/schemas/AppInstanceInfo"
        And the process of instantiating the app starts in all available edge cloud zones in the region provided

    @EdgeCloud_EAM_createAppInstance_02_success_scenario_optional_parameters
    Scenario: Instantiate an Application with mandatory parameters ("name", "appId" and "edgeCloudZoneId" in body) and optional parameter ("KubernetesClusterRef")
        Given an application has already been submitted by operation submitApp
        And the request body property "$.name" is set to a valid name
        And the request body property "$.appId" is set to a valid application ID
        And the request body property "$.edgeCloudZoneId" is set to a valid edge zone id
        And the request body property "$.KubernetesClusterRef" is set to a valid kubernetes cluster
        When the request "createApp" is sent
        Then response code is 202
        And the response header "Content-Type" is "application/json"
        And the response header "x-correlator" has the same value as the request header "x-correlator"
        And the response body complies with the OAS schema at "/components/schemas/AppInstanceInfo"
        And the process of instantiating the app starts only in given region and edge cloud zone


    # Error scenarios

    #Error 409

    @EdgeCloud_EAM_createAppInstance_409.conflict
    Scenario: Instantiate an existing application with mandatory parameters ("name", "appId" and "edgeCloudZoneId" in body)
        Given there are running instances of the app
        And the request body property "$.name" is set to a valid name
        And the request body property "$.appId" is set to a valid application ID
        And the request body property "$.edgeCloudZoneId" is set to a valid edge zone id
        And Application instance with "$.name" and "$.appId" is already running in "$.edgeCloudZoneId"
        When the request "createApp" is sent
        Then response code is 409
        And the response header "Content-Type" is "application/json"
        And the response header "x-correlator" has the same value as the request header "x-correlator"
        And the response property "$.code" is "CONFLICT"
        And the response property "$.message" contains a user friendly text

    # Error 400

    @EdgeCloud_eam_createAppInstance_400.1_schema_not_compliant
    Scenario: Invalid Argument. Generic Syntax Exception
        Given the request body is set to any value which is not compliant with the schema at "/components/schemas/AppInstanceManifest"
        When the request "createAppInstance" is sent
        Then the response status code is 400
        And the response header "x-correlator" has same value as the request header "x-correlator"
        And the response header "Content-Type" is "application/json"
        And the response property "$.status" is 400
        And the response property "$.code" is "INVALID_ARGUMENT"
        And the response property "$.message" contains a user friendly text

    @EdgeCloud_eam_createAppInstance_400.2_no_request_body
    Scenario: Missing request body
        Given the request body is not included
        When the request "createAppInstance" is sent
        Then the response status code is 400
        And the response header "x-correlator" has same value as the request header "x-correlator"
        And the response header "Content-Type" is "application/json"
        And the response property "$.status" is 400
        And the response property "$.code" is "INVALID_ARGUMENT"
        And the response property "$.message" contains a user friendly text

    @EdgeCloud_eam_createAppInstance_400.3_empty_request_body
    Scenario: Empty object as request body
        Given the request body is set to {}
        When the request "createAppInstance" is sent
        Then the response status code is 400
        And the response header "x-correlator" has same value as the request header "x-correlator"
        And the response header "Content-Type" is "application/json"
        And the response property "$.status" is 400
        And the response property "$.code" is "INVALID_ARGUMENT"
        And the response property "$.message" contains a user friendly text

    @EdgeCloud_eam_createAppInstance_400.4_empty_property
    Scenario: Error response for empty property in request body
        Given the request body property "<required_property>" is set to {}
        When the request "createAppInstance" is sent
        Then the response status code is 400
        And the response header "x-correlator" has same value as the request header "x-correlator"
        And the response header "Content-Type" is "application/json"
        And the response property "$.status" is 400
        And the response property "$.code" is "INVALID_ARGUMENT"
        And the response property "$.message" contains a user friendly text

    # Errors 403

    @EdgeCloud_eam_createAppInstance_403.1_missing_access_token_scope
    Scenario: Missing access token scope
        Given the header "Authorization" is set to an access token that does not include the required scope
        When the request "createAppInstance" is sent
        Then the response status code is 403
        And the response header "x-correlator" has same value as the request header "x-correlator"
        And the response header "Content-Type" is "application/json"
        And the response property "$.status" is 403
        And the response property "$.code" is "PERMISSION_DENIED"
        And the response property "$.message" contains a user friendly text
        
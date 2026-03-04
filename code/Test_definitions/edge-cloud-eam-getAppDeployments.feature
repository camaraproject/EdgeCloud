Feature: CAMARA Edge Application Management API, vwip - Operation getAppDeployments
    # Input to be provided by the implementation to the tester
    #
    # Implementation indications:
    # * apiRoot: API root of the server URL
    #
    # Testing assets:
    # * An appId of a submitted application and the values used in the submitApp operation.
    # * A deployment instantiated by createAppDeployment operation

    # References to OAS spec schemas refer to schemas specified in edge-application-management.yaml

    Background: Common getAppDeployments setup
        Given an environment at "apiRoot"
        And the resource "/edge-application-management/vwip/deployments"
        And the header "Content-Type" is set to "application/json"
        And the header "Authorization" is set to a valid access token
        And the header "x-correlator" complies with the schema at "#/components/schemas/XCorrelator"


    # Success scenarios


    @EdgeCloud_EAM_getAppDeployments_01_generic_success_scenario
    Scenario: Get information of all existing application deployments
        Given there are application deployments created by operation createAppInstance
        When the request "getAppDeployments" is sent
        Then response code is 200
        And A list of existing app deployments is returned
        And the response header "Content-Type" is "application/json"
        And the response header "x-correlator" has same value as the request header "x-correlator"
        And the response body complies with the OAS schema at "/components/schemas/AppDeploymentInfo"

    @EdgeCloud_EAM_getAppDeployments_02_success_scenario_filtered_by_appId
    Scenario: Get application deployments info with mandatory parameter ("appId")
        Given there are application deployments created by operation createAppInstance
        And the request path parameter "$.appId" is set to a valid application ID
        When the request "getAppDeployments" is sent
        Then response code is 200
        And the response header "Content-Type" is "application/json"
        And the response header "x-correlator" has same value as the request header "x-correlator"
        And information of all existing app deployments of given app is returned
        And the response body complies with the OAS schema at "/components/schemas/AppDeploymentInfo"

    @EdgeCloud_EAM_getAppDeployments_03_success_scenario_filtered_by_appInstanceId
    Scenario: Get application deployments info with mandatory parameter ("appInstanceId")
        Given there are application deployments created by operation createAppInstance
        And the request path parameter "$.appInstanceId" is set to a valid application ID
        When the request "getAppDeployments" is sent
        Then response code is 200
        And the response header "Content-Type" is "application/json"
        And the response header "x-correlator" has same value as the request header "x-correlator"
        And information of all existing app deployments of given app is returned
        And the response body complies with the OAS schema at "/components/schemas/AppDeploymentInfo"
        And the response property "$name" has the value provided for createAppInstance
        And the response property "$appId" has the value provided for createAppInstance
        And the response property "$appInstanceId" has the value provided for createAppInstance and used as path parameter
        And the response property "$appProvider" has the value provided for createAppInstance
        And the response property "$edgeCloudZoneId" has the value provided for createAppInstance



    # Errors

    # Error 404

    @EdgeCloud_EAM_getAppDeployments_404.1_not_found_filtered_by_appInstanceId
    Scenario: Get a list of application deployments info with a non-existing appInstanceId
        Given there are running deployments of the app
        And the path parameter "$.appInstanceId" is set to an invalid application instance ID
        When the request "getAppDeployments" is sent
        Then response code is 404
        And the response header "Content-Type" is "application/json"
        And the response header "x-correlator" has same value as the request header "x-correlator"
        And the response property "$.status" is 404
        And the response property "$.code" is "NOT_FOUND"
        And the response property "$.message" contains a user friendly text

    @EdgeCloud_EAM_getAppDeployments_404.2_not_found_filtered_by_appId
    Scenario: Get a list of application deployments info with a non-existing appId
        Given the path parameter "appId" is set to a random UUID
        When the request "getAppDeployments" is sent
        Then response code is "404"
        And the response header "Content-Type" is "application/json"
        And the response header "x-correlator" has same value as the request header "x-correlator"
        And the response property "$.status" is 404
        And the response property "$.code" is "NOT_FOUND"
        And the response property "$.message" contains a user friendly text

    # Error 403

    @EdgeCloud_eam_getAppDeployments_403.1_missing_access_token_scope
    Scenario: Missing access token scope
        Given the header "Authorization" is set to an access token that does not include the required scope
        When the request "getAppDeployments" is sent
        Then the response status code is 403
        And the response header "x-correlator" has same value as the request header "x-correlator"
        And the response header "Content-Type" is "application/json"
        And the response property "$.status" is 403
        And the response property "$.code" is "PERMISSION_DENIED"
        And the response property "$.message" contains a user friendly text

    # Error 410

    @EdgeCloud_eam_getAppDeployments_410.1_gone
    Scenario: Get information of a removed app deployment
        Given app instance with "$.appDeploymentId" was removed by removeAppDeployment operation
        And the request path parameter "$.appDeploymentId" is set to an already removed removeAppDeployment Id
        When the request "getAppDeployments" is sent
        Then response code is 410
        And the response header "x-correlator" has same value as the request header "x-correlator"
        And the response header "Content-Type" is "application/json"
        And the response property "$.status" is 410
        And the response property "$.code" is "GONE"
        And the response property "$.message" contains a user friendly text

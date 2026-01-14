Feature: CAMARA Edge Application Management API, vwip - Operation getEdgeCloudZones
    # Input to be provided by the implementation to the tester
    #
    # Implementation indications:
    # * apiRoot: API root of the server URL
    #
    # Testing assets:
    # * An available edge Cloud Zones to get information
    #

    # References to OAS spec schemas refer to schemas specified in edge-application-management.yaml


    Background: Common getEdgeCloudZones setup
        Given an environment at "apiRoot"
        And the resource "/edge-application-management/vwip/edge-cloud-zones"
        And the header "Content-Type" is set to "application/json"
        And the header "Authorization" is set to a valid access token
        And the header "x-correlator" complies with the schema at "#/components/schemas/XCorrelator"
        
    
    # Success scenarios

    #/edge-cloud-zones	GET 200
    @EdgeCloud_EAM_getEdgeCloudZone_01_generic_success_scenario
    Scenario: Get information of existing edge cloud zones
        Given There are at least one Edge Cloud Zones available
        When the request "getEdgeCloudZone" is sent
        Then response code is 200
        And the response header "Content-Type" is "application/json"
        And the response header "x-correlator" has same value as the request header "x-correlator"
        And A list of Edge Cloud Zones is returned
        And the response body complies with the OAS schema at "/components/schemas/EdgeCloudZones"

    #/edge-cloud-zones	GET	200	filtered by region
    @EdgeCloud_EAM_getEdgeCloudZone_02_generic_success_scenario_filtered_by_region
    Scenario: Get information of existing Edge Cloud Zones with optional parameters ("region")
        Given There are at least one Edge Cloud Zones available
        And the path parameter "$.region" is set to a valid region
        When When the request "getEdgeCloudZone" is sent
        Then response code is 200
        And the response header "Content-Type" is "application/json"
        And the response header "x-correlator" has same value as the request header "x-correlator"
        And information of Edge Cloud Zones of "$.region" is returned
        And the response body complies with the OAS schema at "/components/schemas/EdgeCloudZones"

    #/edge-cloud-zones	GET	200	filtered by status
    @EdgeCloud_EAM_getEdgeCloudZone_03_generic_success_scenario_filtered_by_status
    Scenario: Get information of existing Edge Cloud Zones with optional parameters ("status")
        Given There are at least one Edge Cloud Zones available
        And the path parameter "$.status" is set to a valid status
        When When the request "getEdgeCloudZone" is sent
        Then response code is 200
        And the response header "Content-Type" is "application/json"
        And the response header "x-correlator" has same value as the request header "x-correlator"
        And information of Edge Cloud Zones of "$.status" is returned
        And the response body complies with the OAS schema at "/components/schemas/EdgeCloudZones"


    #Errors

    #/edge-cloud-zones	GET	404
    @EdgeCloud_EAM_getEdgeCloudZone_404.1_not_found
    Scenario: Get information of existing Edge Cloud Zones with optional parameters ("region")
        Given the path parameter "$.region" is set to an invalid region
        When When the request "getEdgeCloudZone" is sent
        Then response code is 404 
        And the response header "x-correlator" has same value as the request header "x-correlator"
        And the response header "Content-Type" is "application/json"
        And the response property "$.status" is 404
        And the response property "$.code" is "NOT_FOUND"
        And the response property "$.message" contains a user friendly text

  # Errors 403

  @EdgeCloud_EAM_getEdgeCloudZone_403.1_missing_access_token_scope
  Scenario: Missing access token scope
        Given the header "Authorization" is set to an access token that does not include the required scope
        When When the request "getEdgeCloudZone" is sent
        Then the response status code is 403
        And the response header "x-correlator" has same value as the request header "x-correlator"
        And the response header "Content-Type" is "application/json"
        And the response property "$.status" is 403
        And the response property "$.code" is "PERMISSION_DENIED"
        And the response property "$.message" contains a user friendly text
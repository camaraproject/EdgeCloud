Feature: CAMARA Application Endpoints Registration API - v0.1 - Operations registerApplicationEndpoints, getAllRegisteredApplicationEndpoints, getApplicationEndpointsById, updateApplicationEndpoint, deregisterApplicationEndpoint

# Input to be provided by the implementation to the tester
#
# Implementation indications:
# * apiRoot: API root of the server URL
# * Valid application profile IDs for testing
# * Valid edge cloud zone information (IDs, names, providers, regions)
# * Test credentials with appropriate OpenID Connect scopes
# * Valid endpoint configurations for testing
#
# Testing assets:
# * ApplicationEndpointInfo objects with valid required fields
# * Valid applicationEndpointsId values from previous registrations
# * Invalid test data for validation scenarios
#
# References to OAS spec schemas refer to schemas specified in application-endpoint-registration.yaml

Background: Common application endpoint registration setup
    Given an environment at "apiRoot" 
    And the header "Content-Type" is set to "application/json"
    And the header "Authorization" is set to a valid access token

# =============================================================================
# Happy Path Scenarios
# =============================================================================

@app_endpoint_registration_01_register_endpoint_ipv4
Scenario: Successfully register application endpoint with IPv4 address
    Given the path "/application-endpoints"
    And the header "x-correlator" complies with the schema at "#/components/parameters/x-correlator"
    And the request body is an array containing one ApplicationEndpointInfo with:
      | applicationEndpoint.fqdn | app.example.com |
      | applicationEndpoint.ipv4Address | 203.0.113.10 |
      | applicationEndpoint.port | 8080 |
      | applicationServerProviderName | ExampleProvider |
      | applicationProfileId | valid-app-profile-id |
      | edgeCloudZoneId | valid-edge-zone-uuid |
      | edgeCloudZoneName | zone-name-1 |
      | edgeCloudProvider | CloudProvider1 |
      | edgeCloudRegionId | us-west-1 |
    When the request "registerApplicationEndpoints" is sent
    Then the response status code is 200
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" complies with the schema at "#/components/headers/x-correlator"
    And the response header "x-correlator" complies with the schema at "#/components/headers/x-correlator"
    And the response header "x-correlator" complies with the schema at "#/components/headers/x-correlator"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body complies with the OAS schema at "#/components/schemas/ApplicationEndpointsId"
    And the response property is a valid UUID format

@app_endpoint_registration_02_register_endpoint_ipv6
Scenario: Successfully register application endpoint with IPv6 address
    Given the path "/application-endpoints"
    And the header "x-correlator" complies with the schema at "#/components/parameters/x-correlator"
    And the request body is an array containing one ApplicationEndpointInfo with:
      | applicationEndpoint.fqdn | app.example.com |
      | applicationEndpoint.ipv6Address | 2001:db8:85a3:8d3:1319:8a2e:370:7344 |
      | applicationEndpoint.port | 8080 |
      | applicationServerProviderName | ExampleProvider |
      | applicationProfileId | valid-app-profile-id |
      | edgeCloudZoneId | valid-edge-zone-uuid |
      | edgeCloudZoneName | zone-name-1 |
      | edgeCloudProvider | CloudProvider1 |
      | edgeCloudRegionId | us-west-1 |
    When the request "registerApplicationEndpoints" is sent
    Then the response status code is 200
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body complies with the OAS schema at "#/components/schemas/ApplicationEndpointsId"
    And the response property is a valid UUID format

@app_endpoint_registration_03_get_all_endpoints
Scenario: Successfully retrieve all registered application endpoints
    Given the path "/application-endpoints"
    And the header "x-correlator" complies with the schema at "#/components/parameters/x-correlator"
    When the request "getAllRegisteredApplicationEndpoints" is sent
    Then the response status code is 200
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" complies with the schema at "#/components/headers/x-correlator"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body is an array
    And each item in the response array complies with the OAS schema at "#/components/schemas/ApplicationEndpoints"
    And each item contains "applicationEndpointsId" property with valid UUID format

@app_endpoint_registration_04_get_endpoint_by_id
Scenario: Successfully retrieve application endpoint by ID
    Given the path "/application-endpoints/{applicationEndpointsId}"
    And the path parameter "applicationEndpointsId" is set to a valid registered endpoint ID
    And the header "x-correlator" complies with the schema at "#/components/parameters/x-correlator"
    When the request "getApplicationEndpointsById" is sent
    Then the response status code is 200
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" complies with the schema at "#/components/headers/x-correlator"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body complies with the OAS schema at "#/components/schemas/ApplicationEndpoints"
    And the response property "$.applicationEndpointsId" matches the requested ID
    And the response property "$.applicationInstance" is an array

@app_endpoint_registration_05_update_endpoint
Scenario: Successfully update application endpoint information
    Given the path "/application-endpoints/{applicationEndpointsId}"
    And the path parameter "applicationEndpointsId" is set to a valid registered endpoint ID
    And the header "x-correlator" complies with the schema at "#/components/parameters/x-correlator"
    And the request body is an array containing updated ApplicationEndpointInfo
    When the request "updateApplicationEndpoint" is sent
    Then the response status code is 204
    And the response header "x-correlator" complies with the schema at "#/components/headers/x-correlator"
    And the response header "x-correlator" has same value as the request header "x-correlator"

@app_endpoint_registration_06_delete_endpoint
Scenario: Successfully deregister application endpoint
    Given the path "/application-endpoints/{applicationEndpointsId}"
    And the path parameter "applicationEndpointsId" is set to a valid registered endpoint ID
    And the header "x-correlator" complies with the schema at "#/components/parameters/x-correlator"
    When the request "deregisterApplicationEndpoint" is sent
    Then the response status code is 200
    And the response header "x-correlator" complies with the schema at "#/components/headers/x-correlator"
    And the response header "x-correlator" has same value as the request header "x-correlator"

# =============================================================================
# Validation Error Scenarios
# =============================================================================

@app_endpoint_registration_07_register_empty_array
Scenario: Fail to register with empty array (violates minItems constraint)
    Given the path "/application-endpoints"
    And the header "x-correlator" complies with the schema at "#/components/parameters/x-correlator"
    And the request body is an empty array
    When the request "registerApplicationEndpoints" is sent
    Then the response status code is 400
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" complies with the schema at "#/components/headers/x-correlator"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body complies with the OAS schema at "#/components/schemas/ErrorInfo"
    And the response property "$.code" is "INVALID_ARGUMENT"

@app_endpoint_registration_08_register_missing_required_fields
Scenario: Fail to register with missing required applicationEndpoint field
    Given the path "/application-endpoints"
    And the header "x-correlator" complies with the schema at "#/components/parameters/x-correlator"
    And the request body is an array containing ApplicationEndpointInfo missing required field "applicationEndpoint"
    When the request "registerApplicationEndpoints" is sent
    Then the response status code is 400
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" complies with the schema at "#/components/headers/x-correlator"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body complies with the OAS schema at "#/components/schemas/ErrorInfo"
    And the response property "$.code" is "INVALID_ARGUMENT"

@app_endpoint_registration_09_register_invalid_formats
Scenario: Fail to register with invalid UUID and IP address formats
    Given the path "/application-endpoints"
    And the header "x-correlator" complies with the schema at "#/components/parameters/x-correlator"
    And the request body is an array containing ApplicationEndpointInfo with:
      | edgeCloudZoneId | invalid-uuid-format |
      | applicationEndpoint.ipv4Address | 999.999.999.999 |
      | applicationEndpoint.fqdn | app.example.com |
      | applicationEndpoint.port | 8080 |
    When the request "registerApplicationEndpoints" is sent
    Then the response status code is 400
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" complies with the schema at "#/components/headers/x-correlator"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body complies with the OAS schema at "#/components/schemas/ErrorInfo"
    And the response property "$.code" is "INVALID_ARGUMENT"

@app_endpoint_registration_10_register_anyof_constraint_violation
Scenario: Fail to register with ApplicationEndpoint missing required anyOf combinations
    Given the path "/application-endpoints"
    And the header "x-correlator" complies with the schema at "#/components/parameters/x-correlator"
    And the request body is an array containing ApplicationEndpointInfo with applicationEndpoint containing:
      | fqdn | app.example.com |
      | port | 8080 |
    And missing both ipv4Address and ipv6Address required for anyOf constraint
    When the request "registerApplicationEndpoints" is sent
    Then the response status code is 400
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" complies with the schema at "#/components/headers/x-correlator"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body complies with the OAS schema at "#/components/schemas/ErrorInfo"
    And the response property "$.code" is "INVALID_ARGUMENT"

@app_endpoint_registration_11_register_invalid_port_range
Scenario: Fail to register with invalid port number
    Given the path "/application-endpoints"
    And the header "x-correlator" complies with the schema at "#/components/parameters/x-correlator"
    And the request body is an array containing ApplicationEndpointInfo with:
      | applicationEndpoint.fqdn | app.example.com |
      | applicationEndpoint.ipv4Address | 203.0.113.10 |
      | applicationEndpoint.port | -1 |
    When the request "registerApplicationEndpoints" is sent
    Then the response status code is 400
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" complies with the schema at "#/components/headers/x-correlator"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body complies with the OAS schema at "#/components/schemas/ErrorInfo"
    And the response property "$.code" is "INVALID_ARGUMENT"

@app_endpoint_registration_12_register_invalid_uri_format
Scenario: Fail to register with invalid URI format
    Given the path "/application-endpoints"
    And the header "x-correlator" complies with the schema at "#/components/parameters/x-correlator"
    And the request body is an array containing ApplicationEndpointInfo with:
      | applicationEndpoint.fqdn | app.example.com |
      | applicationEndpoint.ipv4Address | 203.0.113.10 |
      | applicationEndpoint.port | 8080 |
      | applicationEndpoint.uri | invalid-uri-format |
    When the request "registerApplicationEndpoints" is sent
    Then the response status code is 400
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body complies with the OAS schema at "#/components/schemas/ErrorInfo"
    And the response property "$.code" is "INVALID_ARGUMENT"

@app_endpoint_registration_13_invalid_id_format
Scenario: Fail to retrieve endpoint with invalid applicationEndpointsId format
    Given the path "/application-endpoints/{applicationEndpointsId}"
    And the path parameter "applicationEndpointsId" is set to "invalid-uuid-format"
    And the header "x-correlator" is set to a valid correlation identifier
    When the request "getApplicationEndpointsById" is sent
    Then the response status code is 400
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body complies with the OAS schema at "#/components/schemas/ErrorInfo"
    And the response property "$.code" is "INVALID_ARGUMENT"

# =============================================================================
# Authentication and Authorization Error Scenarios
# =============================================================================

@app_endpoint_registration_14_no_auth_token
Scenario: Fail to register when no authentication token is provided
    Given the path "/application-endpoints"
    And the header "x-correlator" is set to a valid correlation identifier
    And an API consumer without an authentication token
    And the request body is an array containing valid ApplicationEndpointInfo
    When the request "registerApplicationEndpoints" is sent
    Then the response status code is 401
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body complies with the OAS schema at "#/components/schemas/ErrorInfo"
    And the response property "$.code" is "UNAUTHENTICATED"

@app_endpoint_registration_15_insufficient_scope
Scenario: Fail to register when token lacks required write scope
    Given the path "/application-endpoints"
    And the header "x-correlator" is set to a valid correlation identifier
    And an API consumer with an authentication token missing 'application-endpoint-registration:application-endpoints:write' scope
    And the request body is an array containing valid ApplicationEndpointInfo
    When the request "registerApplicationEndpoints" is sent
    Then the response status code is 403
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body complies with the OAS schema at "#/components/schemas/ErrorInfo"
    And the response property "$.code" is "PERMISSION_DENIED"

@app_endpoint_registration_16_invalid_token_context
Scenario: Fail when application profile in request doesn't match token context
    Given the path "/application-endpoints"
    And the header "x-correlator" is set to a valid correlation identifier
    And an API consumer with a valid token associated with a specific application profile
    And the request body is an array containing ApplicationEndpointInfo with different applicationProfileId than token context
    When the request "registerApplicationEndpoints" is sent
    Then the response status code is 403
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body complies with the OAS schema at "#/components/schemas/ErrorInfo"
    And the response property "$.code" is "INVALID_TOKEN_CONTEXT"

# =============================================================================
# Resource Not Found and Business Logic Errors
# =============================================================================

@app_endpoint_registration_17_endpoint_not_found
Scenario: Fail to retrieve application endpoint with non-existent ID
    Given the path "/application-endpoints/{applicationEndpointsId}"
    And the path parameter "applicationEndpointsId" is set to a valid UUID format but non-existent endpoint ID
    And the header "x-correlator" is set to a valid correlation identifier
    When the request "getApplicationEndpointsById" is sent
    Then the response status code is 404
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body complies with the OAS schema at "#/components/schemas/ErrorInfo"
    And the response property "$.code" is "NOT_FOUND"

@app_endpoint_registration_18_unidentifiable_application_profile
Scenario: Fail when application profile cannot be identified from token context
    Given the path "/application-endpoints"
    And the header "x-correlator" is set to a valid correlation identifier
    And an API consumer with a token that doesn't contain application profile information
    And the request body is an array containing ApplicationEndpointInfo where applicationProfileId cannot be derived from token
    When the request "registerApplicationEndpoints" is sent
    Then the response status code is 422
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body complies with the OAS schema at "#/components/schemas/ErrorInfo"
    And the response property "$.code" is "UNIDENTIFIABLE_APPLICATION_PROFILE"

@app_endpoint_registration_19_service_not_supported
Scenario: Fail when service is not supported for the application profile
    Given the path "/application-endpoints"
    And the header "x-correlator" is set to a valid correlation identifier
    And the request body is an array containing ApplicationEndpointInfo with unsupported applicationProfileId
    When the request "registerApplicationEndpoints" is sent
    Then the response status code is 422
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body complies with the OAS schema at "#/components/schemas/ErrorInfo"
    And the response property "$.code" is "NOT_SUPPORTED"

# =============================================================================
# Edge Case and Integration Scenarios
# =============================================================================

@app_endpoint_registration_20_register_multiple_endpoints
Scenario: Successfully register multiple application endpoints in one request
    Given the path "/application-endpoints"
    And the header "x-correlator" is set to a valid correlation identifier
    And the request body is an array containing multiple valid ApplicationEndpointInfo objects
    When the request "registerApplicationEndpoints" is sent
    Then the response status code is 200
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body complies with the OAS schema at "#/components/schemas/ApplicationEndpointsId"
    And the response property is a valid UUID format

@app_endpoint_registration_21_complete_crud_flow
Scenario: Complete flow - register, verify, update, and delete endpoints
    Given the path "/application-endpoints"
    And the header "x-correlator" is set to a valid correlation identifier
    And the request body is an array containing valid ApplicationEndpointInfo
    When the request "registerApplicationEndpoints" is sent
    Then the response status code is 200
    And the response property is stored as "createdEndpointId"
    
    When I retrieve the endpoint using the stored ID via "getApplicationEndpointsById"
    Then the response status code is 200
    And the retrieved endpoint matches the originally registered data
    
    When I update the endpoint using the stored ID via "updateApplicationEndpoint"
    Then the response status code is 204
    
    When I delete the endpoint using the stored ID via "deregisterApplicationEndpoint"
    Then the response status code is 200
    
    When I attempt to retrieve the deleted endpoint via "getApplicationEndpointsById"
    Then the response status code is 404
    And the response property "$.code" is "NOT_FOUND"

@app_endpoint_registration_22_register_endpoint_with_optional_fields
Scenario: Successfully register endpoint with all optional fields populated
    Given the path "/application-endpoints"
    And the header "x-correlator" is set to a valid correlation identifier
    And the request body is an array containing ApplicationEndpointInfo with all optional fields:
      | applicationEndpoint.uri | http://app.example.com/api/v1 |
      | applicationDescription | Main API endpoint for application |
    When the request "registerApplicationEndpoints" is sent
    Then the response status code is 200
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body complies with the OAS schema at "#/components/schemas/ApplicationEndpointsId"

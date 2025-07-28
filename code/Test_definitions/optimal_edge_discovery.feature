Feature: CAMARA Optimal Edge Discovery API - vwip - Operations get-regions and get-edgeCloudZone

# Input to be provided by the implementation to the tester
#
# Implementation indications:
# * apiRoot: API root of the server URL
# * List of device identifier types which are supported, among: phoneNumber, ipv4Address, ipv6Address, networkAccessIdentifier
# * List of available edge cloud regions in the network
# * Whether 3-legged tokens are supported for device identification
# * Note: API spec contains inconsistencies:
#   - OAuth scope: "edge:discovery:read" (security) vs "discovery:read" (securitySchemes)
#   - Error codes: INVALID_TOKEN_CONTEXT exists in examples but not in schema enum for 403 responses
#   - Documentation describes header-based device identification but OpenAPI spec only defines request body Device schema
#
# Testing assets:
# * A device object applicable for edge discovery service with valid identifiers
# * Valid application profile IDs for testing
# * Valid edge cloud region names available in the network
# * Test credentials with appropriate OAuth2 scopes
# * Invalid test data for validation scenarios
#
# References to OAS spec schemas refer to schemas specified in optimal-edge-discovery.yaml

Background: Common optimal edge discovery setup
    Given an environment at "apiRoot" 
    And the header "Content-Type" is set to "application/json"
    And the header "Authorization" is set to a valid access token

# =============================================================================
# GET /regions Tests
# =============================================================================

@optimal_edge_discovery_01_get_regions_success
Scenario: Successfully retrieve all available edge cloud regions
    Given the path "/regions"
    And the header "x-correlator" is set to a valid correlation identifier
    When the request "get-regions" is sent
    Then the response status code is 200
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body is an array
    And each item in the response array complies with the OAS schema at "#/components/schemas/EdgeCloudRegions"
    And each region in the response contains "edgeCloudRegion" property

@optimal_edge_discovery_02_get_regions_success_no_correlator
Scenario: Successfully retrieve regions without x-correlator header
    Given the path "/regions"
    When the request "get-regions" is sent
    Then the response status code is 200
    And the response header "Content-Type" is "application/json"
    And the response body is an array
    And each item in the response array complies with the OAS schema at "#/components/schemas/EdgeCloudRegions"

@optimal_edge_discovery_03_get_regions_no_auth
Scenario: Fail to retrieve regions when no authentication token is provided
    Given the path "/regions"
    And the header "x-correlator" is set to a valid correlation identifier
    And an API consumer without an OAuth2 token
    When the request "get-regions" is sent
    Then the response status code is 401
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body complies with the OAS schema at "#/components/schemas/ErrorInfo"
    And the response property "$.code" is "UNAUTHORIZED"


# =============================================================================
# POST /retrieve-optimal-edge-cloud-zones Tests - Happy Path
# =============================================================================

@optimal_edge_discovery_04_get_zones_minimal_params
Scenario: Successfully retrieve optimal edge cloud zones with minimal parameters
    Given the path "/retrieve-optimal-edge-cloud-zones"
    And the header "x-correlator" is set to a valid correlation identifier
    And the request body property "$.applicationProfileId" is set to a valid application profile UUID
    When the request "get-edgeCloudZone" is sent
    Then the response status code is 200
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body is an array
    And each item in the response array complies with the OAS schema at "#/components/schemas/ResourcesEdgeCloudZones"
    And each zone contains "edgeCloudZoneId", "edgeCloudZoneName", and "edgeCloudProvider" properties

@optimal_edge_discovery_05_get_zones_with_device_phone
Scenario: Successfully retrieve optimal edge cloud zones with phone number device identifier
    Given the path "/retrieve-optimal-edge-cloud-zones"
    And the header "x-correlator" is set to a valid correlation identifier
    And the request body property "$.applicationProfileId" is set to a valid application profile UUID
    And the request body property "$.device.device.phoneNumber" is set to a valid phone number in E.164 format
    When the request "get-edgeCloudZone" is sent
    Then the response status code is 200
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body is an array
    And each item in the response array complies with the OAS schema at "#/components/schemas/ResourcesEdgeCloudZones"
    And the response contains optimal edge cloud zones for the specified device

@optimal_edge_discovery_06_get_zones_with_device_ipv4_private
Scenario: Successfully retrieve optimal edge cloud zones with IPv4 device identifier using private address
    Given the path "/retrieve-optimal-edge-cloud-zones"
    And the header "x-correlator" is set to a valid correlation identifier
    And the request body property "$.applicationProfileId" is set to a valid application profile UUID
    And the request body property "$.device.device.ipv4Address.publicAddress" is set to a valid public IPv4 address
    And the request body property "$.device.device.ipv4Address.privateAddress" is set to a valid private IPv4 address
    When the request "get-edgeCloudZone" is sent
    Then the response status code is 200
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body is an array
    And each item in the response array complies with the OAS schema at "#/components/schemas/ResourcesEdgeCloudZones"
    And the response contains optimal edge cloud zones for the specified device location

@optimal_edge_discovery_07_get_zones_with_device_ipv4_port
Scenario: Successfully retrieve optimal edge cloud zones with IPv4 device identifier using port
    Given the path "/retrieve-optimal-edge-cloud-zones"
    And the header "x-correlator" is set to a valid correlation identifier
    And the request body property "$.applicationProfileId" is set to a valid application profile UUID
    And the request body property "$.device.device.ipv4Address.publicAddress" is set to a valid public IPv4 address
    And the request body property "$.device.device.ipv4Address.publicPort" is set to a valid port number
    When the request "get-edgeCloudZone" is sent
    Then the response status code is 200
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body is an array
    And each item in the response array complies with the OAS schema at "#/components/schemas/ResourcesEdgeCloudZones"
    And the response contains optimal edge cloud zones for the specified device location

@optimal_edge_discovery_08_get_zones_with_device_ipv6
Scenario: Successfully retrieve optimal edge cloud zones with IPv6 device identifier
    Given the path "/retrieve-optimal-edge-cloud-zones"
    And the header "x-correlator" is set to a valid correlation identifier
    And the request body property "$.applicationProfileId" is set to a valid application profile UUID
    And the request body property "$.device.device.ipv6Address" is set to a valid IPv6 address
    When the request "get-edgeCloudZone" is sent
    Then the response status code is 200
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body is an array
    And each item in the response array complies with the OAS schema at "#/components/schemas/ResourcesEdgeCloudZones"
    And the response contains optimal edge cloud zones for the specified device location

@optimal_edge_discovery_9_get_zones_with_region_filter
Scenario: Successfully retrieve optimal edge cloud zones with region filter
    Given the path "/retrieve-optimal-edge-cloud-zones"
    And the header "x-correlator" is set to a valid correlation identifier
    And the request body property "$.applicationProfileId" is set to a valid application profile UUID
    And the request body property "$.edgeCloudRegion" is set to a valid edge cloud region name
    And the request body property "$.device.device.phoneNumber" is set to a valid phone number in E.164 format
    When the request "get-edgeCloudZone" is sent
    Then the response status code is 200
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body is an array
    And each item in the response array complies with the OAS schema at "#/components/schemas/ResourcesEdgeCloudZones"
    And all returned zones belong to the specified region

@optimal_edge_discovery_10_get_zones_no_request_body_three_legged
Scenario: Successfully retrieve optimal edge cloud zones with no request body using 3-legged token
    Given the path "/retrieve-optimal-edge-cloud-zones"
    And the header "x-correlator" is set to a valid correlation identifier
    And an API consumer with a valid 3-legged OAuth2 token associated with a device and application profile
    And no request body is provided
    When the request "get-edgeCloudZone" is sent
    Then the response status code is 200
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body is an array
    And each item in the response array complies with the OAS schema at "#/components/schemas/ResourcesEdgeCloudZones"
    And the response contains optimal edge cloud zones for the device and application profile associated with the token

@optimal_edge_discovery_11_get_zones_empty_body_three_legged
Scenario: Successfully retrieve optimal edge cloud zones with empty request body using 3-legged token with context
    Given the path "/retrieve-optimal-edge-cloud-zones"
    And the header "x-correlator" is set to a valid correlation identifier
    And an API consumer with a valid 3-legged OAuth2 token associated with a device and application profile
    And the request body is an empty object
    When the request "get-edgeCloudZone" is sent
    Then the response status code is 200
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body is an array
    And each item in the response array complies with the OAS schema at "#/components/schemas/ResourcesEdgeCloudZones"

# =============================================================================
# POST /retrieve-optimal-edge-cloud-zones Tests - Validation Error Scenarios
# =============================================================================

@optimal_edge_discovery_12_invalid_application_profile_format
Scenario: Fail to retrieve zones with invalid application profile ID format
    Given the path "/retrieve-optimal-edge-cloud-zones"
    And the header "x-correlator" is set to a valid correlation identifier
    And the request body property "$.applicationProfileId" is set to "invalid-uuid-format"
    When the request "get-edgeCloudZone" is sent
    Then the response status code is 400
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body complies with the OAS schema at "#/components/schemas/ErrorInfo"
    And the response property "$.code" is "INVALID_ARGUMENT"

@optimal_edge_discovery_13_invalid_phone_number_format
Scenario: Fail to retrieve zones with invalid phone number format
    Given the path "/retrieve-optimal-edge-cloud-zones"
    And the header "x-correlator" is set to a valid correlation identifier
    And the request body property "$.applicationProfileId" is set to a valid application profile UUID
    And the request body property "$.device.device.phoneNumber" is set to "123456789"
    When the request "get-edgeCloudZone" is sent
    Then the response status code is 400
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body complies with the OAS schema at "#/components/schemas/ErrorInfo"
    And the response property "$.code" is "INVALID_ARGUMENT"

@optimal_edge_discovery_14_invalid_ipv4_format
Scenario: Fail to retrieve zones with invalid IPv4 address format
    Given the path "/retrieve-optimal-edge-cloud-zones"
    And the header "x-correlator" is set to a valid correlation identifier
    And the request body property "$.applicationProfileId" is set to a valid application profile UUID
    And the request body property "$.device.device.ipv4Address.publicAddress" is set to "999.999.999.999"
    And the request body property "$.device.device.ipv4Address.publicPort" is set to 8080
    When the request "get-edgeCloudZone" is sent
    Then the response status code is 400
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body complies with the OAS schema at "#/components/schemas/ErrorInfo"
    And the response property "$.code" is "INVALID_ARGUMENT"

@optimal_edge_discovery_15_invalid_ipv6_format
Scenario: Fail to retrieve zones with invalid IPv6 address format
    Given the path "/retrieve-optimal-edge-cloud-zones"
    And the header "x-correlator" is set to a valid correlation identifier
    And the request body property "$.applicationProfileId" is set to a valid application profile UUID
    And the request body property "$.device.device.ipv6Address" is set to "invalid-ipv6-format"
    When the request "get-edgeCloudZone" is sent
    Then the response status code is 400
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body complies with the OAS schema at "#/components/schemas/ErrorInfo"
    And the response property "$.code" is "INVALID_ARGUMENT"

@optimal_edge_discovery_16_invalid_port_number_negative
Scenario: Fail to retrieve zones with negative port number
    Given the path "/retrieve-optimal-edge-cloud-zones"
    And the header "x-correlator" is set to a valid correlation identifier
    And the request body property "$.applicationProfileId" is set to a valid application profile UUID
    And the request body property "$.device.device.ipv4Address.publicAddress" is set to a valid public IPv4 address
    And the request body property "$.device.device.ipv4Address.publicPort" is set to -1
    When the request "get-edgeCloudZone" is sent
    Then the response status code is 400
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body complies with the OAS schema at "#/components/schemas/ErrorInfo"
    And the response property "$.code" is "INVALID_ARGUMENT"

@optimal_edge_discovery_17_invalid_port_number_too_large
Scenario: Fail to retrieve zones with port number exceeding maximum
    Given the path "/retrieve-optimal-edge-cloud-zones"
    And the header "x-correlator" is set to a valid correlation identifier
    And the request body property "$.applicationProfileId" is set to a valid application profile UUID
    And the request body property "$.device.device.ipv4Address.publicAddress" is set to a valid public IPv4 address
    And the request body property "$.device.device.ipv4Address.publicPort" is set to 65536
    When the request "get-edgeCloudZone" is sent
    Then the response status code is 400
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body complies with the OAS schema at "#/components/schemas/ErrorInfo"
    And the response property "$.code" is "INVALID_ARGUMENT"

@optimal_edge_discovery_18_ipv4_missing_required_fields
Scenario: Fail to retrieve zones with IPv4 address missing both privateAddress and publicPort
    Given the path "/retrieve-optimal-edge-cloud-zones"
    And the header "x-correlator" is set to a valid correlation identifier
    And the request body property "$.applicationProfileId" is set to a valid application profile UUID
    And the request body property "$.device.device.ipv4Address.publicAddress" is set to a valid public IPv4 address
    When the request "get-edgeCloudZone" is sent
    Then the response status code is 400
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body complies with the OAS schema at "#/components/schemas/ErrorInfo"
    And the response property "$.code" is "INVALID_ARGUMENT"

@optimal_edge_discovery_19_network_access_identifier_not_supported
Scenario: Validate that networkAccessIdentifier is rejected per CAMARA v0.4 constraints
    Given the path "/retrieve-optimal-edge-cloud-zones"
    And the header "x-correlator" is set to a valid correlation identifier
    And the request body property "$.applicationProfileId" is set to a valid application profile UUID
    And the request body property "$.device.device.networkAccessIdentifier" is set to "user@domain.com"
    When the request "get-edgeCloudZone" is sent
    Then the response status code is 400
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body complies with the OAS schema at "#/components/schemas/ErrorInfo"
    And the response property "$.code" is "INVALID_ARGUMENT"

@optimal_edge_discovery_20_empty_device_object
Scenario: Fail to retrieve zones with empty device object
    Given the path "/retrieve-optimal-edge-cloud-zones"
    And the header "x-correlator" is set to a valid correlation identifier
    And the request body property "$.applicationProfileId" is set to a valid application profile UUID
    And the request body property "$.device.device" is set to an empty object
    When the request "get-edgeCloudZone" is sent
    Then the response status code is 400
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body complies with the OAS schema at "#/components/schemas/ErrorInfo"
    And the response property "$.code" is "INVALID_ARGUMENT"

@optimal_edge_discovery_21_missing_application_profile_two_legged
Scenario: Fail to retrieve zones when required application profile ID is missing with 2-legged token
    Given the path "/retrieve-optimal-edge-cloud-zones"
    And the header "x-correlator" is set to a valid correlation identifier
    And an API consumer with a valid 2-legged OAuth2 token
    And the request body property "$.device.device.phoneNumber" is set to a valid phone number in E.164 format
    When the request "get-edgeCloudZone" is sent
    Then the response status code is 400
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body complies with the OAS schema at "#/components/schemas/ErrorInfo"
    And the response property "$.code" is "INVALID_ARGUMENT"

@optimal_edge_discovery_22_no_request_body_two_legged
Scenario: Fail to retrieve zones with no request body using 2-legged token
    Given the path "/retrieve-optimal-edge-cloud-zones"
    And the header "x-correlator" is set to a valid correlation identifier
    And an API consumer with a valid 2-legged OAuth2 token
    And no request body is provided
    When the request "get-edgeCloudZone" is sent
    Then the response status code is 400
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body complies with the OAS schema at "#/components/schemas/ErrorInfo"
    And the response property "$.code" is "INVALID_ARGUMENT"

@optimal_edge_discovery_23_invalid_region_name
Scenario: Handle request with invalid edge cloud region name
    Given the path "/retrieve-optimal-edge-cloud-zones"
    And the header "x-correlator" is set to a valid correlation identifier
    And the request body property "$.applicationProfileId" is set to a valid application profile UUID
    And the request body property "$.edgeCloudRegion" is set to "non-existent-region"
    And the request body property "$.device.device.phoneNumber" is set to a valid phone number in E.164 format
    When the request "get-edgeCloudZone" is sent
    Then the response status code is 404
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body complies with the OAS schema at "#/components/schemas/ErrorInfo"
    And the response property "$.code" is "NOT_FOUND"

# =============================================================================
# Authentication and Authorization Error Scenarios
# =============================================================================

@optimal_edge_discovery_24_no_auth_token
Scenario: Fail to retrieve zones when no authentication token is provided
    Given the path "/retrieve-optimal-edge-cloud-zones"
    And the header "x-correlator" is set to a valid correlation identifier
    And an API consumer without an OAuth2 token
    And the request body property "$.applicationProfileId" is set to a valid application profile UUID
    When the request "get-edgeCloudZone" is sent
    Then the response status code is 401
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body complies with the OAS schema at "#/components/schemas/ErrorInfo"
    And the response property "$.code" is "UNAUTHORIZED"

@optimal_edge_discovery_25_insufficient_permissions
Scenario: Fail to retrieve zones when token lacks required scope
    Given the path "/retrieve-optimal-edge-cloud-zones"
    And the header "x-correlator" is set to a valid correlation identifier
    And an API consumer with an OAuth2 token missing 'edge:discovery:read' scope
    And the request body property "$.applicationProfileId" is set to a valid application profile UUID
    When the request "get-edgeCloudZone" is sent
    Then the response status code is 403
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body complies with the OAS schema at "#/components/schemas/ErrorInfo"
    And the response property "$.code" is "PERMISSION_DENIED"

@optimal_edge_discovery_26_device_token_mismatch
Scenario: Fail to retrieve zones when device in request doesn't match token context
    Given the path "/retrieve-optimal-edge-cloud-zones"
    And the header "x-correlator" is set to a valid correlation identifier
    And an API consumer with a valid 3-legged OAuth2 token associated with a specific device
    And the request body property "$.applicationProfileId" is set to a valid application profile UUID
    And the request body property "$.device.device.phoneNumber" is set to a phone number different from the token's associated device
    When the request "get-edgeCloudZone" is sent
    Then the response status code is 403
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body complies with the OAS schema at "#/components/schemas/ErrorInfo"
    And the response property "$.code" is "PERMISSION_DENIED"

@optimal_edge_discovery_27_application_profile_not_found
Scenario: Fail to retrieve zones when application profile ID is not found
    Given the path "/retrieve-optimal-edge-cloud-zones"
    And the header "x-correlator" is set to a valid correlation identifier
    And the request body property "$.applicationProfileId" is set to a valid UUID format but non-existent application profile
    When the request "get-edgeCloudZone" is sent
    Then the response status code is 404
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body complies with the OAS schema at "#/components/schemas/ErrorInfo"
    And the response property "$.code" is "NOT_FOUND"

@optimal_edge_discovery_28_device_identifiers_mismatch
Scenario: Fail to retrieve zones when multiple device identifiers belong to different devices
    Given the path "/retrieve-optimal-edge-cloud-zones"
    And the header "x-correlator" is set to a valid correlation identifier
    And the request body property "$.applicationProfileId" is set to a valid application profile UUID
    And the request body property "$.device.device.phoneNumber" is set to a valid phone number for device A
    And the request body property "$.device.device.ipv4Address.publicAddress" is set to a valid IPv4 address for device B
    And the request body property "$.device.device.ipv4Address.publicPort" is set to a valid port for device B
    When the request "get-edgeCloudZone" is sent
    Then the response status code is 422
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body complies with the OAS schema at "#/components/schemas/ErrorInfo"
    And the response property "$.code" is "DEVICE_IDENTIFIERS_MISMATCH"


@optimal_edge_discovery_29_not_acceptable_media_type
Scenario: Fail to retrieve zones when requested media type is not acceptable
    Given the path "/retrieve-optimal-edge-cloud-zones"
    And the header "x-correlator" is set to a valid correlation identifier
    And the header "Accept" is set to "application/xml"
    And the request body property "$.applicationProfileId" is set to a valid application profile UUID
    When the request "get-edgeCloudZone" is sent
    Then the response status code is 406
    And the response header "Content-Type" is "application/json"
    And the response header "x-correlator" has same value as the request header "x-correlator"
    And the response body complies with the OAS schema at "#/components/schemas/ErrorInfo"
    And the response property "$.code" is "NOT_ACCEPTABLE"





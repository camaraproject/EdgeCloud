@application_endpoint_discovery
Feature: CAMARA Application Endpoint Discovery API, v0.1.0 - Operation getClosestAppEndpoint
  # Input to be provided by the implementation to the tester
  #
  # Implementation indications:
  # * List of device identifier types which are not supported, among: phoneNumber, networkAccessIdentifier, ipv4Address, ipv6Address
  #
  # Testing assets:
  # * A device object which location is known by the network when connected.
  #
  # References to OAS spec schemas refer to schemas specifies in application-endpoint-discovery.yaml

Background:
  Given an environment at "apiRoot"
  And the resource "/application-endpoint-discovery/vwip/retrieve-closest-app-endpoints"                                                     |
  And the header "Content-Type" is set to "application/json"
  And the header "Authorization" is set to a valid access token
  And the header "x-correlator" is set to a UUID value
  And the request body is set by default to a request body compliant with the schema

#### Happy Path Scenarios #########

@application_endpoint_discovery.01_success_appid
Scenario: Successful retrieval of the closest application endpoint for a given device and application
  Given a valid testing device supported by the service, identified by the token or provided in the request body
  And the testing device is connected to a mobile network
  And the request body is set to a valid request body
  And the request body includes an appId parameter that identifies an application deployed on the platform
  And the application has instances up and running
  When the HTTP POST request "getConnectedNetworkType" is sent
  Then the response code is 200
  And the response header "Content-Type" is "application/json"
  And the response header "x-correlator" has same value as the request header "x-correlator"
  And the response body complies with the OAS schema at "#/components/schemas/EdgeHostedApplicationEndpoints"

@application_endpoint_discovery.02_success_applicationEndpointsId
Scenario: Successful retrieval of the closest application endpoint for a given device and applicationEndpointsId
 Given a valid testing device supported by the service, identified by the token or provided in the request body
  And the testing device is connected to a mobile network
  And the request body is set to a valid request body
  And the request body includes an applicationEndpointsId parameter that identifies an application endpoints ID identifier registered in the platform
  And the application has instances up and running
  When the HTTP POST request "getConnectedNetworkType" is sent
  Then the response code is 200
  And the response header "Content-Type" is "application/json"
  And the response header "x-correlator" has same value as the request header "x-correlator"
  And the response body complies with the OAS schema at "#/components/schemas/EdgeHostedApplicationEndpoints"

#### Error Scenarios      ###########

#################
# Error code 400
#################

@application_endpoint_discovery_400.1_error_device_empty
Scenario: The device value is an empty object
  Given the header "Authorization" is set to a valid access token which does not identify a single device
  And the request body property "$.device" is set to: {}
  When the HTTP "POST" request is sent
  Then the response status code is 400
  And the response property "$.status" is 400
  And the response property "$.code" is "INVALID_ARGUMENT"
  And the response property "$.message" contains a user friendly text

@application_endpoint_discovery_400.2_error_device_identifiers_not_schema_compliant
Scenario Outline: Some device identifier value does not comply with the schema
  Given the header "Authorization" is set to a valid access token which does not identify a single device
  And the request body property "<device_identifier>" does not comply with the OAS schema at "<oas_spec_schema>"
  When the HTTP "POST" request is sent
  Then the response status code is 400
  And the response property "$.status" is 400
  And the response property "$.code" is "INVALID_ARGUMENT"
  And the response property "$.message" contains a user friendly text
       
  Examples:
    | device_identifier          | oas_spec_schema                             |
    | $.device.phoneNumber       | /components/schemas/PhoneNumber             |
    | $.device.ipv4Address       | /components/schemas/DeviceIpv4Addr          |
    | $.device.ipv6Address       | /components/schemas/DeviceIpv6Address       |
    | $.device.networkIdentifier | /components/schemas/NetworkAccessIdentifier |

@application_endpoint_discovery_400.3_error_app_empty
Scenario: The appId and applicationEndpointsId parameters are not included in RequestBody
  Given the header "Authorization" is set to a valid access token which does not identify a single device
  And the request body does not include property "$.appId"
  And the request body does not include property "$.applicationEndpointsId"
  When the HTTP "POST" request is sent
  Then the response status code is 400
  And the response property "$.status" is 400
  And the response property "$.code" is "INVALID_ARGUMENT"
  And the response property "$.message" contains a user friendly text

#################
# Error code 401
#################

@application_endpoint_discovery_401.1_expired_access_token
Scenario: Expired access token
  Given the header "Authorization" is set to an expired access token
  And the request body is set to a valid request body
  When the request "getClosestAppEndpoint" is sent
  Then the response status code is 401
  And the response property "$.status" is 401
  And the response property "$.code" is "UNAUTHENTICATED" or "AUTHENTICATION_REQUIRED"
  And the response property "$.message" contains a user friendly text

@application_endpoint_discovery_401.2_no_authorization_header
Scenario: No Authorization header
  Given the header "Authorization" is removed
  And the request body is set to a valid request body
  When the request "getClosestAppEndpoint" is sent
  Then the response status code is 401
  And the response property "$.status" is 401
  And the response property "$.code" is "UNAUTHENTICATED"
  And the response property "$.message" contains a user friendly text

@application_endpoint_discovery_401.3_malformed_access_token
Scenario: Malformed access token
  Given the header "Authorization" is set to a malformed token
  And the request body is set to a valid request body
  When the request "getClosestAppEndpoint" is sent
  Then the response status code is 401
  And the response header "Content-Type" is "application/json"
  And the response property "$.status" is 401
  And the response property "$.code" is "UNAUTHENTICATED"
  And the response property "$.message" contains a user friendly text

#################
# Error code 403
#################

@application_endpoint_discovery_403.1_error_permissions_denied
Scenario: Client does not have sufficient permissions to perform this action
  Given header "Authorization" set to an access token not including scope "connected-network-type:read"
  And the request body is set to a valid request body
  When the request "getConnectedNetworkType" is sent
  Then the response status code is 403
  And the response property "$.status" is 403
  And the response property "$.code" is "PERMISSION_DENIED"
  And the response property "$.message" contains a user friendly text

################
# Error code 404
################

@application_endpoint_discovery_404.1_error_device_not_found
Scenario: Some identifier cannot be matched to a device
  Given the header "Authorization" is set to a valid access token which does not identify a single device
  And the request body property "$.device" is compliant with the schema but does not identify a valid device
  When the HTTP "POST" request is sent
  Then the response status code is 404
  And the response property "$.status" is 404
  And the response property "$.code" is "IDENTIFIER_NOT_FOUND"
  And the response property "$.message" contains a user friendly text

@application_endpoint_discovery_404.2_error_application_not_found
Scenario: Some identifier cannot be matched to a device
  Given the header "Authorization" is set to a valid access token which does not identify a single device
  And the request body property "$.appId" is compliant with the schema but does not identify a valid application
  When the HTTP "POST" request is sent
  Then the response status code is 404
  And the response property "$.status" is 404
  And the response property "$.code" is "NOT_FOUND"
  And the response property "$.message" contains a user friendly text

@application_endpoint_discovery_404.3_error_endpoints_id_not_found
Scenario: Some identifier cannot be matched to a device
  Given the header "Authorization" is set to a valid access token which does not identify a single device
  And the request body property "$.applicationEndpointsId" is compliant with the schema but does not identify a valid application endpoints ID
  When the HTTP "POST" request is sent
  Then the response status code is 404
  And the response property "$.status" is 404
  And the response property "$.code" is "NOT_FOUND"
  And the response property "$.message" contains a user friendly text

################
# Error code 422
################

@application_endpoint_discovery_422.1_error_unnecessary_device
Scenario: Device not to be included when it can be deduced from the access token
  Given the header "Authorization" is set to a valid access token identifying a device
  And the request body property "$.device" is set to a valid device
  When the HTTP "POST" request is sent
  Then the response status code is 422
  And the response property "$.status" is 422
  And the response property "$.code" is "UNNECESSARY_IDENTIFIER"
  And the response property "$.message" contains a user-friendly text

@application_endpoint_discovery_422.2_error_missing_device
Scenario: Device not included and cannot be deduced from the access token
  Given the header "Authorization" is set to a valid access token which does not identify a single device
  And the request body property "$.device" is not included
  When the HTTP "POST" request is sent
  Then the response status code is 422
  And the response property "$.status" is 422
  And the response property "$.code" is "MISSING_IDENTIFIER"
  And the response property "$.message" contains a user-friendly text

@application_endpoint_discovery_422.3_error_unsupported_device
Scenario: None of the provided device identifiers is supported by the implementation
  Given that some types of device identifiers are not supported by the implementation
  And the header "Authorization" is set to a valid access token which does not identify a single device
  And the request body property "$.device" only includes device identifiers not supported by the implementation
  When the HTTP "POST" request is sent
  Then the response status code is 422
  And the response property "$.status" is 422
  And the response property "$.code" is "UNSUPPORTED_IDENTIFIER"
  And the response property "$.message" contains a user-friendly text

@application_endpoint_discovery_422.4_error_device_not_supported
Scenario: Service not available for the device
  Given that the service is not available for all devices commercialized by the operator
  And a valid device, identified by the token or provided in the request body, for which the service is not applicable
  When the HTTP "POST" request is sent
  Then the response status code is 422
  And the response property "$.status" is 422
  And the response property "$.code" is "SERVICE_NOT_APPLICABLE"
  And the response property "$.message" contains a user-friendly text

@application_endpoint_discovery_422.5_error_device_identifiers_mismatch
Scenario: Device identifiers mismatch
  Given the header "Authorization" is set to a valid access token which does not identify a single device
  And at least 2 types of device identifiers are supported by the implementation
  And the request body property "$.device" includes several identifiers, each of them identifying a valid but different device
  When the HTTP "POST" request is sent
  Then the response status code is 422
  And the response property "$.status" is 422
  And the response property "$.code" is "IDENTIFIER_MISMATCH"
  And the response property "$.message" contains a user friendly text

#################
# Error code 503
#################

@connected_network_type_503_network_error
Scenario: Network error temporarily prevents the connected network type from being retrieved
  # This test is for use by the API provider only
  Given a valid testing device supported by the service, identified by the token or provided in the request body
  And the testing device is connected to a mobile network
  And the request body is set to a valid request body
  And the request body includes an appId parameter that identifies an application deployed on the platform
  And the application has instances up and running
  When the HTTP POST request "getConnectedNetworkType" is sent
  And a network error prevents the connected network type from being retrieved
  Then the response status code is 503
  And the response property "$.status" is 503
  And the response property "$.code" is "UNAVAILABLE"
  And the response property "$.message" contains a user friendly text indicating a temporary network error

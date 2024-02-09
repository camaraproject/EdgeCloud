#/*- ---license-start
#* CAMARA Project
#* ---
#* Copyright (C) 2022 - 2023 Contributors | Deutsche Telekom AG to CAMARA a Series of LF Projects, LLC
#* The contributor of this file confirms his sign-off for the
#* Developer Certificate of Origin (http://developercertificate.org).
#* ---
#* Licensed under the Apache License, Version 2.0 (the "License");
#* you may not use this file except in compliance with the License.
#* You may obtain a copy of the License at
#*
#*      http://www.apache.org/licenses/LICENSE-2.0
#*
#* Unless required by applicable law or agreed to in writing, software
#* distributed under the License is distributed on an "AS IS" BASIS,
#* WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#* See the License for the specific language governing permissions and
#* limitations under the License.
#* ---license-end
#*/

@EDS
Feature: EDS API test

  @EDSGetClosestMECPlatform
  Scenario: API Client requests name of closest MEC platform to a target UE
    Given Use the EDS MOCK URL
    When API Client makes a valid GET request
    Then Response code is 200
    And The response includes the name of the closest MEC platform
    And The response includes the name of the MEC platform provider

  @EDSNoFilterParameter
  Scenario: API Client omits filter parameter
    Given Use the EDS MOCK URL
    When The filter parameter is omitted
    Then Response code is 400

  @EDSIncorrectFilterParameterValue
  Scenario: API Client provides incorrect filter value
    Given Use the EDS MOCK URL
    When The filter parameter value is not 'closest'
    Then Response code is 400

  @EDSInvalidUEIdentity
  Scenario: the user device cannot be identified from the provided parameters
    Given Use the EDS MOCK URL
    When API is requested with invalid user device identity
    Then Response code is 404

  @EDSInternalServerError
  Scenario: Operator unable to resolve closest MEC platform
    Given Use the EDS MOCK URL
    When The operator is unable to resolve the closest MEC platform
    Then Response code is 500

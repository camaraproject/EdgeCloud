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

  Background:
    Given Use the EDS MOCK URL

  @EDSGetClosestMECPlatform
  Scenario: API Client requests name of closest MEC platform to a target UE
    Given the target UE is attached to the operator network
    When API Client makes a valid GET request
    Then Response code is 200 OK
    And the response includes the name of the closest MEC platform


  @EDSInvalidUEIdentity
  Scenario: API Client passes an invalid UE identity
    Given  the target UE identity is invalid
    When API Client makes a GET request with invalid UE identity
    Then Response code is 500 Internal Server Error


  @EDSInternalServerError
  Scenario: Operator unable to resolve closest MEC platform
    Given  the target UE is attached to the operator network
    When API Client makes a valid GET request
    But the operator network is unable to resolve the closest MEC platform
    Then Response code is 500 Internal Server Error

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

@EdgeCloudLCM @EdgeCloudLCMSanity
Feature:Automated Edge Cloud API System Integration Test 


@EdgeCloud_LCM_app_submittion_ok
Scenario: Submit an Application with mandatory parameters
When invoking with the POST method to submit an app with all required parameters
Then response code is 201

@EdgeCloud_LCM_app_submittion_conflict
Scenario: Submit an Application with mandatory parameters
Given an aplication with the same name and version had already been submitted
When invoking with the POST method to submit an app with all required parameters
Then response code is 409

@EdgeCloud_LCM_app_get_info_valid_parameter
Scenario: Get application info with mandatory parameter ("appId")
When invoking the GET method to obtain app information with mandatory parameter ("appId")
Then response code is 200

@EdgeCloud_LCM_app_get_info_invalid_parameter
Scenario: Get application info with mandatory parameter ("appId")
Given appId provided does not exist
When invoking the GET method to obtain submittion app information with mandatory parameter ("appId")
Then response code is 404

@EdgeCloud_LCM_app_delete_valid_parameter
Scenario: Delete all the information and content related to an Application with mandatory parameter ("appId")
Given there are no running instances of the app
When invoking with the DELETE method to delete an app with just mandatory parameter ("appId")
Then response code is 202
And the application information is deleted

@EdgeCloud_LCM_app_delete_conflict
Scenario: Delete all the information and content related to an Application with mandatory parameter ("appId")
Given there are running instances of the app
When invoking with the DELETE method to delete an app with just mandatory parameter ("appId")
Then response code is 409

@EdgeCloud_LCM_app_delete_invalid_parameter
Scenario: Delete all the information and content related to an Application with mandatory parameter ("appId")
Given appId provided does not exist
When invoking with the DELETE method to delete an app with just mandatory parameter ("appId")
Then response code is 404

@EdgeCloud_LCM_app_instantiation_ok_mandatory_parameters
Scenario: Instantiate an Application with just mandatory parameters ("appId" in path, and "region" in body)
Given an aplication has already been submitted
When invoking with the POST method to instantiate an app with just mandatory parameters ("appId" in path, and "region" in body)
Then response code is 202
And the process of instantiating the app starts in all available edge cloud zones in the region provided 

@EdgeCloud_LCM_app_instantiation_ok_optional_parameters
Scenario: Instantiate an Application with mandatory parameters ("appId" in path, and "region" in body) and optional parameter ("EdgeCloudZone")
Given an aplication has already been submitted
When invoking with the POST method to instantiate an app with mandatory mandatory parameters ("appId" in path, and "region" in body) and optional parameter ("EdgeCloudZone")
Then response code is 202
And the process of intantiating the app starts only in given region and edge cloud zone

@EdgeCloud_LCM_app_instantiation_conflict
Scenario: Instantiate an Application with mandatory parameters ("appId" in path, and "region" in body) and optional parameter ("EdgeCloudZone")
Given an aplication has already been submitted, but already instantiated in given EdgeCloudZone
When invoking with the POST method to instantiate an app with mandatory mandatory parameters ("appId" in path, and "region" in body) and optional parameter ("EdgeCloudZone")
Then response code is 409

@EdgeCloud_LCM_app_instance_get_info_valid_parameter
Scenario: Get application instance info with mandatory parameter ("appId")
When invoking the GET method to obtain information an app instance with mandatory parameter ("appId")
Then response code is 200
And information of all existing app instances of given app is returned

@EdgeCloud_LCM_app_instance_get_info_invalid_parameter
Scenario: Get application instance info with mandatory parameter ("appId")
Given appId provided does not exist
When invoking the GET method to obtain information an app instance with mandatory parameter ("appId")
Then response code is 404

@EdgeCloud_LCM_app_innstance_delete_all_instances
Scenario: Delete all running instances of an application in Edge Cloud
When invoking with the DELETE method to terminate running instances of an application within Edge Cloudwith with just mandatory parameter ("appId")
Then response code is 202
And all the application instances termination initiated

@EdgeCloud_LCM_app_innstance_delete_valid_parameter
Scenario: Delete a running instance of an application within an Edge Cloud Zone with optional parameter ("appInstanceId")
When invoking with the DELETE method to terminate a running instance of an application including optional parameter ("appInstanceId") and mandatory parameter ("appId")
Then response code is 202
And the application instance termination initiated


@EdgeCloud_LCM_app_innstance_delete_invalid_parameter
Scenario: Delete a running instance of an application within an Edge Cloud Zone with optional parameter ("appInstanceId")
Given appInstanceId provided does not exist
When invoking with the DELETE method to terminate a running instance of an application including optional parameter ("appInstanceId") and mandatory parameter ("appId")
Then response code is 404

@EdgeCloud_LCM_get_all_edge_cloud_zones_ok
Scenario: Get information of all existing Edge Cloud Zones
When invoking the GET method to obtain information of Edge Cloud Zones with no optional parameters
Then response code is 200
And information of all existing edge cloud zones is returned

@EdgeCloud_LCM_get_filtered_edge_cloud_zones_ok
Scenario: Get information of existing Edge Cloud Zones with optional parameters ("region","status")
When invoking the GET method to obtain information of Edge Cloud Zones with a region and a status (active,inactive,unknown)
Then response code is 200
And only information of cloud zones in the region and with the current status given in the input is returned

@EdgeCloud_LCM_get_filtered_edge_cloud_zones_nok
Scenario: Get information of existing Edge Cloud Zones with optional parameters ("region","status")
Given region provided that not exist
When invoking the GET method to obtain information of Edge Cloud Zones with a region and a status (active,inactive,unknown)
Then response code is 404

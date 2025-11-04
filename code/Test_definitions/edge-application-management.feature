@EdgeCloudEAM @EdgeCloudEAMSanity
Feature:Automated Edge Cloud API System Integration Test


    #API Error responses

    @EdgeCloud_EAM_app_get_info_invalid_parameter
    Scenario: Get application info with mandatory parameter ("appId")
        Given the header "Authorization" is set to a valid access token
        And the path parameter "$.appId" is set to an invalid application ID
        When invoking the GET method to obtain submission app information with mandatory parameter ("appId")
        Then response code is "404"
        And the response property "$.status" is "404"
        And the response property "$.code" is "NOT_FOUND"
        And the response property "$.message" contains a user friendly text

    @EdgeCloud_EAM_app_delete_conflict
    Scenario: Delete all the information and content related to an Application with mandatory parameter ("appId")
        Given there are running instances of the app
        And an application identified with ("appId") is being deleted due to a previous request
        And the path parameter "$.appId" is set to a valid application ID
        When invoking with the DELETE method to delete an app with just mandatory parameter ("appId")
        Then response code is 409
        And the response property "$.code" is "CONFLICT"
        And the response property "$.message" contains a user friendly text

    @EdgeCloud_EAM_app_delete_invalid_parameter
    Scenario: Delete all the information and content related to an Application with mandatory parameter ("appId")
        Given there are running instances of the app
        And the path parameter "$.appId" is set to an invalid application ID
        When invoking with the DELETE method to delete an app with just mandatory parameter ("appId")
        Then response code is 404
        And the response property "$.code" is "NOT_FOUND"
        And the response property "$.message" contains a user friendly text

    @EdgeCloud_EAM_app_instance_get_info_invalid_parameter
    Scenario: Get application instance info with mandatory parameter ("appInstanceId")
        Given there are running instances of the app
        And the path parameter "$.appInstanceId" is set to an invalid application instance ID
        When invoking the GET method to obtain information an app instance with mandatory parameter ("appInstanceId")
        Then response code is 404
        And the response property "$.code" is "NOT_FOUND"
        And the response property "$.message" contains a user friendly text

    @EdgeCloud_EAM_app_submission_conflict
    Scenario: Submit an Application with mandatory parameters
        Given there are applications already submitted
        And the request body property "$.name" is set to an existing application name
        And the request body property "$.version" is set to the same version of the existing application
        When invoking with the POST method to submit an app with all required parameters
        Then response code is 409
        And the response property "$.code" is "CONFLICT"
        And the response property "$.message" contains a user friendly text

    @EdgeCloud_EAM_app_instance_delete_invalid_parameter
    Scenario: Delete a running instance of an application within an Edge Cloud Zone with optional parameter ("appInstanceId")
        Given there are application instances running
        And the path parameter "$.appInstanceId" is set to an invalid application instance ID
        When invoking with the DELETE method to terminate a running instance of an application including optional parameter ("appInstanceId") and mandatory parameter ("appId")
        Then response code is 404
        And the response property "$.code" is "NOT_FOUND"
        And the response property "$.message" contains a user friendly text

    @EdgeCloud_EAM_get_filtered_edge_cloud_zones_nok
    Scenario: Get information of existing Edge Cloud Zones with optional parameters ("region","status")
        Given the path parameter "$.region" is set to an invalid region
        When invoking the GET method to obtain information of Edge Cloud Zones with a region and a status (active,inactive,unknown)
        Then response code is 404
        And the response property "$.code" is "NOT_FOUND"
        And the response property "$.message" contains a user friendly text

    #POST /appinstances 409
    @EdgeCloud_EAM_app_instance_conflict
    Scenario: Instantiate an existing application with mandatory parameters ("name", "appId" and "edgeCloudZoneId" in body)
        Given there are running instances of the app
        And the request body property "$.name" is set to a valid name
        And the request body property "$.appId" is set to a valid application ID
        And the request body property "$.edgeCloudZoneId" is set to a valid edge zone id
        And Application instance with "$.name" and "$.appId" is already running in "$.edgeCloudZoneId"
        And the request body property "$.appId" is set to a valid application ID
        When invoking with the POST method to instantiate an app with just mandatory parameters ("name", "appId" and "edgeCloudZoneId" in body)
        Then response code is 409
        And the response property "$.code" is "CONFLICT"
        And the response property "$.message" contains a user friendly text

    #/deployments	POST	409
    @EdgeCloud_EAM_deployments_confict
    Scenario: Deploy an existing application with mandatory parameters ("appDeploymentName", "appId" and "edgeCloudZoneId" in body)
        Given an application has already been submitted
        And the request body property "$.appDeploymentName" is set to a valid name
        And the request body property "$.appId" is set to a valid application ID
        And the request body property "$.edgeCloudZoneId" is set to a valid edge zone id
        And there is a running deployment with "$.appDeploymentName" and "$.appId"
        When invoking with the POST method to instantiate an app with just mandatory parameters ("appDeploymentName", "appId" and "edgeCloudZoneId" in body)
        Then response code is 409
        And the response property "$.code" is "CONFLICT"
        And the response property "$.message" contains a user friendly text

    #/deployments	GET	404
    @EdgeCloud_EAM_deployments_get_info_not_found
    Scenario: Get information of a deployment with non-existent appId
        Given there are deployments running
        And the request path parameter "$.appId" is set to a non-existent application ID
        When invoking the GET method to obtain information of existing deployments
        Then response code is 404
        And the response property "$.code" is "NOT_FOUND"
        And the response property "$.message" contains a user friendly text

    #/deployments	GET	410
    @EdgeCloud_EAM_deployments_get_info_gone
    Scenario: Get information of a removed deployment
        Given there are deployments running
        And the request path parameter "$.appDeploymentId" is set to an already removed Deployment ID
        When invoking the GET method to obtain information of the deployment
        Then response code is 410
        And the response property "$.code" is "GONE"
        And the response property "$.message" contains a user friendly text

    #/deployments/{appDeploymentId}	DELETE	410
    @EdgeCloud_EAM_deployments_delete_gone
    Scenario: Delete an already removed deployment
        Given the request path parameter "$.appDeploymentId" is set to an already removed Deployment ID
        When invoking the DELETE method to remove the deployment
        Then response code is 410
        And the response property "$.code" is "GONE"
        And the response property "$.message" contains a user friendly text

    #/deployments/{appDeploymentId}	PATCH	404
    @EdgeCloud_EAM_deployments_update_not_found
    Scenario: Update information of an non-existent deployment
        Given there are deployments running
        And the request path parameter "$.appDeploymentId" is set to an invalid Deployment ID
        And the request body property "$.appDeploymentName" is set to a valid Deployment name
        When invoking the PATCH method to update the information of the deployment
        Then response code is 404 
        And the response property "$.code" is "NOT_FOUND"
        And the response property "$.message" contains a user friendly text

    #/deployments/{appDeploymentId}	PATCH	410
    @EdgeCloud_EAM_deployments_update_gone
    Scenario: Update information of an already removed deployment
        Given there are deployments running
        And the request path parameter "$.appDeploymentId" is set to an already removed Deployment ID
        And the request body property "$.appDeploymentName" is set to a valid Deployment name
        When invoking the PATCH method to update the information of the deployment
        Then response code is 410
        And the response property "$.code" is "GONE"
        And the response property "$.message" contains a user friendly text

    #/clusters	GET	404
    @EdgeCloud_EAM_clusters_get_info_not_found
    Scenario: Get information of existing clusters with optional parameters ("region")
        Given the path parameter "$.region" is set to an invalid region
        When invoking the GET method to obtain information of Edge Cloud Cluster
        Then response code is 404 
        And the response property "$.code" is "NOT_FOUND"
        And the response property "$.message" contains a user friendly text


    #API succesfull responses


    @EdgeCloud_EAM_app_submission_ok
    Scenario: Submit an Application with mandatory parameters
        Given A valid application to be submitted
        And the request body property "$.name" is set to a valid name
        And the request body property "$.appPorvider" is set to a application provider
        And the request body property "$.version" is set to a valid version
        And the request body property "$.packageType" is set to a valid package type
        And the request body property "$.appRepo" is set to a valid repository
        And the request body property "$.requiredResources" is set to a valid required resources object
        And the request body property "$.componentSpect" is set to a valid object
        When invoking with the POST method to submit an app with all required parameters
        Then response code is 201
        And the response property "$.appId" is returned


    @EdgeCloud_EAM_app_get_info_valid_parameter
    Scenario: Get application info with mandatory parameter ("appId")
        Given there are applications already submitted
        And the path parameter "$.appId" is set to a valid application ID
        When invoking the GET method to obtain app information with mandatory parameter ("appId")
        Then response code is 200
        And the response body complies with the OAS schema at "/components/schemas/AppManifest"


    @EdgeCloud_EAM_app_delete_valid_parameter
    Scenario: Delete all the information and content related to an Application with mandatory parameter ("appId")
        Given there are no running instances of the app
        And the path parameter "$.appId" is set to a valid application ID
        When invoking with the DELETE method to delete an app with just mandatory parameter ("appId")
        Then response code is 202
        And the application information is deleted

    @EdgeCloud_EAM_app_instantiation_ok_mandatory_parameters
    Scenario: Instantiate an Application with just mandatory parameters ("name", "appId" and "edgeCloudZoneId" in body)
        Given an application has already been submitted
        And the request body property "$.name" is set to a valid name
        And the request body property "$.appId" is set to a valid application ID
        And the request body property "$.edgeCloudZoneId" is set to a valid edge zone id 
        When invoking with the POST method to instantiate an app with just mandatory parameters ("name", "appId" and "edgeCloudZoneId" in body)
        Then response code is 202
        And the process of instantiating the app starts in all available edge cloud zones in the region provided

    @EdgeCloud_EAM_app_instantiation_ok_optional_parameters
    Scenario: Instantiate an Application with mandatory parameters ("name", "appId" and "edgeCloudZoneId" in body) and optional parameter ("KubernetesClusterRef")
        Given an application has already been submitted
        And the request body property "$.name" is set to a valid name
        And the request body property "$.appId" is set to a valid application ID
        And the request body property "$.edgeCloudZoneId" is set to a valid edge zone id
        And the request body property "$.KubernetesClusterRef" is set to a valid kubernetes cluster
        When invoking with the POST method to instantiate an app with mandatory and optional parameters
        Then response code is 202
        And the process of instantiating the app starts only in given region and edge cloud zone
        And the response body complies with the OAS schema at "/components/schemas/AppInstanceInfo"

    @EdgeCloud_EAM_app_instance_get_info_valid_parameter
    Scenario: Get application instance info with mandatory parameter ("appId")
        Given there are application instances running
        And the request path parameter "$.appId" is set to a valid application ID
        When invoking the GET method to obtain information an app instance with mandatory parameter ("appId")
        Then response code is 200
        And information of all existing app instances of given app is returned
        And the response body complies with the OAS schema at "/components/schemas/AppInstanceInfo"

    @EdgeCloud_EAM_app_deployment_delete_instances
    Scenario: Delete all running instances of an application in Edge Cloud
        Given there are application instances running
        And the request path parameter "$.appDeploymentId" is set to a valid deployment ID
        When invoking with the DELETE method to terminate running instances of a deployment within Edge Cloud with just mandatory parameter ("appDeploymentId")
        Then response code is 202
        And all the application instances termination initiated

    @EdgeCloud_EAM_app_instance_delete_valid_parameter
    Scenario: Delete a running instance of an application within an Edge Cloud Zone with optional parameter ("appInstanceId")
        Given there are application instances running
        And the request path parameter "$.appId" is set to a valid application ID
        And the request path parameter "$.appInstanceId" is set to a valid application ID
        When invoking with the DELETE method to terminate a running instance of an application including optional parameter ("appInstanceId") and mandatory parameter ("appId")
        Then response code is 202
        And the application instance termination initiated

    @EdgeCloud_EAM_get_all_edge_cloud_zones_ok
    Scenario: Get information of all existing Edge Cloud Zones
        When invoking the GET method to obtain information of Edge Cloud Zones with no optional parameters
        Then response code is 200
        And information of all existing edge cloud zones is returned
        And the response body complies with the OAS schema at "/components/schemas/EdgeCloudZones"

    @EdgeCloud_EAM_get_filtered_edge_cloud_zones_ok
    Scenario: Get information of existing Edge Cloud Zones with optional parameters ("region","status")
        Given the path parameter "$.region" is set to a valid region
        And the path parameter "$.status" is set to a valid status
        When invoking the GET method to obtain information of Edge Cloud Zones with a region and a status (active,inactive,unknown)
        Then response code is 200
        And only information of cloud zones in the region and with the current status given in the input is returned
        And the response body complies with the OAS schema at "/components/schemas/EdgeCloudZones"

    #GET /apps
    @EdgeCloud_EAM_get_apps
    Scenario: Get information of all existing applications
        Given there are applications submitted
        When invoking the GET method to obtain information of existing applications
        Then response code is 200
        And A list of applications with information of them is returned
        And the response body complies with the OAS schema at "/components/schemas/AppManifest"

    #GET /appinstances 200
    @EdgeCloud_EAM_app_instance_get_info_valid
    Scenario: Get information of all existing application instances
        Given there are application instances running
        When invoking the GET method to obtain information of existing application instances
        Then response code is 200 
        And information of all existing app instances is returned
        And the response body complies with the OAS schema at "/components/schemas/AppInstanceInfo"

    #GET /appinstances filtered 200
    @EdgeCloud_EAM_app_instance_get_info_filtered
    Scenario: Get information of all existing application instances with path filter
        Given there are application instances running
        And the request path parameter "$.appId" is a valid application Id
        When invoking the GET method to obtain information of existing application instances
        Then response code is 200 
        And information of all app instances with ".appId" is returned
        And the response body complies with the OAS schema at "/components/schemas/AppInstanceInfo"

    #POST /deployments 202
    @EdgeCloud_EAM_deployments_instantiate
    Scenario: Deploy an existing application with mandatory parameters ("appDeploymentName", "appId" and "edgeCloudZoneId" in body)
        Given an application has already been submitted
        And the request body property "$.appDeploymentName" is set to a valid name
        And the request body property "$.appId" is set to a valid application ID
        And the request body property "$.edgeCloudZoneId" is set to a valid edge zone id 
        When invoking with the POST method to instantiate an app with just mandatory parameters ("appDeploymentName", "appId" and "edgeCloudZoneId" in body)
        Then response code is 202 
        And the instantiation is accepted
        And the response body complies with the OAS schema at "/components/schemas/AppDeploymentId"


    #/deployments	GET	200
    @EdgeCloud_EAM_deployments_get_info_valid
    Scenario: Get information of all existing deployments
        Given there are deployments running
        When invoking the GET method to obtain information of existing deployments
        Then response code is 200 
        And information of all existing deployments is returned
        And the response body complies with the OAS schema at "/components/schemas/AppDeploymentInfo"


    #/deployments/{appDeploymentId}	PATCH	200
    @EdgeCloud_EAM_deployments_update_valid
    Scenario: Update information of an existing deployment
        Given there are deployments running
        And the request path parameter "$.appDeploymentId" is set to a valid Deployment ID
        And the request body property "$.appDeploymentName" is set to a valid Deployment name
        When invoking the PATCH method to update the information of the deployment
        Then response code is 200 
        And information of the deployment with new name is returned
        And the response body complies with the OAS schema at "/components/schemas/AppDeploymentInfo"


    #/clusters	GET 200
    @EdgeCloud_EAM_clusters_get_info
    Scenario: Get information of existing clusters
        When invoking the GET method to obtain information of Edge Cloud Cluster
        Then response code is 200
        And information of clusters is returned
        And the response body complies with the OAS schema at "/components/schemas/ClusterInfo"

    #/clusters	GET	200	filtered
    @EdgeCloud_EAM_clusters_get_info_filtered
    Scenario: Get information of existing clusters with optional parameters ("region")
        Given the path parameter "$.region" is set to a valid region
        When invoking the GET method to obtain information of Edge Cloud Cluster
        Then response code is 200
        And information of clusters of "$.region" is returned
        And the response body complies with the OAS schema at "/components/schemas/ClusterInfo"

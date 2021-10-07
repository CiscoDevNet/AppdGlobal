# Instrumenting legacy Tomcat application for AppDynamics business insights with Intersight Cloud Orchestrator (ICO)
## Contents
        Use Case

        Pre-requisites

        Intersight Target configuration for AppDynamics and on prem entities

        Provision infrastructure and deploy App services with AppDynamics instrumentation

            Step 1: Importing ICO template for App Services Deployment and Instrumentation

            Step 2: Importing ICO template for App Services Load Generation

            Step 3: Setup global data

            Step 4: Execute ICO template for App Services Deployment and Instrumentation

            Step 5: Execute ICO template for App Services Load Generation

            Step 6: View AppDynamics Insights

        Undeploy applications and deprovision infrastructure


### Use Case

* As a DevOps and App developer, use ICO (Intersight Cloud Orchestrator) to enable existing Java/Tomcat Micro services for AppDynamics Insights

* As DevOps and App Developer, use Intersight and AppDynamics to view app and infrastructure insights for Full Stack Observability

This use case addresses the second flow in the below diagram:

![alt text](https://github.com/prathjan/images/blob/main/AppdTomcat3.png?raw=true)

### Pre-requisites

1. The VM template that you provision in Step 5 below will have a user "root/Cisco123" provisioned with sudo privileges. Terraform scripts will use this user credentials to remotely run installation scripts in the VM.

2. Sign up for a user account on Intersight.com. You will need Premier license as well as IWO license to complete this use case. 

3. Sign up for a TFCB (Terraform for Cloud Business) at https://app.terraform.io/. Log in and generate the User API Key. You will need this when you create the TF Cloud Target in Intersight.

4. You will need access to a vSphere infrastructure with backend compute and storage provisioned

5. You will also need an account in AppDynamics SAAS Controller and should have the API Client ID and Client Secret.

### Intersight Target configuration for AppDynamics and on prem entities

You will log into your Intersight account and create the following targets. Please refer to Intersight docs for details on how to create these Targets:

    Assist

    vSphere

    AppDynamics

    TFC Cloud

    TFC Cloud Agent - When you claim the TF Cloud Agent, please make sure you have the following added to your Managed Hosts. This is in addition to other local subnets you may have that hosts your kubernetes cluster like the IPPool that you may configure for your k8s addressing:
    NO_PROXY URL's listed:

            github-releases.githubusercontent.com

            github.com

            app.terraform.io

            registry.terraform.io

            releases.hashicorp.com

            archivist.terraform.io

### Provision infrastructure and deploy App services with AppDynamics instrumentation


## Step 1: Importing ICO template for App Services Deployment and Instrumentation

Clone the following github repo to get the ICO template:

https://github.com/CiscoDevNet/IcoTemplates.git

Import the template ** Exportlegacy.json ** in Intersight:

![alt text](https://github.com/prathjan/images/blob/main/importleg.png?raw=true)

## Step 2: Importing ICO template for App Services Load Generation

Import the template ** ExportOnlyLoad.json ** in Intersight:

![alt text](https://github.com/prathjan/images/blob/main/importload.png?raw=true)


## Step 3: Setup global data

In Intersight, you will set up the data specific to your environment in this step. 

Open Orchestration-> UpdateLegacyVars->Update AppdGlobal Variables Task:

![alt text](https://github.com/prathjan/images/blob/main/globvar.png?raw=true)

 Add the following variables:

vsphere_user(eg. administrator@vsphere.local)

vm_memory(eg. 8192)

nbrapm(eg. 8)

nbrma(eg. 1)

nbrsim(eg. 1)

nbrnet(eg. 0)

vm_cpu(eg. 4)

vm_count (eg. 1)

Add the following sensitive variables:
root_password

mysql_pass

vsphere_password

Next, open Orchestration-> UpdateLegacyVars->Update AppdGlobal Variables2 Task and add the following variables:

appport(eg. 8085)

vsphere_server(eg. 10.88.168.24)

datacenter(eg. Piso14-Lab)

resource_pool(eg. ccmsuite)

datastore_name(eg. CCPHXM4)

network_name(eg. vm-network-6)

template_name(eg. ubuntu-tmp)

vm_folder(eg. terraform)

vm_prefix(eg. terraform-)

vm_domain(eg. lab14.lc)


## Step 4: Execute ICO Workflow for App Services Deployment and Instrumentation

![alt text](https://github.com/prathjan/images/blob/main/exelegacy.png?raw=true)

You will be prompted for the following data:

![alt text](https://github.com/prathjan/images/blob/main/exeparams.png?raw=true)

Pick up the Agent Pool ID and token from your TFCB account

![alt text](https://github.com/prathjan/images/blob/main/tfcb1.png?raw=true)

![alt text](https://github.com/prathjan/images/blob/main/tfcb2.png?raw=true)

## Step 5: Execute ICO Workflow for App Services Load Generation

![alt text](https://github.com/prathjan/images/blob/main/exeload.png?raw=true)


### View Application Insights in AppDynamics 

Checkout the application insights in AppDynamics:

![alt text](https://github.com/prathjan/images/blob/main/appd.png?raw=true)

### View Application Insights in Intersight

Checkout the infrastructure insights in Intersight:

![alt text](https://github.com/prathjan/images/blob/main/optimize.png?raw=true)

### Interfacing with AppDynamics Controller API for De-provisioning - Use RBAC script to remove AppDynamics User and license rule

Execute the AppdRemove workspace to remove all the entities created in AppDynamics.

Due to a known error, you will have to manually delete the SuperChaiStore application from AppDynamics to complete the cleanup:

![alt text](https://github.com/prathjan/images/blob/main/appddel.png?raw=true)
            
### Undeploy applications and deprovision infrastructure

ICO Workflows do not support deleting TFCB workspaces at this time. So, we will have to terminate and clean up leveraging TFCB.

Destroy the TFCB workspaces in this order:

AppdLoad

AppdRemove

AppdRbac

AppdSaas

AppdInfra

AppdDb

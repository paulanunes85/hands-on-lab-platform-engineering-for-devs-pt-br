---
published: true
type: workshop
title: Platform engineering for devs Hands-on Lab
short_title: Platform engineering for devs
description: This workshop will guide you on how to fast start your dev experience, how to deploy to Azure, and how to detect potential issues with your code during runtime.
level: beginner # Required. Can be 'beginner', 'intermediate' or 'advanced'
navigation_numbering: false
authors: # Required. You can add as many authors as needed
  - Iheb Khemissi
contacts: # Required. Must match the number of authors
  - "@ikhemissi"
duration_minutes: 180
tags: azure, devbox, ade, deployment environment, azd, azure developer cli, azure functions, azure load testing, application insights
navigation_levels: 3
---

# Platform engineering for devs

Welcome to this workshop focusing on enhancing your dev experience by:
- Using a remote environment customized to your needs for a fast start on a project
- Creating temporary test environments to assess your changes while being compliant with your organization policies
- Using tools which can simplify the experience of managing environments on Azure and deploying your workload code
- Leveraging load testing as a means for early issue detection
- Debugging issues in a distributed workload

During this workshop you will have the instructions to complete each steps. It is recommended to search for the answers in provided resources and links before looking at the solutions placed under the '📚 Toggle solution' panel.

<div class="task" data-title="Task">

> You will find the instructions and expected configurations for each Lab step in these yellow **TASK** boxes.
> Inputs and parameters to select will be defined, all the rest can remain as default as it has no impact on the scenario.
>
> Use the provided credentials to Log into the Azure subscription locally using Azure CLI and on the [Azure Portal][az-portal].
> Instructions and solutions will be provided for `azd`, `Azure CLI`, and the portal, but you can also opt for using the Azure Portal during the entire workshop if you prefer.

</div>


## Scenario

The goal of the workshop is to edit the code of a simple Order management API, deploy it to Azure, and detect potential issues using load tests and monitoring.

We will be using the following services:
- [Microsoft Dev Box][devbox]
- [Azure Deployment Environment][ade]
- [Azure Developer CLI][azd]
- [Azure Load Testing][loadtesting]
- [Application Insights][appinsights]

TODO: add a diagram to illustrate the scenario and more details to the various services ?

[az-portal]: https://portal.azure.com
[vscode]: https://code.visualstudio.com/
[devbox]: https://learn.microsoft.com/en-us/azure/dev-box/overview-what-is-microsoft-dev-box
[ade]: https://learn.microsoft.com/en-us/azure/deployment-environments/overview-what-is-azure-deployment-environments
[azd]: https://learn.microsoft.com/en-us/azure/developer/azure-developer-cli/overview
[loadtesting]: https://learn.microsoft.com/en-us/azure/load-testing/overview-what-is-azure-load-testing
[appinsights]: https://learn.microsoft.com/en-us/azure/azure-monitor/app/app-insights-overview
[devportal]: https://devportal.microsoft.com/
[resourcemanager]: https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/overview
[functionloadtesting]: https://learn.microsoft.com/en-us/azure/load-testing/how-to-create-load-test-function-app

---

# Lab 1 : Make changes to the project

## Setup your dev environment

TODO: add a brief description of Dev Box and its advantages

We will be using a Dev Box with a customized image intended for full stack development. The Dev Box includes [VS Code][vscode] with few extensions, nodejs, git, az cli, and azd.

<div class="task" data-title="Task">

> - Log into the Developer portal and connect to your Dev Box
> - Open VS Code

</div>

<details>

<summary>📚 Toggle solution</summary>

1. Open the [Developer portal][devportal]
1. Sign in using the provided credentials.
1. Locate your Dev Box and click on the `Open in RDP client` button
1. Click on the `Connect` button
1. Wait until the Dec Box starts
1. Open VS Code
1. Check the installed extensions, you should be able to see Azure and Github extensions (among others)

</details>

## Clone the project

<div class="task" data-title="Task">

> - Clone the project https://github.com/ikhemissi/hands-on-lab-platform-engineering-for-devs

</div>

<details>

<summary>📚 Toggle solution</summary>

Use the integrated terminal to run the following commands:

```sh
git clone https://github.com/ikhemissi/hands-on-lab-platform-engineering-for-devs.git
```

</details>

## Update the code

<div class="task" data-title="Task">

> - Update the `qna` endpoint in `service/api/src/api.js` by prefixing the return value with a prefix of your choice

</div>

<details>

<summary>📚 Toggle solution</summary>

1. Open the file `service/api/src/api.js`
1. Locate the line `answer: '42',`
1. Replace '42' with 'PREFIX 42' where `PREFIX` is your initials

</details>

---

# Lab 2 : Deploy your code to Azure

In this second lab we will focus on how to deploy our services to Azure.

To do this we need to:
- Provision resources on Azure like the compute service which will host our code, the database, and the monitoring service
- Package our code and deploy it to the provisioned resources


## Provision resources on Azure

Resource provisioning can be done [in many ways][resourcemanager]:
- (Recommended) Using Infrastructure as Code (IaC) like Bicep and Terraform
- Using the Azure CLI
- Using APIs and SDKs
- From the Azure Portal

Working with IaC can be a challenge in some contexts like defining who can do what:
- Who will be writing the IaC and guaranteeing it is compliant with company standards and best practices ?
- Who will be creating resources using IaC, and how ? 

[Azure Deployment Environments][ade] solves this problems by providing a framework for authoring "environment definitions", provisioning them, assigning resources to projects, and handling permissions.
Environments can be created directly from the [Developer portal][devportal] or using a compatible tool like Azure Developer CLI (`azd`).


<div class="task" data-title="Task">

> - Create a new environment using the `Function` definition

</div>

<details>

<summary>📚 Toggle solution</summary>

1. Open the [Developer portal][devportal]
1. Sign in using the provided credentials if needed
1. Click on the `New` button on the top left and click on the `New environment` option. Copy the chosen name.
1. Choose a short name and select `Project-1``
1. Select the environment type `Dev` and the `Function` definition
1. Hit `Next`
1. Use the same environment name as in the previous step and leave the location as is.
1. Hit `Create` and wait for the environment to be created

</details>

## Deploy services

[`azd`][azd] simplifies the process of creating resources and deploying code by providing a simple abstraction on top of the various integrations (e.g. with compute and management services).


<div class="task" data-title="Task">

> - Using [`azd`][azd], select the ADE environment which you have previously created
> - Deploy services to the selected environment

</div>

<details>

<summary>📚 Toggle solution</summary>

1. Log into Azure using `azd`

```sh
azd auth login
```

2. List available environments

```sh
azd env list
```

3. Select the remote environment which was created via Dev portal

```sh
azd env select <ade-environment-name>
```

4. Deploy services to the selected environment using the configuration defined in `azure.yaml`

```sh
azd deploy
```

Follow the wizard and wait until the deployment finishes.
You should have access to the deployed service url (e.g. Function App) and the resource group which was used for the deployment.

</details>


## Test deployed services


<div class="task" data-title="Task">

> - Test the newly deployed function and make sure the changes you made in the last step of Lab 1 are being taken into account in the response of the function.

</div>

<div class="tip" data-title="Tips">

> You can use the supplied `test.http` file to test the newly deployed function

</div>

<details>

<summary>📚 Toggle solution</summary>

1. Open the `test.http`
1. Update the `@host` variable to point to your Function App
1. Use the `Send Request` button on top of line 3 to send a request
1. Make sure you see the change you made at the end of Lab 1 (e.g. adding a prefix to the response)

</details>

---

# Lab 3 : Load testing

## Create a load test

Using load testing can help identify potential issues (e.g. errors and latency) very early and reduce the impact of these issues on your users.

TODO: Add a short description of Azure Load Testing, its benefits, and the integration with other services.

## Run the test

<div class="task" data-title="Task">

> - Create a Load test for the Function endpoint
> - Limit the duration of the test to 3 minutes

</div>

<div class="tip" data-title="Tips">

> Use the direct integration of [Azure Load Testing with Azure Functions][functionloadtesting]

</div>

<details>

<summary>📚 Toggle solution</summary>

1. Locate the Function App in the Azure Portal
1. Click on the `Load Testing (Preview)` blade
1. Click on the `Create test` button
1. Select the existing Azure Load Testing resource and provide a short name and description of the test
1. Click on `Add request`
1. Make sure the pre-populated request points to your Function endpoint and uses the right HTTP method (`POST`)
1. Select the body tab, set the `Data type` value to `JSON view`, and paste the request body used in the file `test.http`
1. Valide the request using the `Add` button
1. Select the tab `Load configuration` and set `Test duration (minutes)` to 3
1. Click on `Review + create` then on `Create`
1. The test will take few seconds to get created and then you should see a popup telling you that the test has started

</details>

As the test starts, you will see a `Load test results` dashboard with various metrics like the total number of requests, throughput, and error percentage.


<div class="task" data-title="Task">

> - Find out the average response time ?

</div>

<details>

<summary>📚 Toggle solution</summary>

1. Locate the `Aggregation` filter in the `Client-side metrics` panel
1. Uncheck existing selection, select `Average`, then click on `Apply`
1. Locate the metric below the graph in `Response time (successful responses)`. That is the average response time.

</details>


## Check your stack using Application Map

TODO: add a short description App Insights and Application Map

<div class="task" data-title="Task">

> - Find out how what components are used within your stack/workload
> - Which component depends on the other ?
> - Where is most of the time spent when making a request to your function ?

</div>

TODO: add the solution

---

# Lab 4 : Investigate errors

As you add new features to your application, few regressions may appear, hence the need for testing and monitoring to detect and fix these regressions.

To simulate making changes and deploying new releases, the provided Function App relies on the `RELEASE` environment variable to control its behaviour and introduce regressions like throwing errors and injecting latency. 

## Simulate a new release

<div class="task" data-title="Task">

> - Update the config of the Function Apps by setting the environment variable `RELEASE` to `2`. The function should start throwing errors for 10% of the requests.

</div>

TODO: describe the solution

## Re-run load testing

<div class="task" data-title="Task">

> - Re-run the load test which you have created in the previous lab and observe if there are any changes compared to before

</div>

TODO: describe the solution


## Inspect errors

<div class="task" data-title="Task">

> - Use Application Insights to find more details about the error that you started observing.
> - Which service and which line of code is throwing this error ?

</div>

TODO: describe the solution

---

# Lab 5 : Investigate latency issues

The goal of this lab is to investigate potential latency issues.
The release `3` introduces a latency of 2 seconds in the function, so you will start by simulating the deployment of that release.
<div class="task" data-title="Task">

> - Update the config of the Function Apps by setting the environment variable `RELEASE` to `3`. Request should now be 2 seconds slower compared to before.

</div>

TODO: describe the solution

## Re-run load testing

<div class="task" data-title="Task">

> - Re-run the same load test which you have used in the previous lab and observe if there are any changes compared to before

</div>

TODO: describe the solution

## Inspect performance issues

<div class="task" data-title="Task">

> - Use Application Insights to find more details about the latency issue that you started observing.

</div>

TODO: describe the solution

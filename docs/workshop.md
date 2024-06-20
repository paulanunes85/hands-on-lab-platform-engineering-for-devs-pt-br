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
  - François-Xavier Kim
contacts: # Required. Must match the number of authors
  - "@ikhemissi"
  - "@frkim"
duration_minutes: 180
tags: azure, devbox, ade, deployment environment, azd, azure developer cli, azure functions, azure load testing, application insights
navigation_levels: 3

---

# Platform engineering for devs

Greetings! This workshop is designed to improve your development experience by:

- Utilizing a personalized remote environment for a quick project kickoff
- Establishing temporary testing environments to evaluate your modifications in line with your company's guidelines
- Employing tools that streamline the process of managing Azure environments and deploying your software
- Harnessing load testing for early identification of potential issues
- Troubleshooting issues in a distributed workload setup

During this workshop, you will receive instructions to complete each step. It is recommended that you search for the answers in the provided resources and links before looking at the solutions placed under the '📚 *Toggle solution*' panel.

<div class="task" data-title="Task">

> You will find the instructions and expected configurations for each Lab step in these yellow **TASK** boxes.
> Inputs and parameters to select will be defined; all the rest can remain at their default settings as they have no impact on the scenario
>
> Use the provided credentials to log into the Azure subscription locally using Azure CLI and on the [Azure Portal][az-portal].
> Instructions and solutions will be provided for `azd`, `Azure CLI`, and the portal, but you can also opt for using the Azure Portal during the entire workshop if you prefer.

</div>

## Scenario

The goal of the workshop is to edit the code of a simple *Order management* API, deploy it to Azure, and detect potential issues using load tests and monitoring.

We will be using the following services:

- [Microsoft Dev Box][devbox]
- [Azure Deployment Environment][ade]
- [Azure Developer CLI][azd]
- [Azure Load Testing][loadtesting]
- [Application Insights][appinsights]

![Global diagram](./media/global-diagram.png)

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
[applicationmap]: https://learn.microsoft.com/en-us/azure/azure-monitor/app/app-map

---

# Lab 1 : Make changes to the project

## Setup your dev environment

Azure DevBox is a development environment provided by Microsoft Azure. It's essentially a cloud-based, pre-configured development environment that developers can use to write, run, and debug their code. Here are some of its advantages:

- **Pre-configured Environment**: Azure DevBox comes with a pre-configured development environment, which includes a variety of popular programming languages, development tools, and frameworks. This saves developers the time and effort of setting up their own environment.
- **Anywhere Access**: Since Azure DevBox is cloud-based, developers can access their development environment from anywhere, on any device. This makes it a great tool for remote teams and flexible working arrangements.
- **Scalability**: Azure DevBox can easily scale up or down based on the needs of the project. This means developers can choose the right amount of resources for their project, without having to worry about over or under-provisioning.
- **Integration with Azure Services**: Azure DevBox is fully integrated with other Azure services, making it easy to build, test, and deploy applications that use these services.
- **Security**: Azure DevBox is hosted on Azure, which means it benefits from Azure's security measures. This includes features like Azure Security Center, Azure Active Directory, and compliance offerings.
- **Collaboration**: Azure DevBox supports real-time collaboration between developers. This makes it easier for teams to work together on the same codebase, regardless of their physical location.

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

> - Clone the project [https://github.com/ikhemissi/hands-on-lab-platform-engineering-for-devs](https://github.com/ikhemissi/hands-on-lab-platform-engineering-for-devs)

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

Azure Load Testing is a cloud-based service provided by Microsoft Azure that allows developers to simulate high volumes of user traffic to their applications. This service is designed to identify potential performance bottlenecks and ensure that applications can handle high loads, especially during peak times.

Benefits of Azure Load Testing:

- **Scalability**: Azure Load Testing can simulate thousands to millions of virtual users, allowing you to test your application under various load conditions.
- **Ease of Use**: With its intuitive interface and pre-configured test templates, Azure Load Testing makes it easy to set up and run load tests.
- **Detailed Reporting**: Azure Load Testing provides detailed reports and real-time analytics, helping you identify and resolve performance bottlenecks.
- **Cost-Effective**: With Azure Load Testing, you only pay for what you use. This makes it a cost-effective solution for load testing.

Integration with other services:

Azure Load Testing integrates seamlessly with other Azure services. For instance, it can be used in conjunction with Azure Monitor and Application Insights to provide detailed performance metrics and insights. It also integrates with Azure DevOps, allowing you to incorporate load testing into your CI/CD pipeline.

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

<div class="tip" data-title="Tips">

> Check the [Application Map overview][applicationmap]

</div>

<details>

<summary>📚 Toggle solution</summary>

1. Open the resource group on Azure portal
1. Locate the Application Insights resource
1. Click on the `Application Map` blade
1. You should see the various component of the stack and their dependencies
1. Check the average duration spent on each component and locate the one where most of the time is spent

</details>

---

# Lab 4 : Investigate errors

As you add new features to your application, few regressions may appear, hence the need for testing and monitoring to detect and fix these regressions.

To simulate making changes and deploying new releases, the provided Function App relies on the `RELEASE` environment variable to control its behaviour and introduce regressions like throwing errors and injecting latency.

## Simulate a new release

<div class="task" data-title="Task">

> - Update the config of the Function Apps by setting the environment variable `RELEASE` to `2`. The function should start throwing errors for 10% of the requests.

</div>

<details>

<summary>📚 Toggle solution</summary>

1. Open the resource group on Azure portal
1. Locate the Function App
1. Click on the `Environment variables` blade
1. Click on the `RELEASE` environment variable to edit it
1. Set the value to `2` and hit `Apply`
1. Hit `Apply` to validate all changes on environment variables
1. Select `Confirm`

The Function App will reload and then it will adapt its behavior to throw errors at a 10% rate

</details>

## Re-run load testing

<div class="task" data-title="Task">

> - Re-run the load test which you have created in the previous lab and observe if there are any changes compared to before

</div>

<details>

<summary>📚 Toggle solution</summary>

You can either opt for creating a new test like you did in Lab 3 or re-rerun an existing test.

Here is how you should proceed if you choose to rerun a test:

1. Locate the Function App in the Azure Portal
1. Click on the `Load Testing (Preview)` blade
1. Select any test in `Test runs` section
1. Click on the `Rerun` button on the top
1. Optionally provide a short description (e.g. `Checking for errors`)
1. Click on the `Rerun` button
1. The test will take few seconds to get created and then you should see a popup telling you that the test has started
1. Click on the new test run to access test results

</details>

## Inspect errors

<div class="task" data-title="Task">

> - Use Application Insights to find more details about the error that you started observing.
> - Which service and which line of code is throwing this error ?

</div>

<details>

<summary>📚 Toggle solution</summary>

1. Open the resource group on Azure portal
1. Locate the Application Insights resource
1. You should see a spike of errors on the `Failed requests` panel
1. Use the `Failures` blade or click on the errors' chart
1. Click on the top response code (`500`) on the right panel
1. Select the suggested sample operation on the right panel
1. You should see the details of the errors including any other service which was involved on the operation
1. Click on `Traces and Events`
1. Select the exception to access its call stack
1. Check the `message` on the right panel and click on `[show more]` to get more details
1. You should see a reference to `Random error`, the file `api.js` where the error was triggered, and the call trace including line numbers

</details>

---

# Lab 5 : Investigate latency issues

The goal of this lab is to investigate potential latency issues.
The release `3` introduces a latency of 2 seconds in the function, so you will start by simulating the deployment of that release.
<div class="task" data-title="Task">

> - Update the config of the Function Apps by setting the environment variable `RELEASE` to `3`. Request should now be 2 seconds slower compared to before.

</div>

<details>

<summary>📚 Toggle solution</summary>

1. Open the resource group on Azure portal
1. Locate the Function App
1. Click on the `Environment variables` blade
1. Click on the `RELEASE` environment variable to edit it
1. Set the value to `3` and hit `Apply`
1. Hit `Apply` to validate all changes on environment variables
1. Select `Confirm`

The Function App will reload and then it will adapt its behavior to inject a latency of 2 seconds

</details>

## Run load testing again

<div class="task" data-title="Task">

> - Re-run the same load test which you have used in the previous lab and observe if there are any changes compared to before

</div>

<details>

<summary>📚 Toggle solution</summary>

You can either opt for creating a new test like you did in Lab 3 or re-rerun an existing test.

Here is how you should proceed if you choose to rerun a test:

1. Locate the Function App in the Azure Portal
1. Click on the `Load Testing (Preview)` blade
1. Select any test in `Test runs` section
1. Click on the `Rerun` button on the top
1. Optionally provide a short description (e.g. `Checking for latency issues`)
1. Click on the `Rerun` button
1. The test will take few seconds to get created and then you should see a popup telling you that the test has started
1. Click on the new test run to access test results

</details>

## Inspect performance issues

<div class="task" data-title="Task">

> - Use Application Insights to find more details about the latency issue that you started observing.

</div>

<details>

<summary>📚 Toggle solution</summary>

1. Open the resource group on Azure portal
1. Locate the Application Insights resource
1. You should see an increase in response time on the `Server response time` panel
1. Use the `Performance` blade or click on the response time chart
1. You should see the duration taken by each operation
1. The `qna` operation should be unnaturally slow (+2 seconds) and you should see a red arrow on the right of the operation together with the percentage of increase in latency. That is the endpoint to investigate.
1. You can use the `Profiler` to get more details about the origin of the issue

</details>

TODO: add more details about the Profiler of App Insights

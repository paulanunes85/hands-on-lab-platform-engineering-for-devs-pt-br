---
published: true
type: workshop
title: Platform engineering for devs Hands-on Lab
short_title: Platform engineering for devs
description: This workshop will guide you on how to fast start your dev experience, and how to detect potential issues during runtime.
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
- [Microsoft Dev Box (DevBox)][devbox]
- [Azure Deployment environment (ADE)][ade]
- [Azure Developer CLI (AZD)][azd]
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

> - Clone the project https://github.com/ikhemissi/platform-engineering-summit-2024

</div>

<details>

<summary>📚 Toggle solution</summary>

Use the integrated terminal to run the following commands:

```bash
git clone https://github.com/ikhemissi/platform-engineering-summit-2024.git
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

## Create a deployment environment

TODO


## Inspect the resource group

TODO


## Deploy services with azd

TODO


## Test deployed services

TODO

---

# Lab 3 : Load testing

## Create a load test

TODO: use the Load Testing feature in the Function App to simplify test creation

## Run the test

TODO

## Check your stack using Application Map

TODO

---

# Lab 4 : Investigate errors

## Simulate a new release

TODO: set `RELEASE` to `2`

## Re-run load testing

TODO

## Inspect errors

TODO: use App Insights

---

# Lab 5 : Investigate latency issues

## Simulate a new release

TODO: set `RELEASE` to `3`

## Re-run load testing

TODO

## Inspect performance issues

TODO: use App Insights / Performance


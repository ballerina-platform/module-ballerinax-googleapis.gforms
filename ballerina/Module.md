## Overview

The Ballerina Google Forms connector allows you to interact with the Google Forms API. It provides functionalities to create, retrieve, and update Google Forms and their responses. This connector supports the Google Forms API v1.

## Setup guide

### Obtain Credentials

1. Go to the [Google Cloud Console](https://console.cloud.google.com/).
2. Create a new project or select an existing project.
3. Enable the Google Forms API for the project.
4. Create OAuth 2.0 credentials by navigating to **APIs & Services** > **Credentials** > **Create Credentials** > **OAuth 2.0 Client IDs**.
5. Configure the consent screen and download the OAuth 2.0 client ID JSON file.

### Configure the Connector

1. Add the downloaded OAuth 2.0 client ID JSON file to your Ballerina project.
2. Use the following configuration to initialize the Google Forms client:

```ballerina
import ballerina/oauth2;
import ballerinax/googleapis.gforms;

oauth2:ClientOAuth2Config oauth2Config = {
    clientId: "<CLIENT_ID>",
    clientSecret: "<CLIENT_SECRET>",
    refreshUrl: "https://oauth2.googleapis.com/token",
    refreshToken: "<REFRESH_TOKEN>"
};

gforms:GoogleFormsClient googleFormsClient = check new (oauth2Config);
```

## Quickstart

### Create a Google Form

The following example demonstrates how to create a Google Form using the Google Forms connector.

```ballerina
import ballerinax/googleapis.gforms;

gforms:Form form = {
    title: "Sample Form",
    description: "This is a sample form",
    questions: [
        {
            questionId: "1",
            text: "What is your name?",
            type: "TEXT"
        },
        {
            questionId: "2",
            text: "What is your age?",
            type: "NUMBER"
        }
    ]
};

gforms:Form createdForm = check googleFormsClient->createForm(form);
log:printInfo("Created Form: " + createdForm.toString());
```

## Examples

### Example 1: Create a Google Form

This example demonstrates how to create a Google Form with sample questions.

```ballerina
import ballerinax/googleapis.gforms;

gforms:Form form = {
    title: "Sample Form",
    description: "This is a sample form",
    questions: [
        {
            questionId: "1",
            text: "What is your name?",
            type: "TEXT"
        },
        {
            questionId: "2",
            text: "What is your age?",
            type: "NUMBER"
        }
    ]
};

gforms:Form createdForm = check googleFormsClient->createForm(form);
log:printInfo("Created Form: " + createdForm.toString());
```

### Example 2: Retrieve Responses from a Google Form

This example demonstrates how to retrieve responses from a Google Form.

```ballerina
import ballerinax/googleapis.gforms;

string formId = "<FORM_ID>";
gforms:Response[] responses = check googleFormsClient->getFormResponses(formId);
foreach gforms:Response response in responses {
    log:printInfo("Response: " + response.toString());
}
```

### Example 3: Update a Google Form

This example demonstrates how to update a Google Form by modifying its title and adding a new question.

```ballerina
import ballerinax/googleapis.gforms;

gforms:UpdateForm updateForm = {
    formId: "<FORM_ID>",
    title: "Updated Sample Form",
    questions: [
        {
            questionId: "3",
            text: "What is your favorite color?",
            type: "TEXT"
        }
    ]
};

gforms:Form updatedForm = check googleFormsClient->updateForm(updateForm);
log:printInfo("Updated Form: " + updatedForm.toString());
```

import ballerina/log;
import ballerinax/googleapis.gforms;

gforms:GoogleFormsClient googleFormsClient = check new ("<ACCESS_TOKEN>");

string formId = "<FORM_ID>";
gforms:Response[] responses = check googleFormsClient->getFormResponses(formId);
foreach gforms:Response response in responses {
    log:printInfo("Response: " + response.toString());
}

import ballerina/log;
import ballerinax/googleapis.gforms;

gforms:GoogleFormsClient googleFormsClient = check new ("<ACCESS_TOKEN>");

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

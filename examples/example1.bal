import ballerina/log;
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

gforms:GoogleFormsClient googleFormsClient = check new ("<ACCESS_TOKEN>");
gforms:Form createdForm = check googleFormsClient->createForm(form);
log:printInfo("Created Form: " + createdForm.toString());

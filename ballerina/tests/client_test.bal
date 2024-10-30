import ballerina/test;
import ballerinax/googleapis.gforms;

@test:Config {}
function testCreateForm() {
    gforms:Form form = {
        title: "Test Form",
        description: "This is a test form",
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
    test:assertEquals(createdForm.title, form.title);
    test:assertEquals(createdForm.description, form.description);
    test:assertEquals(createdForm.questions.length(), form.questions.length());
}

@test:Config {}
function testGetFormResponses() {
    gforms:GoogleFormsClient googleFormsClient = check new ("<ACCESS_TOKEN>");
    string formId = "<FORM_ID>";
    gforms:Response[] responses = check googleFormsClient->getFormResponses(formId);
    test:assertTrue(responses.length() > 0);
}

@test:Config {}
function testUpdateForm() {
    gforms:GoogleFormsClient googleFormsClient = check new ("<ACCESS_TOKEN>");
    gforms:UpdateForm updateForm = {
        formId: "<FORM_ID>",
        title: "Updated Test Form",
        questions: [
            {
                questionId: "3",
                text: "What is your favorite color?",
                type: "TEXT"
            }
        ]
    };

    gforms:Form updatedForm = check googleFormsClient->updateForm(updateForm);
    test:assertEquals(updatedForm.title, updateForm.title);
    test:assertEquals(updatedForm.questions.length(), updateForm.questions.length());
}

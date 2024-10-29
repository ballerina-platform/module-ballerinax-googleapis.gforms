// Copyright (c) 2024, WSO2 LLC. (http://www.wso2.com).
//
// WSO2 LLC. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.


import ballerina/http;
import ballerina/log;
import ballerina/oauth2;

public type Form record {
    string formId;
    string title;
    string description?;
    Question[] questions;
};

public type Question record {
    string questionId;
    string text;
    string type;
    string[] options?;
};

public type Response record {
    string responseId;
    string formId;
    map<anydata> answers;
};

public type UpdateForm record {
    string formId;
    string title?;
    string description?;
    Question[] questions?;
};

public type UpdateQuestion record {
    string questionId;
    string text?;
    string type?;
    string[] options?;
};

public type Error record {
    string message;
    int code;
};

public client class GoogleFormsClient {
    private final http:Client httpClient;
    private final string apiUrl = "https://forms.googleapis.com/v1";

    public function init(string accessToken) {
        self.httpClient = check new (self.apiUrl, {
            auth: {
                token: accessToken
            }
        });
    }

    public function createForm(Form form) returns Form|Error {
        http:Response response = check self.httpClient->post("/forms", form);
        if response.statusCode == 200 {
            return check response.getJsonPayload();
        } else {
            return Error {
                message: "Failed to create form",
                code: response.statusCode
            };
        }
    }

    public function getFormResponses(string formId) returns Response[]|Error {
        http:Response response = check self.httpClient->get("/forms/" + formId + "/responses");
        if response.statusCode == 200 {
            return check response.getJsonPayload();
        } else {
            return Error {
                message: "Failed to retrieve form responses",
                code: response.statusCode
            };
        }
    }

    public function updateForm(UpdateForm updateForm) returns Form|Error {
        http:Response response = check self.httpClient->patch("/forms/" + updateForm.formId, updateForm);
        if response.statusCode == 200 {
            return check response.getJsonPayload();
        } else {
            return Error {
                message: "Failed to update form",
                code: response.statusCode
            };
        }
    }
}

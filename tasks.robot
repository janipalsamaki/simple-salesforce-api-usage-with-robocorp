*** Settings ***
Documentation     Salesforce API examples.
...               Prerequisites:
...               1. Register a developer account.
...               2. View profile -> Settings -> Reset My Security Token
...               3. Set up Robocorp vault:
...               Vault name = salesforce
...               username = The username of the account you registered.
...               password = The password of the account you registered.
...               token = The token from the security token reset mail.
Library           Collections
Library           RPA.Robocorp.Vault
Library           RPA.Salesforce
Library           String
Suite Setup       Authenticate
Task Setup        Generate random name

*** Variables ***
${ACCOUNT_NAME}=    Burlington Textiles Corp of America
${CLOSE_DATE}=    2022-02-22
${OBJECT_TYPE}=    Opportunity
${STAGE_NAME}=    Closed Won

*** Tasks ***
Create a new Opportunity using the convenience keyword
    ${object_id}=
    ...    Create New Opportunity
    ...    close_date=${CLOSE_DATE}
    ...    opportunity_name=${RANDOM_NAME}
    ...    stage_name=${STAGE_NAME}
    ...    account_name=${ACCOUNT_NAME}
    ${opportunity}=    Get and log object    ${OBJECT_TYPE}    ${object_id}

Create a new Opportunity using the generic object creation keyword
    ${account}=
    ...    Salesforce Query Result As Table
    ...    SELECT Id FROM Account WHERE Name = '${ACCOUNT_NAME}'
    ${object_data}=
    ...    Create Dictionary
    ...    AccountId=${account}[0][0]
    ...    CloseDate=${CLOSE_DATE}
    ...    Name=${RANDOM_NAME}
    ...    StageName=${STAGE_NAME}
    ${object}=
    ...    Create Salesforce Object
    ...    object_type=${OBJECT_TYPE}
    ...    object_data=${object_data}
    ${opportunity}=    Get and log object    ${OBJECT_TYPE}    ${object}[id]

*** Keywords ***
Authenticate
    ${secret}=    Get Secret    salesforce
    Auth With Token
    ...    ${secret}[username]
    ...    ${secret}[password]
    ...    ${secret}[token]

Generate random name
    ${random_string}=    Generate Random String
    Set Suite Variable    ${RANDOM_NAME}    Random name ${random_string}

Get and log object
    [Arguments]    ${object_type}    ${object_id}
    ${object}=    Get Salesforce Object By Id    ${object_type}    ${object_id}
    Log Dictionary    ${object}
    [Return]    ${object}

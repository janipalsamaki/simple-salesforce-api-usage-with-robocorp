# Simple Salesforce API examples using Robocorp

This robot demonstrates how to use Salesforce API with Robocorp:

- Authenticate with a username, password, and a security token.
- Create a new Salesforce object.
- Query objects using Salesforce Object Query Language (SOQL).
- Describe a Salesforce object by type.
- Describe all picklist values for a Salesforce object field.
- Get the metadata for a Salesforce object.

For more information, see [`RPA.Salesforce`](https://robocorp.com/docs/libraries/rpa-framework/rpa-salesforce) library documentation.

## Prerequisites

1. [Register a Salesforce developer account](https://developer.salesforce.com/signup) (it's free).
2. `View profile` -> `Settings` -> `Reset My Security Token`
3. [Set up Robocorp vault](https://robocorp.com/docs/development-guide/variables-and-secrets/vault):

```json
{
  "salesforce": {
    "username": "The username of the account you registered.",
    "password": "The password of the account you registered.",
    "token": "The token from the security token reset mail."
  }
}
```

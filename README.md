# HelloID-Task-SA-Target-ActiveDirectory-GroupCreate

## Prerequisites

- [ ] HelloID API key and secret
- [ ] Pre-defined variables: `portalBaseUrl`, `portalApiKey` and `portalApiSecret` created in your HelloID portal.

## Description

This code snippet will create a new group within HelloID and executes the following tasks:

1. Define a hash table `$formObject`. The keys of the hash table represent the properties necessary to create a new group within `HelloID`, while the values represent the values entered in the form.

> To view an example of the form output, please refer to the JSON code pasted below.

```json
{
    "name": "John Doe's Group",
    "isEnabled": "true",
    "isDefault": "false",
    "userGuids": [
        "953d9fdb-e303-4c9a-8e97-7cae5c8c512b",
        "a74295b1-75a4-403c-86b8-021494c7fb72"
    ],
    "userNames": [
        "john.doe@enyoi.org",
        "jane.doe@enyoi.org"
    ],
    "applicationNames": [
        "Generic SAML Application",
        "Generic OIDC Application"
    ],
    "managedByUserGuid": "b27a9d33-d660-4f48-a338-e5013a688991",
    "applicationGUIDs": [
        "6937b1f8-9294-45b7-a0ed-ccba3bcff325"
    ]
}
```

> :exclamation: It is important to note that the names of your form fields might differ. Ensure that the `$formObject` hash table is appropriately adjusted to match your form fields.
> [See the HelloID API Docs page](https://apidocs.helloid.com/docs/helloid/0b84c01989115-add-a-group)

2. Creates authorization headers using the provided API key and secret.

3. Create a new group using the: `Invoke-RestMethod` cmdlet. The hash table called: `$formObject` is passed to the body of the: `Invoke-RestMethod` cmdlet as a JSON object.

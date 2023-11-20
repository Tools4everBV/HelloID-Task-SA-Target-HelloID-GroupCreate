# HelloID-Task-SA-Target-HelloID-GroupCreate
###########################################################
# Form mapping
$formObject = @{
    name              = $form.name
    isEnabled         = [bool]$form.isEnabled
    isDefault         = [bool]$form.isDefault
    userNames         = $form.userNames
    userGuids         = $form.userGuids
    managedByUserGuid = $form.managedByUserGuid
    applicationNames  = $form.applicationNames
    applicationGUIDs  = $form.applicationGUIDs
}

try {
    Write-Information "Executing HelloID action: [CreateResource] for Group: [$($formObject.name)]"
    Write-Verbose "Creating authorization headers"
    # Create authorization headers with HelloID API key
    $pair = "${portalApiKey}:${portalApiSecret}"
    $bytes = [System.Text.Encoding]::ASCII.GetBytes($pair)
    $base64 = [System.Convert]::ToBase64String($bytes)
    $key = "Basic $base64"
    $headers = @{"authorization" = $Key }

    Write-Verbose "Creating HelloIDGroup for: [$($formObject.name)]"
    $splatCreateUserParams = @{
        Uri         = "$($portalBaseUrl)/api/v1/groups"
        Method      = "POST"
        Body        = ([System.Text.Encoding]::UTF8.GetBytes(($formObject | ConvertTo-Json -Depth 10)))
        Verbose     = $false
        Headers     = $headers
        ContentType = "application/json"
    }
    $response = Invoke-RestMethod @splatCreateUserParams

    $auditLog = @{
        Action            = "CreateResource"
        System            = "HelloID"
        TargetIdentifier  = [String]$response.userGUID
        TargetDisplayName = [String]$response.userName
        Message           = "HelloID action: [CreateResource] for Group: [$($formObject.name)] executed successfully"
        IsError           = $false
    }
    Write-Information -Tags "Audit" -MessageData $auditLog

    Write-Information "HelloID action: [CreateResource] for Group: [$($formObject.name)] executed successfully"
}
catch {
    $ex = $_
    $auditLog = @{
        Action            = "CreateResource"
        System            = "HelloID"
        TargetIdentifier  = ""
        TargetDisplayName = [String]$formObject.userName
        Message           = "Could not execute HelloID action: [CreateResource] for Group: [$($formObject.name)], error: $($ex.Exception.Message)"
        IsError           = $true
    }
    if ($($ex.Exception.GetType().FullName -eq "Microsoft.PowerShell.Commands.HttpResponseException")) {
        $auditLog.Message = "Could not execute HelloID action: [CreateResource] for Group: [$($formObject.name)]"
        Write-Error "Could not execute HelloID action: [CreateResource] for Group: [$($formObject.name)], error: $($ex.ErrorDetails)"
    }
    Write-Information -Tags "Audit" -MessageData $auditLog
    Write-Error "Could not execute HelloID action: [CreateResource] for Group: [$($formObject.name)], error: $($ex.Exception.Message)"
}
###########################################################
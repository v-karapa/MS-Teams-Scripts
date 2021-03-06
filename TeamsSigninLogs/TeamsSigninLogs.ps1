﻿#creating token id
$input = get-content info.json | ConvertFrom-Json
$Client_Secret = $input.Client_Secret
$client_Id = $input.client_Id
$Tenantid = $input.Tenantid

 

#Grant Adminconsent 
$Grant= 'https://login.microsoftonline.com/common/adminconsent?client_id='
$admin = '&state=12345&redirect_uri=https://localhost:1234'
$Grantadmin = $Grant + $client_Id + $admin

 

start $Grantadmin
write-host "login with your tenant login detials to proceed further"

 

$proceed = Read-host " Press Y to continue "
if ($proceed -eq 'Y')
{
    write-host "Creating Access_Token"          
              $ReqTokenBody = @{
         Grant_Type    =  "client_credentials"
        client_Id     = "$client_Id"
        Client_Secret = "$Client_Secret"
        Scope         = "https://graph.microsoft.com/.default"
    } 

 

    $loginurl = "https://login.microsoftonline.com/" + "$Tenantid" + "/oauth2/v2.0/token"
    $Token = Invoke-RestMethod -Uri "$loginurl" -Method POST -Body $ReqTokenBody -ContentType "application/x-www-form-urlencoded"

 

    $Header = @{
        Authorization = "$($token.token_type) $($token.access_token)"
    }
  
         $Audits="https://graph.microsoft.com/v1.0/auditLogs/signIns"
         $AuditResults = Invoke-RestMethod -Headers $Header -Uri $Audits -Method get -ContentType 'application/json'
                 
         foreach($AuditResult in $AuditResults.value)
         {
         $AppDisplayName =$AuditResult.appDisplayName
         $createdDateTime =$AuditResult.createdDateTime
         $resourceDisplayName = $AuditResult.resourceDisplayName
         $status = $AuditResult.status
         $errorCode = $status.errorCode
         $userPrincipalName =$AuditResult.userPrincipalName
         $deviceDetail = $AuditResult.deviceDetail
         $isInteractive = $AuditResult.isInteractive
         $deviceDetails = [string]::Join("* ",$deviceDetail)


if((($AppDisplayName -eq "Microsoft Teams Web Client") -or ($AppDisplayName -eq "Microsoft Teams")) -and ($errorCode -eq "0") -and ("Microsoft Teams Chat Aggregator", "Office 365 Exchange Online", "Skype Presence Service", "Microsoft Stream Service", "Call Recorder"  -notcontains $resourceDisplayName))                

{
                $file = New-Object psobject
                $file | add-member -MemberType NoteProperty -Name UserUPN  $userPrincipalName
                $file | add-member -MemberType NoteProperty -Name CreatedDateTime $createdDateTime
                $file | add-member -MemberType NoteProperty -Name resourceDisplayName $resourceDisplayName
                $file | add-member -MemberType NoteProperty -Name AppDisplayName $AppDisplayName
                $file | add-member -MemberType NoteProperty -Name isInteractive $isInteractive
                $file | add-member -MemberType NoteProperty -Name deviceDetail $deviceDetails
                $file | export-csv Signinoutput.csv -NoTypeInformation -Append
                 }
            
         else{ 
                write-host ".."
              }
       
        }
         }
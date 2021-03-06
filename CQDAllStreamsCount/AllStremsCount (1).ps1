﻿
#write-host "Provide startDate and Enddate in DD-MM-YYYY(Ex:31-03-2020)"

param(
      [Parameter(Mandatory=$true)][System.DateTime]$StartDate,
      [Parameter(Mandatory=$true)][System.DateTime]$EndDate
      )

$dimensions = "AllStreams.Date","AllStreams.Media Type","AllStreams.Second UPN" 
 
$measures = "Measures.Total Stream Count","Measures.Audio Stream Count","Measures.Video Stream Count","Measures.AppSharing Stream Count","Measures.VBSS Stream Count"
#"Measures.Call Count","Measures.Audio Call Count","Measures.Video Call Count"

$CustomFilter = @()
$F1 = New-Object pscustomobject
$F1 | Add-Member -Type NoteProperty -Name FName -Value "AllStreams.Is Teams"
$F1 | Add-Member -Type NoteProperty -Name FValue -Value "1"
$F1 | Add-Member -Type NoteProperty -Name Op -Value 0
$CustomFilter += $F1

$F2 = New-Object pscustomobject
$F2 | Add-Member -Type NoteProperty -Name FName -Value "AllStreams.Second UserType"
$F2 | Add-Member -Type NoteProperty -Name FValue -Value "User"
$F2 | Add-Member -Type NoteProperty -Name Op -Value 0
$CustomFilter += $F2

  $CQDTableTemp= Get-CQDData -OutPutType CSV -OutPutFilePath cqdoutput.csv  -CQDVer V3 -LargeQuery -StartDate $StartDate -EndDate $EndDate -IsServerPair 'Client : Server','Client : Client'  `
    -Dimensions $dimensions -Measures $measures -customfilter $CustomFilter  -ShowQuery $true 

    

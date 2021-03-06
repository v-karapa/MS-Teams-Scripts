﻿Connect-MicrosoftTeams
$Groups= Import-Csv Input.csv
# $Groups

foreach($Group in $Groups)
{


$Teams = New-team -DisplayName $Group.TeamName  -Owner $group.Owner -Visibility $Group.Visibility

$groupid = $teams.GroupId
$teamchannel = New-TeamChannel -DisplayName $group.ChannelName -GroupId $groupid
$teamuser = Add-TeamUser -GroupId $groupid -User $group.Member -Role Member



if($Teams -ne $null)
{
            $file = New-Object psobject
            $file | add-member -MemberType NoteProperty -Name TeamName $Teams.DisplayName
            $file | add-member -MemberType NoteProperty -Name Teamid $Teams.groupid
            $file | add-member -MemberType NoteProperty -Name channelName $teamchannel.DisplayName
            $file | add-member -MemberType NoteProperty -Name channelId $teamchannel.ID
            $file | add-member -MemberType NoteProperty -Name TeamOwner $group.Owner
	        $file | add-member -MemberType NoteProperty -Name TeamMember $group.Member
            $file | export-csv output.csv  -NoTypeInformation -Append
            }
}



#### Description:
##### Prerequisites:
1. As an Administrator, type PowerShell in the start menu. Right-click Windows PowerShell, then select Run as Administrator.
Click Yes at the UAC prompt.

2. Type the following within PowerShell and then press Enter:\
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**`Install-Module MicrosoftTeams`**
  
3. Type Y at the prompt.Press Enter.
 
4. If you are prompted for an untrusted repository,then type A (Yes to All) and press Enter.The module will now install. 

Please fallow the below steps to create _Messaging policy_ for restricting Private Chat
1)	Install [SFB online connector](https://www.microsoft.com/en-us/download/details.aspx?id=39366)
2)	Run the **`Createmessaingpolicy.ps1`**
3) Provide the parameters `policyname` and `username`







<powershell>
$pwd = ConvertTo-SecureString 'r3dh4t1!' -AsPlainText -Force

$UserAccount = Get-LocalUser -Name "Administrator"
$UserAccount | Set-LocalUser -Password $pwd

Invoke-Expression -Command ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/ansible/ansible-documentation/devel/examples/scripts/ConfigureRemotingForAnsible.ps1')); Enable-WSManCredSSP -Role Server -Force
</powershell>
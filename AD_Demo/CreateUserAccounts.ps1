$newpass = read-host "enter the new password" -AsSecureString

$i = 1

while($i -ne 200)
{
    New-ADUser -DisplayName:"Test User$i" -GivenName:"Test" -Name:"Test User$i" -Path:"OU=UserAccounts,DC=test,DC=com" -SamAccountName:"usert$i" -Server:"PDC1.test.com" -Surname:"User$i" -Type:"user" -UserPrincipalName:"test.user$i@test.com"

    Set-ADAccountPassword -Identity:"CN=Test User$i,OU=UserAccounts,DC=test,DC=com" -NewPassword:$newpass -Reset:$false -Server:"PDC1.test.com"

    Enable-ADAccount -Identity:"CN=Test User$i,OU=UserAccounts,DC=test,DC=com" -Server:"PDC1.test.com"

    Set-ADAccountControl -AccountNotDelegated:$false -AllowReversiblePasswordEncryption:$false -CannotChangePassword:$false -DoesNotRequirePreAuth:$false -Identity:"CN=Test User$i,OU=UserAccounts,DC=test,DC=com" -PasswordNeverExpires:$false -Server:"PDC1.test.com" -UseDESKeyOnly:$false

    Set-ADUser -ChangePasswordAtLogon:$false -Identity:"CN=Test User$i,OU=UserAccounts,DC=test,DC=com" -Server:"PDC1.test.com" -SmartcardLogonRequired:$false

    $i++
}

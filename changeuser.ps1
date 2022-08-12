##Setting variables##
$domain = "DOMAIN"
$user = Read-Host -Prompt "Enter username of user to set computer login to. Press enter if you do not want to specify a user."
$username = "$domain\$user"
([wmi]"win32_userAccount.Domain='$domain',Name='$user'").sid | tee-object -variable sid
([wmi]"win32_userAccount.Domain='$domain',Name='$user'").fullname | Tee-Object -variable displayname
##Adding registry keys based on supplied username##
set-location -path Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Authentication\LogonUI
set-itemproperty -path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Authentication\LogonUI -name LastLoggedOnDisplayName $displayname
set-itemproperty -path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Authentication\LogonUI -name LastLoggedOnSAMUser $username
set-itemproperty -path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Authentication\LogonUI -name LastLoggedOnUser $username
set-itemproperty -path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Authentication\LogonUI -name LastLoggedOnUserSID $sid
##Clearing variables##
Clear-variable -name "displayname"
clear-variable -name "username"
clear-variable -name "sid"

$domain = "DOMAIN"
$user = Read-Host -Prompt "Enter username of user to set computer login to"
$username = "$domain\$user"
([wmi]"win32_userAccount.Domain='$domain',Name='$user'").sid | tee-object -variable sid
([wmi]"win32_userAccount.Domain='$domain',Name='$user'").fullname | Tee-Object -variable displayname
set-location -path Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Authentication\LogonUI
set-itemproperty -path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Authentication\LogonUI -name LastLoggedOnDisplayName $displayname
set-itemproperty -path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Authentication\LogonUI -name LastLoggedOnSAMUser $username
set-itemproperty -path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Authentication\LogonUI -name LastLoggedOnUser $username
set-itemproperty -path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Authentication\LogonUI -name LastLoggedOnUserSID $sid

$domain = "DOMAIN"
$user = Read-Host -Prompt "Enter admin username"
$password = Read-Host -prompt "Enter admin password" -AsSecureString
$username = "$domain\$user"
$credential = new-object system.management.automation.pscredential($username,$password)
add-computer -DomainName $domain -Credential $credential

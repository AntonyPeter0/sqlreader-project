$LoginName="sqladmin"
$LoginPassword="Azure@1234"
$ServerName="db-vm"
$DBQuery="CREATE DATABASE ${DatabaseName}"


Invoke-SqlCmd -ServerInstance $ServerName -U $LoginName -p $LoginPassword -Query $DBQuery


$LoginName="sqladmin"
$LoginPassword="Azure@1234"
$ServerName="db-vm"
$ScriptFile="https://${storage_account_name}.blob.core.windows.net/${container_name}/01.sql"
$Destination="D:\01.sql"


Invoke-WebRequest -Uri $ScriptFile -OutFile $Destination
Invoke-SqlCmd -ServerInstance $ServerName -InputFile $Destination -Database ${DatabaseName} -Username $LoginName -Password $LoginPassword

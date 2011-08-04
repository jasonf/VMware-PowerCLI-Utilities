Import-Module .\Module\Common.psm1

Disconnect-VIServer "*" -Force:$true
$vCenterCurrent = Read-Host "Name of the Current vCenter Server"

Connect-VIServer $vCenterCurrent

$datacenter = Menu (Get-Datacenter) "Select the datacenter to modify"

$cluster = Menu (Get-Cluster) "Select the Cluster to modify"

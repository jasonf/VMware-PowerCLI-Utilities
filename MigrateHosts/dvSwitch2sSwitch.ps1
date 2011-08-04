Import-Module ..\Modules\Common.psm1

$TESTING=$true

Disconnect-VIServer "*" -Force:$true

cls

$vCenterCurrent = Read-Host "Name of the Current vCenter Server"

Connect-VIServer $vCenterCurrent

$datacenter = Menu (Get-Datacenter | sort) "Select the datacenter to modify"

if($TESTING) {
	$cluster = Menu ($datacenter | Get-Cluster | where {$_.name -match "TEST" }| sort) "Select the Cluster to modify"
} else {
	$cluster = Menu ($datacenter | Get-Cluster | sort) "Select the Cluster to modify"
}

$vmhost = Menu ($cluster | Get-VMhost | sort) "Select the Host to modify"

$dvSwitches = Get-VirtualSwitch -distributed $vmhost

for ($i = 0; $i -lt $dvSwitches.count; $i++ ) {
	$dvsw_name = $dvSwitches[$i].name
	$dvsw_mtu = $dvSwitches[$i].mtu
	if($dvsw_name -match "dvSW(.*)") {
	    $vsw_name = 'vSwitch-Migrate' + $matches[1]
		New-VirtualSwitch -Name $vsw_name -NumPorts 256 -MTU $dvsw_mtu -VMHost $vmhost -Confirm
	} else {
	  Write-Host "Unknown switch name format" -ForegroundColor Red
	}
}
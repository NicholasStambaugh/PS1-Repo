# check network connectivity
function Check-NetworkConnectivity {
    param (
        [Parameter(Mandatory=$true)]
        [string]$IPAddress
    )

    $pingResult = Test-Connection -ComputerName $IPAddress -Count 1 -Quiet

    if ($pingResult) {
        Write-Host "Network connectivity to $IPAddress is successful."
    } else {
        Write-Host "Network connectivity to $IPAddress failed."
    }
}

# check device status
function Get-DeviceStatus {
    param (
        [Parameter(Mandatory=$true)]
        [string]$DeviceName
    )

    $status = Get-Service -Name $DeviceName -ErrorAction SilentlyContinue

    if ($status) {
        Write-Host "Device $DeviceName is running."
    } else {
        Write-Host "Device $DeviceName is not running."
    }
}

# Main
Write-Host "Welcome to Network Monitoring Script!"

# user input
$choice = Read-Host "Please select an option: `n1. Check network connectivity`n2. Check device status"

if ($choice -eq "1") {
    $ipAddress = Read-Host "Enter the IP address to check network connectivity"
    Check-NetworkConnectivity -IPAddress $ipAddress
} elseif ($choice -eq "2") {
    $deviceName = Read-Host "Enter the device name to check status"
    Get-DeviceStatus -DeviceName $deviceName
} else {
    Write-Host "Invalid choice. Exiting script."
}

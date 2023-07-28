# IP address of the machine
function Get-IPAddress {
    $ipConfig = Get-WmiObject -Class Win32_NetworkAdapterConfiguration | Where-Object { $_.IPAddress -ne $null }
    $ipConfig.IPAddress
}

# MAC address of the machine
function Get-MACAddress {
    $macConfig = Get-WmiObject -Class Win32_NetworkAdapterConfiguration | Where-Object { $_.MACAddress -ne $null }
    $macConfig.MACAddress
}

# default gateway of the machine
function Get-DefaultGateway {
    $gatewayConfig = Get-WmiObject -Class Win32_NetworkAdapterConfiguration | Where-Object { $_.DefaultIPGateway -ne $null }
    $gatewayConfig.DefaultIPGateway
}

# DNS servers of the machine
function Get-DNSServers {
    $dnsConfig = Get-WmiObject -Class Win32_NetworkAdapterConfiguration | Where-Object { $_.DNSServerSearchOrder -ne $null }
    $dnsConfig.DNSServerSearchOrder
}

# network adapter information of the machine
function Get-NetworkAdapterInfo {
    $adapterInfo = Get-WmiObject -Class Win32_NetworkAdapter | Where-Object { $_.NetEnabled -eq $true }
    $adapterInfo | Select-Object Name, AdapterType, Speed, Manufacturer
}


Write-Host "IP Address: $(Get-IPAddress)"
Write-Host "MAC Address: $(Get-MACAddress)"
Write-Host "Default Gateway: $(Get-DefaultGateway)"
Write-Host "DNS Servers: $(Get-DNSServers)"
Write-Host "Network Adapter Information:"
Get-NetworkAdapterInfo

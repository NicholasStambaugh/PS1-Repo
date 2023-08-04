function Get-SystemInfo {
    $cpuInfo = Get-WmiObject Win32_Processor
    $memoryInfo = Get-WmiObject Win32_OperatingSystem
    $diskInfo = Get-WmiObject Win32_LogicalDisk -Filter "DriveType = 3"
    $networkInfo = Get-WmiObject Win32_NetworkAdapter | Where-Object { $_.NetConnectionStatus -eq 2 }

    $systemInfo = @{
        'ComputerName' = $env:COMPUTERNAME
        'CPU' = $cpuInfo.Name
        'Cores' = $cpuInfo.NumberOfCores
        'Memory' = "{0:N2} GB" -f ($memoryInfo.TotalVisibleMemorySize / 1GB)
        'FreeMemory' = "{0:N2} GB" -f ($memoryInfo.FreePhysicalMemory / 1GB)
        'DiskUsage' = $diskInfo | ForEach-Object {
            "{0} ({1}) - {2:P0} Free" -f $_.DeviceID, $_.VolumeName, ($_.FreeSpace / $_.Size)
        }
        'NetworkAdapter' = $networkInfo.Name
        'IPv4Address' = $networkInfo | ForEach-Object { $_.IPAddress[0] }
    }

    return $systemInfo
}

function Show-SystemInfo {
    $systemInfo = Get-SystemInfo

    Write-Host "System Information"
    Write-Host "------------------"

    Write-Host "Computer Name: $($systemInfo.ComputerName)"
    Write-Host "CPU: $($systemInfo.CPU)"
    Write-Host "Cores: $($systemInfo.Cores)"
    Write-Host "Memory: $($systemInfo.Memory)"
    Write-Host "Free Memory: $($systemInfo.FreeMemory)"
    
    Write-Host "`nDisk Usage:"
    $systemInfo.DiskUsage | ForEach-Object {
        Write-Host "- $_"
    }
    
    Write-Host "Network Adapter: $($systemInfo.NetworkAdapter)"
    Write-Host "IPv4 Address: $($systemInfo.IPv4Address)"
}

Show-SystemInfo

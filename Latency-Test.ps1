# check network connectivity
function Test-NetworkConnection {
    param (
        [Parameter(Mandatory=$true)]
        [string]$IPAddress
    )

    $pingResult = Test-Connection -ComputerName $IPAddress -Count 1 -Quiet

    if ($pingResult) {
        Write-Host "Network connection to $IPAddress is successful."
    } else {
        Write-Host "Network connection to $IPAddress failed."
    }
}

# check network latency
function Measure-NetworkLatency {
    param (
        [Parameter(Mandatory=$true)]
        [string]$IPAddress
    )

    $pingResult = Test-Connection -ComputerName $IPAddress -Count 5

    $averageLatency = ($pingResult | Measure-Object -Property ResponseTime -Average).Average

    Write-Host "Average network latency to $IPAddress is $averageLatency ms."
}

# check network bandwidth
function Measure-NetworkBandwidth {
    param (
        [Parameter(Mandatory=$true)]
        [string]$IPAddress
    )

    $downloadSpeed = Measure-Command {
        $null = Invoke-WebRequest -Uri "http://$IPAddress/speedtest" -OutFile $env:TEMP\speedtest.bin
    }

    $downloadSpeed = ($downloadSpeed.TotalMilliseconds / 1000) - 2

    Write-Host "Network bandwidth to $IPAddress is approximately $downloadSpeed Mbps."
}

# Main script logic
$IPAddress = Read-Host "Enter the IP address to test network connectivity, latency, and bandwidth:"

Test-NetworkConnection -IPAddress $IPAddress
Measure-NetworkLatency -IPAddress $IPAddress
Measure-NetworkBandwidth -IPAddress $IPAddress

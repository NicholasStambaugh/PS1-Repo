# Enable transcription logging
$transcriptionPath = "C:\log"
if (-not (Test-Path $transcriptionPath)) {
    New-Item -ItemType Directory -Path $transcriptionPath | Out-Null
}
$transcriptionFile = Join-Path $transcriptionPath -ChildPath "PowerShellTranscript_$(Get-Date -Format 'yyyyMMdd_HHmmss').txt"
Start-Transcript -Path $transcriptionFile -Force


# Set the output directory, this is where the CSV files will be stored 
# (talk to Keith)
$outputDirectory = "C:\log"

# Create the output directory if it doesn't exist, default C drive
if (-not (Test-Path $outputDirectory)) {
    New-Item -ItemType Directory -Path $outputDirectory | Out-Null
}

# Listing contents of C:\users
Write-Host "Listing contents of C:\users:"
$usersContents = Get-ChildItem -Path C:\users
$usersContents | Export-Csv -Path "$outputDirectory\UsersContents.csv" -NoTypeInformation
Write-Host "Exported contents of C:\users to $outputDirectory\UsersContents.csv"

# Hostname
Write-Host "`nHostname:"
$hostname = hostname
$hostnameObject = New-Object PSObject -Property @{
    Hostname = $hostname
}
$hostnameObject | Export-Csv -Path "$outputDirectory\Hostname.csv" -NoTypeInformation
Write-Host "Exported hostname to $outputDirectory\Hostname.csv"


# Running Processes
Write-Host "`nRunning Processes:"
$processes = Get-Process
$processes | Export-Csv -Path "$outputDirectory\RunningProcesses.csv" -NoTypeInformation
Write-Host "Exported running processes to $outputDirectory\RunningProcesses.csv"

# Installed Software
Write-Host "`nInstalled Software:"
$installedSoftware = Get-WmiObject -Query "SELECT * FROM Win32_Product" | Select-Object Name, Version, InstallDate
$installedSoftware | Export-Csv -Path "$outputDirectory\InstalledSoftware.csv" -NoTypeInformation
Write-Host "Exported installed software to $outputDirectory\InstalledSoftware.csv"

# Network Connections
Write-Host "`nNetwork Connections:"
$networkConnections = Get-NetTCPConnection
$networkConnections | Export-Csv -Path "$outputDirectory\NetworkConnections.csv" -NoTypeInformation
Write-Host "Exported network connections to $outputDirectory\NetworkConnections.csv"

# Active Network Interfaces
Write-Host "`nNetwork Interfaces:"
$networkInterfaces = Get-NetAdapter | Select-Object Name, InterfaceDescription, MacAddress, Status, Speed
$networkInterfaces | Export-Csv -Path "$outputDirectory\NetworkInterfaces.csv" -NoTypeInformation
Write-Host "Exported network interfaces to $outputDirectory\NetworkInterfaces.csv"

# Active Network Connections
Write-Host "`nActive Network Connections:"
$activeNetworkConnections = Get-NetConnectionProfile
$activeNetworkConnections | Export-Csv -Path "$outputDirectory\ActiveNetworkConnections.csv" -NoTypeInformation
Write-Host "Exported active network connections to $outputDirectory\ActiveNetworkConnections.csv"

# Firewall
Write-Host "`nFirewall Rules:"
$firewallRules = Get-NetFirewallRule | Select-Object DisplayName, Direction, Enabled, Action, Profile
$firewallRules | Export-Csv -Path "$outputDirectory\FirewallRules.csv" -NoTypeInformation
Write-Host "Exported firewall rules to $outputDirectory\FirewallRules.csv"

# Event logs
Write-Host "`nExporting Event Logs to CSV:"
$logs = @("System", "Application")
foreach ($log in $logs) {
    $events = Get-EventLog -LogName $log
    $events | Export-Csv -Path "$outputDirectory\$log-EventLog.csv" -NoTypeInformation
    Write-Host "Exported events from $log to $outputDirectory\$log-EventLog.csv"
}

# Scheduled Tasks
Write-Host "`nScheduled Tasks:"
$scheduledTasks = Get-ScheduledTask | Select-Object TaskName, TaskPath, State, NextRunTime
$scheduledTasks | Export-Csv -Path "$outputDirectory\ScheduledTasks.csv" -NoTypeInformation
Write-Host "Exported scheduled tasks to $outputDirectory\ScheduledTasks.csv"

# Startup Programs
Write-Host "`nStartup Programs:"
$startupPrograms = Get-CimInstance Win32_StartupCommand | Select-Object Name, Command, Location, User
$startupPrograms | Export-Csv -Path "$outputDirectory\StartupPrograms.csv" -NoTypeInformation
Write-Host "Exported startup programs to $outputDirectory\StartupPrograms.csv"

# Services
Write-Host "`nServices:"
$services = Get-Service | Select-Object DisplayName, ServiceName, Status
$services | Export-Csv -Path "$outputDirectory\Services.csv" -NoTypeInformation
Write-Host "Exported services to $outputDirectory\Services.csv"

# Recently Modified
Write-Host "`nRecently Modified Files in C:\users:"
$recentlyModifiedFiles = Get-ChildItem -Path C:\users | Where-Object { $_.LastWriteTime -gt (Get-Date).AddDays(-7) } | Select-Object FullName, LastWriteTime
$recentlyModifiedFiles | Export-Csv -Path "$outputDirectory\RecentlyModifiedFiles.csv" -NoTypeInformation
Write-Host "Exported recently modified files to $outputDirectory\RecentlyModifiedFiles.csv"

# End
Write-Host "`nScript execution completed."

# Check for errors
if ($Error) {
    Write-Host "`nErrors occurred. Check the PowerShell console for details."
    # Output errors to the console
    $Error | ForEach-Object { Write-Host $_.Exception.Message }
}

# Stop PowerShell Transcription Logging
Stop-Transcript

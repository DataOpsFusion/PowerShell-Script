# This script is designed to be run as a scheduled task on Windows.
# It will check for updates to all installed applications using Windows Package Manager (winget) and log the results to a file.
# The script will run weekly at 2:00 AM.

$location = "C:\ProgramData\Update.txt"

if (-not (Test-Path $location)) {
    # Create the file if it doesn't exist
    New-Item -Path $location -ItemType File -Force | Out-Null
}

Register-ScheduledJob -Name "Update-Weekly" -ScriptBlock {
    $currentDate = Get-Date
    $location = "C:\ProgramData\Update.txt"
    # Convert the content to a datetime value
    
    Write-Host "Running update script..."
    winget update --all --silent --accept-source-agreements --accept-package-agreements *> "$location.log"

    # Append the current date to the log file to record the update time

    $currentDate | Out-File $location -Append
    Write-Host "Update script completed. Log file: $location.log"
} -Trigger (New-JobTrigger - -At "02:00")


# This script is designed to be run as a scheduled job on Windows.
# It will check for updates to all installed applications using Windows Package Manager (winget) and log the results to a file.

$logPath = "C:\ProgramData\WingetUpdateLog.txt"

if (-not (Test-Path $logPath)) {
    # Create the file if it doesn't exist
    New-Item -Path $logPath -ItemType File -Force | Out-Null
}

# Remove existing scheduled job if exists
if (Get-ScheduledJob -Name "Update-Weekly" -ErrorAction SilentlyContinue) {
    Unregister-ScheduledJob -Name "Update-Weekly" -Force
}

Register-ScheduledJob -Name "Update-Weekly" -ScriptBlock {
    $currentDate = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $logPath = "C:\ProgramData\WingetUpdateLog.txt"
    
    Add-Content -Path $logPath -Value "========== Update Run: $currentDate =========="

    try {
        winget update --all --silent --accept-source-agreements --accept-package-agreements | Out-File -FilePath $logPath -Append
    }
    catch {
        Add-Content -Path $logPath -Value "Error running winget update."
    }

    Add-Content -Path $logPath -Value "========== Update Complete ==========`n"
    
} -Trigger (New-JobTrigger -Weekly -DaysOfWeek Monday -At 2:00AM) -RunNow:$false

Write-Host "Scheduled Job 'Update-Weekly' created successfully." -ForegroundColor Green
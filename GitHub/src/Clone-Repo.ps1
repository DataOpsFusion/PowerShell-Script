# Clone a repo based on provided URL and location
# This script will clone a git repo in specified location or use a default

function Check-Package {
    param (
        [string]$Package
    )
    if (Get-Command $Package -ErrorAction SilentlyContinue) {
        Write-Host "$Package is installed."
    }
    else {
        Write-Host "$Package is NOT installed." -ForegroundColor Red
        Write-Host "Exiting script." -ForegroundColor Red
        exit 1
    }
}

Write-Host "This script will clone a repository that you provide at your intended location."
Write-Host "Please make sure that you have administrative privileges to run this shell."
Write-Host "Default location: C:\ProgramData\Github\"
$confirmation = Read-Host "Type Y to continue or N to exit."

$RequirementPackages = @('git')

if ($confirmation -ne 'Y') {
    Write-Host "Exiting script." -ForegroundColor Red
    exit
}
else {
    foreach ($element in $RequirementPackages) {
        Check-Package -Package $element
    }

    $URL = Read-Host "Please provide a URL of that repository: "
    $Path = Read-Host "Please provide an absolute path or it will use default location: "
    if ([string]::IsNullOrEmpty($URL)) {
        Write-Host "URL is not provide." -ForegroundColor Red
        Write-Host "Exiting script." -ForegroundColor Red
        exit 1
    }
    if ([string]::IsNullOrEmpty($Path)) {
        Write-Host "Will use the default location for installation" -ForegroundColor Yellow
        $Path = "C:\ProgramData\Github\"
    }

    if (-not (Test-Path -Path $Path)) {
        Write-Host "Path '$Path' does not exist. Creating it now..." -ForegroundColor Yellow
        New-Item -ItemType Directory -Path $Path -Force | Out-Null
    }
    else {
        Write-Host "Path '$Path' already exists. Skipping creation." -ForegroundColor Green
    }

    Write-Host "Start clone the repo..."
    git clone "$URL" "$Path"
}


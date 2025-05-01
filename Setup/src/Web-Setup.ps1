# This script installs Visual Studio Code, Git, and Node.js (including npm) using Windows Package Manager (winget).

Write-Host "This script will install Visual Studio Code, Git, and Node.js (npm included) on your system." -ForegroundColor Green
Write-Host "Please ensure you have administrative privileges to run this script." -ForegroundColor Yellow
Write-Host "Do you want to continue? (Y/N)" -ForegroundColor Cyan
$confirmation = Read-Host "Type Y to continue or N to exit"

function Check-Requirement {
    if (-not (Get-Command winget -ErrorAction SilentlyContinue)) {
        Write-Host "Winget is not installed or not available. Please install Winget first." -ForegroundColor Red
        exit
    }
}

if ($confirmation -ne 'Y') {
    Write-Host "Exiting script." -ForegroundColor Red
    exit
}

Write-Host "Continuing with installation..." -ForegroundColor Green

Check-Requirement

# Install Visual Studio Code
Write-Host "Installing Visual Studio Code..." -ForegroundColor Cyan
winget install -e --id Microsoft.VisualStudioCode

# Install Git
Write-Host "Installing Git..." -ForegroundColor Cyan
winget install -e --id Git.Git

# Install Node.js (npm included)
Write-Host "Installing Node.js..." -ForegroundColor Cyan
winget install -e --id OpenJS.NodeJS

Write-Host "Installation completed successfully!" -ForegroundColor Green
Write-Host "Please restart your terminal or command prompt to ensure all changes take effect." -ForegroundColor Yellow
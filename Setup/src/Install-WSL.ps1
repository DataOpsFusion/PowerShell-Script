# This script aims to automate WSL setup

function Install-Distro {
    param (
        [string]$Distro = "Ubuntu-22.04"
    )

    Write-Host "Installing WSL with $Distro..." -ForegroundColor Green
    wsl --install -d $Distro
    wsl --set-default-version 2
    wsl --set-default $Distro
    Write-Host "WSL installation completed." -ForegroundColor Green
}

function Check-Requirement {
    if ($PSVersionTable.PSVersion.Major -lt 5) {
        Write-Host "PowerShell version 5 or higher is required." -ForegroundColor Red
        exit
    }
}

function List-Distro {
    # List all available distributions
    Write-Host "Available distributions:" -ForegroundColor Green
    wsl --list --online

    Write-Host "Please choose a distribution to install." -ForegroundColor Yellow
    $Distro = Read-Host "Enter the name of the distribution (e.g., Ubuntu-22.04)"
    return $Distro
}

Write-Host "This script will install WSL and a specified Linux distribution on your system." -ForegroundColor Green
Write-Host "Please ensure you have administrative privileges to run this script." -ForegroundColor Yellow
$response = Read-Host "Do you want to continue? (Y/N)"

if ($response -ne 'Y') {
    Write-Host "Exiting script." -ForegroundColor Red
    exit
}

Write-Host "Continuing with installation..." -ForegroundColor Green
Check-Requirement

$Distro = List-Distro
if ([string]::IsNullOrWhiteSpace($Distro)) {
    Write-Host "No distribution selected. Exiting." -ForegroundColor Red
    exit
}

Install-Distro -Distro $Distro

Write-Host "Please restart your terminal or command prompt to ensure all changes take effect." -ForegroundColor Yellow
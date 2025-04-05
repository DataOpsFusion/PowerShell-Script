#This script will aim to automate setup wsl

function install_distro{
    # Try to install distro you want but fall to Ubuntu if it fails
    param (
        [string]$distro = "Ubuntu-22.04"
    )

    Write-Host "Installing WSL with $distro..." -ForegroundColor Green
    wsl --install -d $distro --update --import --version 2
    Write-Host "WSL installation completed." -ForegroundColor Green

    wsl --set-default $($distro)
}

function check_requirement {
    if ($PSVersionTable.PSVersion.Major -lt 5) {
        Write-Host "PowerShell version 5 or higher is required." -ForegroundColor Red
        exit
    }

}

function list_distro {
    # List all available distributions
    Write-Host "Available distributions:" -ForegroundColor Green
    wsl --list --online

    Write-Host "Please choose a distribution to install." -ForegroundColor Yellow
    $distro = Read-Host "Enter the name of the distribution (e.g., Ubuntu-22.04)"
    return $distro
}


Write-Host "This script will install WSL and a specified Linux distribution on your system." -ForegroundColor Green
Write-Host "Please ensure you have administrative privileges to run this script." -ForegroundColor Yellow
Write-Host "Do you want to continue? (Y/N)" -ForegroundColor Cyan
$response = Read-Host "Type Y to continue or N to exit"
if ($response -ne 'Y') {
    Write-Host "Exiting script." -ForegroundColor Red
    exit
} else {
    Write-Host "Continuing with installation..." -ForegroundColor Green
    check_requirement
    $distro = list_distro
    if ($distro -eq "") {
        Write-Host "No distribution selected. Exiting." -ForegroundColor Red
        exit
    } else {
        Write-Host "Installing WSL with $distro..." -ForegroundColor Green
        install_distro -distro $distro
    }
    install_distro -distro $distro
    Write-Host "WSL installation completed." -ForegroundColor Green
    Write-Host "Installation completed." -ForegroundColor Green
    Write-Host "Please restart your terminal or command prompt to ensure all changes take effect." -ForegroundColor Yellow
}
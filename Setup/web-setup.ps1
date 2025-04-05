# Install vsc, git, node and npm
# This script installs Visual Studio Code, Git, Node.js, and npm using Windows Package Manager (winget).
Write-Host "This script will install Visual Studio Code, Git, Node.js, and npm on your system." -ForegroundColor Green
Write-Host "Please ensure you have administrative privileges to run this script." -ForegroundColor Yellow
Write-Host "Do you want to continue? (Y/N)" -ForegroundColor Cyan
$confirmation = Read-Host "Type Y to continue or N to exit"

if ($confirmation -ne 'Y') {
    Write-Host "Exiting script." -ForegroundColor Red
    exit
} else {
    Write-Host "Continuing with installation..." -ForegroundColor Green
    winget install -e --id Microsoft.VisualStudioCode
    winget install -e --id Microsoft.Nodejs
    winget install -e --id Microsoft.npm
    winget install -e --id Git.Git
    Write-Host "Installation completed." -ForegroundColor Green
    Write-Host "Please restart your terminal or command prompt to ensure all changes take effect." -ForegroundColor Yellow
}
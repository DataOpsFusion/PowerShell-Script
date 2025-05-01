# This script deletes a user from the system.
# It checks if the user exists and, if so, deletes the user with the provided username.

function Delete-User {
    param (
        [Parameter(Mandatory = $true)]
        [string]$Username
    )

    try {
        $existingUser = Get-LocalUser -Name $Username -ErrorAction SilentlyContinue
        if ($existingUser) {
            Remove-LocalUser -Name $Username
            Write-Host "User '$Username' deleted successfully." -ForegroundColor Green
        }
        else {
            Write-Host "User '$Username' does not exist." -ForegroundColor Yellow
        }
    }
    catch {
        Write-Host "Failed to delete user '$Username'. Error: $($_.Exception.Message)" -ForegroundColor Red
    }
}


# Prompt the user for input
Write-Host "Remove a user..." -ForegroundColor Cyan
$Username = Read-Host "Enter username"

Write-Host "This script will try to remove a user on your system." -ForegroundColor Green
Write-Host "Please have a backup for all important file" -ForegroundColor Green

$response = Read-Host "Do you want to continue? (Y/N)"

if ($response -ne 'Y') {
    Write-Host "Exiting script." -ForegroundColor Red
    exit
} 

else {
    Delete-User -Username $Username
    Write-Host "Please restart your terminal or command prompt to ensure all changes take effect." -ForegroundColor Yellow
}

# This script creates a new user in the system.
# It checks if the user already exists and if not, creates a new user with the provided username and password.

function Create-NewUser {
    param (
        [Parameter(Mandatory = $true)]
        [string]$Username,

        [Parameter(Mandatory = $true)]
        [SecureString]$Password
    )

    try {
        $existingUser = Get-LocalUser -Name $Username -ErrorAction SilentlyContinue
        if ($existingUser) {
            Write-Host "User '$Username' already exists." -ForegroundColor Yellow
            return
        }

        New-LocalUser -Name $Username -Password $Password -Description "Created by script"
        Write-Host "User '$Username' created successfully." -ForegroundColor Green
    }
    catch {
        Write-Host "Failed to create user '$Username'. Error: $($_.Exception.Message)" -ForegroundColor Red
    }
}

# Prompt the user for input
Write-Host "Creating a new user..." -ForegroundColor Cyan
$Username = Read-Host "Enter username"
$Password = Read-Host "Enter password" -AsSecureString

# Call the function
Create-NewUser -Username $Username -Password $Password

Write-Host "User creation process completed." -ForegroundColor Green
Write-Host "Please restart your terminal or command prompt to ensure all changes take effect." -ForegroundColor Yellow
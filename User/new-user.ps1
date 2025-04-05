# This script creates a new user in the system.
# It checks if the user already exists and if not, creates a new user with the provided username, password, and email.


function create_new_user {
    param (
        [string]$username,
        [string]$password,
        [string]$email
    )
    # Check for existing uer
    $existingUser = Get-LocalUser -Name $username -ErrorAction SilentlyContinue
    if ($existingUser) {
        Write-Host "User $username already exists."
        return
    } else {
        try {
            New-LocalUser -Name $username -Password (ConvertTo-SecureString $password -AsPlainText -Force) -Description "Created by script" -EmailAddress $email
            Write-Host "User $username created successfully."
        } catch {
            Write-Host "Failed to create user $username. Error: $_"
        }
    }
}

Write-Host "Creating new user..."
$username = Read-Host "Enter username"
$password = Read-Host "Enter password" -AsSecureString
$email = Read-Host "Enter email address"
create_new_user -username $username -password $password -email $email
Write-Host "User creation process completed."
Write-Host "Please restart your terminal or command prompt to ensure all changes take effect." -ForegroundColor Yellow
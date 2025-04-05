# This script delete user in the system
# It checks if the user exists and if so, deletes the user with the provided username.


function delete_user {
    param (
        [string]$username
    )
    try {
        $existingUser = Get-LocalUser -Name $username -ErrorAction SilentlyContinue
        if ($existingUser) {
            Remove-LocalUser -Name $username
            Write-Host "User $username deleted successfully."
        } else {
            Write-Host "User $username does not exist."
        }
    } catch {
        Write-Host "Failed to delete user $username. Error: $_"
    }
}
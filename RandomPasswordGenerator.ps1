function Get-RandomPassword {
    param (
        [int]$Length = 12,
        [switch]$IncludeUppercase,
        [switch]$IncludeLowercase,
        [switch]$IncludeNumbers,
        [switch]$IncludeSpecialCharacters
    )

    $uppercaseLetters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
    $lowercaseLetters = 'abcdefghijklmnopqrstuvwxyz'
    $numbers = '0123456789'
    $specialCharacters = '!@#$%^&*()_-+=<>?/[]{}|'

    $characterSets = @()

    if ($IncludeUppercase) { $characterSets += $uppercaseLetters }
    if ($IncludeLowercase) { $characterSets += $lowercaseLetters }
    if ($IncludeNumbers) { $characterSets += $numbers }
    if ($IncludeSpecialCharacters) { $characterSets += $specialCharacters }

    if (-not $characterSets) {
        Write-Error "You must include at least one character set (Uppercase, Lowercase, Numbers, or Special Characters)."
        return
    }

    $random = New-Object System.Random
    $password = 1..$Length | ForEach-Object { $characterSets[$random.Next(0, $characterSets.Count)] }
    return -join $password
}

# Example usage:
$randomPassword = Get-RandomPassword -Length 16 -IncludeUppercase -IncludeLowercase -IncludeNumbers -IncludeSpecialCharacters
Write-Host "Random Password: $randomPassword"

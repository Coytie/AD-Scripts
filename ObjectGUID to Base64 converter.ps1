#########################
# Author: Brenden Coyte #
# Date: 21/11/2024      #
# Version 1.0           #
#########################

# Input AD Username
$ADUser = Read-Host "Please Input AD User"

# Gets AD user's ObjectGUID and converts to Hex
$ObjectGUIDHex = Get-ADUser -Identity $ADUser -Properties ObjectGUID | Select-Object -Property @{Name='HexObjectGUID'; Expression={-join ($_.ObjectGUID.ToByteArray() | ForEach-Object { "{0:X2}" -f $_ })}} | ft -Wrap -HideTableHeaders | Out-String -NoNewline

# Converts the Hexadecimal ObjectGUID to its bytes data
$bytes = [byte[]] -split ($ObjectGUIDHex -replace '..', '0x$& ')

# Converts the Bytes data to Base64
[Convert]::ToBase64String($bytes)

###################################################################################
#
#    Script:    evil_deobfuscator_b64uc_gz_xor.ps1
#    Version:   1.0
#    Author:    Dan Saunders
#    Contact:   dan.saunders@global.ntt
#    Purpose:   Decode Malicious Base64 UTF-16LE (Unicode) > GZip > XOR Payload & dumps to .txt file
#    Usage:     .\evil_deobfuscator_b64uc_gz_xor.ps1
#
#    This program is free software: you can redistribute it and / or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program. If not, see <https://www.gnu.org/licenses/>.
#
###################################################################################

$version = "v1.0"

# System Date/Time
$timestamp = ((Get-Date).ToString('yyyyMMdd_HHmmss'))

########## Startup ##########

Write-Host "
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Script: evil_deobfuscator_b64uc_gz_xor.ps1 - $version - Author: Dan Saunders dcscoder@gmail.com

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"

########## Layer 1 - Base64 UTF-16LE (Unicode) ##########

$payload = Read-Host -Prompt "
Insert Layer 1 (Evil Base64 Payload) ->"

$layer1 = [System.Text.Encoding]::Unicode.GetString([System.Convert]::FromBase64String($payload))

Write-Host "
Layer 1 decoded... Base64 UTF-16LE (Unicode) data." -ForegroundColor red -BackgroundColor black

Write-Host "
$layer1"  -ForegroundColor green -BackgroundColor black

$layer1 | Out-File $timestamp-evil_layer_1.txt

########## Layer 2 - Base64 & GZip Compressed ##########

$layer2 = Read-Host -Prompt "
Insert Layer 2"

$layer2 = [System.Convert]::FromBase64String($layer2)
$ms = New-Object System.IO.MemoryStream
$ms.Write($layer2, 0, $layer2.Length)
$ms.Seek(0,0)
$cs = New-Object System.IO.Compression.GZipStream($ms, [System.IO.Compression.CompressionMode]::Decompress)
$sr = New-Object System.IO.StreamReader($cs)
$layer2 = $sr.readtoend()

Write-Host "
Layer 2 decoded... Base64 & GZip Compressed." -ForegroundColor red -BackgroundColor black

Write-Host "
$layer2"  -ForegroundColor green -BackgroundColor black

$layer2 | Out-File $timestamp-evil_layer_2.txt

########## Layer 3 - Base64 & XOR ##########

$layer3 = Read-Host -Prompt "
Insert Layer 3"

$key = 35
$string = [System.Convert]::FromBase64String($layer3)
for($counter = 0; $counter -lt $string.Length; $counter++)
{
    $string[$counter] = $string[$counter] -bxor $key
}
$layer3 = [System.Text.Encoding]::ASCII.GetString($string)

Write-Host "
Layer 3 decoded... Base64 & XOR data." -ForegroundColor red -BackgroundColor black

Write-Host "
$layer3" -ForegroundColor green -BackgroundColor black

$layer3 | Out-File $timestamp-evil_layer_3.txt

Write-Host "
Script completed - review above code!" -ForegroundColor yellow -BackgroundColor black
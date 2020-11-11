###################################################################################
#
#    Script:    evil_deobfuscator_b64.ps1
#    Version:   1.0
#    Author:    Dan Saunders
#    Contact:   dcscoder@gmail.com
#    Purpose:   Decode Malicious Base64 UTF-8 Payload & dumps to .txt file
#    Usage:     .\evil_deobfuscator_b64.ps1
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
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Script: evil_deobfuscator_b64.ps1 - $version - Author: Dan Saunders dcscoder@gmail.com

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"

########## Layer - Base64 ##########

$payload = Read-Host -Prompt "
Insert Layer (Evil Base64 Payload) ->"

$layer = [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String($payload))

Write-Host "
Layer decoded... Base64 data." -ForegroundColor red -BackgroundColor black

Write-Host "
$layer"  -ForegroundColor green -BackgroundColor black

$layer | Out-File $timestamp-evil_layer.txt

Write-Host "
Script completed - review above code!" -ForegroundColor yellow -BackgroundColor black
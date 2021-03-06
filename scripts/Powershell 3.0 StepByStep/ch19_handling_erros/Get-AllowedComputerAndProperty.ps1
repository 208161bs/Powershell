# -----------------------------------------------------------------------------
# Script: Get-AllowedComputerAndProperty.ps1
# Author: ed wilson, msft
# Date: 04/22/2012 16:37:49
# Keywords: Scripting Techniques, Error Handling
# comments: 
# PowerShell 3.0 Step-by-Step, Microsoft Press, 2012
# Chapter 19
# -----------------------------------------------------------------------------
Param([string]$computer = $env:computername,[string]$property="name")

Function Get-AllowedComputer([string]$computer, [string]$property)
{
 $servers = Get-Content -path c:\fso\serversAndProperties.txt 
 $s = $servers -contains $computer
 $p = $servers -contains $property
 Return $s -and $p
} #end Get-AllowedComputer function

# *** Entry point to Script ***

if(Get-AllowedComputer -computer $computer -property $property)
 {
   Get-WmiObject -class Win32_Bios -Computer $computer | 
   Select-Object -property $property
 }
Else
 {
  "Either $computer is not an allowed computer, `r`nor $property is not an allowed property"
 }

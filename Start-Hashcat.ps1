<#
.Description
Use multiple worldlist against multiple handshakes using Hashcat.

.Parameter CaptureDirectory
The location where the handshake captures are located.

.Parameter DictionaryDirectory
The location where the dictionary/wodlist are located.

.Parameter HashCatDirectory
The location where the hashcat.exe and releated files are located

.Parameter ShowResults
This will show the results for all of the captures that were cracked.

.Parameter Mode
The mode that Hashcat will run in.  For WPA, it will be 22000 or 22001.

.Example
PS> .\start-hashcat.ps1 -CaptureDirectory C:\Users\username\Documents\caputures -DirectoryDictionary C:\Wordlist -HashCatDirectory C:\Hashcat -mode 22000 -ShowResults $True

This will run all the captures in the C:\Users\username\Documents\capture directory that end with 22000 against all the dictionary files in C:\Wordlist. It will then print the results to the screen

.OUTPUTS

SSID      Password
----      --------
Netgear64 Ilov3Wifi

.Link
https://hashcat.net/hashcat/
https://github.com/DaDubbs/PSCat

#>

[CmdletBinding()]
param(
    [Parameter(Mandatory)]
    [string]$CaptureDirectory,

    [Parameter(Mandatory)]
    [string]$DictionaryDirectory,

    [Parameter(Mandatory)]
    [string]$HashCatDirectory,

    [Parameter()]
    [bool]$ShowResults = $true,

    [Parameter()]
    [int]$Mode = 22000
)

function Show-Results($cap, $mode, $hash){
    $Results = New-Object psobject
    $hashcat = "$($hash)\hashcat.exe"
    $Output = (cmd.exe /c $($hashcat) --show $($cap) -m $mode)|Out-String
    if($Output -ne ""){
        $OutputSplit = $Output -split ":"
        $Results|Add-Member -MemberType NoteProperty -Name "SSID" -Value $OutputSplit[-2]
        $Results|Add-Member -MemberType NoteProperty -Name "Password" -Value $OutputSplit[-1]
        return $Results
    }
}

# Being nice to get the current directory to move back to at the end of the script.
$CurrentDirectory = Get-Location
$Hashcat = "$($HashCatDirectory)\hashcat.exe"

if(Test-Path $DictionaryDirectory){
    $DictList = Get-ChildItem $DictionaryDirectory
}

Set-Location $HashCatDirectory

# Checking that the CaptureDirectory Exist
if(Test-Path $CaptureDirectory){
    # Checking if the CapDiretory is a directory
    if(Test-Path $CaptureDirectory -PathType Container){
        # Getting all the files in the directory
        $Caps = Get-ChildItem $CaptureDirectory
        foreach($Cap in $Caps){
            # We only want the files that have the same ending as the mode
            if(($Cap).name -match $Mode){               
                # Loop through each dictionary list against each capture 
                foreach($Dict in $DictList){
                    $DictPath = $Dict.VersionInfo.FileName
                    $capFile = $Cap.VersionInfo.FileName
                    write-Output "Using $($Dict.name) against $($Cap.name)" 
                    cmd.exe /c $Hashcat -a 0 -w 3 $capFile -m $Mode -o 2 $DictPath --stdout
                }
                # Show cracked passwords
                if($ShowResults){
                    $Results = Show-Results -cap $Cap.VersionInfo.FileName -mode $Mode -hash $HashCatDirectory
                    Write-Output $Results
                }
            }
        }
    }else{
        foreach($Dict in $DictList){
            $DictPath = $Dict.VersionInfo.FileName
            $capFile = $Cap.VersionInfo.FileName
            cmd.exe /c $Hashcat -a 0 -w 3 $capFile -m $Mode -o 2 $DictPath --stdout
        }
        # Show cracked passwords
        if($ShowResults){
            $Results = Show-Results -cap $Cap.VersionInfo.FileName -mode $Mode -hash $HashCatDirectory
            Write-Output $Results
        }
    }
}else{
    Write-Output "Error: CaptureDirectory ($($CaptureDirectory)) does not exit"

}


Set-Location $CurrentDirectory
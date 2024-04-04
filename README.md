# PSCat
Powershell script to automate using wordlist with Hashcat with the option to display the results of cracked hashes.

# Parameters
The following are parameters within the script along with their usage. This can also be shown with get-help Start-Hashcat.ps1 within PowerShell.

### CaptureDirectory
The location where the handshake captures are located.

### DictionaryDirectory
The location where the dictionary/wodlist are located.

### HashCatDirectory
The location where the hashcat.exe and releated files are located

### HashTuneDirectory
This is the location the tune file is for Hashcat. It is normally located in the same directory. Only use this option if there is an error message about the tune file.

### ShowResults
This will show the results for all of the captures that were cracked. 

### Mode
The mode that Hashcat will run in.  For WPA, it will be 22000 or 22001.

# Example
\start-hashcat.ps1 -CaptureDirectory C:\Users\username\Documents\caputures -DirectoryDictionary C:\Wordlist -HashCatDirectory C:\Hashcat -mode 22000 -ShowResults $True

# Output

SSID      Password
----      --------
Netgear64 Ilov3Wifi

# Disclaimer
This script is only for learning. Only run it against handshake captures which you have permissions to gather. Be responsible.
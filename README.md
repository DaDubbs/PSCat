# PSCat
Powershell script to automate using wordlist with Hashcat with the option to display the results of cracked hashes. 

# Prerequisite
You will need to have Hashcat installed on the machine you are running the script on. More information about [hashcat](https://hashcat.net/hashcat/) can be found at [https://hashcat.net/hashcat/](https://hashcat.net/hashcat/). It is also expected that you have some WiFi handshakes which are in a format that HshCat supports.  HashCat's website has a tool called [Converter](https://hashcat.net/cap2hashcat/) which can assist converting the file is needed. Handshakes can be captured using devices like a pwnagotchi, wifi pineapple, or a computer running software to capture the handshakes. Remember be responsible and only capature handshakes which you have permission to capture. 

This script has only been tested on Windows, while 

# Parameters
The following are parameters within the script along with their usage. This can also be shown with get-help Start-Hashcat.ps1 within PowerShell.

### *CaptureDirectory*
The location where the handshake captures are located. This should be the full directory path. The script doesn't support realitive paths, such as .\. All files with the extension that is the same as the mode will be ran against Hashcat.  For example, if you have the mode set to 22001, any file with 22000, txt, etc will be filtered out. 

### *DictionaryDirectory*
The location where the dictionary/wodlist are located. [SecList](https://github.com/danielmiessler/SecLists) by Daniel Miessler has a large sample of wordlist that can be downloaded. 

### *HashCatDirectory*
The location where the hashcat.exe and releated files are located. This should be whereever you extracted the 7z file from the Hashcat website. Only include the directory, and not the full path to the hashcat file. The script will change to this directory in order to try to avoid issues with the hashtune file.

### *ShowResults*
This will show the results for all of the captures that were cracked. This is a boolean switch, which is true in the default state. If you don't want to see the results, set this to $False. This will write the results of hashcat.exe --show capture -m mode to a PSObject. The output can be piped to Out-Grid, Export-CSV, etc. 

### *Mode*
The mode that Hashcat will run in.  For WPA, it will be 22000 or 22001. Hashcat has a list of [modes](https://hashcat.net/wiki/doku.php?id=hashcat) on their website. The script was designed with 22000 and 22001 in mind. You should be able to use any of the modes, since this parameter is passed to Hashcat to set the mode. Just make sure that the extension on the capture is the same as the mode. 

# Example
.\start-hashcat.ps1 -CaptureDirectory C:\Users\username\Documents\caputures -DirectoryDictionary C:\Wordlist -HashCatDirectory C:\Hashcat -mode 22000 -ShowResults $True

# Output
```
SSID      Password
----      --------
Netgear64 Ilov3Wifi
```
# *Disclaimer*
This script is only for learning. Only run it against handshake captures which you have permissions to gather. Be responsible.
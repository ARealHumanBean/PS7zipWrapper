function Compress-7Zip {
    [CmdletBinding()]
    param (
        [String]$Path = 'C:\Users\dburton\Documents\scripts\' ,
        [String]$Target = 'C:\Users\dburton\Desktop\escrow.7zip',
        [string]$VolumeSize = '4400000k'
        #[String]$WorkingDirectory = 'D:\escrow\'
    )


    if (-not (test-path "$env:ProgramFiles\7-Zip\7z.exe")) {throw "$env:ProgramFiles\7-Zip\7z.exe needed"} 
    set-alias 7z "$env:ProgramFiles\7-Zip\7z.exe"

    $Password = Read-Host -Prompt "Enter Password"
    $Password = "-p$Password"

    $NumCores = Get-WmiObject –class Win32_processor | select -ExpandProperty numberofcores
    $MultiThread = "-mmt$NumCores"

    $7zipParamaters = @{
        Password = "-p$Password";
        #Path = $Path;
        #Format = 'SevenZip';
        #CompressionLevel = 'Normal';
        #CustomInitialization = $InitScript;
    }

    7z a $Target $Path -r -v4400m -t7z -m0=LZMA2 $MultiThread ($7zipParamaters.Values | Out-String) #$Password -mhe
}
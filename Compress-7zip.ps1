function Compress-Escrow {
    [CmdletBinding()]
    param (
        [String]$Path,
        [String]$Target,
        [string]$VolumeSize,
        [switch]$EnableMultiCore
    )

    begin {
        if (-not (test-path "$env:ProgramFiles\7-Zip\7z.exe")) {throw "$env:ProgramFiles\7-Zip\7z.exe needed"} 
        set-alias 7z "$env:ProgramFiles\7-Zip\7z.exe"

        $Password = Read-Host -Prompt "Enter Password"
        $Password = "-p$Password"

        if ($EnableMultiCore) {
            $NumCores = Get-WmiObject –class Win32_processor | select -ExpandProperty numberofcores
            $MultiThread = "-mmt$NumCores"
        }
    
    }


    process {
        7z a $Target $Path -r -v4400m -t7z -m0=LZMA2 $MultiThread $Password
    }

    end {}
}
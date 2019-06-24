<#
.SYNOPSIS
Writes Log messages to host.

.DESCRIPTION
Writes message to the host where script is run adding current time for reference.

.PARAMETER Message
The message to write in hosts' log messages.
#>

function Write-LogToHost
{
    Param
    (
        [Parameter(Mandatory=$true)] [string] $Message
    )

    Write-Host ("{0} - {1}" -f (Get-Date -Format "HH:mm:ss.fff"), $Message)
}

Export-ModuleMember -Function Write-LogToHost

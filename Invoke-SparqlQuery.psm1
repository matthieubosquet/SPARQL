<#
.SYNOPSIS
SPARQL query RDF4J API endpoint.

.PARAMETER Uri
URI of the SPARQL endpoint.

.PARAMETER Query
The SPARQL query or a .sparql file containing the query.

.PARAMETER Infer
Specify whether inferred statements should be included in the query evaluation. Inferred statements are included by default.

.PARAMETER Repository
Name of SPARQL repository will be added onto the Sparql endpoint base URI if specified.

.PARAMETER SubscriptionKey
Product subscription key for protected endpoints. See https://docs.microsoft.com/en-us/azure/api-management/api-management-key-concepts#--products.

.PARAMETER ApiVersion
Refers to the API endpoint version. See https://docs.microsoft.com/en-us/azure/api-management/api-management-get-started-publish-versions.
#>

Import-Module -Name $PSScriptRoot\Write-LogToHost.psm1

function Invoke-SparqlQuery
{
    Param
    (
        [Parameter(Mandatory=$true)] [string] $Uri,
        [Parameter(Mandatory=$true)] [string] $Query,
        [Parameter(Mandatory=$false)] [bool] $Infer = $true,
        [Parameter(Mandatory=$false)] [string] $Repository = "",
        [Parameter(Mandatory=$false)] [string] $SubscriptionKey,
        [Parameter(Mandatory=$false)] [string] $ApiVersion
    )

    # Use TLS 1.2
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

    # SPARQL Endpoint URL
    if ($Repository -ne "")
    {
        $Uri = "$Uri/repositories/$Repository"
    }

    # Query
    if ($Query.EndsWith(".sparql")) {
        $FilePath = "$PSScriptRoot\$Query"
        $Query = Get-Content $FilePath
    }

    # Initialise headers dictionary
    $Headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"

    ## Set SPARQL query or update
    if ($Query | Select-String -Pattern 'DELETE|INSERT' -Quiet)
    {
        $Headers.Add('Content-Type', "application/sparql-update; charset=UTF-8")
        $Uri = $Uri + "/statements"
    }
    else
    {
        $Headers.Add('Content-Type', "application/sparql-query; charset=UTF-8")
    }

    # Infer parameter
    if ($Infer -ne $true)
    {
        $Uri = $Uri + "?infer=false"
    }

    # API version (environment)
    if ($ApiVersion -ne "") {
        $Headers.Add('Api-Version', $ApiVersion)
    }

    # Subscription key (if protected)
    if ($SubscriptionKey -ne "") {
        $Headers.Add('Ocp-Apim-Subscription-Key', $SubscriptionKey)
    }

    # Log request
    Write-LogToHost "Uri: $Uri"
    Write-LogToHost ("Content-type: {0}" -f $Headers["Content-Type"])
    Write-LogToHost "Query string: $Query"
    if ($ApiVersion -ne "") {
        Write-LogToHost "API version: $ApiVersion"
    }

    Invoke-RestMethod -Method Post -Uri $Uri -Headers $Headers -Body $Query -Verbose
}

Export-ModuleMember -Function Invoke-SparqlQuery

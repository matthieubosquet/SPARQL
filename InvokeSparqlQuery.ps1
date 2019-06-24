Param(
    [Parameter(Mandatory=$false)] [string] $Repository = "",
    [Parameter(Mandatory=$false)] [string] $SubscriptionKey,
    [Parameter(Mandatory=$false)] [string] $APIVersion,
    [Parameter(Mandatory=$false)] [bool] $Infer = $true,
    [Parameter(Mandatory=$true)] [string] $SparqlEndpointBaseUrl,
    [Parameter(Mandatory=$true)] [string] $Query
)

# Use TLS 1.2
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

# SPARQL Endpoint URL
if ($Repository -ne "")
{
    $SparqlEndpointBaseUrl = "$SparqlEndpointBaseUrl/repositories/$Repository"
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
    $SparqlEndpointBaseUrl = $SparqlEndpointBaseUrl + "/statements"
}
else
{
    $Headers.Add('Content-Type', "application/sparql-query; charset=UTF-8")
}

# Infer parameter
if ($Infer -ne $true)
{
    $SparqlEndpointBaseUrl = $SparqlEndpointBaseUrl + "?infer=false"
}

# API version (environment)
if ($APIVersion -ne "") {
    $Headers.Add('Api-Version', $APIVersion)
}

# Subscription key (if protected)
if ($SubscriptionKey -ne "") {
    $Headers.Add('Ocp-Apim-Subscription-Key', $SubscriptionKey)
}

# Log request
Write-Host ("{0} - Uri: {1}" -f (Get-Date -Format "HH:mm:ss.fff"), $Uri)
Write-Host ("{0} - Content-type: {1}" -f (Get-Date -Format "HH:mm:ss.fff"), $Headers["Content-Type"])
Write-Host ("{0} - Query string: {1}" -f (Get-Date -Format "HH:mm:ss.fff"), $Query)
if ($APIVersion -ne "") {
    Write-Host ("{0} - API Version: {1}" -f (Get-Date -Format "HH:mm:ss.fff"), $APIVersion)
}

Invoke-RestMethod -Method Post -Uri $SparqlEndpointBaseUrl -Headers $Headers -Body $Query -Verbose

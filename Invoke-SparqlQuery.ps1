<#
.SYNOPSIS
SPARQL query RDF4J API endpoint.

.PARAMETER SparqlEndpointBaseUrl
Address of the SPARQL endpoint.

.PARAMETER Query
The SPARQL query or a .sparql file containing the query.

.PARAMETER Repository
Name of SPARQL repository will be added onto the Sparql endpoint base URL if specified.

.PARAMETER SubscriptionKey
Product subscription key for protected endpoints. See https://docs.microsoft.com/en-us/azure/api-management/api-management-key-concepts#--products.

.PARAMETER ApiVersion
Refers to the API endpoint version. See https://docs.microsoft.com/en-us/azure/api-management/api-management-get-started-publish-versions.

.PARAMETER Infer
Specify whether inferred statements should be included in the query evaluation. Inferred statements are included by default.
#>

Param
(
    [Parameter(Mandatory=$true)] [string] $SparqlEndpointBaseUrl,
    [Parameter(Mandatory=$true)] [string] $Query,
    [Parameter(Mandatory=$false)] [string] $Repository = "",
    [Parameter(Mandatory=$false)] [string] $SubscriptionKey,
    [Parameter(Mandatory=$false)] [string] $ApiVersion,
    [Parameter(Mandatory=$false)] [bool] $Infer = $true
)

Import-Module -Name $PSScriptRoot\Invoke-SparqlQuery.psm1

Invoke-SparqlQuery -SparqlEndpointBaseUrl $SparqlEndpointBaseUrl -Query $Query -Repository $Repository -SubscriptionKey $SubscriptionKey -ApiVersion $ApiVersion -Infer $Infer

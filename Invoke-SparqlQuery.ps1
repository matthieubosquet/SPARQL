<#
.SYNOPSIS
SPARQL query RDF4J API endpoint.

.PARAMETER Uri
URI of the SPARQL endpoint.

.PARAMETER Query
SPARQL as a string or relative path of a .sparql file containing the SPARQL.

.PARAMETER Infer
Specify whether inferred statements should be included in the query evaluation. Inferred statements are included by default.

.PARAMETER Repository
Name of graph repository. It will be added onto the Sparql endpoint base URI if specified.

.PARAMETER SubscriptionKey
Product subscription key for protected endpoints. See https://docs.microsoft.com/en-us/azure/api-management/api-management-key-concepts#--products.

.PARAMETER ApiVersion
Refers to the API endpoint version. See https://docs.microsoft.com/en-us/azure/api-management/api-management-get-started-publish-versions.
#>

Param
(
    [Parameter(Mandatory=$true)] [string] $Uri,
    [Parameter(Mandatory=$true)] [string] $Query,
    [Parameter(Mandatory=$false)] [bool] $Infer = $true,
    [Parameter(Mandatory=$false)] [string] $Repository = "",
    [Parameter(Mandatory=$false)] [string] $SubscriptionKey,
    [Parameter(Mandatory=$false)] [string] $ApiVersion
)

Import-Module -Name $PSScriptRoot\Invoke-SparqlQuery.psm1

Invoke-SparqlQuery -Uri $Uri -Query $Query -Infer $Infer -Repository $Repository -SubscriptionKey $SubscriptionKey -ApiVersion $ApiVersion

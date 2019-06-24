# SPARQL

A collection of fairly generic SPARQL queries.

## PowerShell script usage

This PowerShell script is created to work with the [RDF4J API](https://rdf4j.eclipse.org/documentation/rest-api/).

The *SubscriptionKey* and *ApiVersion* parameters are aimed at [Azure API Management](https://azure.microsoft.com/services/api-management/).

Simple example, in a local repository named "test", retrieve 10 statements:

```powershell
.\InvokeSparqlQuery.ps1 -Query "select 10 statements.sparql" -SparqlEnd
pointBaseUrl "http://localhost:7200/repositories/test"
```

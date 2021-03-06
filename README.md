# SPARQL

A collection of fairly generic SPARQL queries.

## SPARQL 1.1 Technical Recommendation (21 March 2013)

- [Overview](https://www.w3.org/TR/sparql11-overview/)
- [Query Language](https://www.w3.org/TR/sparql11-query/)
- [Update](https://www.w3.org/TR/sparql11-update/)
- [Service Description](https://www.w3.org/TR/sparql11-service-description/)
- [Federated Query](https://www.w3.org/TR/sparql11-federated-query/)
- [Query Results JSON Format](https://www.w3.org/TR/sparql11-results-json/)
- [Query Results CSV and TSV Formats](https://www.w3.org/TR/sparql11-results-csv-tsv/)
- [Query Results XML Format](https://www.w3.org/TR/rdf-sparql-XMLres/)
- [Entailment Regimes](https://www.w3.org/TR/sparql11-entailment/)
- [Protocol](https://www.w3.org/TR/sparql11-protocol/)
- [Graph Store HTTP Protocol](https://www.w3.org/TR/sparql11-http-rdf-update/)

## Invoke-SparqlQuery

PowerShell script to run SPARQL queries.

Intended to work with the [RDF4J API](https://rdf4j.org/documentation/reference/rest-api/) and [Azure API Management](https://azure.microsoft.com/services/api-management/).

### Parameters

**Uri** URI of the SPARQL endpoint. *Required parameter*.

**Query** SPARQL as a string or relative path of a *.sparql* file containing the SPARQL. *Required parameter*.

**Infer** Specify whether inferred statements should be included in the query evaluation. Inferred statements are included by default.

**Repository** Name of the repository to query. Will add */repositories/repository_name* to the *Uri* if specified.

**SubscriptionKey** Product subscription key for protected endpoints. See [Azure API Management key concepts: products](https://docs.microsoft.com/en-us/azure/api-management/api-management-key-concepts#--products).

**ApiVersion** Refers to the API endpoint version. See [Azure API Management: publishing versions](https://docs.microsoft.com/en-us/azure/api-management/api-management-get-started-publish-versions).

### Examples

Retrieve 10 statements from a local repository named "test":

```powershell
.\Invoke-SparqlQuery.ps1 -Uri "http://localhost:7200/repositories/test" -Query "select 10 statements.sparql"
```

Retrieve 10 statements from a local repository named "test" using the repository parameter:

```powershell
.\Invoke-SparqlQuery.ps1 -Uri "http://localhost:7200" -Query "select 10 statements.sparql" -Repository "test"
```

Retrieve 10 statements from a local repository named "test" using the repository parameter and no inference:

```powershell
.\Invoke-SparqlQuery.ps1 -Uri "http://localhost:7200" -Query "select 10 statements.sparql" -Infer $false -Repository "test"
```

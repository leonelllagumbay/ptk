<cfdbinfo datasource="FBC_CBOSE" 
		  name="Result"
		  type="columns"
		  table="cinpreempreqchklist"
>
<cfset colArr = ArrayNew(1) >

<cfloop query="Result" >
	<cfset ArrayAppend(colArr, COLUMN_NAME) >
</cfloop>
<cfset columnList = ArrayToList(colArr, ',') >
<cfdump var="#columnList#" >


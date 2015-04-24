<cfquery name="test" datasource="FBC_CBOSE" >
SELECT  *,FIRSTNAME AS 'First Name'
  FROM CMFPA
 limit 0, 20
</cfquery>

<cfoutput>
<dl>
<dt>Alphabetized Column List</dt>
<dd>#test.columnList#</dd>
<dt>Original Ordered Column List (specified in database table)</dt>
<dd>#arrayToList(test.getColumnList())#</dd>
</dl>
</cfoutput>

<cfdump var="#test.getMeta().getColumnLabels()#" >
<!---The method used above get the original column order and original column case. 
This is very helpful. Thanks a lot!--->
<!---<cfdump var="#test#" >--->
<!---<cfdump var="#test.getMeta().getColumnCount()#" >
<cfdump var="#test.getMeta().getExtendedMetaData()#" >--->
<style>
	#remtable tr:nth-child(odd) {
		background: #ff7777;
	}
	
</style>
<table id="remtable" border="1" cellpadding="3" cellspacing="1" style="font: 12px Arial; border-collapse: collapse;">
	<tr>
		<cfloop array="#test.getColumnList()#" index="ColumnName" >
			<th><cfoutput>#ColumnName#</cfoutput></th>
		</cfloop>
	</tr>
	<cfloop from="1" to="#test.RecordCount#" index="queryindex" >
		<tr>
			<cfset remArr = ArrayNew(1) >
			<cfset remArr = test.getColumnList() >
			<cfloop from="1" to="#ArrayLen(remArr)#" index="ColumnName" >
				<cfset theValue = "test['#remArr[ColumnName]#'][#queryindex#]" >
				<td><cfoutput>#Evaluate(theValue)#</cfoutput></td>
			</cfloop>
		</tr>
    </cfloop>	
</table>
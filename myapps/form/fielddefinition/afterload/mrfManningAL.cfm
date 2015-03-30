<cfquery name="mrfManning" datasource="#session.company_dsn#" >
	SELECT NATUREOFEMPLOYMENT, SUM(BUDGET) AS BUDGET, SUM(ACTUAL) AS ACTUAL
	  FROM ECINMANNINGBUDGET
	 WHERE DATEOFUPDATE = '#dateformat(now(), "YYYY-MM-DD")#'
	GROUP BY NATUREOFEMPLOYMENT
	ORDER BY NATUREOFEMPLOYMENT DESC
</cfquery>

<cfsavecontent variable="theContent" >
	<style type="text/css">
		#tlsdjdjfkfd tr {
			border: 1px solid black;
			border-collapse: collapse
		}
		#tlsdjdjfkfd tr:nth-child(odd) {
			background: yellow;
		}
	</style>
	<table style='font: inherit;' id="tlsdjdjfkfd">
		<thead>
		<tr>
			<th>&nbsp;</th>
			<th>Budget</th>
			<th>Actual</th>
			<th>Variance</th>
		</tr>
		</thead>
		<tbody>
		<cfset bTot = 0 >
		<cfset aTot = 0 >
		<cfset vTot = 0 >
		<cfloop query="mrfManning" >
			<cfoutput>
			<tr>
				<td>#mrfManning.NATUREOFEMPLOYMENT#</td>
				<td>#mrfManning.BUDGET#</td>
				<td>#mrfManning.ACTUAL#</td>
				<td>#mrfManning.BUDGET - mrfManning.ACTUAL#</td>
			</tr>
			</cfoutput>
			<cfset bTot += mrfManning.BUDGET >
			<cfset aTot += mrfManning.ACTUAL >
			<cfset vTot += mrfManning.BUDGET - mrfManning.ACTUAL >
		</cfloop>
		</tbody>
		<tfoot>
			<tr>
				<td><b>Total Requirement</b></td>
				<td><cfoutput>#bTot#</cfoutput></td>
				<td><cfoutput>#aTot#</cfoutput></td>
				<td><cfoutput>#vTot#</cfoutput></td>
			</tr>
		</tfoot>
	</table>
</cfsavecontent>

<cfscript>
	tmpresult['C__CMFPA__GUID'] = theContent;   
</cfscript>

<cfset returnStruct['success'] = "true" >
<cfset returnStruct['data']   = tmpresult >
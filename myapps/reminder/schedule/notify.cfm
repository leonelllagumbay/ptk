<cfset ad = url.ad >
<cfset cid = url.cid >
<cfset end = url.end >
<cfset id = url.id >
<cfset loc = url.loc >
<cfset notes = url.notes >
<cfset rem = url.rem >
<cfset dquery = url.dquery >
<!---<cfset rrule = url.rrule >--->
<cfset start = url.start >
<cfset title = url.title >
<cfset globaldsn = url.global_dsn >
<cfset companydsn = url.company_dsn >
<cfset urlstring = url.urlstring >
<cfset sender = url.recipient >
<cfset pid = url.pid >

<cfif cid EQ 1 >
	<cfset cal = "Home" >
<cfelseif cid EQ 2 >
	<cfset cal = "Work" >
<cfelseif cid EQ 3 >
	<cfset cal = "School" >
<cfelseif cid EQ 4 >
	<cfset cal = "Sports" >
<cfelseif cid EQ 5 >
	<cfset cal = "Family" >
<cfelse>
	<cfset cal = "None" >
</cfif>

<cfset allRecipients = "" >
<cfset dRecipients = "" >
<cfset dRecipientsGroup = "" >
<!---select all recipients from reminder recipients--->
<cfquery name="qryReminderRecipients" datasource="#globaldsn#" >
	SELECT APPLICANTNUMBER
	  FROM EGRTEREMINDER
	 WHERE APPID = '#id#'
</cfquery>

<cfif qryReminderRecipients.RecordCount gt 0 >

	<cfinvoke method="QueryToList" returnvariable="dArr" dQuery="#qryReminderRecipients#" dColumn="APPLICANTNUMBER" >
	<cfset dList = ArrayToList(dArr,"','") >


	<cfquery name="qryGuid" datasource="#companydsn#" >
		SELECT GUID
		  FROM CMFPA
		 WHERE PERSONNELIDNO IN ('#PreserveSingleQuotes(dList)#');
	</cfquery>
	<cfif qryGuid.RecordCount gt 0 >
		<cfinvoke method="QueryToList" returnvariable="dArr" dQuery="#qryGuid#" dColumn="GUID" >
		<cfset dList = ArrayToList(dArr,"','") >
		<cfquery name="qryProfileName" datasource="#globaldsn#" >
			SELECT PROFILENAME
			  FROM EGRGUSERMASTER
			 WHERE GUID IN ('#PreserveSingleQuotes(dList)#');
		</cfquery>
		<cfif qryProfileName.RecordCount gt 0 >
			<cfinvoke method="QueryToList" returnvariable="dRecipientsA" dQuery="#qryProfileName#" dColumn="PROFILENAME" >
			<cfset dRecipients = ArrayToList(dRecipientsA,",") >
		</cfif>
	</cfif>


	<cfquery name="qryRole" datasource="#globaldsn#" >
		SELECT USERGRPMEMBERSIDX
		  FROM EGRGROLEINDEX
		 WHERE USERGRPIDFK IN ('#PreserveSingleQuotes(dList)#');
	</cfquery>
	<cfif qryRole.RecordCount gt 0 >
		<cfinvoke method="QueryToList" returnvariable="dArrB" dQuery="#qryRole#" dColumn="USERGRPMEMBERSIDX" >
		<cfset dListB = ArrayToList(dArrB,"','") >
		<cfquery name="qryProfileNameB" datasource="#globaldsn#" >
			SELECT PROFILENAME
			  FROM EGRGUSERMASTER
			 WHERE USERID IN ('#PreserveSingleQuotes(dListB)#');
		</cfquery>
		<cfif qryProfileName.RecordCount gt 0 >
			<cfinvoke method="QueryToList" returnvariable="dArrG" dQuery="#qryProfileNameB#" dColumn="PROFILENAME" >
			<cfset dRecipientsGroup = ArrayToList(dArrG,",") >
		</cfif>
	</cfif>

	<cfset allRecipients = ListAppend(dRecipients,dRecipientsGroup,",") >

</cfif>

<cfif trim(allRecipients) neq "" >

<cfmail
	from="#sender#"
	to="#allRecipients#"
	subject="#title#"
	type="html">



	<cfoutput><p><strong>Calendar:</strong> #cal#</p></cfoutput>
	<cfoutput><p><strong>Title:</strong> #title#</p></cfoutput>
	<cfoutput><p><strong>Start Date:</strong> #start#</p></cfoutput>
	<cfoutput><p><strong>End Date:</strong> #end#</p></cfoutput>
	<cfoutput><p><strong>Notes:</strong> #notes#</p></cfoutput>
	<cfoutput><p><strong>Location:</strong> #loc#</p></cfoutput>
	<cfoutput><p><strong>Web:</strong> #urlstring#</p></cfoutput>
	<cfif trim(dquery) neq "" >
		<cfquery name="remQ" datasource="#globaldsn#" >
			#PreserveSingleQuotes(dquery)#
		</cfquery>
		<style>
			##remtable tr:nth-child(odd) {
				background: ##ff7777;
			}
		</style>
		<table id="remtable" border="1" cellpadding="3" cellspacing="1" style="font: 12px Arial; border-collapse: collapse;">
			<tr>
				<cfloop array="#remQ.getColumnList()#" index="ColumnName" >
					<th><cfoutput>#ColumnName#</cfoutput></th>
				</cfloop>
			</tr>
			<cfloop from="1" to="#remQ.RecordCount#" index="queryindex" >
				<tr>
					<cfset remArr = ArrayNew(1) >
					<cfset remArr = remQ.getColumnList() >
					<cfloop from="1" to="#ArrayLen(remArr)#" index="ColumnName" >
						<cfset theValue = "remQ['#remArr[ColumnName]#'][#queryindex#]" >
						<td><cfoutput>#Evaluate(theValue)#</cfoutput></td>
					</cfloop>
				</tr>
		    </cfloop>
		</table>
	<cfelse>
	</cfif>

</cfmail>
<cftry>
	<cfschedule
	    action 			= "delete"
	    task 			= "calendar#title##start##pid#"
	>
	<cfcatch>
	</cfcatch>
</cftry>
<cfoutput>Success</cfoutput>
</cfif>
<cfoutput>No Recipients</cfoutput>
<cffunction name="QueryToList" access="public"  >
	<cfargument name="dQuery" type="query" >
	<cfargument name="dColumn" type="string"  >
	<cfset theArr = ArrayNew(1) >
	<cfloop query="dQuery" >
		<cfset theval = "dQuery.#dColumn#" >
		<cfset val = Evaluate(theval) >
		<cfif trim(val) neq "" >
			<cfset ArrayAppend(theArr,val) >
		</cfif>
	</cfloop>
	<cfreturn theArr >
</cffunction>


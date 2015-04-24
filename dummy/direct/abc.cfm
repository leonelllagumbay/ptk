<cfinvoke 
		component="#arguments.request.action#"
		method="#arguments.request.method#" 
		argumentCollection="#args#"
		returnVariable="result"
	
/>

<cfoutput>#SerializeJSON(results)#</cfoutput>

<!---Matching Transactions--->

<!---Exception Handling--->

<cftry>
	<cfset result=direct.invokeCall(curReq) /> 
	
	<cfcatch type="any">
		<cfset jsonPacket=StructNew() /> 
	    <cfset jsonPacket['type']="exception" />
		<cfset jsonPacket['tid']=curReq['tId'] />
		<cfset jsonPacket['message']=cfcatch.Message />
		<cfcontent reset = "true" />
		<cfoutput>#SerializeJSON(jsonPacket)#</cfoutput>
		<cfabort>
	</cfcatch>
</cftry>
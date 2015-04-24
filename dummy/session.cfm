<CFDUMP VAR="#session#">
<cfscript>
	
	writedump(cgi);
</cfscript>
<cfif findnocase("HTTPS",cgi.SERVER_PROTOCOL) >
	<cfoutput>https</cfoutput>
<cfelse>
	<cfoutput>http</cfoutput>
</cfif>
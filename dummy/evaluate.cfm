<cfset exp = "queryService = new query()" > 

<cfdump var="#exp#" >
<cfscript>
WriteDump(Evaluate(exp));
</cfscript>

<cfset exp = "queryService.addParam(name='newpwd',value=""#Hash('leonell')#"",cfsqltype='cf_sql_varchar')" >
<cfdump var="#exp#" >
<cfscript>
WriteDump(Evaluate(exp));
</cfscript>

<cfset exp = "queryService.setDatasource('#session.global_dsn#')" >
<cfdump var="#exp#" >
<cfscript>
WriteDump(Evaluate(exp));
</cfscript>


<cfset exp = "queryService.execute(sql='SELECT * FROM GMFPEOPLE')" >
<cfdump var="#exp#" >
<cfscript>
WriteDump(Evaluate(exp));
</cfscript>
<!---
  --- Form
  --- ----
  ---
  --- author > LEONELL
  --- date >   2/25/15
  --->
<cfcomponent displayname="Form" output="false" persistent="false">

	<cffunction name="generateCodeToFile" access="public" output="true">
		<cfset rvcode = form.G__EGINFORMRMTVALIDATION__REMOTEVALIDATIONCODE >
		<cfset rvquery = form.G__EGINFORMRMTVALIDATION__RVQUERY >
		<cfset rvcfcode = form.G__EGINFORMRMTVALIDATION__RVCFCODE >
		<cfset rvrelation = form.G__EGINFORMRMTVALIDATION__RVRESULTRELATION >
		<cfset rvrenderto = form.G__EGINFORMRMTVALIDATION__RVRESULTRENDERTO >
		<cfset rvtitle = form.G__EGINFORMRMTVALIDATION__DEFAULTTITLE >
		<cfset rvmessage = form.G__EGINFORMRMTVALIDATION__DEFAULTMESSAGE >
		<cfset rvjavascript = form.G__EGINFORMRMTVALIDATION__DEFAULTJAVASCRIPT >
		<cfset rverrtitle = form.G__EGINFORMRMTVALIDATION__DEFAULTERRTITLE >
		<cfset rverrmessage = form.G__EGINFORMRMTVALIDATION__DEFAULTERRMESSAGE >
		<cfset rverrjavascript = form.G__EGINFORMRMTVALIDATION__DEFAULTERRJAVASCRIPT >
		<cfset rvextra = form.G__EGINFORMRMTVALIDATION__EXTRASTRUCTFIELD >
		<cfset rvexecuteon = form.G__EGINFORMRMTVALIDATION__RVEXECUTEON >
		<cfif trim(rvrelation) eq "">
			<cfset rvrelation = " > 0 ">
		</cfif>

		<cfset NL = CreateObject("java", "java.lang.System").getProperty("line.separator")>
		<cfset dlist = "">
<cfset dformfield = "
	<cfloop list='##form.formfield##' delimiters=',' index='clist'>
	    <cfif Isdefined(""form.##clist##"")>
	    	<cfset ##slist## = Evaluate('form.##clist##') >
	    </cfif>
	</cfloop>
">

		<cfif trim(rvrenderto) neq "">

<cfset renderResultTableTo = "
	<cfloop list='#rvrenderto#' delimiters=',' index='rlist'>
		<cfset formdata['##trim(rlist)##'] = ResultTable >
	</cfloop>
">
		<cfelse>
<cfset renderResultTableTo = "">
		</cfif>



<cfset dcodecontent = "
	<cfset s = StructNew()>
    #dformfield#
	<cfset s['title'] = '#rvtitle#'>
	<cfset s['message'] = '#rvmessage#'>
	<cfset s['javascript'] = '#rvjavascript#'>
	<cfset s['errtitle'] = '#rverrtitle#'>
	<cfset s['errmessage'] = '#rverrmessage#' >
	<cfset s['errjavascript'] = '#rverrjavascript#'>

	<!--- form data to render back to eForm's form --->
	<cfset formdata = StructNew()>
	<cfset formdata['G__EGRGQUERY__EQRYHEIGHT'] = '50'>
	<cfset formdata['G__EGRGQUERY__EQRYWIDTH'] = '100'>

	<cfset s['formdata'] = formdata>

	<cfquery name='qryMy' datasource='##session.global_dsn##'>
		#rvquery#
	</cfquery>
    <cfsavecontent variable=""ResultTable"">
			<style>
				##remtable tr:nth-child(odd) {
					background: ##99bce8;
				}
			</style>
			<table id=""remtable"" border=""1"" cellpadding=""3"" cellspacing=""1"" style=""font: 12px Arial; border-collapse: collapse;"">
				<tr>
					<cfloop array=""##qryMy.getColumnList()##"" index=""ColumnName"" >
						<th><cfoutput>##ColumnName##</cfoutput></th>
					</cfloop>
				</tr>
				<cfloop from=""1"" to=""##qryMy.RecordCount##"" index=""queryindex"" >
				    <tr>
						<cfset remArr = ArrayNew(1) >
						<cfset remArr = qryMy.getColumnList() >
						<cfloop from=""1"" to=""##ArrayLen(remArr)##"" index=""ColumnName"" >
							<cfset theValue = ""qryMy['##remArr[ColumnName]##'][##queryindex##]"" >
							<td><cfoutput>##Evaluate(theValue)##</cfoutput></td>

							<cfif queryindex eq 1>
						    	<cfset formdata['##remArr[ColumnName]##'] = Evaluate(theValue)>
						    </cfif>
						</cfloop>
					</tr>
			    </cfloop>
			</table>
	</cfsavecontent>

	#renderResultTableTo#

	<cfscript>
	rvexecuteon = '#trim(rvexecuteon)#';
		if( rvexecuteon eq 'NA' || rvexecuteon eq '') {
			if( qryMy.Recordcount #rvrelation# ) {
				s['success'] = 'true';
			} else {
				s['success'] = 'false';
			}
		} else {
			s['success'] = '#rvexecuteon#';
		}
	</cfscript>

	#rvcfcode#
	<cfset j = Serializejson(s)>
	<cfoutput>##j##</cfoutput>
	<cfsetting showdebugoutput='false'>
">
		<cfset thepath = "../../myapps/data/form/validation/" & rvcode & ".cfm">
		<cfset thepath = ExpandPath(thepath)>
		<cffile action="write"
			file="#thepath#"
			mode="777"
			output="#dcodecontent#"
	 	>


	</cffunction>

</cfcomponent>
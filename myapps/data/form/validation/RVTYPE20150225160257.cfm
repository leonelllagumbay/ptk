
	<cfset s = StructNew()>
    
	<cfloop list='#form.formfield#' delimiters=',' index='clist'>
	    <cfif Isdefined("form.#clist#")>
	    	<cfset #slist# = Evaluate('form.#clist#') >
	    </cfif>
	</cfloop>

	<cfset s['title'] = 'd title'>
	<cfset s['message'] = 'd message'>
	<cfset s['javascript'] = 'console.log("d js no");'>
	<cfset s['errtitle'] = 'e d title'>
	<cfset s['errmessage'] = 'e d message' >
	<cfset s['errjavascript'] = 'console.log("e d js");'>

	<!--- form data to render back to eForm's form --->
	<cfset formdata = StructNew()>
	<cfset formdata['G__EGRGQUERY__EQRYHEIGHT'] = '50'>
	<cfset formdata['G__EGRGQUERY__EQRYWIDTH'] = '100'>

	<cfset s['formdata'] = formdata>

	<cfquery name='qryMy' datasource='#session.global_dsn#'>
		SELECT GUID AS G__EGRGQUERY__EQRYMARGIN, SALUTATION, FIRSTNAME,  LASTNAME AS G__EGRGQUERY__EQRYPADDING, NICKNAME FROM GMFPEOPLE WHERE FIRSTNAME <> '#G__EGRGQUERY__EQRYNAME#'
LIMIT 0, 10
	</cfquery>
    <cfsavecontent variable="ResultTable">
			<style>
				#remtable tr:nth-child(odd) {
					background: #99bce8;
				}
			</style>
			<table id="remtable" border="1" cellpadding="3" cellspacing="1" style="font: 12px Arial; border-collapse: collapse;">
				<tr>
					<cfloop array="#qryMy.getColumnList()#" index="ColumnName" >
						<th><cfoutput>#ColumnName#</cfoutput></th>
					</cfloop>
				</tr>
				<cfloop from="1" to="#qryMy.RecordCount#" index="queryindex" >
				    <tr>
						<cfset remArr = ArrayNew(1) >
						<cfset remArr = qryMy.getColumnList() >
						<cfloop from="1" to="#ArrayLen(remArr)#" index="ColumnName" >
							<cfset theValue = "qryMy['#remArr[ColumnName]#'][#queryindex#]" >
							<td><cfoutput>#Evaluate(theValue)#</cfoutput></td>

							<cfif queryindex eq 1>
						    	<cfset formdata['#remArr[ColumnName]#'] = Evaluate(theValue)>
						    </cfif>
						</cfloop>
					</tr>
			    </cfloop>
			</table>
	</cfsavecontent>

	

	<cfscript>
	rvexecuteon = 'NA';
		if( rvexecuteon eq 'NA' || rvexecuteon eq '') {
			if( qryMy.Recordcount  > 0  ) {
				s['success'] = 'true';
			} else {
				s['success'] = 'false';
			}
		} else {
			s['success'] = 'NA';
		}
	</cfscript>

	
	<cfset j = Serializejson(s)>
	<cfoutput>#j#</cfoutput>
	<cfsetting showdebugoutput='false'>


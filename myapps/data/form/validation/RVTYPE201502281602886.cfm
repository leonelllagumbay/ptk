
	<cfset s = StructNew()>

	<cfset s['title'] = ''>
	<cfset s['message'] = ''>
	<cfset s['javascript'] = ''>
	<cfset s['errtitle'] = ''>
	<cfset s['errmessage'] = '' >
	<cfset s['errjavascript'] = ''>

	<!--- form data to render back to eForm's form --->
	<cfset formdata = StructNew()>
	<cfset formdata['G__EGRGQUERY__EQRYHEIGHT'] = '50'>
	<cfset formdata['G__EGRGQUERY__EQRYWIDTH'] = '100'>

	<cfset s['formdata'] = formdata>

	<cfquery name='qryMy' datasource='#session.global_dsn#'>
		
	</cfquery>
	<cfscript>
	rvexecuteon = '';
		if( rvexecuteon eq 'NA' || rvexecuteon eq '') {
			if( qryMy.Recordcount  ) {
				s['success'] = 'true';
			} else {
				s['success'] = 'false';
			}
		} else {
			s['success'] = '';
		}
	</cfscript>

	NA
	<cfset j = Serializejson(s)>
	<cfoutput>#j#</cfoutput>
	<cfsetting showdebugoutput='false'>


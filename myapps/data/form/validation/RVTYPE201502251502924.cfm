<cfscript>
	Sleep(1000);
</cfscript>
<!--- the following is the sample output --->
<cfset s = StructNew()>
<cfset s["title"] = " ">
<cfset s["message"] = " ">
<cfset s["javascript"] = " 	">
<cfset s["errtitle"] = "">
<cfset s["errmessage"] = "INvalid 222" >
<cfset s["errjavascript"] = "   				">

<!--- form data to render back to eForm's form --->
<cfset formdata = StructNew()>
<cfset formdata["G__EGRGQUERY__EQRYHEIGHT"] = "50">
<cfset formdata["G__EGRGQUERY__EQRYWIDTH"] = "100">

<cfset s["formdata"] = formdata>
<cfset s["success"] = "true" >

<cfset j = Serializejson(s)>
<cfoutput>#j#</cfoutput>

<cfsetting showdebugoutput="false">
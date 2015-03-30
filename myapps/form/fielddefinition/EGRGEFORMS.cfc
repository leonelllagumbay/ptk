<cfcomponent persistent="true" table="EGRGEFORMS" > 
	<cfproperty name="EFORMID" fieldtype="id" >
	<cfproperty name="EFORMNAME" >
	<cfproperty name="DESCRIPTION" >
	<cfproperty name="EFORMGROUP" >
	<cfproperty name="FORMFLOWPROCESS" > 
	<cfproperty name="ISENCRYPTED" >
	<cfproperty name="GRIDSCRIPT" >
	<cfproperty name="LAYOUTQUERY" >
	<cfproperty name="VIEWAS" >
	<cfproperty name="FORMPADDING" >
	<cfproperty name="GROUPMARGIN" >
	<cfproperty name="BEFORELOAD" >
	<cfproperty name="AFTERLOAD" >
	<cfproperty name="BEFORESUBMIT" >
	<cfproperty name="AFTERSUBMIT" >
	<cfproperty name="BEFOREAPPROVE" >
	<cfproperty name="AFTERAPPROVE" >
	<cfproperty name="ONCOMPLETE" >
	<cfproperty name="ONBEFOREDELETE" >
	<cfproperty name="ONAFTERDELETE" >
	<cfproperty name="ONBEFOREROUTE" >
	<cfproperty name="ONAFTERROUTE" >
	<cfproperty name="COMPANYCODE" >
	
	<cfproperty name="AUDITTDSOURCE" >   
	<cfproperty name="AUDITTNAME" >
	<cfproperty name="LOGDBSOURCE" >
	<cfproperty name="LOGTABLENAME" >
	<cfproperty name="LOGFILENAME" >
	
	<cfproperty name="RECCREATEDBY" >
	<cfproperty name="RECDATECREATED" >
	<cfproperty name="DATELASTUPDATE" > 
	<cfproperty name="EGRTEFORMS" type="array" fieldtype="one-to-many" cfc="EGRTEFORMS" fkcolumn="EFORMID" >
</cfcomponent>
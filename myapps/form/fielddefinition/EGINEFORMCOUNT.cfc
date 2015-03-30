<cfcomponent persistent="true" table="EGINEFORMCOUNT">

	<cfproperty name="PERSONNELIDNO" fieldtype="id"  >
	<cfproperty name="EFORMID" fieldtype="id">
	<cfproperty name="NEW" >
	<cfproperty name="PENDING" >
	<cfproperty name="RETURNED" >
	<cfproperty name="APPROVED" >
	<cfproperty name="DISAPPROVED" >
    <cfproperty name="RECEIVED" >
	<cfproperty name="DATELASTUPDATE" >
	<cfproperty name="EGRTEFORMS" fieldtype="one-to-one" cfc="EGRTEFORMS" cascade="delete">

</cfcomponent>
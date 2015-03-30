<cfcomponent persistent="true" table="EGRGQUERY">

	<cfproperty name="EQRYCODE" fieldtype="id" type="string" generator="assigned">
	<cfproperty name="EQRYNAME" type="string">
	<cfproperty name="EQRYDESCRIPTION" type="string">
	<cfproperty name="EQRYAUTHOR" type="string">
	<cfproperty name="EQRYBODY" type="string">
	<cfproperty name="RECDATECREATED" type="date">
	<cfproperty name="DATELASTUPDATE" type="date">
	<cfproperty name="EGRGEVIEWDATASOURCE" cfc="EGRGEVIEWDATASOURCE" type="array" fieldtype="one-to-many" fkcolumn="EQRYCODEFK" cascade="all-delete-orphan">
	<cfproperty name="EGRGEVIEWTABLES" cfc="EGRGEVIEWTABLES" type="array" fieldtype="one-to-many" fkcolumn="EQRYCODEFK" cascade="all-delete-orphan">
	<cfproperty name="EGRGEVIEWFIELDS" cfc="EGRGEVIEWFIELDS" type="array" fieldtype="one-to-many" fkcolumn="EQRYCODEFK" cascade="all-delete-orphan">
	<cfproperty name="EGRGEVIEWCONDITION" cfc="EGRGEVIEWCONDITION" type="array" fieldtype="one-to-many" fkcolumn="EQRYCODEFK" cascade="all-delete-orphan">
	<cfproperty name="EGRGEVIEWGROUPBY" cfc="EGRGEVIEWGROUPBY" type="array" fieldtype="one-to-many" fkcolumn="EQRYCODEFK" cascade="all-delete-orphan">
	<cfproperty name="EGRGEVIEWHAVING" cfc="EGRGEVIEWHAVING" type="array" fieldtype="one-to-many" fkcolumn="EQRYCODEFK" cascade="all-delete-orphan">
	<cfproperty name="EGRGEVIEWJOINEDTABLES" cfc="EGRGEVIEWJOINEDTABLES" type="array" fieldtype="one-to-many" fkcolumn="EQRYCODEFK" cascade="all-delete-orphan">
	<cfproperty name="EGRGEVIEWORDERBY" cfc="EGRGEVIEWORDERBY" type="array" fieldtype="one-to-many" fkcolumn="EQRYCODEFK" cascade="all-delete-orphan">

	<cfproperty name="EGRGQRYGRID" cfc="EGRGQRYGRID" type="array" fieldtype="one-to-many" fkcolumn="EQRYCODE" cascade="all-delete-orphan">
	<cfproperty name="EGRGQRYCHART" cfc="EGRGQRYCHART" type="array" fieldtype="one-to-many" fkcolumn="EQRYCODE" cascade="all-delete-orphan" >
	<cfproperty name="EGRGQRYFEATURE" cfc="EGRGQRYFEATURE" type="array" fieldtype="one-to-many" fkcolumn="EQRYCODE" cascade="all-delete-orphan" >
	<cfproperty name="EGRGQRYPLUGIN" cfc="EGRGQRYPLUGIN" type="array" fieldtype="one-to-many" fkcolumn="EQRYCODE" cascade="all-delete-orphan" >
</cfcomponent>
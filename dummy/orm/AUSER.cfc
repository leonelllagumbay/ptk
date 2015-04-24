<cfcomponent persistent="true" table="AUSER">
	<cfproperty name="USERID" fieldtype="id" ormtype="string" generator="assigned" >
	<cfproperty name="FIRSTNAME" type="string" >
	<cfproperty name="LASTNAME" type="string">
	<cfproperty name="AUSERSETTING" cfc="AUSERSETTING" fieldtype="one-to-one" cascade="all" >

</cfcomponent>
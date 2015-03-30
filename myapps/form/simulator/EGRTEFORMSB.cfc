<cfcomponent persistent="true" table="EGRTEFORMS">

	<cfproperty name="PERSONNELIDNO" fieldtype="id" >
	<cfproperty name="EFORMID" fieldtype="id">
	<cfproperty name="EGINEFORMCOUNT" fieldtype="one-to-one" cfc="EGINEFORMCOUNTB" constrained="true" cascade="delete">

</cfcomponent>
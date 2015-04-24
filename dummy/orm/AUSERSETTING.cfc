<cfcomponent persistent="true" table="AUSERSETTING">
	<cfproperty name="USERID" fieldtype="id" ormtype="string" generator="assigned" > 
	<cfproperty name="DEFAULTAPP" ormtype="string"> 
	<cfproperty name="MAXROWS" ormtype="int" > 
	<cfproperty name="AUSER" cfc="AUSER" fieldtype="one-to-one" constrained="true" >
	
	
	
</cfcomponent>

<!---constrained="true" cascade="delete"--->




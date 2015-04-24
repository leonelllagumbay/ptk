<cfloop from="1" to="10" index="index">
	<cfmail to="leonelllagumbay@gmail.com"
	from="leonelllagumbay@gmail.com"
	subject="#index# This is a test">
	
		<cfoutput>#index# This is a body</cfoutput>
	</cfmail>
	<cfoutput>#index# This is a body</cfoutput><br>
</cfloop>
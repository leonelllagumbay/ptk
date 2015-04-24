<cfset theString = "marksolis" >
<cfset enc = encrypt(theString, "WhzOuos3P75e2/QWnQTU+Q==", "AES") >
<cfoutput>#enc#</cfoutput>

<br>

<cfoutput>#decrypt(enc, "WhzOuos3P75e2/QWnQTU+Q==", "AES")#</cfoutput>

<!---<cfoutput>#dateformat("10:00 pm","YYYY-MM-DD")#</cfoutput> 
<cfoutput>#LSIsNumeric("2014/01/01")#</cfoutput>

<cfset hi = "<cfqueryparam value=""?**.U5>A68'B)0##P2-OE)""!3)R=S'1:3[DSO6OBA)/("" >"">"> 

<cfquery name="abcv" datasource="IBOSEDATA" >
	SELECT * FROM CMFPA
	  WHERE LASTNAME = <cfqueryparam value="?**.U5>A68'B)0##P2-OE)""!3)R=S'1:3[DSO6OBA)/("" >"> AND FIRSTNAME = <cfqueryparam value="#enc#" >
	    <cfloop from="1" to="3" index="asdf">
		</cfloop>
</cfquery>

<cfdump var="#abcv#" >--->
<!---#evaluate(hi)#--->
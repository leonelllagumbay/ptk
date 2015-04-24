<h1>Test</h1>

<cfset auser = EntityLoad('AUSER', 'Abbbbbb3', true)> 
<cfset EntityDelete(auser)>

<!---<cfset A = EntityNew("AUSER") >
<cfset A.setUSERID("Abbbbbb3") >
<cfset A.setFIRSTNAME("Jhelyn") >
<cfset A.setLASTNAME("Adizas") >

<cfset B = EntityNew("AUSERSETTING") >
<cfset B.setUSERID("Abbbbbb3") >
<cfset B.setDEFAULTAPP("APAPPP") >
<cfset B.setMAXROWS(12) >
<cfset B.setAUSER(A) >

<cfset A.setAUSERSETTING(B) >

<cfset EntitySave(B) >
<cfset EntitySave(A) >--->
<cfset ormflush()>

<!---<cfset auser = EntityLoad("AUSER") >
<cfdump var="#auser#" >

<cfset auserB = EntityLoad("AUSERSETTING") >
<cfdump var="#auserB#" >--->
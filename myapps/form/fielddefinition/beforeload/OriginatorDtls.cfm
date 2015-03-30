<style type = 'text/css'>
p {
    font-family: 'Lekton', Helvetica, Arial, sans-serif;
    font-size: 12px;
    line-height: 18px;
}
h1 {
    font-family: 'Molengo', Georgia, Times, serif;
}
</style>

<cfset uid = ( IsDefined("GetEntry") ? GetEntry.PERSONNELIDNO : session.CHAPA ) >

<CFQUERY name="getDtls" datasource="#session.COMPANY_DSN#" MAXROWS="1">
    SELECT A.FIRSTNAME, A.MIDDLENAME, A.LASTNAME, DEP.DESCRIPTION AS DEPT, POS.DESCRIPTION AS POSTN
    FROM CMFPA A
    LEFT JOIN CLKDEPARTMENT DEP ON DEP.DEPARTMENTCODE = A.DEPARTMENTCODE
    LEFT JOIN CLKPOSITION POS ON POS.POSITIONCODE = A.POSITIONCODE
    WHERE A.PERSONNELIDNO = '#uid#'
</CFQUERY>

<cfoutput query="getDtls" maxrows="1">
    <p>  
        Name:&nbsp;&nbsp;#convName('#FIRSTNAME#','#MIDDLENAME#','#LASTNAME#','true')#<br/>
        Position:&nbsp;&nbsp;#convName('#POSTN#','','','false')#<br/>
        Department:&nbsp;&nbsp;#convName('#DEPT#','','','false')#<br/>
    </p>
</cfoutput>




<cffunction name="convName"
	returntype="string">
    <cfargument name="fname" default="">
    <cfargument name="mname" default="">
    <cfargument name="lname" default="">
    <cfargument name="isName" type="boolean" default="true">
    
    
    <cfset fname = ReReplace(Lcase(fname),"((^| )[a-z]{1})", "\U\1", 'all') >
    
    <cfif isName>
		<cfset lname = Ucase(lname)>                                     
        <cfif ListLen(mname," ")>
            <cfset mname = Left(ListLast(mname," "),1) &".">
            <cfset mname = Ucase(mname)>
        <cfelse>
            <cfset mname = Left(mname,1) &".">
        </cfif>
        <cfreturn "<b>#lname#, #fname# #mname#</b>"> 
   <cfelse>
   		<cfreturn "<b>#fname#</b>">
   </cfif>

</cffunction>
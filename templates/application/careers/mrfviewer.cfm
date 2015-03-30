<link rel="icon" type="image/ico" href="<cfoutput>#client.domain#</cfoutput>diginfologo.ico"> 

<cfset requisitionnoval = trim(url.reqno) />

<cfif isdefined("url.companydsn") >
<cfset companydsn = url.companydsn>
<cfset norevert = "&norevert=NOREVERT" >
<cfelse>
	<cfif url.companycode EQ "" >
    	<cfset companydsn = "DIET2011_CBOSE">
    <cfelse>
    	<cfset companydsn = "#client.company_dsn#">
    </cfif> 
  
<cfset norevert = "&yesrevert=YESREVERT" >
</cfif>

<!---<cfoutput><h1>requisitionno#requisitionnoval#</h1></cfoutput>--->

<cfquery name="getMRF" datasource="#companydsn#" maxrows="1">
	SELECT  A.POSITIONCODE AS POSITIONCODE,
            B.DESCRIPTION AS DESCRIPTION,
	        A.REQUISITIONNO AS REQUISITIONNO,
	        REQUESTEDBY,
	        A.USERID AS USERID,
	        DATENEEDED,
            BRIEFDESC,
            SKILLSREQ,
	        DEPARTMENTCODE,
			DIVISIONCODE,
			REQUIREDNO,
            COMPANYCODE,
			A.DATELASTUPDATE AS DATELASTUPDATE
	   FROM CRGPERSONELREQUEST A LEFT JOIN CLKPOSITION B 
         ON (A.POSITIONCODE = B.POSITIONCODE)
   
   WHERE A.REQUISITIONNO = '#requisitionnoval#'
   ;
</cfquery>


<ul  style="list-style: none; font-family:Arial, Helvetica, sans-serif; border: #c0c9ed 1px solid; margin: 50 200 40 200;">

<li style="background-color: #e8eff8; font-size: 1.4em; font-weight: bold; text-align: center; margin: 10 50 0 50; padding: 5px;"><cfoutput>#getMRF.DESCRIPTION#</cfoutput></li>
<cfquery name="getCompany" datasource="#client.global_dsn#" maxrows="1">
	SELECT  DESCRIPTION
	  FROM GLKCOMPANY 
     WHERE COMPANYCODE = '#getMRF.COMPANYCODE#'
   ;
</cfquery>
<li style="background-color: #e8eff8; font-size: 1em; font-weight: bold; text-align: center; margin: 0 50 0 50; padding: 5px;"><cfoutput><img width="150" height="50" src="#client.domain#templates/themes/images/logo1.jpg"><!---(#getMRF.COMPANYCODE#) - #getCompany.DESCRIPTION#---></cfoutput></li>

<li style="background-color: #e8eff8; font-size: 1.3em; font-weight: normal; text-align: left; font-weight: bold; margin: 20 50 0 50; padding: 5px;">Responsibilities:</li>
<li style="font-size: 1em; font-weight: normal; text-align: left; font-weight: bold; margin: 7 50 0 40; padding: 5px;">
	<ul style="font-size: 1em; font-weight: normal; text-align: left; margin: 10 0 20 40; padding-top: 5px;">
    	<li><cfoutput>#getMRF.BRIEFDESC#</cfoutput></li>
    </ul>
</li>
<li style="background-color: #e8eff8; font-size: 1.3em; font-weight: normal; text-align: left; font-weight: bold; margin: 10 50 0 50; padding: 5px;">Requirements:</li>
<li style="font-size: 1em; font-weight: normal; text-align: left; font-weight: bold; margin: 7 50 0 40; padding: 5px;">
	<ul style="font-size: 1em; font-weight: normal; text-align: left; margin: 10 0 20 40; padding-top: 5px;">
    	<li><cfoutput>#getMRF.SKILLSREQ#</cfoutput></li>
    </ul>
</li>  
<li style="background-color: #e8eff8; font-size: 1.3em; font-weight: normal; text-align: left; font-weight: bold; margin: 10 50 0 50; padding: 5px;">Date Needed: <span style="font-size: .8em; font-weight: normal;"><cfoutput>#DateFormat(getMRF.DATENEEDED, "MM/DD/YYYY")#</cfoutput></span></li>
<li style="font-size: 1em; font-weight: normal; text-align: center; margin: 20 50 10 50;"><a target="_self" style="background-color: #FD0; font-size: 1em; padding: 5px; font-weight: normal;" href="<cfoutput>#client.domain#myapps/recruitment/applicationonline/?companyname=#getCompany.DESCRIPTION#&companycode=#getMRF.COMPANYCODE#&position=#getMRF.POSITIONCODE##norevert#</cfoutput>">Click here to apply</a></li>

</ul>
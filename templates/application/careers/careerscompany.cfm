<cfset callback = url.callback />
<cfset page     = url.page />
<cfset start    = url.start />
<cfset sort     = url.sort />
<cfset dir      = url.dir />
<cfset limit    = url.limit />
<cfset _dc      = url._dc />
<cfset companydsn = url.companydsn>



<cfquery name="getCmfpa" datasource="#companydsn#">
	SELECT  A.POSITIONCODE AS POSITIONCODE,
            B.DESCRIPTION AS DESCRIPTION,
	        REQUISITIONNO,
	        REQUESTEDBY,
	        A.USERID AS USERID,
	        DATENEEDED,
	        DEPARTMENTCODE,
			DIVISIONCODE,
			REQUIREDNO,
            COMPANYCODE,
			A.DATEACTIONWASDONE AS DATEACTIONWASDONE
	   FROM CRGPERSONELREQUEST A LEFT JOIN CLKPOSITION B 
         ON (A.POSITIONCODE = B.POSITIONCODE)
      WHERE (A.POSTEDTO = 'Company' OR A.POSTEDTO = 'All') AND POSTEDBYIBOSE = 'Y'
     <cfif isdefined('url.query')>
	    AND B.DESCRIPTION LIKE '%#url.query#%'
     </cfif>
	ORDER BY #sort# #dir#
    
	
    <cfif Ucase(client.DBMS) EQ 'MYSQL'>
     	LIMIT #start#, #limit#
    <cfelseif Ucase(client.DBMS) EQ 'MSSQL'>
         OFFSET #start# ROWS
         FETCH NEXT #limit# ROWS ONLY
    <cfelse>
    	LIMIT #start#, #limit#
    </cfif>
	  ;
	       
	
</cfquery>


<cfquery name="countTotal" datasource="#companydsn#" maxrows="1">
	 SELECT  COUNT(*) AS TOTALREC
	   FROM CRGPERSONELREQUEST A LEFT JOIN CLKPOSITION B 
         ON (A.POSITIONCODE = B.POSITIONCODE)
      WHERE (A.POSTEDTO LIKE '%Company%' OR A.POSTEDTO = 'All') AND POSTEDBYIBOSE = 'Y'
     <cfif isdefined('url.query')>
	    AND B.DESCRIPTION LIKE '%#url.query#%'
     </cfif>
	
	  ;
</cfquery>


<cfoutput>
	
	#callback#(
	{
    "totalCount":"#countTotal.TOTALREC#",
	"topics":[
	
	<!---#SerializeJSON(getCmfpa, true)#--->
	<cfloop query="getCmfpa">
		<cfquery name="converttoFull" datasource="#client.company_dsn#" maxrows="1">
			SELECT DESCRIPTION
			  FROM CLKPOSITION
			 WHERE POSITIONCODE = '#POSITIONCODE#';
		</cfquery>
	{
		"POSITIONCODE": #SerializeJSON(converttoFull.DESCRIPTION)#,
		"REQUISITIONNO": #SerializeJSON(REQUISITIONNO)#,
		"REQUESTEDBY": #SerializeJSON(REQUESTEDBY)#,
		"USERID": #SerializeJSON(USERID)#,
		"DATENEEDED": #SerializeJSON(DATENEEDED)#,
		"DEPARTMENTCODE": #SerializeJSON(DEPARTMENTCODE)#,
		"DIVISIONCODE": #SerializeJSON(DIVISIONCODE)#,
		"REQUIREDNO": #SerializeJSON(REQUIREDNO)#,
        "COMPANYCODE": #SerializeJSON(COMPANYCODE)#,
		"DATEACTIONWASDONE": #SerializeJSON(DATEACTIONWASDONE)#
	},
	</cfloop>
	
	{
		"POSITIONCODE": "",
		"REQUISITIONNO": "",
		"REQUESTEDBY": "",
		"USERID": "",
		"DATENEEDED": "",
		"DEPARTMENTCODE":  "",
		"DIVISIONCODE": "",
		"REQUIREDNO": "",
        "COMPANYCODE": "",
		"DATEACTIONWASDONE": ""
	}
	]  
	});
	
</cfoutput>

<cfsetting showdebugoutput="false" >
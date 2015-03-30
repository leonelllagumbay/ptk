

<cfset callback = url.callback />
<cfset page     = url.page />
<cfset start    = url.start />
<cfset sort     = url.sort />
<cfset dir      = url.dir />
<cfset limit    = url.limit />
<cfset _dc      = url._dc />


<cfquery name="getCmfpa" datasource="#client.global_dsn#">
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
			A.DATELASTUPDATE AS DATELASTUPDATE
	   FROM GRGPERSONELREQUEST A LEFT JOIN 
       
       	    <cfif Ucase(client.DBMS) EQ 'MYSQL'>
                #client.company_dsn#.CLKPOSITION B 
            <cfelseif Ucase(client.DBMS) EQ 'MSSQL'>
                #client.company_dsn#.dbo.CLKPOSITION B 
            <cfelse>
            	#client.company_dsn#.CLKPOSITION B 
            </cfif>
       
       	    ON (A.POSITIONCODE = B.POSITIONCODE)
     <cfif isdefined('url.query')>
	   WHERE B.DESCRIPTION LIKE '%#url.query#%'
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

  
<cfquery name="countTotal" datasource="#client.global_dsn#">
	 SELECT  COUNT(*) AS TOTALREC
	   FROM GRGPERSONELREQUEST A LEFT JOIN 

	    <cfif Ucase(client.DBMS) EQ 'MYSQL'>
                #client.company_dsn#.CLKPOSITION B 
            <cfelseif Ucase(client.DBMS) EQ 'MSSQL'>
                #client.company_dsn#.dbo.CLKPOSITION B 
            <cfelse>
            	#client.company_dsn#.CLKPOSITION B 
            </cfif>
       
       	    ON (A.POSITIONCODE = B.POSITIONCODE)
      
     <cfif isdefined('url.query')>
	   WHERE B.DESCRIPTION LIKE '%#url.query#%'
     </cfif>
	
	  ;
</cfquery>


<cfoutput>
	
	#callback#(
	{
    "totalCount":"#countTotal.TOTALREC#",
	"topics":[
	
	<cfloop query="getCmfpa">
		
	{
		"POSITIONCODE": #SerializeJSON(DESCRIPTION)#,
		"REQUISITIONNO": #SerializeJSON(REQUISITIONNO)#,
		"REQUESTEDBY": #SerializeJSON(REQUESTEDBY)#,
		"USERID": #SerializeJSON(USERID)#,
		"DATENEEDED": #SerializeJSON(DATENEEDED)#,
		"DEPARTMENTCODE": #SerializeJSON(DEPARTMENTCODE)#,
		"DIVISIONCODE": #SerializeJSON(DIVISIONCODE)#,
		"REQUIREDNO": #SerializeJSON(REQUIREDNO)#,
        "COMPANYCODE": #SerializeJSON(COMPANYCODE)#,
		"DATELASTUPDATE": #SerializeJSON(DATELASTUPDATE)#
	},
	</cfloop>
	
	{
		"POSITIONCODE": "No Position",
		"REQUISITIONNO": "",
		"REQUESTEDBY": "",
		"USERID": "",
		"DATENEEDED": "",
		"DEPARTMENTCODE":  "",
		"DIVISIONCODE": "",
		"REQUIREDNO": "",
        "COMPANYCODE": "",
		"DATELASTUPDATE": ""
	}
	]  
	});
	
</cfoutput>



<cfsetting showdebugoutput="false" >
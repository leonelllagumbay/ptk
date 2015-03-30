<cfcomponent name="lookup" ExtDirect="true">

<cffunction name="getCivilstatus" ExtDirect="true">
  <cftry>
	<cfquery name="qryLookup" datasource="#client.company_dsn#">
		SELECT CIVILSTATUS, DESCRIPTION
		  FROM CLKCIVILSTATUS
	</cfquery>

	<cfset totalcnt = qryLookup.recordcount >
    <cfset resultArr = ArrayNew(1) >
    <cfset rootstuct = StructNew() >

    <cfset rootstuct['totalCount'] = totalcnt >
	<cfset rootstuct['success']    = "true" >
	<cfset cnt = 1 >
	  <cfloop query = "qryLookup" >
	  	<cfset tmpresult = StructNew() >
		<cfset tmpresult['civilstatuscode']  = ' ' & CIVILSTATUS >
		<cfset tmpresult['civilstatusname']  = ' ' & DESCRIPTION >
		<cfset resultArr[cnt] = tmpresult    >
		<cfset cnt = cnt + 1 >
	  </cfloop>
	<cfset rootstuct['topics'] = resultArr >

	<cfreturn rootstuct />
  <cfcatch>
  	  <cfreturn cfcatch.Detail & ' ' & cfcatch.Message >
  </cfcatch>
  </cftry>
</cffunction>

<cffunction name="getCompany" ExtDirect="true">
<cfargument name="inputargs" >

<cftry>

<cfset page = inputargs.page />
<cfset limit= inputargs.limit />
<cfset start= inputargs.start />
<cfif isdefined("inputargs.query") >
<cfset query= inputargs.query />
<cfelse>
<cfset query= "" />
</cfif>


	<cfquery name="qryLookup" datasource="#client.global_dsn#">
		SELECT COMPANYCODE, DESCRIPTION
		  FROM GLKCOMPANY
		<cfif query NEQ "" >
		 WHERE DESCRIPTION LIKE '%#trim(query)#%'
		</cfif>
		ORDER BY DESCRIPTION ASC
		<cfif Ucase(client.DBMS) EQ 'MYSQL'>
	     	LIMIT #start#, #limit#
	    <cfelseif Ucase(client.DBMS) EQ 'MSSQL'>
	        OFFSET #start# ROWS
	        FETCH NEXT #limit# ROWS ONLY
	    </cfif>
	    ;
	</cfquery>

    <cfquery name="countAll" datasource="IBOSE_GLOBAL" >
        SELECT COMPANYCODE
		  FROM GLKCOMPANY
		<cfif query NEQ "" >
		 WHERE DESCRIPTION LIKE '%#trim(query)#%'
		</cfif>
        ;
    </cfquery>


	<cfset totalcnt = countAll.recordcount >
    <cfset resultArr = ArrayNew(1) >
    <cfset rootstuct = StructNew() >

    <cfset rootstuct['totalCount'] = totalcnt >
	<cfset rootstuct['success']    = "true" >
	<cfset cnt = 1 >
	  <cfloop query = "qryLookup" >
	  	<cfset tmpresult = StructNew() >
		<cfset tmpresult['companycode']  = ' ' & COMPANYCODE >
		<cfset tmpresult['companyname']  = ' ' & DESCRIPTION >
		<cfset resultArr[cnt] = tmpresult    >
		<cfset cnt = cnt + 1 >
	  </cfloop>
	<cfset rootstuct['topics'] = resultArr >

	<cfreturn rootstuct />
  <cfcatch>
  	  <cfreturn cfcatch.Detail & ' ' & cfcatch.Message >
  </cfcatch>
  </cftry>
</cffunction>

<cffunction name="getPosition" ExtDirect="true">
<cfargument name="inputargs" >

<cftry>

<cfset page = inputargs.page />
<cfset limit= inputargs.limit />
<cfset start= inputargs.start />
<cfif isdefined("inputargs.query") >
<cfset query= inputargs.query />
<cfelse>
<cfset query= "" />
</cfif>


	<cfquery name="qryLookup" datasource="#client.company_dsn#">
		SELECT POSITIONCODE, DESCRIPTION
		  FROM CLKPOSITION
		<cfif query NEQ "" >
		 WHERE DESCRIPTION LIKE '%#trim(query)#%'
		</cfif>
		ORDER BY DESCRIPTION ASC
		<cfif Ucase(client.DBMS) EQ 'MYSQL'>
	     	LIMIT #start#, #limit#
	    <cfelseif Ucase(client.DBMS) EQ 'MSSQL'>
	        OFFSET #start# ROWS
	        FETCH NEXT #limit# ROWS ONLY
	    </cfif>
	    ;
	</cfquery>

    <cfquery name="countAll" datasource="#client.company_dsn#" >
        SELECT POSITIONCODE
		  FROM CLKPOSITION
		<cfif query NEQ "" >
		 WHERE DESCRIPTION LIKE '%#trim(query)#%'
		</cfif>
        ;
    </cfquery>

	<cfset totalcnt = countAll.recordcount >
    <cfset resultArr = ArrayNew(1) >
    <cfset rootstuct = StructNew() >

    <cfset rootstuct['totalCount'] = totalcnt >
	<cfset rootstuct['success']    = "true" >
	<cfset cnt = 1 >
	  <cfloop query = "qryLookup" >
	  	<cfset tmpresult = StructNew() >
		<cfset tmpresult['positioncode']  = ' ' & POSITIONCODE >
		<cfset tmpresult['positionname']  = ' ' & DESCRIPTION >
		<cfset resultArr[cnt] = tmpresult    >
		<cfset cnt = cnt + 1 >
	  </cfloop>
	<cfset rootstuct['topics'] = resultArr >

	<cfreturn rootstuct />
  <cfcatch>
  	  <cfreturn cfcatch.Detail & ' ' & cfcatch.Message >
  </cfcatch>
  </cftry>
</cffunction>

<cffunction name="getCitizenship" ExtDirect="true">
  <cftry>
	<cfquery name="qryLookup" datasource="#client.global_dsn#">
		SELECT CITIZENSHIP, DESCRIPTION
		  FROM GLKCITIZEN
	</cfquery>

	<cfset totalcnt = qryLookup.recordcount >
    <cfset resultArr = ArrayNew(1) >
    <cfset rootstuct = StructNew() >

    <cfset rootstuct['totalCount'] = totalcnt >
	<cfset rootstuct['success']    = "true" >
	<cfset cnt = 1 >
	  <cfloop query = "qryLookup" >
	  	<cfset tmpresult = StructNew() >
		<cfset tmpresult['citizenshipcode']  = ' ' & CITIZENSHIP >
		<cfset tmpresult['citizenshipname']  = ' ' & DESCRIPTION >
		<cfset resultArr[cnt] = tmpresult    >
		<cfset cnt = cnt + 1 >
	  </cfloop>
	<cfset rootstuct['topics'] = resultArr >

	<cfreturn rootstuct />
  <cfcatch>
  	  <cfreturn cfcatch.Detail & ' ' & cfcatch.Message >
  </cfcatch>
  </cftry>
</cffunction>

<cffunction name="getReligion" ExtDirect="true">
  <cftry>
	<cfquery name="qryLookup" datasource="#client.global_dsn#">
		SELECT RELIGIONCODE, DESCRIPTION
		  FROM GLKRELIGION
	</cfquery>

	<cfset totalcnt = qryLookup.recordcount >
    <cfset resultArr = ArrayNew(1) >
    <cfset rootstuct = StructNew() >

    <cfset rootstuct['totalCount'] = totalcnt >
	<cfset rootstuct['success']    = "true" >
	<cfset cnt = 1 >
	  <cfloop query = "qryLookup" >
	  	<cfset tmpresult = StructNew() >
		<cfset tmpresult['religioncode']  = ' ' & RELIGIONCODE >
		<cfset tmpresult['religionname']  = ' ' & DESCRIPTION >
		<cfset resultArr[cnt] = tmpresult    >
		<cfset cnt = cnt + 1 >
	  </cfloop>
	<cfset rootstuct['topics'] = resultArr >

	<cfreturn rootstuct />
  <cfcatch>
  	  <cfreturn cfcatch.Detail & ' ' & cfcatch.Message >
  </cfcatch>
  </cftry>
</cffunction>

<cffunction name="getSchool" ExtDirect="true">
<cfargument name="inputargs" >

<cftry>

<cfset page = inputargs.page />
<cfset limit= inputargs.limit />
<cfset start= inputargs.start />
<cfif isdefined("inputargs.query") >
<cfset query= inputargs.query />
<cfelse>
<cfset query= "" />
</cfif>


	<cfquery name="qryLookup" datasource="#client.global_dsn#">
		SELECT SCHOOLCODE, SCHOOLNAME
		  FROM GLKSCHOOL
		<cfif query NEQ "" >
		 WHERE SCHOOLNAME LIKE '%#trim(query)#%'
		</cfif>
		ORDER BY SCHOOLNAME ASC
		<cfif Ucase(client.DBMS) EQ 'MYSQL'>
	     	LIMIT #start#, #limit#
	    <cfelseif Ucase(client.DBMS) EQ 'MSSQL'>
	        OFFSET #start# ROWS
	        FETCH NEXT #limit# ROWS ONLY
	    </cfif>
	    ;
	</cfquery>

    <cfquery name="countAll" datasource="IBOSE_GLOBAL" >
        SELECT SCHOOLCODE
		  FROM GLKSCHOOL
		<cfif query NEQ "" >
		 WHERE SCHOOLNAME LIKE '%#trim(query)#%'
		</cfif>
        ;
    </cfquery>


	<cfset totalcnt = countAll.recordcount >
    <cfset resultArr = ArrayNew(1) >
    <cfset rootstuct = StructNew() >

    <cfset rootstuct['totalCount'] = totalcnt >
	<cfset rootstuct['success']    = "true" >
	<cfset cnt = 1 >
	  <cfloop query = "qryLookup" >
	  	<cfset tmpresult = StructNew() >
		<cfset tmpresult['schoolcode']  = ' ' & SCHOOLCODE >
		<cfset tmpresult['schoolname']  = ' ' & SCHOOLNAME >
		<cfset resultArr[cnt] = tmpresult    >
		<cfset cnt = cnt + 1 >
	  </cfloop>
	<cfset rootstuct['topics'] = resultArr >

	<cfreturn rootstuct />
  <cfcatch>
  	  <cfreturn cfcatch.Detail & ' ' & cfcatch.Message >
  </cfcatch>
  </cftry>
</cffunction>

<cffunction name="getField" ExtDirect="true">
<cfargument name="inputargs" >

<cftry>

<cfset page = inputargs.page />
<cfset limit= inputargs.limit />
<cfset start= inputargs.start />
<cfif isdefined("inputargs.query") >
<cfset query= inputargs.query />
<cfelse>
<cfset query= "" />
</cfif>


	<cfquery name="qryLookup" datasource="#client.global_dsn#">
		SELECT DEGREECODE, DESCRIPTION
		  FROM GLKDEGREE
		<cfif query NEQ "" >
		 WHERE DESCRIPTION LIKE '%#trim(query)#%'
		</cfif>
		ORDER BY DESCRIPTION ASC
		<cfif Ucase(client.DBMS) EQ 'MYSQL'>
	     	LIMIT #start#, #limit#
	    <cfelseif Ucase(client.DBMS) EQ 'MSSQL'>
	        OFFSET #start# ROWS
	        FETCH NEXT #limit# ROWS ONLY
	    </cfif>
	    ;
	</cfquery>

    <cfquery name="countAll" datasource="IBOSE_GLOBAL" >
        SELECT DEGREECODE, DESCRIPTION
		  FROM GLKDEGREE
		<cfif query NEQ "" >
		 WHERE DESCRIPTION LIKE '%#trim(query)#%'
		</cfif>
        ;
    </cfquery>

	<cfset totalcnt = countAll.recordcount >
    <cfset resultArr = ArrayNew(1) >
    <cfset rootstuct = StructNew() >

    <cfset rootstuct['totalCount'] = totalcnt >
	<cfset rootstuct['success']    = "true" >
	<cfset cnt = 1 >
	  <cfloop query = "qryLookup" >
	  	<cfset tmpresult = StructNew() >
		<cfset tmpresult['fieldcode']  = ' ' & DEGREECODE >
		<cfset tmpresult['fieldname']  = ' ' & DESCRIPTION >
		<cfset resultArr[cnt] = tmpresult    >
		<cfset cnt = cnt + 1 >
	  </cfloop>
	<cfset rootstuct['topics'] = resultArr >

	<cfreturn rootstuct />
  <cfcatch>
  	  <cfreturn cfcatch.Detail & ' ' & cfcatch.Message >
  </cfcatch>
  </cftry>
</cffunction>

<cffunction name="getCourse" ExtDirect="true">
<cfargument name="inputargs" >

<cftry>

<cfset page = inputargs.page />
<cfset limit= inputargs.limit />
<cfset start= inputargs.start />
<cfif isdefined("inputargs.query") >
<cfset query= inputargs.query />
<cfelse>
<cfset query= "" />
</cfif>


	<cfquery name="qryLookup" datasource="IBOSE_GLOBAL">
		SELECT COURSECODE, DESCRIPTION
		  FROM GLKCOURSE
		<cfif query NEQ "" >
		 WHERE DESCRIPTION LIKE '%#trim(query)#%'
		</cfif>
		ORDER BY DESCRIPTION ASC
		<cfif Ucase(client.DBMS) EQ 'MYSQL'>
	     	LIMIT #start#, #limit#
	    <cfelseif Ucase(client.DBMS) EQ 'MSSQL'>
	        OFFSET #start# ROWS
	        FETCH NEXT #limit# ROWS ONLY
	    </cfif>
	    ;
	</cfquery>

    <cfquery name="countAll" datasource="IBOSE_GLOBAL" >
        SELECT COURSECODE
		  FROM GLKCOURSE
		<cfif query NEQ "" >
		 WHERE DESCRIPTION LIKE '%#trim(query)#%'
		</cfif>
        ;
    </cfquery>

	<cfset totalcnt = countAll.recordcount >
    <cfset resultArr = ArrayNew(1) >
    <cfset rootstuct = StructNew() >

    <cfset rootstuct['totalCount'] = totalcnt >
	<cfset rootstuct['success']    = "true" >
	<cfset cnt = 1 >
	  <cfloop query = "qryLookup" >
	  	<cfset tmpresult = StructNew() >
		<cfset tmpresult['coursecode']  = ' ' & COURSECODE >
		<cfset tmpresult['coursename']  = ' ' & DESCRIPTION >
		<cfset resultArr[cnt] = tmpresult    >
		<cfset cnt = cnt + 1 >
	  </cfloop>
	<cfset rootstuct['topics'] = resultArr >

	<cfreturn rootstuct />
  <cfcatch>
  	  <cfreturn cfcatch.Detail & ' ' & cfcatch.Message & ' ' & start & ' ' & limit>
  </cfcatch>
  </cftry>
</cffunction>


<cffunction name="getGovexam" ExtDirect="true">
  <cftry>
	<cfquery name="qryLookup" datasource="#client.global_dsn#">
		SELECT EXAMCODE, TYPEOFEXAM
		  FROM GLKGOVEXAM;
	</cfquery>

	<cfset totalcnt = qryLookup.recordcount >
    <cfset resultArr = ArrayNew(1) >
    <cfset rootstuct = StructNew() >

    <cfset rootstuct['totalCount'] = totalcnt >
	<cfset rootstuct['success']    = "true" >
	<cfset cnt = 1 >
	  <cfloop query = "qryLookup" >
	  	<cfset tmpresult = StructNew() >
		<cfset tmpresult['govexamcode']  = ' ' & EXAMCODE >
		<cfset tmpresult['govexamname']  = ' ' & TYPEOFEXAM >
		<cfset resultArr[cnt] = tmpresult    >
		<cfset cnt = cnt + 1 >
	  </cfloop>
	<cfset rootstuct['topics'] = resultArr >

	<cfreturn rootstuct />
  <cfcatch>
  	  <cfreturn cfcatch.Detail & ' ' & cfcatch.Message >
  </cfcatch>
  </cftry>
</cffunction>


<cffunction name="getCaptcha" ExtDirect="true">

	<cfset retStruct = StructNew()>
	<cfset stringLength = 6>
	<cfset stringList = "0,1,2,3,4,5,6,7,8,9,A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z">
    <cfset rndString = "">
    <cfloop from="1" to="#stringLength#" index="i">
    	<cfset rndNum = RandRange(1, listlen(stringList))>
    	<cfset rndString = rndString & listgetat(stringlist,rndNum)>
	</cfloop>
	<cfset retStruct['captchastring'] = rndString>
	<cfsavecontent variable="c">
		<cfimage
		    action = "captcha"
		    height = "100"
		    text = "#rndString#"
		    width = "300"
		    difficulty = "low"
		    fonts="Arial,Verdana"
		    overwrite = "yes"
		    fontSize = "20">
	</cfsavecontent>
	<cfset retStruct['captchalink'] = c  >
	<cfreturn retStruct>



</cffunction>



</cfcomponent>
<cfcomponent name="lookup" ExtDirect="true">

	
<cffunction name="getDepartments" ExtDirect="true">

<cfquery name="GetGroupName" datasource="#session.global_dsn#" maxrows="1">
	SELECT DESCRIPTION
  	  FROM EGRGUSERGROUPS
	 WHERE DESCRIPTION = 'Power User - Department' AND USERGRPID IN (SELECT USERGRPIDFK
						  	                              			   FROM EGRGROLEINDEX
							                     				      WHERE USERGRPMEMBERSIDX = 'ADMIN' <!---'#session.userid#'---> ); 
</cfquery>

	<cfif GetGroupName.recordcount GT 0> 
	   <cfquery name="positionslist" datasource="#session.company_dsn#">   
    		SELECT DESCRIPTION, DEPARTMENTCODE
              FROM CLKDEPARTMENT;
       </cfquery>
       <cfset totalcnt = positionslist.recordcount >
	   
	    <cfset resultArr = ArrayNew(1) >
	    <cfset rootstuct = StructNew() >
		
	    <cfset rootstuct['totalCount'] = totalcnt >
	    
		<cfset cnt = 1 >
		  <cfloop query = "positionslist" >
		  	<cfset tmpresult = StructNew() >
			<cfset tmpresult['departmentcode']  = DEPARTMENTCODE >
			<cfset tmpresult['departmentname']  = DESCRIPTION >
			<cfset resultArr[cnt] = tmpresult    >
			<cfset cnt = cnt + 1 >
		  </cfloop>
		<cfset rootstuct['topics'] = resultArr > 
		
	<cfelse>
		<cfquery name="positionslist" datasource="#session.company_dsn#" maxrows="1">
			SELECT A.DEPARTMENTCODE AS DEPARTMENTCODE, B.DESCRIPTION AS DESCRIPTION, PERSONNELIDNO
          	  FROM #session.maintable# A LEFT JOIN CLKDEPARTMENT B ON (A.DEPARTMENTCODE = B.DEPARTMENTCODE) 
         	 WHERE PERSONNELIDNO = '#session.chapa#' ;
        </cfquery>
        
       
        <cfset cnt = 2 >
	    <cfset resultArr = ArrayNew(1) >
	    <cfset rootstuct = StructNew() >
		<cfset tmpresult = StructNew() >
		<cfset tmpresult['departmentcode']  = positionslist.DEPARTMENTCODE >
		<cfset tmpresult['departmentname']  = positionslist.DESCRIPTION >
		<cfset resultArr[1] = tmpresult    >
	   <cfquery name="qryAdditionalDept" datasource="#session.company_dsn#">  
    		SELECT DESCRIPTION, DEPARTMENTCODE
              FROM CLKDEPARTMENT;
       </cfquery>
       
       <cfloop query="qryAdditionalDept" >
	   	   
        <cfquery name="GetDeptGroup" datasource="#session.global_dsn#" maxrows="1">
			SELECT DESCRIPTION, USERGRPID
		  	  FROM EGRGUSERGROUPS
			 WHERE DESCRIPTION = '#DEPARTMENTCODE#' AND USERGRPID IN (SELECT USERGRPIDFK
						  	                              			   FROM EGRGROLEINDEX
							                     				      WHERE USERGRPMEMBERSIDX = '#session.userid#' );
		</cfquery>
		  <cfif GetDeptGroup.recordcount GT 0 >
		  	<cfset tmpresult = StructNew() >
		    <cfset tmpresult['departmentcode']  = qryAdditionalDept.DEPARTMENTCODE >
			<cfset tmpresult['departmentname']  = qryAdditionalDept.DESCRIPTION >
			<cfset resultArr[cnt] = tmpresult    >
			<cfset cnt = cnt + 1 >
		  </cfif>
		</cfloop>
		
		
		
		<cfset rootstuct['topics'] = resultArr >
		<cfset rootstuct['totalCount'] = cnt > 
	</cfif>
	   
	<cfreturn rootstuct />
	
</cffunction>
	
	

	
	
</cfcomponent>
<cfcomponent name="data" ExtDirect="true">
	
<cffunction name="GetAll" ExtDirect="true">
					
	<cfargument name="page" >
	<cfargument name="start" >
	<cfargument name="limit" >
	<cfargument name="sort" >
	<cfargument name="filter" >
	<cfargument name="departmentcode" >
	
		
	<cfif departmentcode EQ "__" >
		<cfquery name="getUserDept" datasource="#session.company_dsn#" maxrows="1" >
			SELECT DEPARTMENTCODE
			  FROM #session.maintable# 
			 WHERE PERSONNELIDNO = '#session.chapa#'
		</cfquery>
		<cfif isdefined("getUserDept") >
			<cfif getUserDept.recordcount GT 0 >
				<cfset departmentcode = getUserDept.DEPARTMENTCODE />
			</cfif>
		<cfelse>
		</cfif>
	
	</cfif>

		
	  <cfset var qryAuthors = "" /> 
	  
	  <cfquery name="qryMRF" datasource="#session.company_dsn#">
	    SELECT  REQUISITIONNO, 
	    		A.DATELASTUPDATE AS DATELASTUPDATE,
	    		RANKCODE,
	            SKILLSREQ,
	            SPECTRAINING,
	            SEX,
	            REQUISITIONEDBY,
	            REPLACEMENTREASON,
	            REPORTINGTO,
	            REPLACEMENTOF,
	            RELIGION,
	            NATUREOFJOBVAC,
	    		NATUREOFEMP,
	    		NATIONALITY,
	    		MARITALSTAT,
	    	    EFFECTIVE,
	    		AGE,
	            BRIEFDESC,
	            DATE,
	            DATEREQUISITION,
	            IFCONTRACTUAL,
	            DATETO,
	            DEGREEREQ, 
	            EDUCATTAINMENT1,
	            EDUCATTAINMENT2,
	            EDUCATTAINMENT3,
	            EDUCATTAINMENT4,
	            EDUCATTAINMENT5,
	    		DATENEEDED,
	            A.DEPARTMENTCODEFK,
	            DIVISIONCODE,
	            B.DESCRIPTION AS DESCRIPTION,
	            STATUS,
	            REQUIREDNO,
	            PROJECTCODE, 
	            SOURCENAME,
	            POSTED,
	            A.APPROVED,
	            POSTEDBYIBOSE, 
	            POSTEDTO
	      FROM  CRGPERSONELREQUEST A LEFT JOIN CLKPOSITION B ON (A.POSITIONCODEFK = B.POSITIONCODE)
      
	 <cfset where             = "()" >
	 <cfif isdefined('query')>
	   WHERE REQUISITIONNO LIKE '%#query#%'
	 <cfelse>
	 	    <cfset where             = " (" >
            <cfset tmpdatafield      = "" >
            <cfset tmpfilteroperator = "0" >
			
			<cftry>
			<cfset filter = deserializejson(filter) >	<!---Deserialize JSON string coz Router forgets to do the work on filter but not on sort--->
			<cfloop array=#filter# index="filterdata">
            	<cftry>
					<cfset filterdatafield = filterdata.field />
					<cfcatch>
						<cfbreak>
					</cfcatch>
				</cftry>
            
            	<cfset filterdatafield = filterdata.field />
				<cfset filterdatafield = replace(filterdatafield, "_", ".") >
				<cfset filtervalue     = filterdata.value />
				<cfset filtertype      = filterdata.type />
				<cfif tmpdatafield EQ "" >
                <cfset tmpdatafield = filterdatafield >	
                <cfelseif tmpdatafield NEQ filterdatafield >
                	<cfset where = "#where# ) AND ( " >
                <cfelseif tmpdatafield EQ filterdatafield >
                	<cfif tmpfilteroperator EQ 0>
                    	<cfset where = "#where# AND " >
                    <cfelse>
                    	<cfset where = "#where# OR " >
                    </cfif>
				</cfif>
                
                <cfif ucase(filtertype) EQ "STRING" >
					<cfset where = "#where##filterdatafield#  LIKE '%#filtervalue#%'" >
				<cfelseif  ucase(filtertype) EQ "NUMERIC" >
					<cfset filtercondition = filterdata.comparison >
					<cfset expression = "#Ucase(Trim(filtercondition))#" >
               			<cfif expression  EQ "LT">
						   	<cfset where = "#where##filterdatafield#  < #filtervalue#">
						<cfelseif expression EQ "GT"> 	   
							<cfset where = "#where##filterdatafield#  > #filtervalue#">
						<cfelseif expression EQ "EQ"> 	   	
							<cfset where = "#where##filterdatafield#  = #filtervalue#">
						<cfelse>
					</cfif>
				<cfelseif  ucase(filtertype) EQ "DATE" >
					<cfset filtercondition = filterdata.comparison >
					<cfset expression = "#Ucase(Trim(filtercondition))#" >
					
						<cfset filtervalue = CreateODBCDateTime(filtervalue) />
               			<cfif expression  EQ "LT">
	               			<cfset where = "#where##filterdatafield#  < #filtervalue#">
						<cfelseif expression EQ "GT"> 	   
							<cfset where = "#where##filterdatafield#  > #filtervalue#">
						<cfelseif expression EQ "EQ"> 	   	
							<cfset where = "#where##filterdatafield#  = #filtervalue#">
						<cfelse>
							<cfset where = "#where##filterdatafield#  = #filtervalue#">
					    </cfif>
				<cfelse>
					<!---boolean--->
					<cfif filtervalue EQ 'true' >
						<cfset filtervalue = 'Yes' >
					<cfelse>
						<cfset filtervalue = 'No' >
					</cfif>
					<cfset where = "#where##filterdatafield#  LIKE '%#filtervalue#%'" >
				</cfif>
                <cfset tmpdatafield      = filterdatafield >
			</cfloop>
            	<cfcatch>
					<!---Do nothing here since filter is not a valid JSON string--->
				</cfcatch>
            </cftry>
            
            <cfset where = "#where#)" >
			<cfset where = Replace(where, "''", "'" , "all") />
			
			<cfif trim(where) NEQ "()">
				WHERE #PreserveSingleQuotes(where)# AND A.APPROVED LIKE '%Y%' AND A.DEPARTMENTCODEFK = '#departmentcode#'
			<cfelse>
				WHERE A.APPROVED LIKE '%Y%' AND A.DEPARTMENTCODEFK = '#departmentcode#'
			</cfif> 
			
     </cfif>
	      
	  ORDER BY 
	  <!--- Order By Arguments/Contents --->
	  <cfset thecnt = 1 >
	  <cfloop array=#sort# index="sortdata">
	  	  #replace(sortdata.property, "_", ".")# #sortdata.direction#
	  	  <cfif thecnt EQ ArrayLen(sort) >
		  <cfelse>
	  	  	,
		  </cfif>
		  <cfset thecnt = thecnt + 1 > 
	  </cfloop>
	  <!--- End Order By Arguments/Contents --->
	  	
	 <cfif Ucase(session.DBMS) EQ 'MSSQL'>
	  	 OFFSET #start# ROWS
         FETCH NEXT #limit# ROWS ONLY
     <cfelse>
         LIMIT #start#, #limit#
     </cfif>
	  
	  
	  </cfquery>

	<cfquery name="countAll" datasource="#session.company_dsn#" >
		SELECT COUNT(*) AS found_rows 
		  FROM CRGPERSONELREQUEST A LEFT JOIN CLKPOSITION B ON (A.POSITIONCODEFK = B.POSITIONCODE)
	    	<cfif trim(where) NEQ "()">
				WHERE #PreserveSingleQuotes(where)# AND A.APPROVED LIKE '%Y%' AND A.DEPARTMENTCODEFK = '#departmentcode#'
			<cfelse>
				WHERE A.APPROVED LIKE '%Y%' AND A.DEPARTMENTCODEFK = '#departmentcode#'
			</cfif>;
	</cfquery>


	<cfset ecounter = 1 >
	<cfset resultArr = ArrayNew(1) >
	
	<cfset rootstuct = StructNew() >
	<cfset rootstuct['totalCount'] = countAll.found_rows >
	
	<!---Creates an array of structure to be converted to JSON using serializeJSON--->
	<cfloop query="qryMRF">
		<cfset tmpresult                       = StructNew() > <!---Creates new structure in every loop to be added to the array--->
		<cfset tmpresult['REQUISITIONNO']      = REQUISITIONNO  >
		<cfset tmpresult['RANKCODE']           = RANKCODE >
		<cfset tmpresult['SKILLSREQ']          = SKILLSREQ  >
		<cfset tmpresult['SPECTRAINING']       = SPECTRAINING  >
		<cfset tmpresult['SEX']                = SEX  >
		<cfset tmpresult['REQUISITIONEDBY']    = REQUISITIONEDBY  >
		<cfset tmpresult['REPLACEMENTREASON']  = REPLACEMENTREASON  >
		<cfset tmpresult['REPORTINGTO']        = REPORTINGTO  >
		<cfset tmpresult['REPLACEMENTOF']      = REPLACEMENTOF  >
		<cfset tmpresult['RELIGION']           = RELIGION  >
		<cfset tmpresult['NATUREOFJOBVAC']     = NATUREOFJOBVAC  >
		<cfset tmpresult['NATUREOFEMP']  	   = NATUREOFEMP  >
		<cfset tmpresult['NATIONALITY']  	   = NATIONALITY  >
		<cfset tmpresult['MARITALSTAT']  	   = MARITALSTAT  >
		<cfset tmpresult['EFFECTIVE']  		   = EFFECTIVE  >
		<cfset tmpresult['AGE']  			   = AGE  >
		<cfset tmpresult['BRIEFDESC']  		   = BRIEFDESC  >
		<cfset tmpresult['DATELASTUPDATE']     = DATELASTUPDATE  >
		<cfset tmpresult['DATEREQUISITION']    = DATEREQUISITION  >
		<cfset tmpresult['IFCONTRACTUAL']      = IFCONTRACTUAL  >
		<cfset tmpresult['DATETO']  		   = DATETO  >
		<cfset tmpresult['DEGREEREQ']          = DEGREEREQ  >
		<cfset tmpresult['EDUCATTAINMENT1']     = EDUCATTAINMENT1  >
		<cfset tmpresult['EDUCATTAINMENT2']     = EDUCATTAINMENT2  >
		<cfset tmpresult['EDUCATTAINMENT3']     = EDUCATTAINMENT3  >
		<cfset tmpresult['EDUCATTAINMENT4']     = EDUCATTAINMENT4  >
		<cfset tmpresult['EDUCATTAINMENT5']     = EDUCATTAINMENT5  >
		<cfset tmpresult['DATENEEDED'] 		   = DATENEEDED >
		<cfset tmpresult['DEPARTMENTCODEFK']     = qryMRF.DEPARTMENTCODEFK  >
		<cfset tmpresult['DIVISIONCODE']  	   = DIVISIONCODE  >
		<cfset tmpresult['B_DESCRIPTION']  	   = DESCRIPTION  >
		<cfset tmpresult['STATUS']  		   = STATUS  >
		<cfset tmpresult['REQUIREDNO']  	   = REQUIREDNO  >
		<cfset tmpresult['PROJECTCODE'] 	   = PROJECTCODE  >
		<cfset tmpresult['SOURCENAME']  	   = SOURCENAME  >
		<cfset tmpresult['POSTEDBYIBOSE'] 	   = POSTEDBYIBOSE  >
		<cfset tmpresult['POSTEDTO']           = POSTEDTO  >
		
		<cfset resultArr[ecounter] = tmpresult    >  
		<cfset ecounter = ecounter + 1            >
		 
	</cfloop>
	
	<cfset rootstuct['topics'] = resultArr > 
	
		   
	<cfreturn rootstuct />
	
</cffunction>
	
	
	
<cffunction name="post" ExtDirect="true">
		<cfargument name="requisitionno" >
		<cfargument name="type" >
		
	<cfset requisitionnoval = requisitionno >
    <cfset thetype          = type >

	<cfif type EQ 'internal'>
     
   <!---1. Query crgpersonelrequest using the above requisition number. Result returns one record.
		2. Result write to ECRGBOARD for data and ECRTBOARD for users
			a. Data from crgpersonelrequest
			b. Get all users
			c. Insert into ectboard for users
			d. Insert into ecrgboard for data
		3. Update ecrgpersonelrequest Postedbyibose to 'Y'--->
	
	    <cfinvoke component       ="jobposting"
	              method          ="postInternal"
	              returnvariable  ="returnedvar"
	              requisitionnoval="#requisitionnoval#"
	              >
	              
	    <cfif returnedvar EQ requisitionnoval >
	    	<!---OK--->
	    <cfelse>
	    	<cfthrow detail="Requisition Number mismatch" message="Requisition Number Error!">
	    </cfif>

	<cfelseif type EQ 'company'>

	    <cfinvoke component       ="jobposting"
	              method          ="postCompany"
	              returnvariable  ="returnedvar"
	              requisitionnoval="#requisitionnoval#"
	              >
              
             
            <cfif returnedvar EQ requisitionnoval >
				<!---OK--->
                <cfoutput>Posted to Company</cfoutput>
            <cfelse>
                <cfthrow detail="Requisition Number mismatch" message="Requisition Number Error!">
            </cfif>


	<cfelseif type EQ 'global'>

		<cfinvoke component="jobposting"
	              method="postGlobal"
	              returnvariable="returnedvar"
	              requisitionnoval="#requisitionnoval#"
	              >
              
             <cfif returnedvar EQ requisitionnoval >
				<!---OK--->
                <cfoutput>Posted to Global</cfoutput>
             <cfelse>
                <cfthrow detail="Requisition Number mismatch" message="Requisition Number Error!">
             </cfif>
             
	<cfelseif type EQ 'internalcompany'>

		<cfinvoke component="jobposting"
	              method="postinternalcompany"
	              returnvariable="returnedvar"
	              requisitionnoval="#requisitionnoval#"
	              >
              
             <cfif returnedvar EQ requisitionnoval >
				<!---OK--->
                <cfoutput>Posted to Internal and Company</cfoutput>
             <cfelse>
                <cfthrow detail="Requisition Number mismatch" message="Requisition Number Error!">
             </cfif>
             
	<cfelseif type EQ 'internalglobal'>
	
		<cfinvoke component="jobposting"
	              method="postinternalglobal"
	              returnvariable="returnedvar"
	              requisitionnoval="#requisitionnoval#"
	              >
              
             <cfif returnedvar EQ requisitionnoval >
				<!---OK--->
                <cfoutput>Posted to Internal and Global</cfoutput>
             <cfelse>
                <cfthrow detail="Requisition Number mismatch" message="Requisition Number Error!">
             </cfif>
             
	<cfelseif type EQ 'companyglobal'>
	
		<cfinvoke component="jobposting"
	              method="postcompanyglobal"
	              returnvariable="returnedvar"
	              requisitionnoval="#requisitionnoval#"
	              >
              
             <cfif returnedvar EQ requisitionnoval >
				<!---OK--->
                <cfoutput>Posted to Company and Global</cfoutput>
             <cfelse>
                <cfthrow detail="Requisition Number mismatch" message="Requisition Number Error!">
             </cfif>
             
	<cfelseif type EQ 'all'>
	
		<cfinvoke component="jobposting"
	              method="postAll"
	              returnvariable="returnedvar"
	              requisitionnoval="#requisitionnoval#"
	              >
              
             <cfif returnedvar EQ requisitionnoval >
				<!---OK--->
                <cfoutput>Posted to All</cfoutput>
             <cfelse>
                <cfthrow detail="Requisition Number mismatch" message="Requisition Number Error!">
             </cfif>
               
	<cfelse>
		<cfthrow detail="unknown type" message="unknown type!">
	</cfif>
		
		<cfset resultArr = ArrayNew(1) >
	    <cfset rootstuct = StructNew() >
	    <cfset rootstuct['totalCount'] = 1 >
		<cfset tmpresult['requisitionno']  = requisitionno >
		<cfset tmpresult['type'] = type >
		
		<cfset resultArr[1] = tmpresult    >
		<cfset rootstuct['topics'] = resultArr > 
		   
	<cfreturn rootstuct />
	
</cffunction>
	
	
	
	
<cffunction name      ="gridtoexcel"
			returntype="string"
			access    ="remote"
			ExtDirect ="true"
>
    
    <cftry>
    	<cfquery name="mygriddata"
				 datasource="#session.company_dsn#"
	    >
	    	SELECT * 
			  FROM CRGPERSONELREQUEST
		</cfquery>
   
   		<cfspreadsheet  
		    action="write" 
		    filename = "#expandpath('./')#JobPostingData.xls"
		    overwrite = "true"				  
		    query = "mygriddata" 
		>
	<cfcatch type="any">
		<cfreturn cfcatch.detail >
	</cfcatch>
		
	</cftry>	
	
	<cfreturn "success">	
   
</cffunction>
	
	
<cffunction name      ="updatenow"
			ExtDirect ="true"
>
<cfargument name="datatoupdate" >

<cftry>
<cfif isArray(datatoupdate) >
	<cfset datatoupdate = datatoupdate[1] >
</cfif>
	
	<cfset DATENEEDED = DateFormat(left(datatoupdate.DATENEEDED, 10), 'YYYY-MM-DD') >
	<cfquery name="updatecrgpersonelrequet" datasource="#session.company_dsn#">
		UPDATE CRGPERSONELREQUEST
	       SET DATENEEDED = <cfqueryparam  cfsqltype="cf_sql_date" value="#DATENEEDED#">,
	           POSTEDBYIBOSE = <cfqueryparam  cfsqltype="cf_sql_varchar" value="#datatoupdate.POSTEDBYIBOSE#">
	     WHERE REQUISITIONNO = '#datatoupdate.REQUISITIONNO#';
	</cfquery>

<cfcatch>
	<cfreturn "#cfcatch.Detail# #cfcatch.Message#">
</cfcatch>
</cftry>
<cfreturn "success" >

</cffunction> 
	
	
</cfcomponent>
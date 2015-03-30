<cfcomponent name="data" ExtDirect="true">
	
<cffunction name="GetAll" ExtDirect="true">
					
	<cfargument name="page" >
	<cfargument name="start" >
	<cfargument name="limit" >
	<cfargument name="sort" >
	<cfargument name="filter" >
	<cfargument name="departmentcode" >
		
	  <cfset var qryAuthors = "" /> 
	  
	  <cfquery name="qryMRF" datasource="#session.global_dsn#">
	    SELECT A.REFERENCECODE 		AS A_REFERENCECODE,
	           A.FIRSTNAME 			AS A_FIRSTNAME,
	           A.LASTNAME 			AS A_LASTNAME,
	           A.MIDDLENAME 		AS A_MIDDLENAME,
	           A.STARTINGSALARY 	AS A_STARTINGSALARY,
	           A.WORKEXPRATING 		AS A_WORKEXPRATING,
	           A.APPLICATIONDATE 	AS A_APPLICATIONDATE,
	           C.DESCRIPTION 		AS C_DESCRIPTION,
	           D.DESCRIPTION 		AS D_DESCRIPTION,
	           E.DESCRIPTION 		AS E_DESCRIPTION,
	           A.COMPANYCODE 		AS A_COMPANYCODE,
	           F.SCHOOLNAME 		AS F_SCHOOLNAME,
	           I.DESCRIPTION 		AS I_DESCRIPTION,
	           A.COLLEGEISGRAD 		AS A_COLLEGEISGRAD,
	           G.SCHOOLNAME 		AS G_SCHOOLNAME,
	           J.DESCRIPTION 		AS J_DESCRIPTION,
	           A.POSTGRADISGRAD 	AS A_POSTGRADISGRAD,
	           H.SCHOOLNAME 		AS H_SCHOOLNAME,
	           K.DESCRIPTION 		AS K_DESCRIPTION,
	           A.VOCATIONALISGRAD 	AS A_VOCATIONALISGRAD,
	           B.AGE 				AS B_AGE,
	           B.SEX 				AS B_SEX,
	           B.CIVILSTATUS 		AS B_CIVILSTATUS,
	           B.CONTACTADDRESS 	AS B_CONTACTADDRESS,
	           B.CITIZENSHIP 		AS B_CITIZENSHIP
	                  
	     FROM EGMFAP A LEFT JOIN EGIN21PERSONALINFO B ON (A.REFERENCECODE = B.REFERENCECODE)
	        <cfif ucase(session.dbms) eq "MSSQL" >
	        	LEFT JOIN #session.company_dsn#.dbo.CLKPOSITION C ON (A.POSITIONCODE=C.POSITIONCODE)
	          	LEFT JOIN #session.company_dsn#.dbo.CLKPOSITION D ON (A.POSITIONSECONDPRIORITY=D.POSITIONCODE)
	          	LEFT JOIN #session.company_dsn#.dbo.CLKPOSITION E ON (A.POSITIONTHIRDPRIORITY=E.POSITIONCODE)
	        <cfelse>
	        	LEFT JOIN #session.company_dsn#.CLKPOSITION C ON (A.POSITIONCODE=C.POSITIONCODE)
	          	LEFT JOIN #session.company_dsn#.CLKPOSITION D ON (A.POSITIONSECONDPRIORITY=D.POSITIONCODE)
	          	LEFT JOIN #session.company_dsn#.CLKPOSITION E ON (A.POSITIONTHIRDPRIORITY=E.POSITIONCODE)
	        </cfif>
	          LEFT JOIN GLKSCHOOL F ON (A.COLLEGESCHOOL=F.SCHOOLCODE)
	          LEFT JOIN GLKSCHOOL G ON (A.POSTGRADSCHOOL=G.SCHOOLCODE)
	          LEFT JOIN GLKSCHOOL H ON (A.VOCATIONALSCHOOL=H.SCHOOLCODE)
	          LEFT JOIN GLKCOURSE I ON (A.COLLEGECOURSE=I.COURSECODE)
	          LEFT JOIN GLKCOURSE J ON (A.POSTGRADCOURSE=J.COURSECODE)
	          LEFT JOIN GLKCOURSE K ON (A.VOCATIONALCOURSE=K.COURSECODE)
	     	                       
	      
	 <cfset where             = "()" >
	 <cfif isdefined('query')>
	   WHERE REFERENCECODE LIKE '%#query#%' <!--- reserved for grid with search plugin --->
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
				WHERE #PreserveSingleQuotes(where)#  AND (A.COMPANYCODE = '#session.companycode#' OR A.COMPANYCODE = '' OR A.COMPANYCODE IS NULL)
			<cfelse>
				WHERE (A.COMPANYCODE = '#session.companycode#' OR A.COMPANYCODE = '' OR A.COMPANYCODE IS NULL) 
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
	  	
	  <cfif Ucase(session.DBMS) EQ 'MYSQL'>
     	LIMIT #start#, #limit#
      <cfelseif Ucase(session.DBMS) EQ 'MSSQL'>
         OFFSET #start# ROWS
         FETCH NEXT #limit# ROWS ONLY
      </cfif>
	  
	  </cfquery>

<cfquery name="countAll" datasource="#session.global_dsn#" >
	SELECT COUNT(*) AS found_rows 
     FROM EGMFAP A LEFT JOIN EGIN21PERSONALINFO B ON (A.REFERENCECODE = B.REFERENCECODE)
          LEFT JOIN #session.company_dsn#.CLKPOSITION C ON (A.POSITIONCODE=C.POSITIONCODE)
          LEFT JOIN #session.company_dsn#.CLKPOSITION D ON (A.POSITIONSECONDPRIORITY=C.POSITIONCODE)
          LEFT JOIN #session.company_dsn#.CLKPOSITION E ON (A.POSITIONTHIRDPRIORITY=C.POSITIONCODE)
          LEFT JOIN GLKSCHOOL F ON (A.COLLEGESCHOOL=F.SCHOOLCODE)
          LEFT JOIN GLKSCHOOL G ON (A.POSTGRADSCHOOL=G.SCHOOLCODE)
          LEFT JOIN GLKSCHOOL H ON (A.VOCATIONALSCHOOL=H.SCHOOLCODE)
          LEFT JOIN GLKCOURSE I ON (A.COLLEGECOURSE=I.COURSECODE)
          LEFT JOIN GLKCOURSE J ON (A.POSTGRADCOURSE=J.COURSECODE)
          LEFT JOIN GLKCOURSE K ON (A.VOCATIONALCOURSE=K.COURSECODE)
    	<cfif trim(where) NEQ "()">
			WHERE #PreserveSingleQuotes(where)#  AND (COMPANYCODE = '#session.companycode#' OR COMPANYCODE = '' OR COMPANYCODE IS NULL) 
			<cfelse>
				WHERE (COMPANYCODE = '#session.companycode#' OR COMPANYCODE = '' OR COMPANYCODE IS NULL) 
			</cfif> 
    ;
    
</cfquery>


	<cfset ecounter = 1 >
	<cfset resultArr = ArrayNew(1) >
	
	<cfset rootstuct = StructNew() >
	<cfset rootstuct['totalCount'] = countAll.found_rows >
	
	<!---Creates an array of structure to be converted to JSON using serializeJSON--->
	<cfloop query="qryMRF">
		<cfset tmpresult                        = StructNew() 		> <!---Creates new structure in every loop to be added to the array--->
		<cfset tmpresult['A_REFERENCECODE']     = A_REFERENCECODE  	>
		<cfset tmpresult['A_FIRSTNAME']         = A_FIRSTNAME 		>
		<cfset tmpresult['A_LASTNAME']          = A_LASTNAME  		>
		<cfset tmpresult['A_MIDDLENAME']        = A_MIDDLENAME  	>
		<cfset tmpresult['A_STARTINGSALARY']    = A_STARTINGSALARY  >
		<cfset tmpresult['A_WORKEXPRATING']     = A_WORKEXPRATING  	>
		<cfset tmpresult['A_APPLICATIONDATE']   = A_APPLICATIONDATE >
		<cfset tmpresult['C_DESCRIPTION']       = C_DESCRIPTION  	>
		<cfset tmpresult['D_DESCRIPTION']       = D_DESCRIPTION  	>
		<cfset tmpresult['E_DESCRIPTION']       = E_DESCRIPTION  	>
		<cfset tmpresult['A_COMPANYCODE']       = A_COMPANYCODE  	>
		<cfset tmpresult['F_SCHOOLNAME']  	    = F_SCHOOLNAME  	>
		<cfset tmpresult['I_DESCRIPTION']  	    = I_DESCRIPTION  	>
		<cfset tmpresult['A_COLLEGEISGRAD']  	= A_COLLEGEISGRAD  	>
		<cfset tmpresult['G_SCHOOLNAME']  		= G_SCHOOLNAME  	>
		<cfset tmpresult['J_DESCRIPTION']  		= J_DESCRIPTION  	>
		<cfset tmpresult['A_POSTGRADISGRAD']  	= A_POSTGRADISGRAD  >
		<cfset tmpresult['H_SCHOOLNAME']     	= H_SCHOOLNAME  	>
		<cfset tmpresult['K_DESCRIPTION']    	= K_DESCRIPTION  	>
		<cfset tmpresult['A_VOCATIONALISGRAD']	= A_VOCATIONALISGRAD>
		<cfset tmpresult['B_AGE']  		   		= B_AGE  			>
		<cfset tmpresult['B_SEX']          		= B_SEX  		    >
		<cfset tmpresult['B_CIVILSTATUS']     	= B_CIVILSTATUS  	>
		<cfset tmpresult['B_CONTACTADDRESS'] 	= B_CONTACTADDRESS 	>
		<cfset tmpresult['B_CITIZENSHIP']     	= B_CITIZENSHIP  	>
		
		<cfset resultArr[ecounter] = tmpresult    >
		<cfset ecounter = ecounter + 1            >
		 
	</cfloop>
	
	<cfset rootstuct['topics'] = resultArr > 
		   
	<cfreturn rootstuct />
	
</cffunction>
	


	
<cffunction name="GetMRF" ExtDirect="true">
					
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
	            DEPARTMENTCODEFK,
	            DIVISIONCODE,
	            B.DESCRIPTION AS DESCRIPTION,
	            STATUS,
	            REQUIREDNO,
	            PROJECTCODE,
	            SOURCENAME,
	            POSTEDBYIBOSE,
	            POSTEDTO,
	            A.DATELASTUPDATE AS DATELASTUPDATE
	            
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
	  	
	  <cfif Ucase(session.DBMS) EQ 'MYSQL'>
     	LIMIT #start#, #limit#
      <cfelseif Ucase(session.DBMS) EQ 'MSSQL'>
         OFFSET #start# ROWS
         FETCH NEXT #limit# ROWS ONLY
      </cfif>
	  
	  </cfquery>

<cfquery name="countAll" datasource="#session.company_dsn#" >
	SELECT COUNT(*) AS found_rows FROM CRGPERSONELREQUEST A LEFT JOIN CLKPOSITION B ON (A.POSITIONCODEFK = B.POSITIONCODE)
    	<cfif trim(where) NEQ "()">
			<!---WHERE <cfoutput>#PreserveSingleQuotes(where)#</cfoutput>--->
			WHERE #PreserveSingleQuotes(where)# AND POSTEDBYIBOSE = 'Y' AND A.DEPARTMENTCODEFK = '#departmentcode#'
		<cfelse>
			WHERE POSTEDBYIBOSE = 'Y' AND A.DEPARTMENTCODEFK = '#departmentcode#'
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
		<cfset tmpresult['DATENEEDED'] 		   =  DATENEEDED >
		<cfset tmpresult['DEPARTMENTCODEFK']     = qryMRF.DEPARTMENTCODEFK  >
		<cfset tmpresult['DIVISIONCODE']  	   = DIVISIONCODE  >
		<cfset tmpresult['B_DESCRIPTION']  	   = DESCRIPTION  >
		<cfset tmpresult['STATUS']  		   = STATUS  >
		<cfset tmpresult['REQUIREDNO']  	   = REQUIREDNO  >
		<cfset tmpresult['PROJECTCODE'] 	   = PROJECTCODE  >
		<cfset tmpresult['SOURCENAME']  	   = SOURCENAME  >
		<cfset tmpresult['POSTEDBYIBOSE'] 	           = POSTEDBYIBOSE  >
		<cfset tmpresult['POSTEDTO']           = POSTEDTO  >
		
		<cfset resultArr[ecounter] = tmpresult    >
		<cfset ecounter = ecounter + 1            >
		 
	</cfloop>
	
	<cfset rootstuct['topics'] = resultArr > 
		   
	<cfreturn rootstuct />
	
</cffunction>
	
		
	

<cffunction name="GetLocalPool" ExtDirect="true">
					
	<cfargument name="page" >
	<cfargument name="start" >
	<cfargument name="limit" >
	<cfargument name="sort" >
	<cfargument name="filter" >
	<cfargument name="requisitionno" >
	
			
	  <cfset var qryAuthors = "" /> 
	  
	  <cfquery name="qryMRF" datasource="#session.company_dsn#">
	    SELECT  A.GUID AS GUID,
				A.APPLICANTNUMBER AS APPLICANTNUMBER,
				A.LASTNAME AS LASTNAME,
				A.FIRSTNAME AS FIRSTNAME,
				A.MIDDLENAME AS MIDDLENAME,
				A.APPLICATIONDATE AS APPLICATIONDATE,
				H.EMAILADDRESS AS EMAILADDRESS,
				K.DESCRIPTION AS DESCRIPTION,
				A.JOBVACANCYSOURCE AS JOBVACANCYSOURCE,
				A.RESERVED AS RESERVED,
	            H.CONTACTCELLNUMBER AS CONTACTCELLNUMBER,
	            A.SOURCE AS SOURCE,
	            G.REQUISITIONNO AS REQUISITIONNO,
	            G.DATEPRESCREEN AS DATEPRESCREEN,
	            G.DATESENDOUT AS DATESENDOUT
	            
	             
	     FROM  CMFAP A LEFT JOIN CIN21PERSONALINFO H ON (A.GUID = H.GUID)
	      			   LEFT JOIN CMFCANDIDATELISTNG G ON (G.GUID = A.GUID)
	                   LEFT JOIN CLKPOSITION K ON (K.POSITIONCODE = A.POSITIONCODE)
	     	                       
	      
	 <cfset where = "()" >
	 <cfif isdefined('query')>
	   WHERE APPLICANTNUMBER LIKE '%#query#%' <!--- reserved for grid with search plugin --->
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
			
			
			<cfif requisitionno NEQ "__" AND trim(where) NEQ "()">
            	WHERE #PreserveSingleQuotes(where)#  AND ( G.REQUISITIONNO = '#requisitionno#' OR G.REQUISITIONNO IS NULL OR G.REQUISITIONNO = '' OR G.REQUISITIONNO = '_' )
            <cfelseif trim(where) NEQ "()">
            	WHERE #PreserveSingleQuotes(where)# 
            <cfelseif requisitionno NEQ "__" AND trim(where) EQ "()">
				WHERE G.REQUISITIONNO = '#requisitionno#' OR G.REQUISITIONNO IS NULL OR G.REQUISITIONNO = '' OR G.REQUISITIONNO = '_'
		    <cfelse>
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
	  	
	  <cfif Ucase(session.DBMS) EQ 'MYSQL'>
     	LIMIT #start#, #limit#
      <cfelseif Ucase(session.DBMS) EQ 'MSSQL'>
         OFFSET #start# ROWS
         FETCH NEXT #limit# ROWS ONLY
      </cfif>
	  
	  </cfquery>

<cfquery name="countAll" datasource="#session.company_dsn#" >
	SELECT COUNT(*) AS found_rows 
      FROM  CMFAP A LEFT JOIN CIN21PERSONALINFO H ON (A.GUID = H.GUID)
	      			   LEFT JOIN CMFCANDIDATELISTNG G ON (G.GUID = A.GUID)
	                   LEFT JOIN CLKPOSITION K ON (K.POSITIONCODE = A.POSITIONCODE)
	    <cfif requisitionno NEQ "__" AND trim(where) NEQ "()">
        	WHERE #PreserveSingleQuotes(where)#  AND ( G.REQUISITIONNO = '#requisitionno#' OR G.REQUISITIONNO IS NULL OR G.REQUISITIONNO = '' OR G.REQUISITIONNO = '_' )
        <cfelseif trim(where) NEQ "()">
        	WHERE #PreserveSingleQuotes(where)# 
        <cfelseif requisitionno NEQ "__" AND trim(where) EQ "()">
			WHERE G.REQUISITIONNO = '#requisitionno#' OR G.REQUISITIONNO IS NULL OR G.REQUISITIONNO = '' OR G.REQUISITIONNO = '_'
	    <cfelse>
        </cfif> 
    ;  
</cfquery>

	<cfset ecounter = 1 >
	<cfset resultArr = ArrayNew(1) >
	
	<cfset rootstuct = StructNew() >
	<cfset rootstuct['totalCount'] = countAll.found_rows >
	
	<!---Creates an array of structure to be converted to JSON using serializeJSON--->
	<cfloop query="qryMRF">
		<cfset tmpresult = StructNew() > <!---Creates new structure in every loop to be added to the array--->
		<cfset tmpresult['A_GUID']                 = GUID  >
		<cfset tmpresult['A_APPLICANTNUMBER']      = APPLICANTNUMBER >
		<cfset tmpresult['A_LASTNAME']             = LASTNAME  >
		<cfset tmpresult['A_FIRSTNAME']       	   = FIRSTNAME  >
		<cfset tmpresult['A_APPLICATIONDATE']      = APPLICATIONDATE  >
		<cfset tmpresult['H_EMAILADDRESS']    	   = EMAILADDRESS  >
		<cfset tmpresult['K_DESCRIPTION']          = DESCRIPTION  >
		<cfif RESERVED EQ 'Y' OR RESERVED EQ 1 >
			<cfset newreserved = 1 >
		<cfelse>
			<cfset newreserved = 0 >
		</cfif>	
		<cfset tmpresult['A_RESERVED']             = newreserved  >
		<cfset tmpresult['H_CONTACTCELLNUMBER']    = CONTACTCELLNUMBER  >
		<cfset tmpresult['A_SOURCE']               = SOURCE  >
		<cfset tmpresult['G_REQUISITIONNO']  	   = qryMRF.REQUISITIONNO  >
		<cfset tmpresult['G_DATEPRESCREEN']  	   = DATEPRESCREEN  >
		<cfset tmpresult['G_DATESENDOUT']  		   = DATESENDOUT  >
		
		<cfset resultArr[ecounter] = tmpresult    >
		<cfset ecounter            = ecounter + 1 >
		 
	</cfloop>
	
	<cfset rootstuct['topics'] = resultArr > 
		   
	<cfreturn rootstuct />
	
</cffunction>
	
	
	
<cffunction name      ="gridtoexcel"
			returntype="string"
			access    ="remote"
			ExtDirect ="true"
>
    
    <cftry>
    	<cfquery name="mygriddata" datasource="#session.global_dsn#" >
    		SELECT A.COMPANYCODE 		AS 'Company Code',
    			   C.DESCRIPTION 		AS 'Position First Priority',
		           D.DESCRIPTION 		AS 'Position Second Priority',
		           E.DESCRIPTION 		AS 'Position Third Priority',
		           A.WORKEXPRATING 		AS 'Expected Salary',
		           A.STARTINGSALARY 	AS 'Current Salary',
		           A.APPLICATIONDATE 	AS 'Date of Application',
		           A.REFERENCECODE 		AS 'Reference Code',
		           A.FIRSTNAME 			AS 'First Name',
		           A.LASTNAME 			AS 'Last Name',
		           A.MIDDLENAME 		AS 'Middle Name',
		           B.AGE 				AS B_AGE,
		           B.SEX 				AS B_SEX,
		           B.CIVILSTATUS 		AS 'Civil Status',
		           B.CITIZENSHIP 		AS Citizenship,
		           F.SCHOOLNAME 		AS 'College School',
		           I.DESCRIPTION 		AS 'College Course',
		           A.COLLEGEISGRAD 		AS 'College is Graduate',
		           G.SCHOOLNAME 		AS 'Post Graduate School',
		           J.DESCRIPTION 		AS 'Post Graduate Course',
		           A.POSTGRADISGRAD 	AS 'Post Graduate is Graduate',
		           H.SCHOOLNAME 		AS 'Vocational School',
		           K.DESCRIPTION 		AS 'Vocational Course',
		           A.VOCATIONALISGRAD 	AS 'Vocational is Graduate',
		           B.CONTACTADDRESS 	AS Address
		     FROM EGMFAP A LEFT JOIN EGIN21PERSONALINFO B ON (A.REFERENCECODE = B.REFERENCECODE)
		        <cfif ucase(session.dbms) eq "MSSQL" >
		        	LEFT JOIN #session.company_dsn#.dbo.CLKPOSITION C ON (A.POSITIONCODE=C.POSITIONCODE)
		          	LEFT JOIN #session.company_dsn#.dbo.CLKPOSITION D ON (A.POSITIONSECONDPRIORITY=D.POSITIONCODE)
		          	LEFT JOIN #session.company_dsn#.dbo.CLKPOSITION E ON (A.POSITIONTHIRDPRIORITY=E.POSITIONCODE)
		        <cfelse>
		        	LEFT JOIN #session.company_dsn#.CLKPOSITION C ON (A.POSITIONCODE=C.POSITIONCODE)
		          	LEFT JOIN #session.company_dsn#.CLKPOSITION D ON (A.POSITIONSECONDPRIORITY=D.POSITIONCODE)
		          	LEFT JOIN #session.company_dsn#.CLKPOSITION E ON (A.POSITIONTHIRDPRIORITY=E.POSITIONCODE)
		        </cfif>
		          LEFT JOIN GLKSCHOOL F ON (A.COLLEGESCHOOL=F.SCHOOLCODE)
		          LEFT JOIN GLKSCHOOL G ON (A.POSTGRADSCHOOL=G.SCHOOLCODE)
		          LEFT JOIN GLKSCHOOL H ON (A.VOCATIONALSCHOOL=H.SCHOOLCODE)
		          LEFT JOIN GLKCOURSE I ON (A.COLLEGECOURSE=I.COURSECODE)
		          LEFT JOIN GLKCOURSE J ON (A.POSTGRADCOURSE=J.COURSECODE)
		          LEFT JOIN GLKCOURSE K ON (A.VOCATIONALCOURSE=K.COURSECODE)
		          
		 ORDER BY A.APPLICATIONDATE DESC;
		</cfquery>
   
   		<cfspreadsheet  
		    action="write" 
		    filename = "#expandpath('./')#Globalpooldata.xls"
		    overwrite = "true"				  
		    query = "mygriddata" 
		>
	<cfcatch>
		<cfreturn cfcatch.detail>
	</cfcatch>
		
	</cftry>	
	
	<cfreturn "success">	
   
</cffunction>
	
	
<cffunction name      ="gridtoexcellocal"
			returntype="string"
			access    ="remote"
			ExtDirect ="true"
>
    
    <cftry>
    	<cfquery name="mygriddata"
				 datasource="#session.company_dsn#"
	    >
	    	SELECT  
				A.APPLICANTNUMBER AS APPLICANTNUMBER,
				A.LASTNAME AS LASTNAME,
				A.FIRSTNAME AS FIRSTNAME,
				A.MIDDLENAME AS MIDDLENAME,
				A.APPLICATIONDATE AS APPLICATIONDATE,
				H.EMAILADDRESS AS EMAILADDRESS,
				K.DESCRIPTION AS DESCRIPTION,
				A.JOBVACANCYSOURCE AS JOBVACANCYSOURCE,
				A.RESERVED AS RESERVED,
	            H.CONTACTCELLNUMBER AS CONTACTCELLNUMBER,
	            A.SOURCE AS SOURCE,
	            G.REQUISITIONNO AS REQUISITIONNO,
	            G.DATEPRESCREEN AS DATEPRESCREEN,
	            G.DATESENDOUT AS DATESENDOUT,
	            A.GUID AS GUID
	            
	             
	     FROM  CMFAP A LEFT JOIN CIN21PERSONALINFO H ON (A.GUID = H.GUID)
	      			   LEFT JOIN CMFCANDIDATELISTNG G ON (G.GUID = A.GUID)
	                   LEFT JOIN CLKPOSITION K ON (K.POSITIONCODE = A.POSITIONCODE)
	 ORDER BY A.APPLICATIONDATE DESC;
		</cfquery>
   
   		<cfspreadsheet  
		    action="write" 
		    filename = "#expandpath('./')#Localpooldata.xls"
		    overwrite = "true"				  
		    query = "mygriddata" 
		>
	<cfcatch>
		<cfreturn cfcatch.detail>
	</cfcatch>
		
	</cftry>	
	
	<cfreturn "success">	
   
</cffunction>
	
<cffunction name      ="updatenow"
			ExtDirect ="true"
>
<cfargument name="requisitionno" > 
<cfargument name="value" >
<cfargument name="field" >

<cftry>
	
<cfset tablefield      = field >
<cfset rowvalue        = value >
<cfset requisitionno   = requisitionno >


<cftry>

<cfset resultpos = FindNoCase("DATE", tablefield) />
<cfif resultpos GT 0>
<cfset rowvalue = DateFormat(left(rowvalue, 10), 'YYYY-MM-DD') >
<cfquery name="updatecrgpersonelrequet" datasource="#session.company_dsn#">

	UPDATE CRGPERSONELREQUEST
       SET #tablefield# = <cfqueryparam  cfsqltype="cf_sql_date" value="#rowvalue#">
     WHERE REQUISITIONNO = '#requisitionno#';

</cfquery>
<cfelse>
<cfquery name="updatecrgpersonelrequet" datasource="#session.company_dsn#">

	UPDATE CRGPERSONELREQUEST
       SET #tablefield# = <cfqueryparam cfsqltype="cf_sql_varchar" value="#rowvalue#">
     WHERE REQUISITIONNO = '#requisitionno#';

</cfquery>
</cfif>

<cfcatch>
<cfquery name="updatecrgpersonelrequet" datasource="#session.company_dsn#">

	UPDATE CRGPERSONELREQUEST
       SET #tablefield# = <cfqueryparam cfsqltype="cf_sql_integer" value="#rowvalue#">
     WHERE REQUISITIONNO = '#requisitionno#';

</cfquery>
</cfcatch>
</cftry>

<cfcatch>
	<cfreturn "#cfcatch.Detail# #cfcatch.Message#">
</cfcatch>
</cftry>
<cfreturn "success" >

</cffunction>

<cffunction name="release" ExtDirect ="true">
<cfargument name="referencecodelist" >

	<cfloop list="#referencecodelist#" index="thereference" delimiters="~" > 
		<cftry>
		    
		    <cfquery name="releaseApp" datasource="#session.global_dsn#">
		        UPDATE EGMFAP
		           SET COMPANYCODE    = ''
		         WHERE REFERENCECODE  = '#thereference#';
		    </cfquery>
		    
		    <cftry>
		    	<cfschedule 
			    	action = "delete" 
			    	task = "#thereference#"
				>   
				<cfcatch>
				</cfcatch>
			</cftry>
		<cfcatch>
			<cfcontinue>
		</cfcatch>
		</cftry>
	</cfloop>

<cfreturn "success" >
</cffunction>

<cffunction name ="reserve" ExtDirect ="true" >
<cfargument name="applicantnumber" >
<cfargument name="reqnum" >

<cfset msg = "success" /> 

<cfloop list="#applicantnumber#" index="appnum" delimiters="~">
	
	<cfif len(appnum) LT 3 >
		<cfcontinue>
	</cfif>

<cftry>
	
 
	
 

		<cfquery name="qryCmfap" datasource="#session.company_dsn#" maxrows="1">
			SELECT GUID,
				   RESERVED,
				   LASTNAME,
				   FIRSTNAME,
				   MIDDLENAME,
				   SALUTATION,
				   RESERVEDBY,
				   POSITIONCODE
				   
			  FROM CMFAP
			 WHERE APPLICANTNUMBER = '#appnum#';
		
		</cfquery>
		
		<cfquery name="qryinfo" datasource="#session.company_dsn#" maxrows="1">
			SELECT GUID,
				   STREETBARRIO,
				   TOWNLOCALITY,
				   CITYPROVINCE,
				   CONTACTCELLNUMBER,
				   CONTACTPAGERNO,
				   TELEPHONENUMBER,
				   EMAILADDRESS,
				   CONTACTADDRESS,
				   CONTACTTELNO,
				   PROVINCIALADDRESS,
				   PROVTELNUMBER,
				   SEX
				   
			  FROM CIN21PERSONALINFO
			 WHERE PERSONNELIDNO = '#appnum#';
		
		</cfquery>


  
             
             
             
             <cfquery name="updateCMFAP" datasource="#session.company_dsn#">
                    UPDATE CMFAP
                    SET RESERVED   = <cfqueryparam cfsqltype="cf_sql_varchar" value="Y"/>,
                        STATUSCODE = <cfqueryparam cfsqltype="cf_sql_varchar" value="RESERVED"/>
                    WHERE APPLICANTNUMBER = '#appnum#';
             </cfquery> 
             
             <cfquery name="updateECINEXAMRESULT" datasource="#session.company_dsn#">
                UPDATE ECINEXAMRESULT
                   SET REQUISITIONNO   = <cfqueryparam cfsqltype="cf_sql_varchar" value="#reqnum#"/>
                 WHERE PERSONNELIDNO = '#appnum#';
             </cfquery> 
             
             <cfquery name="updateECINTERVIEWRESULT" datasource="#session.company_dsn#">
                UPDATE ECINTERVIEWRESULT
                   SET REQUISITIONNO = <cfqueryparam cfsqltype="cf_sql_varchar" value="#reqnum#"/>
                 WHERE PERSONNELIDNO = '#appnum#';
             </cfquery> 
             
             <cfquery name="updateECINTERVIEWRESULTFD" datasource="#session.company_dsn#">
                UPDATE ECINTERVIEWRESULTFD
                   SET REQUISITIONNO = <cfqueryparam cfsqltype="cf_sql_varchar" value="#reqnum#"/>
                 WHERE PERSONNELIDNO = '#appnum#';
             </cfquery> 
             
             <cfquery name="updateECINTERVIEWRESULTSD" datasource="#session.company_dsn#">
                UPDATE ECINTERVIEWRESULTSD
                   SET REQUISITIONNO = <cfqueryparam cfsqltype="cf_sql_varchar" value="#reqnum#"/>
                 WHERE PERSONNELIDNO = '#appnum#';
             </cfquery> 
             
             <cfquery name="updateECINTERVIEWRESULTFINAL" datasource="#session.company_dsn#">
                UPDATE ECINTERVIEWRESULTFINAL
                   SET REQUISITIONNO = <cfqueryparam cfsqltype="cf_sql_varchar" value="#reqnum#"/>
                 WHERE PERSONNELIDNO = '#appnum#';
             </cfquery> 
             
             <cfquery name="updateECINJOBOFFER" datasource="#session.company_dsn#">
                UPDATE ECINJOBOFFER
                   SET REQUISITIONNO = <cfqueryparam cfsqltype="cf_sql_varchar" value="#reqnum#"/>
                 WHERE PERSONNELIDNO = '#appnum#';
             </cfquery> 
             
             <cfquery name="updateCINPREEMPREQCHKLIST" datasource="#session.company_dsn#">
                UPDATE CINPREEMPREQCHKLIST
                   SET REQUISITIONNO = <cfqueryparam cfsqltype="cf_sql_varchar" value="#reqnum#"/>
                 WHERE PERSONNELIDNO = '#appnum#';
             </cfquery>
             
             <cfquery name="updateECINCONTRACT" datasource="#session.company_dsn#">
                UPDATE ECINCONTRACT
                   SET REQUISITIONNO = <cfqueryparam cfsqltype="cf_sql_varchar" value="#reqnum#"/>
                 WHERE PERSONNELIDNO = '#appnum#';
             </cfquery> 
        
   
        
		<cfquery name="insert_into_candidate" datasource="#session.company_dsn#">
                
                	INSERT INTO CMFCANDIDATELISTNG (  REQUISITIONNO,
                    								  GUID,
                                                      APPLICANTNUMBER,
                                                      RESERVED,
                                                      LASTNAME,
                                                      FIRSTNAME,
                                                      MIDDLENAME,
													  STREETBARRIO,
                                                      TOWNLOCALITY,
                                                      CITYPROVINCE,
													  CONTACTCELLNUMBER,
                                                      CONTACTPAGERNO,
                                                      TELEPHONENUMBER,
                                                      EMAILADDRESS,
                                                      CONTACTADDRESS,
                                                      CONTACTTELNO,
                                                      PROVINCIALADDRESS,
                                                      PROVTELNUMBER,
													  SALUTATION,
                                                      RESERVEDBY,
                                                      GENDER,
                                                      DATEPRESCREEN,
                                                      RECCREATEDBY,
                                                      RECDATECREATED,
                                                      DATELASTUPDATE,
                                                      TIMELASTUPDATE
                                                      
                                                      )
                    
                    VALUES 							( <cfqueryparam cfsqltype="cf_sql_varchar" value="#reqnum#">,
													  <cfqueryparam cfsqltype="cf_sql_varchar" value="#qryCmfap.GUID#">,
													  <cfqueryparam cfsqltype="cf_sql_varchar" value="#appnum#">,
													  <cfqueryparam cfsqltype="cf_sql_varchar" value="Y">,
													  <cfqueryparam cfsqltype="cf_sql_varchar" value="#qryCmfap.LASTNAME#">,
													  <cfqueryparam cfsqltype="cf_sql_varchar" value="#qryCmfap.FIRSTNAME#">,
													  <cfqueryparam cfsqltype="cf_sql_varchar" value="#qryCmfap.MIDDLENAME#">,
													  <cfqueryparam cfsqltype="cf_sql_varchar" value="#qryinfo.STREETBARRIO#">,
													  <cfqueryparam cfsqltype="cf_sql_varchar" value="#qryinfo.TOWNLOCALITY#">,
													  <cfqueryparam cfsqltype="cf_sql_varchar" value="#qryinfo.CITYPROVINCE#">,
													  <cfqueryparam cfsqltype="cf_sql_varchar" value="#qryinfo.CONTACTCELLNUMBER#">,
													  <cfqueryparam cfsqltype="cf_sql_varchar" value="#qryinfo.CONTACTPAGERNO#">,
													  <cfqueryparam cfsqltype="cf_sql_varchar" value="#qryinfo.TELEPHONENUMBER#">,
													  <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(qryinfo.EMAILADDRESS)#">,
													  <cfqueryparam cfsqltype="cf_sql_varchar" value="#qryinfo.CONTACTADDRESS#">,
													  <cfqueryparam cfsqltype="cf_sql_varchar" value="#qryinfo.CONTACTTELNO#">,
													  <cfqueryparam cfsqltype="cf_sql_varchar" value="#qryinfo.PROVINCIALADDRESS#">,
													  <cfqueryparam cfsqltype="cf_sql_varchar" value="#qryinfo.PROVTELNUMBER#">,
													  <cfqueryparam cfsqltype="cf_sql_varchar" value="#qryCmfap.SALUTATION#">,
													  <cfqueryparam cfsqltype="cf_sql_varchar" value="#qryCmfap.RESERVEDBY#">,
													  <cfqueryparam cfsqltype="cf_sql_varchar" value="#qryinfo.SEX#">,
                                                      <cfqueryparam cfsqltype="cf_sql_date" value="#dateformat(now(), 'YYYY-MM-DD')#"/>,
                                                      <cfqueryparam cfsqltype="cf_sql_varchar" value="#session.company_dsn#">,
													  <cfqueryparam cfsqltype="cf_sql_date" value="#DateFormat(Now(), 'MM/DD/YYYY')#">,
													  <cfqueryparam cfsqltype="cf_sql_date" value="#DateFormat(Now(), 'MM/DD/YYYY')#">,
													  <cfqueryparam cfsqltype="cf_sql_varchar" value="#TimeFormat(Now(), 'HH:MM')#">
													  
                                                      );
                    			
                    		
                    
                
                </cfquery>     
				
				 
				<cfquery name="insert_into_shortlisted" datasource="#session.company_dsn#">
                
                	INSERT INTO CMFSHORTLISTED (      REQUISITIONNO,
                    								  GUID,
                                                      APPLICANTNUMBER,
                                                      PERSONNELIDNO,
                                                      LASTNAME,
                                                      FIRSTNAME,
                                                      MIDDLENAME,
													  SALUTATION,
                                                      POSITIONCODE,
                                                      RESERVEDBY
                                                      )
                    
                    VALUES 							( <cfqueryparam cfsqltype="cf_sql_varchar" value="#reqnum#">,
													  <cfqueryparam cfsqltype="cf_sql_varchar" value="#qryCmfap.GUID#">,
													  <cfqueryparam cfsqltype="cf_sql_varchar" value="#appnum#">,
                                                      <cfqueryparam cfsqltype="cf_sql_varchar" value="#appnum#">,
													  <cfqueryparam cfsqltype="cf_sql_varchar" value="#qryCmfap.LASTNAME#">,
													  <cfqueryparam cfsqltype="cf_sql_varchar" value="#qryCmfap.FIRSTNAME#">,
													  <cfqueryparam cfsqltype="cf_sql_varchar" value="#qryCmfap.MIDDLENAME#">,
													  <cfqueryparam cfsqltype="cf_sql_varchar" value="#qryCmfap.SALUTATION#">,
													  <cfqueryparam cfsqltype="cf_sql_varchar" value="#qryCmfap.POSITIONCODE#">,
													  <cfqueryparam cfsqltype="cf_sql_varchar" value="#qryCmfap.RESERVEDBY#">
                                                      );
                    			
                    		
                    
                
                </cfquery> 
                
                
				
				
				
                
                <cfquery name="update_reserve" datasource="#session.company_dsn#">
                    UPDATE CMFAP
                    SET RESERVED   = <cfqueryparam cfsqltype="cf_sql_varchar" value="Y"/>,
                        STATUSCODE = <cfqueryparam cfsqltype="cf_sql_varchar" value="RESERVED"/>  
                    WHERE APPLICANTNUMBER = '#appnum#';      
                </cfquery> 
                
   
     
        
  <cfcatch>
  
  	<cfset msg = msg & ' ' & cfcatch.Detail & ' ' & cfcatch.Message />
        <cfquery name="rollback_x" datasource="#session.company_dsn#">
            DELETE FROM CMFCANDIDATELISTNG
            WHERE APPLICANTNUMBER = '#appnum#';
        </cfquery> 
        <cfquery name="rollback_x" datasource="#session.company_dsn#">
            DELETE FROM CMFSHORTLISTED
            WHERE APPLICANTNUMBER = '#appnum#';
        </cfquery> 
        <cfquery name="update_reserve" datasource="#session.company_dsn#">
            UPDATE CMFAP
            SET RESERVED   = <cfqueryparam cfsqltype="cf_sql_varchar" value="N"/>,
                STATUSCODE = <cfqueryparam cfsqltype="cf_sql_varchar" value=""/>  
            WHERE APPLICANTNUMBER = '#appnum#';      
        </cfquery> 
    
   </cfcatch>
        
                
</cftry>		      

</cfloop>     

<cfreturn msg >

</cffunction>


<cffunction name="unreserve" ExtDirect="true" >
<cfargument name="applicantnumber" >
 

<cfloop list="#applicantnumber#" index="appnum" delimiters="~">
	
	<cfif len(appnum) LT 3 >
		<cfcontinue>
	</cfif>


<cfquery name="deleteCMFCANDIDATELISTNG" datasource="#session.company_dsn#">
			DELETE 
			  FROM CMFCANDIDATELISTNG
			 WHERE APPLICANTNUMBER = '#appnum#';  
</cfquery> 
<cfquery name="deleteCMFSHORTLISTED" datasource="#session.company_dsn#">
			DELETE 
			  FROM CMFSHORTLISTED
	         WHERE APPLICANTNUMBER = '#appnum#';  
</cfquery> 

<cfquery name="update_reserve" datasource="#session.company_dsn#">
			UPDATE CMFAP
			   SET RESERVED = 'N', STATUSCODE = <cfqueryparam cfsqltype="cf_sql_varchar" value="">
			 WHERE APPLICANTNUMBER = '#appnum#';   
</cfquery> 


<cfquery name="updateECINEXAMRESULT1" datasource="#session.company_dsn#">
    UPDATE ECINEXAMRESULT
       SET REQUISITIONNO = <cfqueryparam cfsqltype="cf_sql_varchar" value="">
     WHERE PERSONNELIDNO = '#appnum#';
 </cfquery> 
 
 <cfquery name="updateECINTERVIEWRESULT2" datasource="#session.company_dsn#">
    UPDATE ECINTERVIEWRESULT
       SET REQUISITIONNO = <cfqueryparam cfsqltype="cf_sql_varchar" value="">
     WHERE PERSONNELIDNO = '#appnum#';
 </cfquery> 
 
 <cfquery name="updateECINTERVIEWRESULTFD3" datasource="#session.company_dsn#">
    UPDATE ECINTERVIEWRESULTFD
       SET REQUISITIONNO = <cfqueryparam cfsqltype="cf_sql_varchar" value="">
     WHERE PERSONNELIDNO = '#appnum#';
 </cfquery> 
 
 <cfquery name="updateECINTERVIEWRESULTSD4" datasource="#session.company_dsn#">
    UPDATE ECINTERVIEWRESULTSD
       SET REQUISITIONNO = <cfqueryparam cfsqltype="cf_sql_varchar" value="">
     WHERE PERSONNELIDNO = '#appnum#';
 </cfquery> 
 
 <cfquery name="updateECINTERVIEWRESULTFINAL5" datasource="#session.company_dsn#">
    UPDATE ECINTERVIEWRESULTFINAL
       SET REQUISITIONNO = <cfqueryparam cfsqltype="cf_sql_varchar" value="">
     WHERE PERSONNELIDNO = '#appnum#';
 </cfquery> 
 
 <cfquery name="updateECINJOBOFFER6" datasource="#session.company_dsn#">
    UPDATE ECINJOBOFFER
       SET REQUISITIONNO = <cfqueryparam cfsqltype="cf_sql_varchar" value="">
     WHERE PERSONNELIDNO = '#appnum#';
 </cfquery> 
 
<cfquery name="updateCINPREEMPREQCHKLIST7" datasource="#session.company_dsn#">
    UPDATE CINPREEMPREQCHKLIST
       SET REQUISITIONNO = <cfqueryparam cfsqltype="cf_sql_varchar" value="">
     WHERE PERSONNELIDNO = '#appnum#';
 </cfquery>
 
 <cfquery name="updateECINCONTRACT8" datasource="#session.company_dsn#">
    UPDATE ECINCONTRACT
       SET REQUISITIONNO = <cfqueryparam cfsqltype="cf_sql_varchar" value="">
     WHERE PERSONNELIDNO = '#appnum#';
 </cfquery> 

</cfloop>
<cfreturn "success">
</cffunction>


<cffunction name="sendemail" ExtDirect="true" >
<cfargument name="recipient" >
<cfargument name="subject" >
<cfargument name="body" >
<cftry>
	
	
<cfset ans = findnocase("<script>", body) >
<cfif ans NEQ 0 >
	<cfset body = left(body, ans - 1) >
</cfif>

<cfmail
	from="#recipient#"
	to="#recipient#"
	subject="#subject#" 
	type="html"  
>
<!---server="smtp.gmail.com"
    port="587"
    username="noreply@foodgroup.ph"
    password="n0r3plyp4ss"
    useTLS="yes"---> 
<cfoutput>#body#</cfoutput>
</cfmail>
<cfquery name="update_reserve4" datasource="#session.company_dsn#">
    UPDATE CMFCANDIDATELISTNG
       SET DATESENDOUT  = <cfqueryparam cfsqltype="cf_sql_date" value="#dateformat(now(), 'YYYY-MM-DD')#"/>
     WHERE EMAILADDRESS = '#trim(recipient)#';
</cfquery> 

<cfreturn "success" >

	<cfcatch>
		<cfreturn cfcatch.Detail & ' ' & cfcatch.Message >
	</cfcatch>
</cftry>
 

 
</cffunction>


	
</cfcomponent>
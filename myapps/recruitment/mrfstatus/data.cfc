<cfcomponent name="data" ExtDirect="true">
	
<cffunction name="GetAll" ExtDirect="true">
					 
	<cfargument name="page" >
	<cfargument name="start" >
	<cfargument name="limit" >
	<cfargument name="sort" >
	<cfargument name="filter" >
	<cfargument name="departmentcode" >


<cftry>	


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
	  <cfif Ucase(session.DBMS) EQ 'MYSQL'>
     	<cfset theif = "if" />
		<cfset now   = "now()" />
		<cfset extraparam = "" >
      <cfelseif Ucase(session.DBMS) EQ 'MSSQL'>
        <cfset theif = "iif" />
		<cfset now   = "getdate()" />  
		<cfset extraparam = "day, " >
      </cfif>
	  
	  <cfquery name="qryShortlisted" datasource="#session.company_dsn#">
	    SELECT  A.GUID                  AS A_GUID,
				A.APPLICANTNUMBER       AS A_APPLICANTNUMBER,
	            A.SUFFIX   				AS A_SUFFIX,
				A.LASTNAME 				AS A_LASTNAME,
				A.FIRSTNAME 			AS A_FIRSTNAME,
				A.MIDDLENAME 			AS A_MIDDLENAME,
				A.APPLICATIONDATE 		AS A_APPLICATIONDATE,
				A.PAGIBIGNUMBER 		AS A_PAGIBIGNUMBER,
				A.REFERREDBY 			AS A_REFERREDBY,
				A.SSSNUMBER 			AS A_SSSNUMBER,
				A.STARTINGSALARY 		AS A_STARTINGSALARY,
				A.TIN 					AS A_TIN,
				A.EMAILADD 				AS A_EMAILADD,
				Z.DESCRIPTION 			AS Z_DESCRIPTION,
				A.JOBVACANCYSOURCE 		AS A_JOBVACANCYSOURCE,
				A.RESERVED 				AS A_RESERVED,
	            A.RECDATECREATED 		AS A_RECDATECREATED,
	            <!---TATSOURCING =  Sourcing Date - Date of Application--->
	            datediff( #extraparam# #theif#(A.RECDATECREATED IS NULL, #now#, A.RECDATECREATED) , A.APPLICATIONDATE) 			AS TATSOURCING,
	            A.SOURCE 				AS A_SOURCE,
	            A.STARTINGSALARY 		AS A_STARTINGSALARY,
	            B.EXAMSCHEDDATE 		AS B_EXAMSCHEDDATE,
	            B.STATUS 				AS B_STATUS,
	            B.COMMENTS 				AS B_COMMENTS,
	            B.APPROVED 				AS B_APPROVED,
	            <!---TATEXAMHRINT = (Actual Interview Date from HR Interview Assessment Slip – Date of Exam) – HRAD Non-Working Days--->
	            datediff( #extraparam# #theif#(C.INTERVIEWDATE IS NULL, #now#, C.INTERVIEWDATE) , B.EXAMSCHEDDATE) 				AS TATEXAMHRINT,
	            <!---TATSUMMARYSC = (Actual Interview Date from HR Interview Assessment Slip – MRF Date Received) – HRAD Non-Working Days--->
	            datediff( #extraparam# #theif#(C.INTERVIEWDATE IS NULL, #now#, C.INTERVIEWDATE) , I.DATELASTUPDATE) 				AS TATSUMMARYSC,
	            C.INTERVIEWDATE 		AS C_INTERVIEWDATE,  
	            C.INTERVIEWER 			AS C_INTERVIEWER,
	            C.STATUS 				AS C_STATUS,
	            C.COMMENTS 				AS C_COMMENTS,
	            C.FEEDBACKDATE 			AS C_FEEDBACKDATE,
	            C.APPROVED 				AS C_APPROVED,
	            <!---TATHRFEEDBACK = (Date of Feedback – Date of HR Interview) - HRAD Non-Working Days--->
	            datediff( #extraparam# #theif#(C.FEEDBACKDATE IS NULL, #now#, C.FEEDBACKDATE) , C.INTERVIEWDATE) 					AS TATHRFEEDBACK,
	            E.DATEINVITE 			AS E_DATEINVITE,
	            E.DATEDECISION 			AS E_DATEDECISION,
	            E.STATUS 				AS E_STATUS,
	            E.COMMENTS 				AS E_COMMENTS,
	            <!---TATJOBOFFER = (Date of Applicant’s Decision – Date Presented Job Offer to Applicant) – HRAD Non-Working Days--->
	            datediff( #extraparam# #theif#(E.DATEDECISION IS NULL, #now#, E.DATEDECISION) , E.DATEINVITE) 						AS TATJOBOFFER,
	            <!---TATSUMMARYJO = (Date Presented Job Offer to Applicant - MRF Date Received) – HRAD Non-Working Days--->
	            datediff( #extraparam# #theif#(E.DATEINVITE IS NULL, #now#, E.DATEINVITE) , I.DATELASTUPDATE) 						AS TATSUMMARYJO,
	            F.DATEDISCUSSED 		AS F_DATEDISCUSSED,
	            F.DATERECEIVED 			AS F_DATERECEIVED,
	            F.STATUS 				AS F_STATUS,
	            F.COMMENTS 				AS F_COMMENTS,
	            <!---TATREQ = (Date Accomplished – MRF Date Received) – HRAD Non-Working Days--->
	            datediff( #extraparam# #theif#(F.DATERECEIVED IS NULL, #now#, F.DATERECEIVED) , I.DATELASTUPDATE) 					AS TATREQ,
	            P.DATENEO 				AS P_DATENEO,
	            P.DATEONBOARD 			AS P_DATEONBOARD,
	            <!---TATTOTAL = (On-Boarding Date – MRF Date Received) – HRAD Non-Working Days--->
	            datediff( #extraparam# #theif#(P.DATEONBOARD IS NULL, #now#, P.DATEONBOARD) , I.DATELASTUPDATE) 					AS TATTOTAL,
	            G.REQUISITIONNO 		AS G_REQUISITIONNO,
	            G.DATEPRESCREEN 		AS G_DATEPRESCREEN,
	            G.DATESENDOUT 			AS G_DATESENDOUT,
	            <!---TATPRESCREENINVITE = (Date of Invite Send-Out – Date Pre-Screened) – HRAD Non Working Days--->
	            datediff( #extraparam# #theif#(G.DATESENDOUT IS NULL, #now#, G.DATESENDOUT) , G.DATEPRESCREEN) 					AS TATPRESCREENINVITE,
	            H.CONTACTCELLNUMBER 	AS H_CONTACTCELLNUMBER,
	            H.EMAILADDRESS			AS H_EMAILADDRESS,
	            I.DIVISIONCODE 			AS I_DIVISIONCODE,
	            I.DEPARTMENTCODEFK		AS I_DEPARTMENTCODEFK,
	            I.DATEREQUESTED 		AS I_DATEREQUESTED,
	            I.DATEACTIONWASDONE 	AS I_DATEACTIONWASDONE,
	            I.DATELASTUPDATE 		AS I_DATELASTUPDATE,
	            I.REQUISITIONEDBY 		AS I_REQUISITIONEDBY,
	            <!---TATMRFPOST = MRF POSTED DATE - MRF DATELASTUPDATE--->
	            datediff( #extraparam# #theif#(I.DATEACTIONWASDONE IS NULL, #now#, I.DATEACTIONWASDONE) , I.DATELASTUPDATE) 		AS TATMRFPOST,
	            J.DATEACCOMPLISH 		AS J_DATEACCOMPLISH,
	            J.DATESIGNEDBYAPP 		AS J_DATESIGNEDBYAPP,
	            J.STATUS 				AS J_STATUS,
	            J.COMMENTS 				AS J_COMMENTS,
	            <!---TATCONTRACT = (Date Signed by Applicant – Date Accomplished) – HRAD Non-Working Days--->
	            datediff( #extraparam# #theif#(J.DATESIGNEDBYAPP IS NULL, #now#, J.DATESIGNEDBYAPP) , J.DATEACCOMPLISH) 			AS TATCONTRACT,
	            K.INTERVIEWDATE 		AS K_INTERVIEWDATE,
	            K.DATEACTUALINTERVIEW 	AS K_DATEACTUALINTERVIEW,
	            K.INTERVIEWER 			AS K_INTERVIEWER,
	            <!---TATHDFD = (Date of First Department Interview - HR Interview Date of Feedback) – HRAD Non-Working Days.--->
	            datediff( #extraparam# #theif#(K.INTERVIEWDATE IS NULL, #now#, K.INTERVIEWDATE) , C.FEEDBACKDATE) 					AS TATHDFD,
	            K.STATUS 				AS K_STATUS,
	            K.COMMENTS 				AS K_COMMENTS,
	            K.FEEDBACKDATE 			AS K_FEEDBACKDATE,
	            <!---TATFD = (Date of Feedback from Hiring Department – Date of Actual Interview) – HRAD Non-Working Days--->
	            datediff( #extraparam# #theif#(K.FEEDBACKDATE IS NULL, #now#, K.FEEDBACKDATE) , K.DATEACTUALINTERVIEW) 			AS TATFD,
	            <!---TATSUMMARYFD = (Actual First Hiring Dept Interview Date – MRF Date Received) – HRAD Non-Working Days--->
	            datediff( #extraparam# #theif#(K.DATEACTUALINTERVIEW IS NULL, #now#, K.DATEACTUALINTERVIEW) , I.DATELASTUPDATE) 	AS TATSUMMARYFD,
	            L.INTERVIEWDATE 		AS L_INTERVIEWDATE,
	            L.DATEACTUALINTERVIEW 	AS L_DATEACTUALINTERVIEW,
	            L.INTERVIEWER 			AS L_INTERVIEWER,
	            <!---TATHDSD = (Date of Second Department Interview – Date of First Department Interview) – HRAD Non-Working Days.--->
	            datediff( #extraparam# #theif#(L.INTERVIEWDATE IS NULL, #now#, L.INTERVIEWDATE) , K.INTERVIEWDATE) 				AS TATHDSD,
	            L.STATUS 				AS L_STATUS,
	            L.COMMENTS 				AS L_COMMENTS,
	            L.FEEDBACKDATE 			AS L_FEEDBACKDATE,
	            <!---TATSD = (Date of Feedback from Hiring Department – Date of Actual Interview) – HRAD Non-Working Days--->
	            datediff( #extraparam# #theif#(L.FEEDBACKDATE IS NULL, #now#, L.FEEDBACKDATE) , L.DATEACTUALINTERVIEW) 			AS TATSD,
	            <!---TATSUMMARYSD = (Actual Second Hiring Dept Interview Date – MRF Date Received) – HRAD Non-Working Days--->
	            datediff( #extraparam# #theif#(L.DATEACTUALINTERVIEW IS NULL, #now#, L.DATEACTUALINTERVIEW) , I.DATELASTUPDATE) 	AS TATSUMMARYSD,
	            M.INTERVIEWDATE 		AS M_INTERVIEWDATE,
	            M.DATEACTUALINTERVIEW 	AS M_DATEACTUALINTERVIEW,
	            M.INTERVIEWER 			AS M_INTERVIEWER,
	            <!---TATHDMD = (Date of Final Interview – Date of Second Department Interview) – HRAD Non-Working Days.--->
	            datediff( #extraparam# #theif#(M.INTERVIEWDATE IS NULL, #now#, M.INTERVIEWDATE) , L.INTERVIEWDATE) 				AS TATHDMD,
	            M.STATUS 				AS M_STATUS,
	            M.COMMENTS 				AS M_COMMENTS,
	            M.FEEDBACKDATE 			AS M_FEEDBACKDATE,
	            <!---TATMD = (Date of Feedback from Final Interview – Date of Final Interview) – HRAD Non-Working Days--->
	            datediff( #extraparam# #theif#(M.FEEDBACKDATE IS NULL, #now#, M.FEEDBACKDATE) , M.INTERVIEWDATE) 					AS TATMD,
	            <!---TATSUMMARYMD = (Actual Final Interview Date – MRF Date Received) – HRAD Non-Working Days--->
	            datediff( #extraparam# #theif#(M.DATEACTUALINTERVIEW IS NULL, #now#, M.DATEACTUALINTERVIEW) , I.DATELASTUPDATE) 	AS TATSUMMARYMD
	           
	              
	     FROM  CMFAP A  LEFT JOIN CMFCANDIDATELISTNG     G ON (A.GUID = G.GUID) 
	     				LEFT JOIN CRGPERSONELREQUEST     I ON (I.REQUISITIONNO = G.REQUISITIONNO)
	     				LEFT JOIN CIN21PERSONALINFO      H ON (A.GUID = H.GUID)
	     				LEFT JOIN ECINEXAMRESULT         B ON (B.APPLICANTNUMBER = G.APPLICANTNUMBER) <!---EGINEXAMRESULT eq global db same with the following--->
		                LEFT JOIN ECINTERVIEWRESULT      C ON (C.APPLICANTNUMBER = G.APPLICANTNUMBER)
	                    LEFT JOIN ECINTERVIEWRESULTFD    K ON (K.APPLICANTNUMBER = G.APPLICANTNUMBER)
	                    LEFT JOIN ECINTERVIEWRESULTSD    L ON (L.APPLICANTNUMBER = G.APPLICANTNUMBER)
	                    LEFT JOIN ECINTERVIEWRESULTFINAL M ON (M.APPLICANTNUMBER = G.APPLICANTNUMBER)
	                    LEFT JOIN ECINJOBOFFER           E ON (E.APPLICANTNUMBER = G.APPLICANTNUMBER)
	                    LEFT JOIN CINPREEMPREQCHKLIST    F ON (F.APPLICANTNUMBER = G.APPLICANTNUMBER)
	                    LEFT JOIN ECINCONTRACT           J ON (J.APPLICANTNUMBER = G.APPLICANTNUMBER)
						LEFT JOIN ECINONBOARDCHECKLIST   P ON (J.APPLICANTNUMBER = P.APPLICANTNUMBER)
	                    LEFT JOIN CLKPOSITION            Z ON (Z.POSITIONCODE  = A.POSITIONCODE)  
		     	                       
	      
	 <cfset where             = "()" >
	 <cfif isdefined('query')>
	   WHERE A_LASTNAME LIKE '%#query#%' <!--- reserved for grid with search plugin --->
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
				WHERE #PreserveSingleQuotes(where)# 
				      AND G.RESERVED = 'Y' 
					  AND I.DEPARTMENTCODEFK = '#departmentcode#' 
					  AND (G.HIRED IS NULL OR G.HIRED = 'N')
			<cfelse>
				WHERE G.RESERVED = 'Y' 
				      AND I.DEPARTMENTCODEFK = '#departmentcode#' 
					  AND (G.HIRED IS NULL OR G.HIRED = 'N')
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
	SELECT COUNT(*) AS found_rows FROM  CMFAP A LEFT JOIN CMFCANDIDATELISTNG     G ON (A.GUID          = G.GUID) 
							     				LEFT JOIN CRGPERSONELREQUEST     I ON (I.REQUISITIONNO = G.REQUISITIONNO)
							     				LEFT JOIN CIN21PERSONALINFO      H ON (A.GUID          = H.GUID)
							     				LEFT JOIN ECINEXAMRESULT         B ON (B.APPLICANTNUMBER = G.APPLICANTNUMBER) 
								                LEFT JOIN ECINTERVIEWRESULT      C ON (C.APPLICANTNUMBER = G.APPLICANTNUMBER)
							                    LEFT JOIN ECINTERVIEWRESULTFD    K ON (K.APPLICANTNUMBER = G.APPLICANTNUMBER)
							                    LEFT JOIN ECINTERVIEWRESULTSD    L ON (L.APPLICANTNUMBER = G.APPLICANTNUMBER)
							                    LEFT JOIN ECINTERVIEWRESULTFINAL M ON (M.APPLICANTNUMBER = G.APPLICANTNUMBER)
							                    LEFT JOIN ECINJOBOFFER           E ON (E.APPLICANTNUMBER = G.APPLICANTNUMBER)
							                    LEFT JOIN CINPREEMPREQCHKLIST    F ON (F.APPLICANTNUMBER = G.APPLICANTNUMBER)
							                    LEFT JOIN ECINCONTRACT           J ON (J.APPLICANTNUMBER = G.APPLICANTNUMBER)
							                    LEFT JOIN ECINONBOARDCHECKLIST   P ON (J.APPLICANTNUMBER = P.APPLICANTNUMBER)
							                    LEFT JOIN CLKPOSITION            Z ON (Z.POSITIONCODE  = A.POSITIONCODE)
    	
			<cfif trim(where) NEQ "()">
				WHERE #PreserveSingleQuotes(where)# 
				      AND G.RESERVED = 'Y' 
					  AND I.DEPARTMENTCODEFK = '#departmentcode#' 
					  AND (G.HIRED IS NULL OR G.HIRED = 'N')
			<cfelse>
				WHERE G.RESERVED = 'Y' 
				      AND I.DEPARTMENTCODEFK = '#departmentcode#' 
					  AND (G.HIRED IS NULL OR G.HIRED = 'N')
			</cfif> 
	 ;    
</cfquery>

<!--- used in rendering the cells if TAT max is reached --->
<cfquery name="getMRFStatusConfig" datasource="#session.company_dsn#">
	SELECT NAME, CONFIGVALUE
	  FROM ECRGMRFSTATUSCONFIG;
</cfquery>
<cfset TOTALTATSOURCING 		= 0 >
<cfset TOTALTATEXAMHRINT 		= 0 >
<cfset TOTALTATSUMMARYSC 		= 0 >
<cfset TOTALTATHRFEEDBACK		= 0 >
<cfset TOTALTATJOBOFFER 		= 0 >
<cfset TOTALTATSUMMARYJO 		= 0 >
<cfset TOTALTATREQ 				= 0 >
<cfset TOTALTATTOTAL 			= 0 >
<cfset TOTALTATPRESCREENINVITE  = 0 >
<cfset TOTALTATMRFPOST          = 0>
<cfset TOTALTATCONTRACT 		= 0 >
<cfset TOTALTATHDFD 			= 0 >
<cfset TOTALTATFD 				= 0 >
<cfset TOTALTATSUMMARYFD 		= 0 >
<cfset TOTALTATHDSD 			= 0 >
<cfset TOTALTATSD 				= 0 >
<cfset TOTALTATSUMMARYSD 		= 0 >
<cfset TOTALTATHDMD 			= 0 >
<cfset TOTALTATMD 				= 0 >
<cfset TOTALTATSUMMARYMD 		= 0 >

<cfloop query="getMRFStatusConfig" >
	<cfif getMRFStatusConfig.NAME EQ 'TOTALTATSOURCING' >
		<cfset TOTALTATSOURCING 		= getMRFStatusConfig.CONFIGVALUE >
	<cfelseif getMRFStatusConfig.NAME EQ 'TOTALTATEXAMHRINT' >
		<cfset TOTALTATEXAMHRINT 		= getMRFStatusConfig.CONFIGVALUE >
	<cfelseif getMRFStatusConfig.NAME EQ 'TOTALTATSUMMARYSC' >
		<cfset TOTALTATSUMMARYSC 		= getMRFStatusConfig.CONFIGVALUE >
	<cfelseif getMRFStatusConfig.NAME EQ 'TOTALTATHRFEEDBACK' >
		<cfset TOTALTATHRFEEDBACK		= getMRFStatusConfig.CONFIGVALUE >
	<cfelseif getMRFStatusConfig.NAME EQ 'TOTALTATJOBOFFER' >
		<cfset TOTALTATJOBOFFER 		= getMRFStatusConfig.CONFIGVALUE >
	<cfelseif getMRFStatusConfig.NAME EQ 'TOTALTATSUMMARYJO' >
		<cfset TOTALTATSUMMARYJO 		= getMRFStatusConfig.CONFIGVALUE >
	<cfelseif getMRFStatusConfig.NAME EQ 'TOTALTATREQ' >
		<cfset TOTALTATREQ 				= getMRFStatusConfig.CONFIGVALUE >
	<cfelseif getMRFStatusConfig.NAME EQ 'TOTALTATTOTAL' >
		<cfset TOTALTATTOTAL 			= getMRFStatusConfig.CONFIGVALUE >
	<cfelseif getMRFStatusConfig.NAME EQ 'TOTALTATPRESCREENINVITE' >
		<cfset TOTALTATPRESCREENINVITE  = getMRFStatusConfig.CONFIGVALUE >
	<cfelseif getMRFStatusConfig.NAME EQ 'TOTALTATMRFPOST' >
		<cfset TOTALTATMRFPOST          = getMRFStatusConfig.CONFIGVALUE >
	<cfelseif getMRFStatusConfig.NAME EQ 'TOTALTATCONTRACT' >
		<cfset TOTALTATCONTRACT 		= getMRFStatusConfig.CONFIGVALUE >
	<cfelseif getMRFStatusConfig.NAME EQ 'TOTALTATHDFD' >
		<cfset TOTALTATHDFD 			= getMRFStatusConfig.CONFIGVALUE >
	<cfelseif getMRFStatusConfig.NAME EQ 'TOTALTATFD' >
		<cfset TOTALTATFD 				= getMRFStatusConfig.CONFIGVALUE >
	<cfelseif getMRFStatusConfig.NAME EQ 'TOTALTATSUMMARYFD' >
		<cfset TOTALTATSUMMARYFD 		= getMRFStatusConfig.CONFIGVALUE >
	<cfelseif getMRFStatusConfig.NAME EQ 'TOTALTATHDSD' >
		<cfset TOTALTATHDSD 			= getMRFStatusConfig.CONFIGVALUE >
	<cfelseif getMRFStatusConfig.NAME EQ 'TOTALTATSD' >
		<cfset TOTALTATSD 				= getMRFStatusConfig.CONFIGVALUE >
	<cfelseif getMRFStatusConfig.NAME EQ 'TOTALTATSUMMARYSD' >
		<cfset TOTALTATSUMMARYSD 		= getMRFStatusConfig.CONFIGVALUE >
	<cfelseif getMRFStatusConfig.NAME EQ 'TOTALTATHDMD' >
		<cfset TOTALTATHDMD 			= getMRFStatusConfig.CONFIGVALUE >
	<cfelseif getMRFStatusConfig.NAME EQ 'TOTALTATMD' >
		<cfset TOTALTATMD 				= getMRFStatusConfig.CONFIGVALUE >
	<cfelseif getMRFStatusConfig.NAME EQ 'TOTALTATSUMMARYMD' >
		<cfset TOTALTATSUMMARYMD 		= getMRFStatusConfig.CONFIGVALUE >
	</cfif>
</cfloop>

	<cfset ecounter = 1 >
	<cfset resultArr = ArrayNew(1) >
	
	<cfset rootstuct = StructNew() >
	<cfset rootstuct['totalCount'] = countAll.found_rows >
	
	<!---Creates an array of structure to be converted to JSON using serializeJSON--->
	<cfloop query="qryShortlisted">
		<cfset tmpresult = StructNew() > <!---Creates new structure in every loop to be added to the array--->
		<cfset tmpresult['A_GUID']                  = A_GUID  >
		<cfset tmpresult['A_APPLICANTNUMBER']       = A_APPLICANTNUMBER >
		<cfset tmpresult['A_FIRSTNAME']             = A_FIRSTNAME  >
		<cfset tmpresult['A_LASTNAME']              = A_LASTNAME  >
		<cfset tmpresult['A_SOURCE']                = A_SOURCE  >
		<cfset tmpresult['A_APPLICATIONDATE']       = A_APPLICATIONDATE  >
		<cfset tmpresult['A_RECDATECREATED']        = A_RECDATECREATED  >
		<cfset tmpresult['B_EXAMSCHEDDATE']         = B_EXAMSCHEDDATE  >
		<cfset tmpresult['B_STATUS']                = B_STATUS  >
		<cfset tmpresult['B_APPROVED']              = B_APPROVED  >
		<cfset tmpresult['B_COMMENTS']              = B_COMMENTS  >
		<cfset tmpresult['C_INTERVIEWDATE']  	    = C_INTERVIEWDATE  >
		<cfset tmpresult['C_INTERVIEWER']  	        = C_INTERVIEWER  >
		<cfset tmpresult['C_STATUS']  	            = C_STATUS  >
		<cfset tmpresult['C_COMMENTS']  		    = C_COMMENTS  >
		<cfset tmpresult['C_FEEDBACKDATE']  		= C_FEEDBACKDATE  >
		<cfset tmpresult['C_APPROVED']  		    = C_APPROVED  >
		<cfset tmpresult['E_DATEINVITE']            = E_DATEINVITE  >
		<cfset tmpresult['E_DATEDECISION']          = E_DATEDECISION  >
		<cfset tmpresult['E_STATUS'] 		        = E_STATUS >
		<cfset tmpresult['E_COMMENTS']              = E_COMMENTS  >
		<cfset tmpresult['F_DATEDISCUSSED']         = F_DATEDISCUSSED  >
		<cfset tmpresult['F_DATERECEIVED']          = F_DATERECEIVED  >
		<cfset tmpresult['F_STATUS']                = F_STATUS  >
		<cfset tmpresult['F_COMMENTS']              = F_COMMENTS  >
		<cfset tmpresult['P_DATENEO']               = P_DATENEO  >
		<cfset tmpresult['P_DATEONBOARD']           = P_DATEONBOARD  >
		<cfset tmpresult['G_REQUISITIONNO']         = G_REQUISITIONNO  >
		<cfset tmpresult['G_DATEPRESCREEN']         = G_DATEPRESCREEN  >
		<cfset tmpresult['G_DATESENDOUT']           = G_DATESENDOUT  > 
		<cfset tmpresult['H_CONTACTCELLNUMBER']     = H_CONTACTCELLNUMBER  >
		<cfset tmpresult['H_EMAILADDRESS']          = H_EMAILADDRESS  >
		<cfset tmpresult['I_REQUISITIONEDBY']       = I_REQUISITIONEDBY  >
		<cfset tmpresult['I_DIVISIONCODE']          = I_DIVISIONCODE  >
		<cfset tmpresult['I_DEPARTMENTCODEFK']        = I_DEPARTMENTCODEFK  >
		<cfset tmpresult['I_DATEREQUESTED']         = I_DATEREQUESTED  >
		<cfset tmpresult['I_DATELASTUPDATE']        = I_DATELASTUPDATE  >
		<cfset tmpresult['I_DATEACTIONWASDONE']     = I_DATEACTIONWASDONE  >
		<cfset tmpresult['J_DATEACCOMPLISH']        = J_DATEACCOMPLISH  >
		<cfset tmpresult['J_DATESIGNEDBYAPP']       = J_DATESIGNEDBYAPP  >
		<cfset tmpresult['J_STATUS']                = J_STATUS  >
		<cfset tmpresult['J_COMMENTS']              = J_COMMENTS  >
		<cfset tmpresult['K_DATEACTUALINTERVIEW']   = K_DATEACTUALINTERVIEW  >
		<cfset tmpresult['K_INTERVIEWDATE']         = K_INTERVIEWDATE  >
		<cfset tmpresult['K_INTERVIEWER']           = K_INTERVIEWER  >
		<cfset tmpresult['K_STATUS']                = K_STATUS  >
		<cfset tmpresult['K_COMMENTS']              = K_COMMENTS  >
		<cfset tmpresult['K_FEEDBACKDATE']          = K_FEEDBACKDATE  >
		<cfset tmpresult['L_DATEACTUALINTERVIEW']   = L_DATEACTUALINTERVIEW  >
		<cfset tmpresult['L_INTERVIEWDATE']         = L_INTERVIEWDATE  >
		<cfset tmpresult['L_INTERVIEWER']           = L_INTERVIEWER  >
		<cfset tmpresult['L_STATUS']                = L_STATUS  >
		<cfset tmpresult['L_COMMENTS']              = L_COMMENTS  >
		<cfset tmpresult['L_FEEDBACKDATE']          = L_FEEDBACKDATE  >
		<cfset tmpresult['M_DATEACTUALINTERVIEW']   = M_DATEACTUALINTERVIEW  >
		<cfset tmpresult['M_INTERVIEWDATE']         = M_INTERVIEWDATE  >
		<cfset tmpresult['M_INTERVIEWER']           = M_INTERVIEWER  >
		<cfset tmpresult['M_STATUS']                = M_STATUS  >
		<cfset tmpresult['M_COMMENTS']              = M_COMMENTS  >
		<cfset tmpresult['M_FEEDBACKDATE']          = M_FEEDBACKDATE  >
		<cfset tmpresult['Z_DESCRIPTION']           = Z_DESCRIPTION  >
		<cfset tmpresult['TATMRFPOST']              = TATMRFPOST  >
		<cfset tmpresult['TATSOURCING']             = TATSOURCING  >
		<cfset tmpresult['TATPRESCREENINVITE']      = TATPRESCREENINVITE  >
		<cfset tmpresult['TATEXAMHRINT']            = TATEXAMHRINT  >
		<cfset tmpresult['TATSUMMARYSC']            = TATSUMMARYSC  >
		<cfset tmpresult['TATHRFEEDBACK']           = TATHRFEEDBACK  >
		<cfset tmpresult['TATHDFD']     			= TATHDFD  >
		<cfset tmpresult['TATFD']     				= TATFD  >
		<cfset tmpresult['TATSUMMARYFD']     		= TATSUMMARYFD  >
		<cfset tmpresult['TATHDSD']     			= TATHDSD  >
		<cfset tmpresult['TATSD']     				= TATSD  >
		<cfset tmpresult['TATSUMMARYSD']    	 	= TATSUMMARYSD  >
		<cfset tmpresult['TATHDMD']     			= TATHDMD  >
		<cfset tmpresult['TATMD']     				= TATMD  >
		<cfset tmpresult['TATSUMMARYMD']     		= TATSUMMARYMD  >
		<cfset tmpresult['TATJOBOFFER']     		= TATJOBOFFER  >
		<cfset tmpresult['TATSUMMARYJO']     		= TATSUMMARYJO  >
		<cfset tmpresult['TATREQ']     				= TATREQ  >
		<cfset tmpresult['TATTOTAL']    			= TATTOTAL  >
		<cfset tmpresult['TATCONTRACT']     		= TATCONTRACT  >
		<cfset tmpresult['TOTALTATSOURCING'] 		= TOTALTATSOURCING >
		<cfset tmpresult['TOTALTATEXAMHRINT'] 		= TOTALTATEXAMHRINT >
		<cfset tmpresult['TOTALTATSUMMARYSC'] 		= TOTALTATSUMMARYSC >
		<cfset tmpresult['TOTALTATHRFEEDBACK']		= TOTALTATHRFEEDBACK >
		<cfset tmpresult['TOTALTATJOBOFFER'] 		= TOTALTATJOBOFFER >
		<cfset tmpresult['TOTALTATSUMMARYJO'] 		= TOTALTATSUMMARYJO >
		<cfset tmpresult['TOTALTATREQ'] 			= TOTALTATREQ >
		<cfset tmpresult['TOTALTATTOTAL'] 			= TOTALTATTOTAL >
		<cfset tmpresult['TOTALTATPRESCREENINVITE'] = TOTALTATPRESCREENINVITE >
		<cfset tmpresult['TOTALTATMRFPOST']         = TOTALTATMRFPOST >
		<cfset tmpresult['TOTALTATCONTRACT'] 		= TOTALTATCONTRACT >
		<cfset tmpresult['TOTALTATHDFD'] 			= TOTALTATHDFD >
		<cfset tmpresult['TOTALTATFD'] 				= TOTALTATFD >
		<cfset tmpresult['TOTALTATSUMMARYFD'] 		= TOTALTATSUMMARYFD >
		<cfset tmpresult['TOTALTATHDSD'] 			= TOTALTATHDSD >
		<cfset tmpresult['TOTALTATSD'] 				= TOTALTATSD >
		<cfset tmpresult['TOTALTATSUMMARYSD'] 		= TOTALTATSUMMARYSD >
		<cfset tmpresult['TOTALTATHDMD'] 			= TOTALTATHDMD >
		<cfset tmpresult['TOTALTATMD'] 				= TOTALTATMD >
		<cfset tmpresult['TOTALTATSUMMARYMD'] 		= TOTALTATSUMMARYMD >
		
		
		<cfset resultArr[ecounter] = tmpresult    >
		<cfset ecounter = ecounter + 1            >
		 
	</cfloop>
	
	<cfset rootstuct['topics'] = resultArr > 
		   
	<cfreturn rootstuct />
	
	<cfcatch>
	 <cfreturn cfcatch.detail & ' ' & cfcatch.message>
	</cfcatch>
</cftry>
	
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
	from="HR"
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


	
<cffunction name      ="gridtoexcel"
			returntype="string"
			access    ="remote"
			ExtDirect ="true"
>
    
    <cftry>
		
		  <cfif Ucase(session.DBMS) EQ 'MYSQL'>
     	<cfset theif = "if" />
		<cfset now   = "now()" />
		<cfset extraparam = "" >
      <cfelseif Ucase(session.DBMS) EQ 'MSSQL'>
        <cfset theif = "iif" />
		<cfset now   = "getdate()" />
		<cfset extraparam = "day, " >
      </cfif>
	  
	  <cfquery name="qryShortlisted" datasource="#session.company_dsn#">
	    SELECT  A.GUID                  AS A_GUID,
				A.APPLICANTNUMBER       AS A_APPLICANTNUMBER,
	            A.SUFFIX   				AS A_SUFFIX,
				A.LASTNAME 				AS A_LASTNAME,
				A.FIRSTNAME 			AS A_FIRSTNAME,
				A.MIDDLENAME 			AS A_MIDDLENAME,
				A.APPLICATIONDATE 		AS A_APPLICATIONDATE,
				A.PAGIBIGNUMBER 		AS A_PAGIBIGNUMBER,
				A.REFERREDBY 			AS A_REFERREDBY,
				A.SSSNUMBER 			AS A_SSSNUMBER,
				A.STARTINGSALARY 		AS A_STARTINGSALARY,
				A.TIN 					AS A_TIN,
				A.EMAILADD 				AS A_EMAILADD,
				Z.DESCRIPTION 			AS Z_DESCRIPTION,
				A.JOBVACANCYSOURCE 		AS A_JOBVACANCYSOURCE,
				A.RESERVED 				AS A_RESERVED,
	            A.RECDATECREATED 		AS A_RECDATECREATED,
	            <!---TATSOURCING =  Sourcing Date - Date of Application--->
	            datediff( #extraparam# #theif#(A.RECDATECREATED IS NULL, #now#, A.RECDATECREATED) , A.APPLICATIONDATE) 			AS TATSOURCING,
	            A.SOURCE 				AS A_SOURCE,
	            A.STARTINGSALARY 		AS A_STARTINGSALARY,
	            B.EXAMSCHEDDATE 		AS B_EXAMSCHEDDATE,
	            B.STATUS 				AS B_STATUS,
	            B.COMMENTS 				AS B_COMMENTS,
	            B.APPROVED 				AS B_APPROVED,
	            <!---TATEXAMHRINT = (Actual Interview Date from HR Interview Assessment Slip – Date of Exam) – HRAD Non-Working Days--->
	            datediff( #extraparam# #theif#(C.INTERVIEWDATE IS NULL, #now#, C.INTERVIEWDATE) , B.EXAMSCHEDDATE) 				AS TATEXAMHRINT,
	            <!---TATSUMMARYSC = (Actual Interview Date from HR Interview Assessment Slip – MRF Date Received) – HRAD Non-Working Days--->
	            datediff( #extraparam# #theif#(C.INTERVIEWDATE IS NULL, #now#, C.INTERVIEWDATE) , I.DATELASTUPDATE) 				AS TATSUMMARYSC,
	            C.INTERVIEWDATE 		AS C_INTERVIEWDATE,  
	            C.INTERVIEWER 			AS C_INTERVIEWER,
	            C.STATUS 				AS C_STATUS,
	            C.COMMENTS 				AS C_COMMENTS,
	            C.FEEDBACKDATE 			AS C_FEEDBACKDATE,
	            C.APPROVED 				AS C_APPROVED,
	            <!---TATHRFEEDBACK = (Date of Feedback – Date of HR Interview) - HRAD Non-Working Days--->
	            datediff( #extraparam# #theif#(C.FEEDBACKDATE IS NULL, #now#, C.FEEDBACKDATE) , C.INTERVIEWDATE) 					AS TATHRFEEDBACK,
	            E.DATEINVITE 			AS E_DATEINVITE,
	            E.DATEDECISION 			AS E_DATEDECISION,
	            E.STATUS 				AS E_STATUS,
	            E.COMMENTS 				AS E_COMMENTS,
	            <!---TATJOBOFFER = (Date of Applicant’s Decision – Date Presented Job Offer to Applicant) – HRAD Non-Working Days--->
	            datediff( #extraparam# #theif#(E.DATEDECISION IS NULL, #now#, E.DATEDECISION) , E.DATEINVITE) 						AS TATJOBOFFER,
	            <!---TATSUMMARYJO = (Date Presented Job Offer to Applicant - MRF Date Received) – HRAD Non-Working Days--->
	            datediff( #extraparam# #theif#(E.DATEINVITE IS NULL, #now#, E.DATEINVITE) , I.DATELASTUPDATE) 						AS TATSUMMARYJO,
	            F.DATEDISCUSSED 		AS F_DATEDISCUSSED,
	            F.DATERECEIVED 			AS F_DATERECEIVED,
	            F.STATUS 				AS F_STATUS,
	            F.COMMENTS 				AS F_COMMENTS,
	            <!---TATREQ = (Date Accomplished – MRF Date Received) – HRAD Non-Working Days--->
	            datediff( #extraparam# #theif#(F.DATERECEIVED IS NULL, #now#, F.DATERECEIVED) , I.DATELASTUPDATE) 					AS TATREQ,
	            P.DATENEO 				AS P_DATENEO,
	            P.DATEONBOARD 			AS P_DATEONBOARD,
	            <!---TATTOTAL = (On-Boarding Date – MRF Date Received) – HRAD Non-Working Days--->
	            datediff( #extraparam# #theif#(P.DATEONBOARD IS NULL, #now#, P.DATEONBOARD) , I.DATELASTUPDATE) 					AS TATTOTAL,
	            G.REQUISITIONNO 		AS G_REQUISITIONNO,
	            G.DATEPRESCREEN 		AS G_DATEPRESCREEN,
	            G.DATESENDOUT 			AS G_DATESENDOUT,
	            <!---TATPRESCREENINVITE = (Date of Invite Send-Out – Date Pre-Screened) – HRAD Non Working Days--->
	            datediff( #extraparam# #theif#(G.DATESENDOUT IS NULL, #now#, G.DATESENDOUT) , G.DATEPRESCREEN) 					AS TATPRESCREENINVITE,
	            H.CONTACTCELLNUMBER 	AS H_CONTACTCELLNUMBER,
	            H.EMAILADDRESS			AS H_EMAILADDRESS,
	            I.DIVISIONCODE 			AS I_DIVISIONCODE,
	            I.DEPARTMENTCODEFK 		AS I_DEPARTMENTCODEFK,
	            I.DATEREQUESTED 		AS I_DATEREQUESTED,
	            I.DATEACTIONWASDONE 	AS I_DATEACTIONWASDONE,
	            I.DATELASTUPDATE 		AS I_DATELASTUPDATE,
	            I.REQUISITIONEDBY 		AS I_REQUISITIONEDBY,
	            <!---TATMRFPOST = MRF POSTED DATE - MRF DATELASTUPDATE--->
	            datediff( #extraparam# #theif#(I.DATEACTIONWASDONE IS NULL, #now#, I.DATEACTIONWASDONE) , I.DATELASTUPDATE) 		AS TATMRFPOST,
	            J.DATEACCOMPLISH 		AS J_DATEACCOMPLISH,
	            J.DATESIGNEDBYAPP 		AS J_DATESIGNEDBYAPP,
	            J.STATUS 				AS J_STATUS,
	            J.COMMENTS 				AS J_COMMENTS,
	            <!---TATCONTRACT = (Date Signed by Applicant – Date Accomplished) – HRAD Non-Working Days--->
	            datediff( #extraparam# #theif#(J.DATESIGNEDBYAPP IS NULL, #now#, J.DATESIGNEDBYAPP) , J.DATEACCOMPLISH) 			AS TATCONTRACT,
	            K.INTERVIEWDATE 		AS K_INTERVIEWDATE,
	            K.DATEACTUALINTERVIEW 	AS K_DATEACTUALINTERVIEW,
	            K.INTERVIEWER 			AS K_INTERVIEWER,
	            <!---TATHDFD = (Date of First Department Interview - HR Interview Date of Feedback) – HRAD Non-Working Days.--->
	            datediff( #extraparam# #theif#(K.INTERVIEWDATE IS NULL, #now#, K.INTERVIEWDATE) , C.FEEDBACKDATE) 					AS TATHDFD,
	            K.STATUS 				AS K_STATUS,
	            K.COMMENTS 				AS K_COMMENTS,
	            K.FEEDBACKDATE 			AS K_FEEDBACKDATE,
	            <!---TATFD = (Date of Feedback from Hiring Department – Date of Actual Interview) – HRAD Non-Working Days--->
	            datediff( #extraparam# #theif#(K.FEEDBACKDATE IS NULL, #now#, K.FEEDBACKDATE) , K.DATEACTUALINTERVIEW) 			AS TATFD,
	            <!---TATSUMMARYFD = (Actual First Hiring Dept Interview Date – MRF Date Received) – HRAD Non-Working Days--->
	            datediff( #extraparam# #theif#(K.DATEACTUALINTERVIEW IS NULL, #now#, K.DATEACTUALINTERVIEW) , I.DATELASTUPDATE) 	AS TATSUMMARYFD,
	            L.INTERVIEWDATE 		AS L_INTERVIEWDATE,
	            L.DATEACTUALINTERVIEW 	AS L_DATEACTUALINTERVIEW,
	            L.INTERVIEWER 			AS L_INTERVIEWER,
	            <!---TATHDSD = (Date of Second Department Interview – Date of First Department Interview) – HRAD Non-Working Days.--->
	            datediff( #extraparam# #theif#(L.INTERVIEWDATE IS NULL, #now#, L.INTERVIEWDATE) , K.INTERVIEWDATE) 				AS TATHDSD,
	            L.STATUS 				AS L_STATUS,
	            L.COMMENTS 				AS L_COMMENTS,
	            L.FEEDBACKDATE 			AS L_FEEDBACKDATE,
	            <!---TATSD = (Date of Feedback from Hiring Department – Date of Actual Interview) – HRAD Non-Working Days--->
	            datediff( #extraparam# #theif#(L.FEEDBACKDATE IS NULL, #now#, L.FEEDBACKDATE) , L.DATEACTUALINTERVIEW) 			AS TATSD,
	            <!---TATSUMMARYSD = (Actual Second Hiring Dept Interview Date – MRF Date Received) – HRAD Non-Working Days--->
	            datediff( #extraparam# #theif#(L.DATEACTUALINTERVIEW IS NULL, #now#, L.DATEACTUALINTERVIEW) , I.DATELASTUPDATE) 	AS TATSUMMARYSD,
	            M.INTERVIEWDATE 		AS M_INTERVIEWDATE,
	            M.DATEACTUALINTERVIEW 	AS M_DATEACTUALINTERVIEW,
	            M.INTERVIEWER 			AS M_INTERVIEWER,
	            <!---TATHDMD = (Date of Final Interview – Date of Second Department Interview) – HRAD Non-Working Days.--->
	            datediff( #extraparam# #theif#(M.INTERVIEWDATE IS NULL, #now#, M.INTERVIEWDATE) , L.INTERVIEWDATE) 				AS TATHDMD,
	            M.STATUS 				AS M_STATUS,
	            M.COMMENTS 				AS M_COMMENTS,
	            M.FEEDBACKDATE 			AS M_FEEDBACKDATE,
	            <!---TATMD = (Date of Feedback from Final Interview – Date of Final Interview) – HRAD Non-Working Days--->
	            datediff( #extraparam# #theif#(M.FEEDBACKDATE IS NULL, #now#, M.FEEDBACKDATE) , M.INTERVIEWDATE) 					AS TATMD,
	            <!---TATSUMMARYMD = (Actual Final Interview Date – MRF Date Received) – HRAD Non-Working Days--->
	            datediff( #extraparam# #theif#(M.DATEACTUALINTERVIEW IS NULL, #now#, M.DATEACTUALINTERVIEW) , I.DATELASTUPDATE) 	AS TATSUMMARYMD
	           
	              
	     FROM  CMFAP A  LEFT JOIN CMFCANDIDATELISTNG     G ON (A.GUID = G.GUID) 
	     				LEFT JOIN CRGPERSONELREQUEST     I ON (I.REQUISITIONNO = G.REQUISITIONNO)
	     				LEFT JOIN CIN21PERSONALINFO      H ON (A.GUID = H.GUID)
	     				LEFT JOIN ECINEXAMRESULT         B ON (B.APPLICANTNUMBER = G.APPLICANTNUMBER) 
		                LEFT JOIN ECINTERVIEWRESULT      C ON (C.APPLICANTNUMBER = G.APPLICANTNUMBER)
	                    LEFT JOIN ECINTERVIEWRESULTFD    K ON (K.APPLICANTNUMBER = G.APPLICANTNUMBER)
	                    LEFT JOIN ECINTERVIEWRESULTSD    L ON (L.APPLICANTNUMBER = G.APPLICANTNUMBER)
	                    LEFT JOIN ECINTERVIEWRESULTFINAL M ON (M.APPLICANTNUMBER = G.APPLICANTNUMBER)
	                    LEFT JOIN ECINJOBOFFER           E ON (E.APPLICANTNUMBER = G.APPLICANTNUMBER)
	                    LEFT JOIN CINPREEMPREQCHKLIST    F ON (F.APPLICANTNUMBER = G.APPLICANTNUMBER)
	                    LEFT JOIN ECINCONTRACT           J ON (J.APPLICANTNUMBER = G.APPLICANTNUMBER)
	                    LEFT JOIN ECINONBOARDCHECKLIST   P ON (J.APPLICANTNUMBER = P.APPLICANTNUMBER)
	                    LEFT JOIN CLKPOSITION            Z ON (Z.POSITIONCODE  = A.POSITIONCODE)
   ORDER BY A_APPLICATIONDATE DESC;
</cfquery>
   
   		<cfspreadsheet  
		    action="write" 
		    filename = "#expandpath('./')#MRFStatusData.xls"
		    overwrite = "true"				  
		    query = "qryShortlisted" 
		>
	<cfcatch>
		<cfreturn cfcatch.detail & ' ' & cfcatch.message>
	</cfcatch>
		
	</cftry>	
	
	<cfreturn "success">	
   
</cffunction> 
  

</cfcomponent>
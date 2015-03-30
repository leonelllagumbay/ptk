<cfcomponent name="globalpool" ExtDirect="true">
	
<cffunction name="fetch" ExtDirect="true">
<cfargument name="referencecodelist" >

<cfset myList = referencecodelist />
<cfset count = ListLen(myList, "~", "no") /> 

<cfset messageback = myList >
<cfset SEQREFERENCE = "" >
<cfset sourceDir = ExpandPath("../../../unDB/forms/#session.companycode#/")>
<cfset destDir = ExpandPath( "../../../unDB/globalattachments/" ) />
<cftry>
	<cfif Not directoryExists(destDir) >
        <cfdirectory action="create" directory="#destDir#" mode="777" >  
    </cfif> 
<cfcatch></cfcatch>
</cftry>
<cfset imageArray = ArrayNew(1) >

<cfloop index="countme" from="1" to="#count#"> 

<cftry>

<!---Generate GUID --->
<cfset listvaluehere = ListGetAt(myList, countme, "~", "no")>
<cfinvoke method="createGUID" >

 <!---check if guid already exist--->
<cfinvoke component="datafetcher"
          method="isGuidUsed"
          returnvariable="status"
          idtocheck="#sValue#"
          datasource="#session.company_dsn#"
          tablename="CMFAP"
          label="GUID"
          >
          
<cfif status EQ "1">  
	<!---generate new GUID--->
    <cfinvoke component="datafetcher"
              method="generateid"
              returnvariable="newsvalue"
              idtochange="#sValue#"
              >
     <cfset sValue = newsvalue >
   <cfelse>
	<cfset sValue = sValue >
   </cfif>




<!---End generate GUID--->

<!---Fetch to GMFPEOPLE-------------------------------------------------------------------------------------->
<cfquery name="query_from_EGMFAP" datasource="#session.global_dsn#" maxrows="1">
  SELECT   *
	FROM EGMFAP
   WHERE REFERENCECODE = '#listvaluehere#';
</cfquery>
   
<cfloop query="query_from_EGMFAP">
	<cfset SEQREFERENCE = YESREVERT >
	<cfquery name="inserthere" datasource="#session.global_dsn#"> 
         INSERT INTO GMFPEOPLE (GUID,
								FIRSTNAME, 
                                MIDDLENAME, 
                                LASTNAME, 
                                PAGIBIGNUMBER, 
                                SSSNUMBER, 
                                TIN, 
                                COMPANYCODE)
                       VALUES ( <cfqueryparam cfsqltype="cf_sql_varchar" value="#sValue#"/>,
					 		    <cfqueryparam cfsqltype="cf_sql_varchar" value="#FIRSTNAME#"/>,
							    <cfqueryparam cfsqltype="cf_sql_varchar" value="#MIDDLENAME#"/>,
							    <cfqueryparam cfsqltype="cf_sql_varchar" value="#LASTNAME#"/>,
							    <cfqueryparam cfsqltype="cf_sql_varchar" value="#PAGIBIGNUMBER#"/>,
							    <cfqueryparam cfsqltype="cf_sql_varchar" value="#SSSNUMBER#"/>,
							    <cfqueryparam cfsqltype="cf_sql_varchar" value="#TIN#"/>,
							    <cfqueryparam cfsqltype="cf_sql_varchar" value="#COMPANYCODE#"/>
							   );
	 </cfquery>
</cfloop>                
<!---END Fetch to GMFPEOPLE-------------------------------------------------------------------------------------->
                 
<!---Fetch to CMFAP-------------------------------------------------------------------------------------->
<cfinvoke method="createApplicantID" >

   <cfinvoke component="datafetcher"
      method="isGuidUsed"
      returnvariable="status"
      idtocheck="#sApp#"
      datasource="#session.company_dsn#"
      tablename="CMFAP"
      label="APPLICANTNUMBER">
   <cfif status EQ "1">
//generate new ID APPLICANT NUMBER
    <cfinvoke component="datafetcher"
              method="generateidapp"
              returnvariable="newsapp"
              idtochange="#sApp#">
    <cfset sApp = newsapp >
   <cfelse>
    <cfset sApp = sApp >
   </cfif>   
 <cfloop query="query_from_EGMFAP">      
   <cfquery name="insert_to_cmfap" datasource="#session.company_dsn#">  
       INSERT INTO CMFAP (  GUID,
                            APPLICANTNUMBER,
                            SUFFIX,
                            LASTNAME,
                            FIRSTNAME,
                            MIDDLENAME,
                            APPLICATIONDATE,
                            PAGIBIGNUMBER,
                            REFERREDBY,
                            SSSNUMBER,
                            STARTINGSALARY,
                            TIN,
                            EMAILADD,
                            POSITIONCODE,
                            SOURCE,
                            RESERVED,
                            WORKEXPRATING,
                            RECDATECREATED,
                            DATELASTUPDATE,
                            APPLICANTTYPE
                            )
                 VALUES ( <cfqueryparam cfsqltype="cf_sql_varchar" value="#sValue#"/>,
                          <cfqueryparam cfsqltype="cf_sql_varchar" value="#sApp#"/>,
                          <cfqueryparam cfsqltype="cf_sql_varchar" value="#SUFFIX#"/>,
                          <cfqueryparam cfsqltype="cf_sql_varchar" value="#LASTNAME#"/>,
                          <cfqueryparam cfsqltype="cf_sql_varchar" value="#FIRSTNAME#"/>,
                          <cfqueryparam cfsqltype="cf_sql_varchar" value="#MIDDLENAME#"/>,
                          <cfqueryparam cfsqltype="cf_sql_date"    value="#APPLICATIONDATE#"/>,
                          <cfqueryparam cfsqltype="cf_sql_varchar" value="#PAGIBIGNUMBER#"/>,
                          <cfqueryparam cfsqltype="cf_sql_varchar" value="#REFERREDBY#"/>,
                          <cfqueryparam cfsqltype="cf_sql_varchar" value="#SSSNUMBER#"/>,
                          <cfqueryparam cfsqltype="cf_sql_integer" value="#STARTINGSALARY#"/>,
                          <cfqueryparam cfsqltype="cf_sql_varchar" value="#TIN#"/>,
                          <cfqueryparam cfsqltype="cf_sql_varchar" value="#EMAILADD#"/>,
                          <cfqueryparam cfsqltype="cf_sql_varchar" value="#POSITIONCODE#"/>,
                          <cfqueryparam cfsqltype="cf_sql_varchar" value="#SOURCE#"/>,
                          <cfqueryparam cfsqltype="cf_sql_varchar" value="N"/>,
                          <cfqueryparam cfsqltype="cf_sql_integer" value="#WORKEXPRATING#"/>,
                          <cfqueryparam cfsqltype="cf_sql_date"    value="#dateformat(now(), 'YYYY-MM-DD')#"/>, 
                          <cfqueryparam cfsqltype="cf_sql_date"    value="#DATELASTUPDATE#"/>,
                          <cfqueryparam cfsqltype="cf_sql_varchar" value="#APPLICANTTYPE#"/>
                         );                
    </cfquery> 
 </cfloop> 
<!---END FETCH TO CMFAP-------------------------------------------------------------------------------------->

<!---FETCH TO CIN21PERSONALINFO-------------------------------------------------------------------------------------->
<cfquery name="query_from_EGIN21PERSONALINFO" datasource="#session.global_dsn#" maxrows="1">
  SELECT   *
	FROM EGIN21PERSONALINFO
   WHERE REFERENCECODE = '#listvaluehere#';
</cfquery>
<cfloop query="query_from_EGIN21PERSONALINFO">
	<cfquery name="insert_to_CIN21PERSONALINFO" datasource="#session.company_dsn#">
            INSERT INTO CIN21PERSONALINFO ( GUID,
            								PERSONNELIDNO,
											CONTACTADDRESS,
                                            PROVINCIALADDRESS,
                                            BIRTHDAY,
                                            BIRTHPLACE,
                                            AGE,
                                            SEX,
                                            CIVILSTATUS,
                                            CITIZENSHIP,
                                            RELIGIONCODE,
                                            CONTACTCELLNUMBER,
                                            CONTACTTELNO,
                                            EMAILADDRESS,
                                            HEIGHT,
                                            WEIGHT,
                                            LANGUAGESPOKEN,
                                            PERSONTOCONTACT,
                                            RELATIONSHIP,
                                            TELEPHONENUMBER,
											PERCELLNUMBER,
											PREVIOUSADDRESS,
                                            PROVPERIODOFRES,
                                            LANGUAGEWRITTEN,
                                            CONTACTADDRESS2,
                                            CONTACTADDRESS3,
                                            ACREXPIRATIONDATE )   
             VALUES ( <cfqueryparam cfsqltype="cf_sql_varchar" value="#sValue#"/>,
             		  <cfqueryparam cfsqltype="cf_sql_varchar" value="#sApp#"/>,
                      <cfqueryparam cfsqltype="cf_sql_varchar" value="#CONTACTADDRESS#"/>,
                      <cfqueryparam cfsqltype="cf_sql_varchar" value="#PROVINCIALADDRESS#"/>,
                      <cfqueryparam cfsqltype="cf_sql_date" value="#BIRTHDAY#"/>,
                      <cfqueryparam cfsqltype="cf_sql_varchar" value="#BIRTHPLACE#"/>,
                      <cfqueryparam cfsqltype="cf_sql_varchar" value="#AGE#"/>,
                      <cfqueryparam cfsqltype="cf_sql_varchar" value="#SEX#"/>,
                      <cfqueryparam cfsqltype="cf_sql_varchar" value="#CIVILSTATUS#"/>,
                      <cfqueryparam cfsqltype="cf_sql_varchar" value="#CITIZENSHIP#"/>,
                      <cfqueryparam cfsqltype="cf_sql_varchar" value="#RELIGIONCODE#"/>,
                      <cfqueryparam cfsqltype="cf_sql_varchar" value="#CONTACTCELLNUMBER#"/>,
                      <cfqueryparam cfsqltype="cf_sql_varchar" value="#CONTACTTELNO#"/>,
                      <cfqueryparam cfsqltype="cf_sql_varchar" value="#EMAILADDRESS#"/>,
                      <cfqueryparam cfsqltype="cf_sql_varchar" value="#HEIGHT#"/>,
                      <cfqueryparam cfsqltype="cf_sql_varchar" value="#WEIGHT#"/>,
                      <cfqueryparam cfsqltype="cf_sql_varchar" value="#LANGUAGESPOKEN#"/>,
                      <cfqueryparam cfsqltype="cf_sql_varchar" value="#PERSONTOCONTACT#"/>,
                      <cfqueryparam cfsqltype="cf_sql_varchar" value="#RELATIONSHIP#"/>,
                      <cfqueryparam cfsqltype="cf_sql_varchar" value="#TELEPHONENUMBER#"/>,
                      <cfqueryparam cfsqltype="cf_sql_varchar" value="#PERCELLNUMBER#"/>,
                      <cfqueryparam cfsqltype="cf_sql_varchar" value="#PREVIOUSADDRESS#"/>,
                      <cfqueryparam cfsqltype="cf_sql_varchar" value="#PROVPERIODOFRES#"/>,
					  <cfqueryparam cfsqltype="cf_sql_varchar" value="#LANGUAGEWRITTEN#"/>,
                      <cfqueryparam cfsqltype="cf_sql_varchar" value="#CONTACTADDRESS2#"/>,
                      <cfqueryparam cfsqltype="cf_sql_varchar" value="#CONTACTADDRESS3#"/>,
                      <cfqueryparam cfsqltype="cf_sql_date" value="#ACREXPIRATIONDATE#"/> );                  
   </cfquery> 
</cfloop>
<!---END FETCH TO CIN21PERSONALINFO-------------------------------------------------------------------------------------->

<!---FETCH TO CIN21POSITNAPLD-------------------------------------------------------------------------------------->
  <cfquery name="query_from_EGIN21POSITNAPLD" datasource="#session.global_dsn#">
	  SELECT *
		FROM EGIN21POSITNAPLD
	   WHERE REFERENCECODE = '#listvaluehere#';
  </cfquery>
  
  <cfloop query="query_from_EGIN21POSITNAPLD">
	 <cfquery name="insert_to_CIN21POSITNAPLD" datasource="#session.company_dsn#">      
	    INSERT INTO CIN21POSITNAPLD (   GUID,
										PERSONNELIDNO,     
	    								POSITIONCODE, 
	                                    DEPARTMENTCODE,
	                                    PRIORITY
	                                )
	                         VALUES (  <cfqueryparam cfsqltype="cf_sql_varchar" value="#sValue#"/>,
	                                   <cfqueryparam cfsqltype="cf_sql_varchar" value="#sApp#"/>,
	                                   <cfqueryparam cfsqltype="cf_sql_varchar" value="#POSITIONCODE#"/>,
	                                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#COMPANYCODE#"/>,
	                                   <cfqueryparam cfsqltype="cf_sql_integer" value="#PRIORITY#"/>         
	                                ); 
	  </cfquery>
  </cfloop>  
<!---END FETCH TO CIN21POSITNAPLD-------------------------------------------------------------------------------------->

<!---FETCH TO CIN21FAMILYBKGRND-------------------------------------------------------------------------------------->
<cfquery name="query_from_EGIN21FAMILYBKGRND" datasource="#session.global_dsn#">
  SELECT   *
	FROM EGIN21FAMILYBKGRND
   WHERE REFERENCECODE = '#listvaluehere#';
</cfquery>
<cfloop query="query_from_EGIN21FAMILYBKGRND">
	<cfquery name="insert_to_CIN21FAMILYBKGROUND" datasource="#session.company_dsn#">
            INSERT INTO CIN21FAMILYBKGRND (     GUID,
												PERSONNELIDNO,
												NAME,
												AGE,
												COMPANY,
												OCCUPATION,
									 			RELATIONSHIP, 
												TELEPHONENUMBER    
									       )      
             VALUES ( <cfqueryparam cfsqltype="cf_sql_varchar" value="#sValue#"/>,
                      <cfqueryparam cfsqltype="cf_sql_varchar" value="#sApp#"/>,       
             		  <cfqueryparam cfsqltype="cf_sql_varchar" value="#NAME#"/>,    
                      <cfqueryparam cfsqltype="cf_sql_integer" value="#AGE#"/>,
                      <cfqueryparam cfsqltype="cf_sql_varchar" value="#COMPANY#"/>,
                      <cfqueryparam cfsqltype="cf_sql_varchar" value="#OCCUPATION#"/>,
                      <cfqueryparam cfsqltype="cf_sql_varchar" value="#RELATIONSHIP#"/>,
                      <cfqueryparam cfsqltype="cf_sql_varchar" value="#TELEPHONENUMBER#"/>
					 );     
    </cfquery>
 </cfloop>	   
<!---END FETCH TO CIN21FAMILYBKGRND-------------------------------------------------------------------------------------->

                             
<!---Fetch to CIN21EDUCATION-------------------------------------------------------------------------------------->
<cfquery name="query_from_EGIN21EDUCATION" datasource="#session.global_dsn#">
  SELECT   *
	FROM EGIN21EDUCATION
   WHERE REFERENCECODE = '#listvaluehere#';
</cfquery>

<cfloop query="query_from_EGIN21EDUCATION">
	<cfquery name="insert_to_CIN21EDUCATION" datasource="#session.company_dsn#">
        INSERT INTO CIN21EDUCATION (    GUID,
										PERSONNELIDNO,
										SCHOOLNAME,    
										EDUCLEVEL,
										MAJORDEGREE,
										COURSECODE,
										SCHOOLCODE,
										DATEBEGIN,
										DATEFINISHED,
										GRADUATE,
										HONORSRECEIVED        
                                                )
                             VALUES (   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#sValue#" >,
									    <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#sApp#" >,
									    <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#SCHOOLNAME#" >,
									    <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#EDUCLEVEL#" >,
									    <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#MAJORDEGREE#" >,
									    <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#COURSECODE#" >,
									    <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#SCHOOLCODE#" >,
									    <cfqueryparam cfsqltype = "cf_sql_date"    value = "#DATEBEGIN#" >,
									    <cfqueryparam cfsqltype = "cf_sql_date"    value = "#DATEFINISHED#" >,
									    <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#GRADUATE#" >,
									    <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#HONORSRECEIVED#" >                     
									 );                
   </cfquery>
</cfloop>                
   <!---END FETCH TO CIN21EDUCATION-------------------------------------------------------------------------------------->

   <!---FETCH TO CIN21EMPEXTRA-------------------------------------------------------------------------------------->
<cfquery name="query_from_EGIN21EMPEXTRA" datasource="#session.global_dsn#">
  SELECT   *
	FROM EGIN21EMPEXTRA
   WHERE REFERENCECODE = '#listvaluehere#';
</cfquery>
 
      	<cfloop query="query_from_EGIN21EMPEXTRA">
	<cfquery name="insert_to_CIN21EMPEXTRA" datasource="#session.company_dsn#">
        INSERT INTO CIN21EMPEXTRA  (    GUID,
										PERSONNELIDNO,
                                        ORGANIZATION,
                                        PERIODCOVERED,
                                        HIGHESTPOSITION
                                   )
                                   
							 VALUES (   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#sValue#" >,
										<cfqueryparam cfsqltype = "cf_sql_varchar" value = "#sApp#" >,
									    <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#ORGANIZATION#" >,
									    <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#PERIODCOVERED#" >,
									    <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#HIGHESTPOSITION#" >
									);    
    </cfquery>
</cfloop>
<!---END FETCH TO CIN21EMPEXTRA-------------------------------------------------------------------------------------->

<!---FETCH TO CIN21EXAMPASS-------------------------------------------------------------------------------------->
<cfquery name="query_from_EGIN21EXAMPASS" datasource="#session.global_dsn#">
  SELECT   *
	FROM EGIN21EXAMPASS
   WHERE REFERENCECODE = '#listvaluehere#';
</cfquery>
   
   	<cfloop query="query_from_EGIN21EXAMPASS">
	<cfquery name="insert_to_CIN21EXAMPASS" datasource="#session.company_dsn#">
        INSERT INTO CIN21EXAMPASS (     GUID,
										PERSONNELIDNO,
										DATETAKENPASSED,
                                        PASSED,
                                        RATING,
                                        TYPEOFEXAM			
                                  )
							 VALUES (   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#sValue#" >,
										<cfqueryparam cfsqltype = "cf_sql_varchar" value = "#sApp#" >,
										<cfqueryparam cfsqltype = "cf_sql_date" value = "#DATETAKENPASSED#" >,
										<cfqueryparam cfsqltype = "cf_sql_varchar" value = "#PASSED#" >,
										<cfqueryparam cfsqltype = "cf_sql_varchar" value = "#RATING#" >,
										<cfqueryparam cfsqltype = "cf_sql_varchar" value = "#TYPEOFEXAM#" >
									);                
   </cfquery>
</cfloop>
<!---END FETCH TO CIN21EXAMPASS-------------------------------------------------------------------------------------->

<!--- BOARD EXAM RESULTS AND RATINGS CIN21ACHIEVEMENTS--->
<cfquery name="query_from_EGIN21ACHIEVEMENTS" datasource="#session.global_dsn#">
  SELECT   *
	FROM EGIN21ACHIEVEMENTS
   WHERE REFERENCECODE = '#listvaluehere#';
</cfquery>
<cfloop query="query_from_EGIN21ACHIEVEMENTS">
	<cfquery name="insert_to_CIN21ACHIEVEMENTS" datasource="#session.company_dsn#">
		INSERT INTO CIN21ACHIEVEMENTS ( GUID,
										PERSONNELIDNO,
										AWARDTITLE,
										DATEGIVEN,
										NATURECATEGORY		
									   )
							 VALUES  (  <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#sValue#" >,
										<cfqueryparam cfsqltype = "cf_sql_varchar" value = "#sApp#" >,
										<cfqueryparam cfsqltype = "cf_sql_varchar" value = "#AWARDTITLE#" >,
										<cfqueryparam cfsqltype = "cf_sql_varchar" value = "#DATEGIVEN#" >,
										<cfqueryparam cfsqltype = "cf_sql_varchar" value = "#NATURECATEGORY#" >
									 );                
	</cfquery>
</cfloop>					
<!--- END BOARD EXAM RESULTS AND RATINGS--->
<!---LICENSE AND CERTIFICATION OF PRESENT PROFESSION--->
<!---END LICENSE AND CERTIFICATION OF PRESENT PROFESSION--->

<!---BLOOD TYPE CIN21MEDHISTORY--->
<cfquery name="query_from_EGIN21MEDHISTORY" datasource="#session.global_dsn#">
  SELECT   *
	FROM EGIN21MEDHISTORY
   WHERE REFERENCECODE = '#listvaluehere#';
</cfquery>
<cfloop query="query_from_EGIN21MEDHISTORY">
	<cfquery name="insert_to_CIN21MEDHISTORY" datasource="#session.company_dsn#">
		INSERT INTO CIN21MEDHISTORY (   GUID,
										PERSONNELIDNO,
										BLOODTYPE		
											
									  )
							 VALUES  (  <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#sValue#" >,
										<cfqueryparam cfsqltype = "cf_sql_varchar" value = "#sApp#" >,
										<cfqueryparam cfsqltype = "cf_sql_varchar" value = "#BLOODTYPE#" >
									 );                
	</cfquery>
</cfloop>
<!---END BLOOD TYPE--->
 
<!---FETCH TO CIN21TRAINING-------------------------------------------------------------------------------------->
<cfquery name="query_from_EGIN21TRAINING" datasource="#session.global_dsn#">
  SELECT   *
	FROM EGIN21TRAINING
   WHERE REFERENCECODE = '#listvaluehere#';
</cfquery>
    
<cfloop query="query_from_EGIN21TRAINING">
	<cfquery name="insert_to_CIN21TRAINING" datasource="#session.company_dsn#">
         INSERT INTO CIN21TRAINING  (   GUID,
										PERSONNELIDNO,
										INCLUSIVEDATE,
										TOPIC,
										REMARKS
								    )
							VALUES (    <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#sValue#" >,
										<cfqueryparam cfsqltype = "cf_sql_varchar" value = "#sApp#" >,
										<cfqueryparam cfsqltype = "cf_sql_varchar" value = "#INCLUSIVEDATE#" >,
										<cfqueryparam cfsqltype = "cf_sql_varchar" value = "#TOPIC#" >,
										<cfqueryparam cfsqltype = "cf_sql_varchar" value = "#REMARKS#" >
									);                
     </cfquery>
</cfloop>		
<!---END FETCH TO CIN21TRAINING-------------------------------------------------------------------------------------->

<!---FETCH TO CIN21WORKHISTORY-------------------------------------------------------------------------------------->
   <cfquery name="query_from_EGIN21WORKHISTORY" datasource="#session.global_dsn#">
	  SELECT   *
		FROM EGIN21WORKHISTORY
	   WHERE REFERENCECODE = '#listvaluehere#';
   </cfquery>
   
    <cfloop query="query_from_EGIN21WORKHISTORY">
    	<cfquery name="insert_to_CIN21WORKHISTORY" datasource="#session.company_dsn#">
			INSERT INTO CIN21WORKHISTORY ( GUID,
										   PERSONNELIDNO,
                                           ENTITYCODE,
										   MAINDUTIES,
                                           DATEHIRED,
                                           SEPARATIONDATE,
                                           WORKSTARTINGSALARY,
                                           WORKENDINGSALARY,
                                           LASTPOSITIONHELD,
                                           SUPERIOR,
                                           REASONFORLEAVING 
									     )
							   VALUES    ( <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#sValue#" >,
										   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#sApp#" >,
										   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#ENTITYCODE#" >,
										   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#MAINDUTIES#" >,
										   <cfqueryparam cfsqltype = "cf_sql_date" value = "#DATEHIRED#" >,
										   <cfqueryparam cfsqltype = "cf_sql_date" value = "#SEPARATIONDATE#" >,
										   <cfqueryparam cfsqltype = "cf_sql_integer" value = "#WORKSTARTINGSALARY#" >,
										   <cfqueryparam cfsqltype = "cf_sql_integer" value = "#WORKENDINGSALARY#" >,
										   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#LASTPOSITIONHELD#" >,
										   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#SUPERIOR#" >,
										   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#REASONFORLEAVING#" >
										 );                
    </cfquery>
  </cfloop>				
<!---END FETCH TO CIN21WORKHISTORY-------------------------------------------------------------------------------------->

<!---Relatives friends working in Filinvet CIN21RELATIVE--->
<cfquery name="query_from_EGIN21RELATIVE" datasource="#session.global_dsn#">
  SELECT   *
	FROM EGIN21RELATIVE
   WHERE REFERENCECODE = '#listvaluehere#';
</cfquery>
<cfloop query="query_from_EGIN21RELATIVE">
     <cfquery name="insert_to_CIN21RELATIVE" datasource="#session.company_dsn#">
           INSERT INTO CIN21RELATIVE   (   GUID,
										   PERSONNELIDNO,
										   NAME,
										   COMPANY,
										   POSITION
										 )
							   VALUES    ( <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#sValue#" >,
										   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#sApp#" >,
										   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#NAME#" >,
										   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#COMPANY#" >,
										   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#POSITION#" >															 
										 );                
	 </cfquery> 
</cfloop>
<!---End Relatives friends working in Filinvet--->

<!--- Special Skills CIN21MISCINFO1--->
<cfquery name="query_from_EGIN21MISCINFO1" datasource="#session.global_dsn#">
  SELECT   *
	FROM EGIN21MISCINFO1
   WHERE REFERENCECODE = '#listvaluehere#';
</cfquery>

<cfloop query="query_from_EGIN21MISCINFO1">
     <cfquery name="insert_to_CIN21MISCINFO1" datasource="#session.company_dsn#">
		INSERT INTO CIN21MISCINFO1  (  GUID,
									   PERSONNELIDNO,
									   SPECIALTALENTS,
									   CLASSIFICATION,
									   RANKHELD
									 )
						   VALUES    ( <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#sValue#" >,
									   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#sApp#" >,
									   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#SPECIALTALENTS#" >,
									   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#CLASSIFICATION#" >,
									   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#RANKHELD#" >															 
									 );                
	</cfquery>        
</cfloop>
<!--- End Special Skills --->

<!---FETCH CIN21CHAREFERENCE--->
<cfquery name="query_from_EGIN21CHARREFERENCE" datasource="#session.global_dsn#">
  SELECT   *
	FROM EGIN21CHAREFERENCE
   WHERE REFERENCECODE = '#listvaluehere#';
</cfquery>
<cfloop query="query_from_EGIN21CHARREFERENCE" >
	<cfquery name="insert_to_CIN21CHAREFERENCE" datasource="#session.company_dsn#">
        INSERT INTO  CIN21CHAREFERENCE (   GUID,
										   PERSONNELIDNO,
										   NAME,
										   OCCUPATION,
										   COMPANY,
										   CELLULARPHONE
									 )
								 VALUES ( <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#sValue#" >,
										  <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#sApp#" >,
										  <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#NAME#" >,
										  <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#OCCUPATION#" >,
										  <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#COMPANY#" >,
										  <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#CELLULARPHONE#" >
										 );                	  
	</cfquery>   
</cfloop>
 <!---END FETCH CIN21CHAREFERENCE--->
    
 <!---Employment Violations CIN21EMPVIOL--->
<cfquery name="query_from_EGIN21EMPVIOL" datasource="#session.global_dsn#">
  SELECT   *
	FROM EGIN21EMPVIOL
   WHERE REFERENCECODE = '#listvaluehere#';
</cfquery>
<cfloop query="query_from_EGIN21EMPVIOL">
    <cfquery name="insert_to_CIN21EMPVIOL" datasource="#session.company_dsn#">
		INSERT INTO CIN21EMPVIOL    (  GUID,
									   PERSONNELIDNO,
									   CASENUMBER,
									   CASENAME,
									   CASESTATUS
									)
						   VALUES   (  <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#sValue#" >,
									   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#sApp#" >,
									   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#CASENUMBER#" >,
									   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#CASENAME#" >,
									   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#CASESTATUS#" >															 
									);                
	</cfquery>         
</cfloop>
 <!---End Employment Violations --->
 
 
 <!--- EGINEXAMRESULT --->
 <cfquery name="query_from_EGINEXAMRESULT" datasource="#session.global_dsn#">
  SELECT   *
	FROM EGINEXAMRESULT
   WHERE REFERENCECODE = '#listvaluehere#';
</cfquery>
<cfloop query="query_from_EGINEXAMRESULT">
    <cfquery name="insertToMRFStatusTable" datasource="#session.company_dsn#">
		INSERT INTO ECINEXAMRESULT (APPLICANTNUMBER,
								   PERSONNELIDNO,
								   REQUISITIONNO,
								   DOCNUMBER,
								   EXAMTYPE,
								   DATEOFAPPLICATION,
								   SOURCINGDATE,
								   PRESCREENEDDATE,
								   INVITESENDOUTDATE,
								   INVITECONFIRMATIONDATE,
								   EXAMSCHEDDATE,
								   ACTUALEXAMDATE,
								   STATUS,
								   COMMENTS,
								   APPROVED,
								   ATTACHEDFILE,
								   DATEACTIONWASDONE,
								   EFORMID,
								   PROCESSID,
								   RECDATECREATED,
								   DATELASTUPDATE,
								   ACTIONBY
								)
					   VALUES   (  <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#sApp#" >,
								   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#session.chapa#" >,
								   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#REQUISITIONNO#" >,
								   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#DOCNUMBER#" >,
								   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#EXAMTYPE#" >,
								   <cfqueryparam cfsqltype = "cf_sql_date" value = "#DATEOFAPPLICATION#" >,
								   <cfqueryparam cfsqltype = "cf_sql_date" value = "#SOURCINGDATE#" >,
								   <cfqueryparam cfsqltype = "cf_sql_date" value = "#PRESCREENEDDATE#" >,
								   <cfqueryparam cfsqltype = "cf_sql_date" value = "#INVITESENDOUTDATE#" >,
								   <cfqueryparam cfsqltype = "cf_sql_date" value = "#INVITECONFIRMATIONDATE#" >,
								   <cfqueryparam cfsqltype = "cf_sql_date" value = "#EXAMSCHEDDATE#" >,
								   <cfqueryparam cfsqltype = "cf_sql_date" value = "#ACTUALEXAMDATE#" >,
								   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#STATUS#" >,
								   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#COMMENTS#" >,
								   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#APPROVED#" >,
								   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#ATTACHEDFILE#" >,
								   <cfqueryparam cfsqltype = "cf_sql_date" value = "#DATEACTIONWASDONE#" >,
								   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#EFORMID#" >,
								   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#PROCESSID#" >,
								   <cfqueryparam cfsqltype = "cf_sql_timestamp" value = "#RECDATECREATED#" >,
								   <cfqueryparam cfsqltype = "cf_sql_timestamp" value = "#DATELASTUPDATE#" >,
								   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#ACTIONBY#" >
								);                
	</cfquery> 
	<cfset arrayAppend(imageArray, ATTACHEDFILE) >        
</cfloop>
 
  
<!--- EGINTERVIEWRESULT --->
 <cfquery name="query_from_EGINTERVIEWRESULT" datasource="#session.global_dsn#">
  SELECT   *
	FROM EGINTERVIEWRESULT
   WHERE REFERENCECODE = '#listvaluehere#';
</cfquery>
<cfloop query="query_from_EGINTERVIEWRESULT">
    <cfquery name="insertToMRFStatusTable" datasource="#session.company_dsn#">
		INSERT INTO ECINTERVIEWRESULT (APPLICANTNUMBER,
								   PERSONNELIDNO,
								   REQUISITIONNO,
								   DOCNUMBER,
								   APPROVED,
								   PROCESSID,
								   EFORMID,
								   ACTIONBY,
								   DATEACTIONWASDONE,
								   DATELASTUPDATE,
								   RECDATECREATED,
								   TYPEOFINTERVIEW,
								   INTERVIEWDATE,
								   INTERVIEWER,
								   STATUS,
								   COMMENTS,
								   FEEDBACKDATE,
								   ATTACHEDFILE
								   
								)
					   VALUES   (  <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#sApp#" >,
								   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#session.chapa#" >,
								   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#REQUISITIONNO#" >,
								   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#DOCNUMBER#" >,
								   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#APPROVED#" >,
								   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#PROCESSID#" >,
								   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#EFORMID#" >,
								   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#ACTIONBY#" >,
								   <cfqueryparam cfsqltype = "cf_sql_date" value = "#DATEACTIONWASDONE#" >,
								   <cfqueryparam cfsqltype = "cf_sql_timestamp" value = "#DATELASTUPDATE#" >,
								   <cfqueryparam cfsqltype = "cf_sql_date" value = "#RECDATECREATED#" >,
								   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#TYPEOFINTERVIEW#" >,
								   <cfqueryparam cfsqltype = "cf_sql_date" value = "#INTERVIEWDATE#" >,
								   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#INTERVIEWER#" >,
								   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#STATUS#" >,
								   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#COMMENTS#" >,
								   <cfqueryparam cfsqltype = "cf_sql_date" value = "#FEEDBACKDATE#" >,
								   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#ATTACHEDFILE#" >
								);                
	</cfquery>  
	<cfset arrayAppend(imageArray, ATTACHEDFILE) >       
</cfloop>

<!--- EGINTERVIEWRESULTFD --->
 <cfquery name="query_from_EGINTERVIEWRESULTFD" datasource="#session.global_dsn#">
  SELECT   *
	FROM EGINTERVIEWRESULTFD
   WHERE REFERENCECODE = '#listvaluehere#';
</cfquery>
<cfloop query="query_from_EGINTERVIEWRESULTFD">
    <cfquery name="insertToMRFStatusTable" datasource="#session.company_dsn#">
		INSERT INTO ECINTERVIEWRESULTFD (APPLICANTNUMBER,
								   PERSONNELIDNO,
								   REQUISITIONNO,
								   DOCNUMBER,
								   APPROVED,
								   PROCESSID,
								   EFORMID,
								   ACTIONBY,
								   DATEACTIONWASDONE,
								   DATELASTUPDATE,
								   RECDATECREATED,
								   STATUS,
								   COMMENTS,
								   ATTACHEDFILE,
								   TYPEOFINTERVIEW,
								   INTERVIEWDATE,
								   DATEACTUALINTERVIEW,
								   INTERVIEWER,
								   FEEDBACKDATE
								)
					   VALUES   (  <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#sApp#" >,
								   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#session.chapa#" >,
								   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#REQUISITIONNO#" >,
								   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#DOCNUMBER#" >,
								   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#APPROVED#" >,
								   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#PROCESSID#" >,
								   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#EFORMID#" >,
								   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#ACTIONBY#" >,
								   <cfqueryparam cfsqltype = "cf_sql_date" value = "#DATEACTIONWASDONE#" >,
								   <cfqueryparam cfsqltype = "cf_sql_timestamp" value = "#DATELASTUPDATE#" >,
								   <cfqueryparam cfsqltype = "cf_sql_timestamp" value = "#RECDATECREATED#" >,
								   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#STATUS#" >,
								   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#COMMENTS#" >,
								   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#ATTACHEDFILE#" >,
								   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#TYPEOFINTERVIEW#" >,
								   <cfqueryparam cfsqltype = "cf_sql_date" value = "#INTERVIEWDATE#" >,
								   <cfqueryparam cfsqltype = "cf_sql_date" value = "#DATEACTUALINTERVIEW#" >,
								   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#INTERVIEWER#" >,
								   <cfqueryparam cfsqltype = "cf_sql_date" value = "#FEEDBACKDATE#" >
								);                
	</cfquery>  
	<cfset arrayAppend(imageArray, ATTACHEDFILE) >       
</cfloop>


<!--- EGINTERVIEWRESULTSD --->
 <cfquery name="query_from_EGINTERVIEWRESULTSD" datasource="#session.global_dsn#">
  SELECT   *
	FROM EGINTERVIEWRESULTSD
   WHERE REFERENCECODE = '#listvaluehere#';
</cfquery>
<cfloop query="query_from_EGINTERVIEWRESULTSD">
    <cfquery name="insertToMRFStatusTable" datasource="#session.company_dsn#">
		INSERT INTO ECINTERVIEWRESULTSD (APPLICANTNUMBER,
								   PERSONNELIDNO,
								   REQUISITIONNO,
								   DOCNUMBER,
								   APPROVED,
								   PROCESSID,
								   EFORMID,
								   ACTIONBY,
								   DATEACTIONWASDONE,
								   DATELASTUPDATE,
								   RECDATECREATED,
								   STATUS,
								   COMMENTS,
								   ATTACHEDFILE,
								   DATEACTUALINTERVIEW,
								   TYPEOFINTERVIEW,
								   INTERVIEWDATE,
								   INTERVIEWER
								)
					   VALUES   (  <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#sApp#" >,
								   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#session.chapa#" >,
								   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#REQUISITIONNO#" >,
								   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#DOCNUMBER#" >,
								   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#APPROVED#" >,
								   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#PROCESSID#" >,
								   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#EFORMID#" >,
								   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#ACTIONBY#" >,
								   <cfqueryparam cfsqltype = "cf_sql_date" value = "#DATEACTIONWASDONE#" >,
								   <cfqueryparam cfsqltype = "cf_sql_timestamp" value = "#DATELASTUPDATE#" >,
								   <cfqueryparam cfsqltype = "cf_sql_timestamp" value = "#RECDATECREATED#" >,
								   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#STATUS#" >,
								   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#COMMENTS#" >,
								   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#ATTACHEDFILE#" >,
								   <cfqueryparam cfsqltype = "cf_sql_date" value = "#DATEACTUALINTERVIEW#" >,
								   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#TYPEOFINTERVIEW#" >,
								   <cfqueryparam cfsqltype = "cf_sql_date" value = "#INTERVIEWDATE#" >,
								   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#INTERVIEWER#" >
								);                
	</cfquery>  
	<cfset arrayAppend(imageArray, ATTACHEDFILE) >       
</cfloop>


<!--- EGINTERVIEWRESULTFINAL --->
 <cfquery name="query_from_EGINTERVIEWRESULTFINAL" datasource="#session.global_dsn#">
  SELECT   *
	FROM EGINTERVIEWRESULTFINAL
   WHERE REFERENCECODE = '#listvaluehere#';
</cfquery>
<cfloop query="query_from_EGINTERVIEWRESULTFINAL">
    <cfquery name="insertToMRFStatusTable" datasource="#session.company_dsn#">
		INSERT INTO ECINTERVIEWRESULTFINAL (APPLICANTNUMBER,
								   PERSONNELIDNO,
								   REQUISITIONNO,
								   DOCNUMBER,
								   APPROVED,
								   PROCESSID,
								   EFORMID,
								   ACTIONBY,
								   DATEACTIONWASDONE,
								   DATELASTUPDATE,
								   RECDATECREATED,
								   STATUS,
								   COMMENTS,
								   ATTACHEDFILE,
								   DATEACTUALINTERVIEW,
								   TYPEOFINTERVIEW,
								   INTERVIEWDATE,
								   INTERVIEWER
								)
					   VALUES   (  <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#sApp#" >,
								   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#session.chapa#" >,
								   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#REQUISITIONNO#" >,
								   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#DOCNUMBER#" >,
								   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#APPROVED#" >,
								   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#PROCESSID#" >,
								   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#EFORMID#" >,
								   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#ACTIONBY#" >,
								   <cfqueryparam cfsqltype = "cf_sql_date" value = "#DATEACTIONWASDONE#" >,
								   <cfqueryparam cfsqltype = "cf_sql_timestamp" value = "#DATELASTUPDATE#" >,
								   <cfqueryparam cfsqltype = "cf_sql_timestamp" value = "#RECDATECREATED#" >,
								   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#STATUS#" >,
								   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#COMMENTS#" >,
								   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#ATTACHEDFILE#" >,
								   <cfqueryparam cfsqltype = "cf_sql_date" value = "#DATEACTUALINTERVIEW#" >,
								   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#TYPEOFINTERVIEW#" >,
								   <cfqueryparam cfsqltype = "cf_sql_date" value = "#INTERVIEWDATE#" >,
								   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#INTERVIEWER#" >
								);                
	</cfquery>
	<cfset arrayAppend(imageArray, ATTACHEDFILE) >         
</cfloop>


<!--- EGINJOBOFFER --->
 <cfquery name="query_from_EGINJOBOFFER" datasource="#session.global_dsn#">
  SELECT   *
	FROM EGINJOBOFFER
   WHERE REFERENCECODE = '#listvaluehere#';
</cfquery>
<cfloop query="query_from_EGINJOBOFFER">
    <cfquery name="insertToMRFStatusTable" datasource="#session.company_dsn#">
		INSERT INTO ECINJOBOFFER  (APPLICANTNUMBER,
								   PERSONNELIDNO,
								   REQUISITIONNO,
								   DOCNUMBER,
								   APPROVED,
								   PROCESSID,
								   EFORMID,
								   ACTIONBY,
								   DATEACTIONWASDONE,
								   DATELASTUPDATE,
								   RECDATECREATED,
								   STATUS,
								   COMMENTS,
								   ATTACHEDFILE,
								   DATEINVITE,
								   DATECONFIRMATION,
								   SCHEDULEDJOBOFFER,
								   DATEPRESENTED,
								   DATEDECISION
								)
					   VALUES   (  <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#sApp#" >,
								   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#session.chapa#" >,
								   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#REQUISITIONNO#" >,
								   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#DOCNUMBER#" >,
								   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#APPROVED#" >,
								   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#PROCESSID#" >,
								   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#EFORMID#" >,
								   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#ACTIONBY#" >,
								   <cfqueryparam cfsqltype = "cf_sql_date" value = "#DATEACTIONWASDONE#" >,
								   <cfqueryparam cfsqltype = "cf_sql_timestamp" value = "#DATELASTUPDATE#" >,
								   <cfqueryparam cfsqltype = "cf_sql_timestamp" value = "#RECDATECREATED#" >,
								   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#STATUS#" >,
								   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#COMMENTS#" >,
								   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#ATTACHEDFILE#" >,
								   <cfqueryparam cfsqltype = "cf_sql_date" value = "#DATEINVITE#" >,
								   <cfqueryparam cfsqltype = "cf_sql_date" value = "#DATECONFIRMATION#" >,
								   <cfqueryparam cfsqltype = "cf_sql_date" value = "#SCHEDULEDJOBOFFER#" >,
								   <cfqueryparam cfsqltype = "cf_sql_date" value = "#DATEPRESENTED#" >,
								   <cfqueryparam cfsqltype = "cf_sql_date" value = "#DATEDECISION#" > 
								);                
	</cfquery>
	<cfset arrayAppend(imageArray, ATTACHEDFILE) >         
</cfloop>


<!--- GINPREEMPREQCHKLIST --->
 <cfquery name="query_from_GINPREEMPREQCHKLIST" datasource="#session.global_dsn#">
  SELECT   *
	FROM GINPREEMPREQCHKLIST
   WHERE REFERENCECODE = '#listvaluehere#';
</cfquery>
<cfloop query="query_from_GINPREEMPREQCHKLIST">
    <cfquery name="insertToMRFStatusTable" datasource="#session.company_dsn#">
		INSERT INTO CINPREEMPREQCHKLIST  (APPLICANTNUMBER,
								   PERSONNELIDNO,
								   REQUISITIONNO,
								   DOCNUMBER,
								   APPROVED,
								   PROCESSID,
								   EFORMID,
								   ACTIONBY,
								   DATEACTIONWASDONE,
								   DATELASTUPDATE,
								   RECDATECREATED,
								   STATUS,
								   COMMENTS,
								   ATTACHEDFILE,
								   
								   APPREQISSUBMIT,
								   APPREQREMARKS,
								   BACKCHECKISSUBMIT,
								   BACKCHECKREMARKS,
								   BIRFORM1905ISSUBMIT,
								   BIRFORM1905REMARKS,
								   BIR2316PRVEMPSUBMIT,
								   BIR2316PRVEMPREMARKS,
								   BIRTHCERTSUBMIT,
								   BIRTHCERTREMARKS,
								   BIRTHCERTOFDEPSUBMIT,
								   BIRTHCERTOFDEPREMARK,
								   BIRTINIDISSUBMIT,
								   BIRTINIDREMARKS,
								   BOARDEXAMRESSUBMIT,
								   BOARDEXAMRESREMARKS,
								   CERTEMPPRVEMPSUBMIT,
								   CERTEMPPRVEMPREMARK,
								   CLRPRVEMPSUBMIT,
								   CLRPRVEMPREMARK,
								   COLOREDPHOTOWITHWHITEBG1X1ISSUBMIT,
								   COLOREDPHOTOWITHWHITEBG1X1REMARKS,
								   COLOREDPHOTOWITHWHITEBG2X2ISSUBMIT,
								   COLOREDPHOTOWITHWHITEBG2X2REMARKS,
								   COMMUNITYTAXCERTIFICATEISSUBMIT,
								   COMMUNITYTAXCERTIFICATEREMARKS,
								   CONTRACTISSUBMIT,
								   CONTRACTREMARKS,
								   DATEDISCUSSED,
								   DATEOFSUBMISSION,
								   DATERECEIVED,
								   DIPLOMAISSUBMIT,
								   DIPLOMAREMARKS,
								   DRUGTESTRESULTISSUBMIT,
								   DRUGTESTRESULTREMARKS,
								   HEALTHPERMITISSUBMIT,
								   HEALTHPERMITREMARKS,
								   MARRIAGECONTRACTISSUBMIT,
								   MARRIAGECONTRACTREMARKS,
								   MAYORSPERMITISSUBMIT,
								   MAYORSPERMITREMARKS,
								   MEDICALRESULTXRAYISSUBMIT,
								   MEDICALRESULTXRAYREMARKS,
								   MUNICIPALITYPERMITSISSUBMIT,
								   MUNICIPALITYPERMITSREMARKS,
								   NBICLEARANCEISSUBMIT,
								   NBICLEARANCEREMARKS,
								   OTHERSREMARKS,
								   PAGIBIGIDNUMBERISSUBMIT,
								   PAGIBIGIDNUMBERREMARKS,
								   PHILHEALTHIDISSUBMIT,
								   PHILHEALTHIDREMARKS,
								   PISIDFORMISSUBMIT,
								   PISIDFORMREMARKS,
								   POLICECLEARANCEISSUBMIT,
								   POLICECLEARANCEREMARKS,
								   PROFESSIONALLICENSUREIDISSUBMIT,
								   PROFESSIONALLICENSUREIDREMARKS,
								   RECEIVEDBY,
								   RECEIVINGCOPYOFMANUALISSUBMIT,
								   RECEIVINGCOPYOFMANUALREMARKS,
								   RECOMMENDLETTERNOTRELATIVEISSUBMIT,
								   RECOMMENDLETTERNOTRELATIVEREMARKS,
								   SKETCHOFRESIDENCELOCATIONISSUBMIT,
								   SKETCHOFRESIDENCELOCATIONREMARKS,
								   SSSIDORE1FORMISSUBMIT,
								   SSSIDORE1FORMREMARKS,
								   TRANSCRIPTOFRECORDSISSUBMIT,
								   TRANSCRIPTOFRECORDSREMARKS,
								   VALIDIDISSUBMIT,
								   VALIDIDREMARKS,
								   WORKSCHEDULEISSUBMIT,
								   WORKSCHEDULEREMARKS,
								   RECCREATEDBY,
								   USERID,
								   GUID
								)
					   VALUES   (  <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#sApp#" >,
								   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#session.chapa#" >,
								   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#REQUISITIONNO#" >,
								   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#DOCNUMBER#" >,
								   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#APPROVED#" >,
								   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#PROCESSID#" >,
								   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#EFORMID#" >,
								   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#ACTIONBY#" >,
								   <cfqueryparam cfsqltype = "cf_sql_date" value = "#DATEACTIONWASDONE#" >,
								   <cfqueryparam cfsqltype = "cf_sql_timestamp" value = "#DATELASTUPDATE#" >,
								   <cfqueryparam cfsqltype = "cf_sql_timestamp" value = "#RECDATECREATED#" >,
								   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#STATUS#" >,
								   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#COMMENTS#" >,
								   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#ATTACHEDFILE#" >,
								   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#APPREQISSUBMIT#" >,
								   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#APPREQREMARKS#" >,
								   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#BACKCHECKISSUBMIT#" >,
								   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#BACKCHECKREMARKS#" >,
								   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#BIRFORM1905ISSUBMIT#" >,
								   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#BIRFORM1905REMARKS#" >,
								   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#BIR2316PRVEMPSUBMIT#" >,
								   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#BIR2316PRVEMPREMARKS#" >,
								   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#BIRTHCERTSUBMIT#" >,
								   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#BIRTHCERTREMARKS#" >,
								   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#BIRTHCERTOFDEPSUBMIT#" >,
								   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#BIRTHCERTOFDEPREMARK#" >,
								   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#BIRTINIDISSUBMIT#" >,
								   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#BIRTINIDREMARKS#" >,
								   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#BOARDEXAMRESSUBMIT#" >,
								   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#BOARDEXAMRESREMARKS#" >,
								   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#CERTEMPPRVEMPSUBMIT#" >,
								   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#CERTEMPPRVEMPREMARK#" >,
								   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#CLRPRVEMPSUBMIT#" >,
								   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#CLRPRVEMPREMARK#" >,
								   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#COLOREDPHOTOWITHWHITEBG1X1ISSUBMIT#" >,
								   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#COLOREDPHOTOWITHWHITEBG1X1REMARKS#" >,
								   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#COLOREDPHOTOWITHWHITEBG2X2ISSUBMIT#" >,
								   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#COLOREDPHOTOWITHWHITEBG2X2REMARKS#" >,
								   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#COMMUNITYTAXCERTIFICATEISSUBMIT#" >,
								   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#COMMUNITYTAXCERTIFICATEREMARKS#" >,
								   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#CONTRACTISSUBMIT#" >,
								   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#CONTRACTREMARKS#" >,
								   <cfqueryparam cfsqltype = "cf_sql_date" value = "#DATEDISCUSSED#" >,
								   <cfqueryparam cfsqltype = "cf_sql_date" value = "#DATEOFSUBMISSION#" >,
								   <cfqueryparam cfsqltype = "cf_sql_date" value = "#DATERECEIVED#" >,
								   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#DIPLOMAISSUBMIT#" >,
								   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#DIPLOMAREMARKS#" >,
								   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#DRUGTESTRESULTISSUBMIT#" >,
								   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#DRUGTESTRESULTREMARKS#" >,
								   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#HEALTHPERMITISSUBMIT#" >,
								   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#HEALTHPERMITREMARKS#" >,
								   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#MARRIAGECONTRACTISSUBMIT#" >,
								   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#MARRIAGECONTRACTREMARKS#" >,
								   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#MAYORSPERMITISSUBMIT#" >,
								   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#MAYORSPERMITREMARKS#" >,
								   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#MEDICALRESULTXRAYISSUBMIT#" >,
								   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#MEDICALRESULTXRAYREMARKS#" >,
								   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#MUNICIPALITYPERMITSISSUBMIT#" >,
								   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#MUNICIPALITYPERMITSREMARKS#" >,
								   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#NBICLEARANCEISSUBMIT#" >,
								   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#NBICLEARANCEREMARKS#" >,
								   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#OTHERSREMARKS#" >,
								   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#PAGIBIGIDNUMBERISSUBMIT#" >,
								   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#PAGIBIGIDNUMBERREMARKS#" >,
								   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#PHILHEALTHIDISSUBMIT#" >,
								   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#PHILHEALTHIDREMARKS#" >,
								   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#PISIDFORMISSUBMIT#" >,
								   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#PISIDFORMREMARKS#" >,
								   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#POLICECLEARANCEISSUBMIT#" >,
								   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#POLICECLEARANCEREMARKS#" >,
								   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#PROFESSIONALLICENSUREIDISSUBMIT#" >,
								   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#PROFESSIONALLICENSUREIDREMARKS#" >,
								   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#RECEIVEDBY#" >,
								   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#RECEIVINGCOPYOFMANUALISSUBMIT#" >,
								   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#RECEIVINGCOPYOFMANUALREMARKS#" >,
								   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#RECOMMENDLETTERNOTRELATIVEISSUBMIT#" >,
								   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#RECOMMENDLETTERNOTRELATIVEREMARKS#" >,
								   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#SKETCHOFRESIDENCELOCATIONISSUBMIT#" >,
								   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#SKETCHOFRESIDENCELOCATIONREMARKS#" >,
								   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#SSSIDORE1FORMISSUBMIT#" >,
								   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#SSSIDORE1FORMREMARKS#" >,
								   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#TRANSCRIPTOFRECORDSISSUBMIT#" >,
								   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#TRANSCRIPTOFRECORDSREMARKS#" >,
								   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#VALIDIDISSUBMIT#" >,
								   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#VALIDIDREMARKS#" >,
								   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#WORKSCHEDULEISSUBMIT#" >,
								   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#WORKSCHEDULEREMARKS#" >,
								   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#RECCREATEDBY#" >,
								   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#USERID#" >,
								   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#GUID#" >
								);                
	</cfquery>
	<cfset arrayAppend(imageArray, ATTACHEDFILE) >        
</cfloop>


<!--- EGINCONTRACT --->
 <cfquery name="query_from_EGINCONTRACT" datasource="#session.global_dsn#">
  SELECT   *
	FROM EGINCONTRACT
   WHERE REFERENCECODE = '#listvaluehere#';
</cfquery>
<cfloop query="query_from_EGINCONTRACT">
    <cfquery name="insertToMRFStatusTable" datasource="#session.company_dsn#">
		INSERT INTO ECINCONTRACT  (APPLICANTNUMBER,
								   PERSONNELIDNO,
								   REQUISITIONNO,
								   DOCNUMBER,
								   APPROVED,
								   PROCESSID,
								   EFORMID,
								   ACTIONBY,
								   DATEACTIONWASDONE,
								   DATELASTUPDATE,
								   RECDATECREATED,
								   STATUS,
								   COMMENTS,
								   ATTACHEDFILE,
								   DATEACCOMPLISH,
								   DATESIGNEDBYAPP
								)
					   VALUES   (  <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#sApp#" >,
								   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#session.chapa#" >,
								   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#REQUISITIONNO#" >,
								   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#DOCNUMBER#" >,
								   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#APPROVED#" >,
								   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#PROCESSID#" >,
								   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#EFORMID#" >,
								   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#ACTIONBY#" >,
								   <cfqueryparam cfsqltype = "cf_sql_date" value = "#DATEACTIONWASDONE#" >,
								   <cfqueryparam cfsqltype = "cf_sql_timestamp" value = "#DATELASTUPDATE#" >,
								   <cfqueryparam cfsqltype = "cf_sql_timestamp" value = "#RECDATECREATED#" >,
								   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#STATUS#" >,
								   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#COMMENTS#" >,
								   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#ATTACHEDFILE#" >,
								   <cfqueryparam cfsqltype = "cf_sql_date" value = "#DATEACCOMPLISH#" >,
								   <cfqueryparam cfsqltype = "cf_sql_date" value = "#DATESIGNEDBYAPP#" >
								);                
	</cfquery> 
	<cfset arrayAppend(imageArray, ATTACHEDFILE) >        
</cfloop>


<!--- EGINONBOARDCHECKLIST --->
 <cfquery name="query_from_EGINONBOARDCHECKLIST" datasource="#session.global_dsn#">
  SELECT   *
	FROM EGINONBOARDCHECKLIST
   WHERE REFERENCECODE = '#listvaluehere#';
</cfquery>
<cfloop query="query_from_EGINONBOARDCHECKLIST">
    <cfquery name="insertToMRFStatusTable" datasource="#session.company_dsn#">
		INSERT INTO ECINONBOARDCHECKLIST  (APPLICANTNUMBER,
								   PERSONNELIDNO,
								   REQUISITIONNO,
								   DOCNUMBER,
								   APPROVED,
								   PROCESSID,
								   EFORMID,
								   ACTIONBY,
								   DATEACTIONWASDONE,
								   DATELASTUPDATE,
								   RECDATECREATED,
								   STATUS,
								   COMMENTS,
								   ATTACHEDFILE,
								   DATENEO,
								   DATEONBOARD,
								   RECCREATEDBY
								)
					   VALUES   (  <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#sApp#" >,
								   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#session.chapa#" >,
								   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#REQUISITIONNO#" >,
								   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#DOCNUMBER#" >,
								   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#APPROVED#" >,
								   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#PROCESSID#" >,
								   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#EFORMID#" >,
								   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#ACTIONBY#" >,
								   <cfqueryparam cfsqltype = "cf_sql_date" value = "#DATEACTIONWASDONE#" >,
								   <cfqueryparam cfsqltype = "cf_sql_timestamp" value = "#DATELASTUPDATE#" >,
								   <cfqueryparam cfsqltype = "cf_sql_timestamp" value = "#RECDATECREATED#" >,
								   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#STATUS#" >,
								   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#COMMENTS#" >,
								   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#ATTACHEDFILE#" >,
								   <cfqueryparam cfsqltype = "cf_sql_date" value = "#DATENEO#" >,
								   <cfqueryparam cfsqltype = "cf_sql_date" value = "#DATEONBOARD#" >,
								   <cfqueryparam cfsqltype = "cf_sql_varchar" value = "#RECCREATEDBY#" > 
								);                
	</cfquery>
	<cfset arrayAppend(imageArray, ATTACHEDFILE) >         
</cfloop>



    <cftry>
	<cfquery name="removeGlobalData" datasource="#session.global_dsn#">
        DELETE FROM EGMFAP WHERE REFERENCECODE = '#listvaluehere#';
    </cfquery>
    <cfquery name="removeGlobalData" datasource="#session.global_dsn#">
        DELETE FROM EGIN21EDUCATION WHERE REFERENCECODE = '#listvaluehere#';
    </cfquery>
    <cfquery name="removeGlobalData" datasource="#session.global_dsn#">
        DELETE FROM EGIN21EMPEXTRA WHERE REFERENCECODE = '#listvaluehere#';     
    </cfquery>
    <cfquery name="removeGlobalData" datasource="#session.global_dsn#">
        DELETE FROM EGIN21EXAMPASS WHERE REFERENCECODE = '#listvaluehere#';  
    </cfquery>
    <cfquery name="removeGlobalData" datasource="#session.global_dsn#">
        DELETE FROM EGIN21FAMILYBKGRND WHERE REFERENCECODE = '#listvaluehere#';  
    </cfquery>
    <cfquery name="removeGlobalData" datasource="#session.global_dsn#">
        DELETE FROM EGIN21PERSONALINFO WHERE REFERENCECODE = '#listvaluehere#';
    </cfquery>
    <cfquery name="removeGlobalData" datasource="#session.global_dsn#">
          DELETE FROM EGIN21POSITNAPLD WHERE REFERENCECODE = '#listvaluehere#';
    </cfquery>
    <cfquery name="removeGlobalData" datasource="#session.global_dsn#">
         DELETE FROM EGIN21TRAINING WHERE REFERENCECODE = '#listvaluehere#';
    </cfquery>
    <cfquery name="removeGlobalData" datasource="#session.global_dsn#">
        DELETE FROM EGIN21WORKHISTORY WHERE REFERENCECODE = '#listvaluehere#';  
    </cfquery> 
    <cfquery name="removeGlobalData" datasource="#session.global_dsn#">
         DELETE FROM EGIN21CHAREFERENCE WHERE REFERENCECODE = '#listvaluehere#'; 
    </cfquery> 
    <cfquery name="removeGlobalData" datasource="#session.global_dsn#">
         DELETE FROM EGIN21ACHIEVEMENTS WHERE REFERENCECODE = '#listvaluehere#'; 
    </cfquery>
    <cfquery name="removeGlobalData" datasource="#session.global_dsn#">
        DELETE FROM EGIN21MEDHISTORY WHERE REFERENCECODE = '#listvaluehere#';  
    </cfquery>
    <cfquery name="removeGlobalData" datasource="#session.global_dsn#">
        DELETE FROM EGIN21RELATIVE WHERE REFERENCECODE = '#listvaluehere#';   
    </cfquery>
    <cfquery name="removeGlobalData" datasource="#session.global_dsn#">
        DELETE FROM EGIN21MISCINFO1 WHERE REFERENCECODE = '#listvaluehere#';   
    </cfquery>
    <cfquery name="removeGlobalData" datasource="#session.global_dsn#">
        DELETE FROM EGIN21EMPVIOL WHERE REFERENCECODE = '#listvaluehere#';  
    </cfquery>
    
    <cfquery name="removeGlobalData" datasource="#session.global_dsn#">
        DELETE FROM EGINEXAMRESULT WHERE REFERENCECODE = '#listvaluehere#';  
    </cfquery>
    <cfquery name="removeGlobalData" datasource="#session.global_dsn#">
        DELETE FROM EGINTERVIEWRESULT WHERE REFERENCECODE = '#listvaluehere#';  
    </cfquery>
    <cfquery name="removeGlobalData" datasource="#session.global_dsn#">
        DELETE FROM EGINTERVIEWRESULTFD WHERE REFERENCECODE = '#listvaluehere#';  
    </cfquery>
    <cfquery name="removeGlobalData" datasource="#session.global_dsn#">
        DELETE FROM EGINTERVIEWRESULTSD WHERE REFERENCECODE = '#listvaluehere#';  
    </cfquery>
    <cfquery name="removeGlobalData" datasource="#session.global_dsn#">
        DELETE FROM EGINTERVIEWRESULTFINAL WHERE REFERENCECODE = '#listvaluehere#';  
    </cfquery>
    <cfquery name="removeGlobalData" datasource="#session.global_dsn#">
        DELETE FROM EGINJOBOFFER WHERE REFERENCECODE = '#listvaluehere#';  
    </cfquery>
    <cfquery name="removeGlobalData" datasource="#session.global_dsn#">
        DELETE FROM GINPREEMPREQCHKLIST WHERE REFERENCECODE = '#listvaluehere#';  
    </cfquery>
    <cfquery name="removeGlobalData" datasource="#session.global_dsn#">
        DELETE FROM EGINCONTRACT WHERE REFERENCECODE = '#listvaluehere#';  
    </cfquery>
    <cfquery name="removeGlobalData" datasource="#session.global_dsn#">
        DELETE FROM EGINONBOARDCHECKLIST WHERE REFERENCECODE = '#listvaluehere#';  
    </cfquery>
    <cfcatch type="any">
    </cfcatch>
    </cftry>  
    
    <cfloop array="#imageArray#" index="fileInd">
    	<cftry>
    		<cffile action="move" source="#destDir##fileInd#" destination="#sourceDir#" >
    	<cfcatch type="any">
    	</cfcatch>
    	</cftry> 
    </cfloop>
    	
    <cfif ucase(SEQREFERENCE) NEQ "NOREVERT" >
	<cftry>
		
		<cfquery name="getMaxApplHoldTime" datasource="#session.global_dsn#" maxrows="1">  
			SELECT CONFIGVALUE
			  FROM EGRGRECRUITMENTCONFIG
			 WHERE NAME = 'MAXAPPLHOLDTIME'
			
		</cfquery>
		<cfif getMaxApplHoldTime.recordcount GT 0 >
			<cfset confvalue = getMaxApplHoldTime.CONFIGVALUE >
		<cfelse>
			<cfset confvalue = 50 >
		</cfif>
		<cfset startingDate = dateformat(dateadd('d',confvalue,now()), 'MM/DD/YYYY') >
		<cfset endingDate   = dateformat(dateadd('d',5,startingDate), 'MM/DD/YYYY') >
		<cfschedule 
		    action = "update"
		    task = "#session.company_dsn##sApp#"
			group="RECRUITMENT"
		    endDate = "#endingDate#"
		    endTime = "12:05 AM"  
		    requestTimeOut = "420"
		    interval="daily"
		    startDate = "#startingDate#"
		    startTime = "10:00 PM"
		    url = "#session.domain#myapps/recruitment/scheduledtask/revertorpreserve.cfm?applicantnumber=#sApp#&guid=#sValue#&companydsn=#session.company_dsn#&companycode=#session.companycode#&globaldsn=#session.global_dsn#"
		    operation="HTTPRequest" 
		>
		<cfcatch>
		</cfcatch>
	</cftry>
	<cftry>
    	<cfschedule 
		    action = "delete" 
		    task   = "#listvaluehere#"
			group  ="RECRUITMENT"> 
			<cfcatch>
			</cfcatch>
	</cftry>
  </cfif>
    	
    	 
   <cfcatch>
 		<cfoutput>#cfcatch.Detail#</cfoutput>
           <cfset messageback = cfcatch.Detail & ' Message: ' & cfcatch.Message />

			<cfquery name="rollback_gmfpeople" datasource="#session.global_dsn#">
                   DELETE FROM GMFPEOPLE WHERE GUID = '#sValue#';
            </cfquery>
            
            <cfquery name="rollback_cmfap" datasource="#session.company_dsn#">
                   DELETE FROM CMFAP WHERE GUID = '#sValue#';
            </cfquery>
            
            <cfquery name="rollback_education" datasource="#session.company_dsn#">
                   DELETE FROM CIN21EDUCATION WHERE GUID = '#sValue#';
            </cfquery>
            
            <cfquery name="rollback_empextra" datasource="#session.company_dsn#">
                   DELETE FROM CIN21EMPEXTRA WHERE GUID = '#sValue#';
            </cfquery>
            
            <cfquery name="rollback_exampass" datasource="#session.company_dsn#">
                   DELETE FROM CIN21EXAMPASS WHERE GUID = '#sValue#';
            </cfquery>
            
            <cfquery name="rollback_familybackground" datasource="#session.company_dsn#">
                   DELETE FROM CIN21FAMILYBKGRND WHERE GUID = '#sValue#';
            </cfquery>
            
            <cfquery name="rollback_personalinfo" datasource="#session.company_dsn#">
                   DELETE FROM CIN21PERSONALINFO WHERE GUID = '#sValue#';
            </cfquery>
            
            <cfquery name="rollback_positionapplied" datasource="#session.company_dsn#">
                   DELETE FROM CIN21POSITNAPLD WHERE GUID = '#sValue#';
            </cfquery>
            
            <cfquery name="rollback_training" datasource="#session.company_dsn#">
                   DELETE FROM CIN21TRAINING WHERE GUID = '#sValue#';
            </cfquery>
            
            <cfquery name="rollback_work_history" datasource="#session.company_dsn#">
                   DELETE FROM CIN21WORKHISTORY WHERE GUID = '#sValue#';
            </cfquery> 
            
            <cfquery name="rollback_work_chareference" datasource="#session.company_dsn#">
                   DELETE FROM CIN21CHAREFERENCE WHERE GUID = '#sValue#';           
            </cfquery> 
            
            <cfquery name="rollback_CIN21ACHIEVEMENTS" datasource="#session.company_dsn#">
                   DELETE FROM CIN21ACHIEVEMENTS WHERE GUID = '#sValue#';
			</cfquery>
            
            <cfquery name="rollback_CIN21MEDHISTORY" datasource="#session.company_dsn#">
                   DELETE FROM CIN21MEDHISTORY WHERE GUID = '#sValue#';
            </cfquery>
            
            <cfquery name="rollback_CIN21RELATIVE" datasource="#session.company_dsn#">
                   DELETE FROM CIN21RELATIVE WHERE GUID = '#sValue#';
            </cfquery>
            
            <cfquery name="rollback_CIN21RELATIVE" datasource="#session.company_dsn#">
                   DELETE FROM CIN21MISCINFO1 WHERE GUID = '#sValue#';
            </cfquery>
            
            <cfquery name="rollback_CIN21EMPVIOL" datasource="#session.company_dsn#">
                   DELETE FROM CIN21EMPVIOL WHERE GUID = '#sValue#';
            </cfquery>
            
            
            <cfquery name="rollback_MRFstatus" datasource="#session.company_dsn#">
                   DELETE FROM ECINEXAMRESULT WHERE APPLICANTNUMBER = '#sApp#';
            </cfquery>
            <cfquery name="rollback_MRFstatus" datasource="#session.company_dsn#">
                   DELETE FROM ECINTERVIEWRESULT WHERE APPLICANTNUMBER = '#sApp#';
            </cfquery>
            <cfquery name="rollback_MRFstatus" datasource="#session.company_dsn#">
                   DELETE FROM ECINTERVIEWRESULTFD WHERE APPLICANTNUMBER = '#sApp#';
            </cfquery>
            <cfquery name="rollback_MRFstatus" datasource="#session.company_dsn#">
                   DELETE FROM ECINTERVIEWRESULTSD WHERE APPLICANTNUMBER = '#sApp#';
            </cfquery>
            <cfquery name="rollback_MRFstatus" datasource="#session.company_dsn#">
                   DELETE FROM ECINTERVIEWRESULTFINAL WHERE APPLICANTNUMBER = '#sApp#';
            </cfquery>
            <cfquery name="rollback_MRFstatus" datasource="#session.company_dsn#">
                   DELETE FROM ECINJOBOFFER WHERE APPLICANTNUMBER = '#sApp#';
            </cfquery>
            <cfquery name="rollback_MRFstatus" datasource="#session.company_dsn#">
                   DELETE FROM CINPREEMPREQCHKLIST WHERE APPLICANTNUMBER = '#sApp#';
            </cfquery>
            <cfquery name="rollback_MRFstatus" datasource="#session.company_dsn#">
                   DELETE FROM ECINCONTRACT WHERE APPLICANTNUMBER = '#sApp#';
            </cfquery>
            <cfquery name="rollback_MRFstatus" datasource="#session.company_dsn#">
                   DELETE FROM ECINONBOARDCHECKLIST WHERE APPLICANTNUMBER = '#sApp#';
            </cfquery>
            
            <cfloop array="#imageArray#" index="fileInd">
            	<cftry>
            		<cffile action="move" source="#sourceDir##fileInd#" destination="#destDir#" > 
            	<cfcatch type="any">
            	</cfcatch>
            	</cftry>
		    </cfloop>
            
            <!---END ROLLBACK here--->
            <cfcontinue>
	   </cfcatch>
</cftry> 

 <cfsetting  
    enableCFoutputOnly = "yes"
    showDebugOutput    = "no" >
	
</cfloop>

<cfreturn #messageback# >

</cffunction>

<cffunction name="createGUID" access="private" output="false" returntype="void">
	<cfset sValue = right(listvaluehere,20) >

	<!---<CFMODULE TEMPLATE="../../../common/autogenfield.cfm"              
            SEEDKEY="GI"    
            CODELENGTH="20"
            COLUMNNAME="GUID"    
            TABLENAME_FK="GMFPEOPLE"
            datasource="#session.global_dsn#"
            WITHDATE="Y">  
            <CFSET sValue=AUTOGENVALUE>--->
            
     
</cffunction>

<cffunction name="createApplicantID" access="private" output="false" returntype="void">
	<!---<CFMODULE TEMPLATE="../../../common/autogenfield.cfm"                
                        SEEDKEY="AP"    
                        CODELENGTH="20"
                        COLUMNNAME="APPLICANTNUMBER"    
                        TABLENAME_FK="CMFAP"
                        datasource="#session.company_dsn#"
                        WITHDATE="Y">  
                        <CFSET sApp=AUTOGENVALUE>--->
    <CFSET sApp="APP#right(createuuid(),15)#">
</cffunction>

</cfcomponent>
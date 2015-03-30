<cfcomponent hint="This component is jobposting. Created MRF (Manpower Request Form) are POSTEDBYIBOSE here."
			 output="no"
             displayname="Job Posting"
             >

   <cffunction name="postGlobal"
   			   access="remote"
   			   description="Post MRF to Global"
               returntype="string"
               hint="return: MRF POSTEDBYIBOSE if success, error string when failure occur."
               >
               <cfargument name="requisitionnoval" required="yes" type="string">

               <cfquery name="updatePostedY" datasource="#session.company_dsn#">

                    UPDATE CRGPERSONELREQUEST
                       SET POSTEDBYIBOSE = 'Y',
                           POSTEDTO = 'Global',
                           DATEACTIONWASDONE = '#dateformat(now(), 'YYYY-MM-DD')#'
                     WHERE REQUISITIONNO = '#requisitionnoval#';

               </cfquery>

               <cfquery name="deleteineboard" datasource="#session.company_dsn#">

                    DELETE FROM ECRGBOARD
                     WHERE BOARDCODE = '#requisitionnoval#';

               </cfquery>

          		<cfinvoke method="globalinsert" requisitionnoval="#requisitionnoval#"  />

   <cfreturn #requisitionnoval# >

   </cffunction>


   <cffunction name="postCompany"
   			   access="remote"
   			   description="Post MRF to Company"
               returntype="string"
               hint="return: MRF POSTEDBYIBOSE if success, error string when failure occur."
               >
               <cfargument name="requisitionnoval" required="yes" type="string">

               <cfquery name="updatePostedY" datasource="#session.company_dsn#">
                	UPDATE CRGPERSONELREQUEST
                   		SET POSTEDBYIBOSE = 'Y',
                            POSTEDTO = 'Company',
                            DATEACTIONWASDONE = '#dateformat(now(), 'YYYY-MM-DD')#'
                 	WHERE REQUISITIONNO = '#requisitionnoval#';
               </cfquery>

               <cfquery name="deleteineboard" datasource="#session.company_dsn#">

                    DELETE FROM ECRGBOARD
                     WHERE BOARDCODE = '#requisitionnoval#';

               </cfquery>

               <cfquery name="deleteGlobalrequestcopy"  datasource="#session.global_dsn#">
                    DELETE
                      FROM GRGPERSONELREQUEST
                     WHERE REQUISITIONNO = '#requisitionnoval#' AND COMPANYCODE = '#session.companycode#'
               </cfquery>

   	<!---Posting goes here...--->

   <cfreturn #requisitionnoval# >

   </cffunction>


   <cffunction name="postinternalcompany"
   			   access="remote"
   			   description="Post MRF to Internal and Company"
               returntype="string"
               hint="return: MRF POSTEDBYIBOSE if success, error string when failure occur."
               >
               <cfargument name="requisitionnoval" required="yes" type="string">



               <cfquery name="deleteGlobalrequestcopy"  datasource="#session.global_dsn#">
                    DELETE
                      FROM GRGPERSONELREQUEST
                     WHERE REQUISITIONNO = '#requisitionnoval#' AND COMPANYCODE = '#session.companycode#'
               </cfquery>

               <cfinvoke component="jobposting"
                  method="postInternal"
                  returnvariable="returnedvar"
                  requisitionnoval="#requisitionnoval#"
                  >

               <cfquery name="updatePostedY" datasource="#session.company_dsn#">
                	UPDATE CRGPERSONELREQUEST
                   	   SET POSTEDBYIBOSE = 'Y',
                           POSTEDTO = 'Internal and Company',
                           DATEACTIONWASDONE = '#dateformat(now(), 'YYYY-MM-DD')#'
                 	 WHERE REQUISITIONNO = '#requisitionnoval#';
               </cfquery>


   <cfreturn #requisitionnoval# >

   </cffunction>


   <cffunction name="postinternalglobal"
   			   access="remote"
   			   description="Post MRF to Internal and Global"
               returntype="string"
               hint="return: MRF POSTEDBYIBOSE if success, error string when failure occur."
               >
               <cfargument name="requisitionnoval" required="yes" type="string">

               <cfinvoke component="jobposting"
                  method="postInternal"
                  returnvariable="returnedvar"
                  requisitionnoval="#requisitionnoval#"
                  >

               <cfinvoke method="globalinsert" requisitionnoval="#requisitionnoval#"  />

               <cfquery name="updatePostedY" datasource="#session.company_dsn#">
                	UPDATE CRGPERSONELREQUEST
                   	   SET POSTEDBYIBOSE = 'Y',
                           POSTEDTO = 'Internal and Global',
                           DATEACTIONWASDONE = '#dateformat(now(), 'YYYY-MM-DD')#'
                 	 WHERE REQUISITIONNO = '#requisitionnoval#';
               </cfquery>


   <cfreturn #requisitionnoval# >

   </cffunction>

   <cffunction name="postcompanyglobal"
   			   access="remote"
   			   description="Post MRF to Company and Global"
               returntype="string"
               hint="return: MRF POSTEDBYIBOSE if success, error string when failure occur."
               >
               <cfargument name="requisitionnoval" required="yes" type="string">

               <cfquery name="updatePostedY" datasource="#session.company_dsn#">
                	UPDATE CRGPERSONELREQUEST
                   	   SET POSTEDBYIBOSE = 'Y',
                           POSTEDTO = 'Company and Global',
                           DATEACTIONWASDONE = '#dateformat(now(), 'YYYY-MM-DD')#'
                 	 WHERE REQUISITIONNO = '#requisitionnoval#';
               </cfquery>

               <cfquery name="deleteineboard" datasource="#session.company_dsn#">

                    DELETE FROM ECRGBOARD
                     WHERE BOARDCODE = '#requisitionnoval#';

               </cfquery>

               <cfinvoke method="globalinsert" requisitionnoval="#requisitionnoval#"  />


   <cfreturn #requisitionnoval# >

   </cffunction>


   <cffunction name="postAll"
   			   access="remote"
   			   description="Post MRF to All"
               returntype="string"
               hint="return: MRF POSTEDBYIBOSE if success, error string when failure occur."
               >
               <cfargument name="requisitionnoval" required="yes" type="string">

               <cfquery name="deleteineboard" datasource="#session.company_dsn#">

                    DELETE FROM ECRGBOARD
                     WHERE BOARDCODE = '#requisitionnoval#';

               </cfquery>



               <cfinvoke  method="postInternal"
                          returnvariable="returnedvar"
                          requisitionnoval="#requisitionnoval#"
                          >

                <cfif returnedvar EQ requisitionnoval >
                    <!---OK--->
                <cfelse>
                    <cfthrow detail="Requisition Number mismatch" message="Requisition Number Error!">
                </cfif>



                <cfquery name="updatePostedY" datasource="#session.company_dsn#">
                	UPDATE CRGPERSONELREQUEST
                   		SET POSTEDBYIBOSE = 'Y',
                            POSTEDTO = 'All',
                            DATEACTIONWASDONE = '#dateformat(now(), 'YYYY-MM-DD')#'
                 	WHERE REQUISITIONNO = '#requisitionnoval#';
               </cfquery>

               <cfinvoke method="globalinsert" requisitionnoval="#requisitionnoval#"  />

   <cfreturn #requisitionnoval# >

   </cffunction>



   <cffunction name="postInternal"
   			   access="remote"
   			   description="Post MRF to Internal"
               returntype="string"
               hint="return: MRF POSTEDBYIBOSE if success, error string when failure occur."
               >
               <cfargument name="requisitionnoval" required="yes" type="string">

   	<!---Posting goes here...--->

    <cfquery name="deleteGlobalrequestcopy"  datasource="#session.global_dsn#">
        DELETE
          FROM GRGPERSONELREQUEST
         WHERE REQUISITIONNO = '#requisitionnoval#' AND COMPANYCODE = '#session.companycode#'
    </cfquery>

    <cfquery name="deleteeBoard" datasource="#session.company_dsn#">
        DELETE
          FROM ECRGBOARD
        WHERE BOARDCODE = '#requisitionnoval#'
    </cfquery>



    	  <cfquery name="getMrf" datasource="#session.company_dsn#" maxrows="1">

                SELECT  REQUISITIONNO AS REQNO,
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
                        POSITIONCODEFK,
                        STATUS,
                        REQUIREDNO,
                        PROJECTCODE,
                        SOURCENAME

                 FROM  CRGPERSONELREQUEST
                WHERE  REQUISITIONNO = '#requisitionnoval#'
                       <!---AND APPROVED LIKE '%Y%'
                       AND (POSTEDBYIBOSE IS NULL OR POSTEDBYIBOSE = 'N' OR POSTEDBYIBOSE = '' OR POSTEDBYIBOSE != 'Internal' )--->
                 ;
            </cfquery>

       <cfloop query="getMrf">


            <cfquery name="getPosition" datasource="#session.company_dsn#" maxrows="1">

                SELECT DESCRIPTION
                  FROM CLKPOSITION
                 WHERE POSITIONCODE = '#POSITIONCODEFK#'

            </cfquery>

            <cfif getPosition.RecordCount GT 0>
                <cfset position = getPosition.DESCRIPTION >
            <cfelse>
                <cfset position = ' '>
            </cfif>


								<cfquery name="getMRFg" datasource="#session.company_dsn#" maxrows="1">
									SELECT  A.POSITIONCODEFK AS POSITIONCODE,
											B.DESCRIPTION AS DESCRIPTION,
											A.REQUISITIONNO AS REQNO,
											A.REQUESTEDBY AS REQUESTEDBY,
											A.USERID AS USERID,
											A.DATENEEDED AS DATENEEDED,
											A.BRIEFDESC AS BRIEFDESC,
											A.DEPARTMENTCODEFK AS DEPARTMENTCODEFK,
											A.DIVISIONCODE AS DIVISIONCODE,
											A.REQUIREDNO AS REQUIREDNO,
											A.COMPANYCODE AS COMPANYCODE,
											A.SKILLSREQ AS SKILLSREQ,
											A.DATELASTUPDATE AS DATELASTUPDATE
									   FROM CRGPERSONELREQUEST A LEFT JOIN CLKPOSITION B
										 ON (A.POSITIONCODEFK = B.POSITIONCODE)

								   WHERE REQUISITIONNO = '#requisitionnoval#'
								   ;
								</cfquery>

								<cfset str1 = '<ul  style="list-style: none;">' />
								<cfset str2 = '<li style="background-color: ##CCC; font-size: 1.2em; font-weight: bold; text-align: center; margin: 50 50 0 50; padding: 5px;">#getMRFg.DESCRIPTION#</li>' />
								<cfquery name="getCompany" datasource="#session.global_dsn#" maxrows="1">
									SELECT DESCRIPTION
									  FROM GLKCOMPANY
									 WHERE COMPANYCODE = '#getMRFg.COMPANYCODE#'
								   ;
								</cfquery>
								<cfif getCompany.recordcount LT 1 >
									<cfset getCompany.DESCRIPTION = '' >
								</cfif>
								<cfset str3 = '<li style="background-color: ##CCC; font-size: 1em; font-weight: bold; text-align: center; margin: 0 50 0 50; padding: 5px;">(#getMRFg.COMPANYCODE#) - #getCompany.DESCRIPTION#</li>' />
								<cfset str4 = '<li style="background-color: ##CCC; font-size: 1em; font-weight: normal; text-align: left; font-weight: bold; margin: 20 50 0 50; padding: 5px;">Responsibilities:</li>' />
								<cfset str5 = '<li style="font-size: 1em; font-weight: normal; text-align: left; font-weight: bold; margin: 7 50 0 40; padding: 5px;">
									<ul style="background-color: ##CCC; font-size: 1em; font-weight: normal; text-align: left; font-weight: bold; margin: 10 0 20 40; padding-top: 5px;">
										<li>#getMRFg.BRIEFDESC#</li>
									</ul>
								</li>' />
                                <cfset str6 = '<li style="background-color: ##CCC; font-size: 1em; font-weight: normal; text-align: left; font-weight: bold; margin: 10 50 0 50; padding: 5px;">Requirements:</li>
								<li style="font-size: 1em; font-weight: normal; text-align: left; font-weight: bold; margin: 7 50 0 40; padding: 5px;">
									<ul style="background-color: ##CCC; font-size: 1em; font-weight: normal; text-align: left; font-weight: bold; margin: 10 0 20 40; padding-top: 5px;">
										<li>#getMRFg.SKILLSREQ#</li>
									</ul>
								</li>' />

								<cfset str7 = '<li style="background-color: ##CCC; font-size: 1em; font-weight: normal; text-align: left; font-weight: bold; margin: 10 50 0 50; padding: 5px;">Date Needed: #DateFormat(getMRFg.DATENEEDED, "MM/DD/YYYY")#</li>
								<li style="font-size: 1em; font-weight: normal; text-align: center; margin: 20 50 0 50;"><a target="_self" style="background-color: ##FC0; font-size: 1em; padding: 5px; font-weight: bold;" href="#session.domain#templates/application/?companyname=#getCompany.DESCRIPTION#&companycode=#getMRFg.COMPANYCODE#&positioncode=#getMRFg.POSITIONCODE#&norevert=NOREVERT">Click here to apply</a></li>
								</ul>' />



            <!---END--->

           <cfset thecontent = "#str1# #str2# #str3# #str4# #str5# #str6# #str7#"  >






            <cfquery name="insertIntoecrgboard" datasource="#session.company_dsn#">

                INSERT INTO ECRGBOARD ( BOARDCODE,
                                        TEMPLATECODE_FK,
                                        DESCRIPTION,
                                        SORTID,
                                        CONTENT,
                                        STARTDATE,
                                        ENDDATE,
                                        ARCHIVE,
                                        PRIORITY,
                                        DISPLAYDESC,
                                        RECCREATEDBY,
                                        RECDATECREATED,
                                        USERID,
                                        DATELASTUPDATE,
                                        TIMELASTUPDATE,
                                        BOARDCOVER
                                        )
                             VALUES   ( <cfqueryparam cfsqltype="cf_sql_varchar" value="#REQNO#">,
                                        <cfqueryparam cfsqltype="cf_sql_varchar" value="BOARD001">,
                                        <cfqueryparam cfsqltype="cf_sql_varchar" value="MRF - #REQNO#, #position#">,
                                        <cfqueryparam cfsqltype="cf_sql_varchar" value="1">,
                                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#thecontent#">,
                                        <cfqueryparam cfsqltype="cf_sql_date" value="#DateFormat(now(), 'YYYY-MM-DD')#">,
                                        <cfqueryparam cfsqltype="cf_sql_date" value="#DateFormat(DATENEEDED, 'YYYY-MM-DD')#">,
                                        <cfqueryparam cfsqltype="cf_sql_varchar" value="Y">,
                                        <cfqueryparam cfsqltype="cf_sql_varchar" value="1-HIGH">,
                                        <cfqueryparam cfsqltype="cf_sql_varchar" value="Y">,
                                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#session.USERID#">,
                                        <cfqueryparam cfsqltype="cf_sql_date" value="#DateFormat(now(), 'YYYY-MM-DD')#">,
                                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#session.USERID#">,
                                        <cfqueryparam cfsqltype="cf_sql_date" value="#DateFormat(now(), 'YYYY-MM-DD')#">,
                                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#TimeFormat(now(), 'HH:MM:SS')#">,
                                        <cfqueryparam cfsqltype="cf_sql_varchar" value="Y">

                                      )
                ;


            </cfquery>

            <cfquery name="updatePostedY" datasource="#session.company_dsn#">

                UPDATE CRGPERSONELREQUEST
                   SET POSTEDBYIBOSE = 'Y',
                       POSTEDTO = 'Internal',
                       DATEACTIONWASDONE = '#dateformat(now(), 'YYYY-MM-DD')#'
                 WHERE REQUISITIONNO = '#requisitionnoval#';

            </cfquery>

			<cfreturn #requisitionnoval# >

            </cfloop>


	<cfreturn 'xxxx'>





   </cffunction>


   <cffunction name="globalinsert" returntype="void" output="no" >

   <cfargument name="requisitionnoval" required="yes" type="string">

   	           <cfquery name="deleteGlobalrequestcopy"  datasource="#session.global_dsn#">
                    DELETE
                      FROM GRGPERSONELREQUEST
                     WHERE REQUISITIONNO = '#requisitionnoval#' AND COMPANYCODE = '#session.companycode#'
                </cfquery>


               <cfquery name="getMRFsample" datasource="#session.company_dsn#">
                    SELECT POSITIONCODEFK,
                           REQUISITIONNO AS REQNO,
                           COMPANYCODE,
                           REQUIREDNO,
                           DATELASTUPDATE,
                           DATEACTIONWASDONE
                      FROM CRGPERSONELREQUEST
                     WHERE REQUISITIONNO = '#requisitionnoval#';
               </cfquery>
                  <!---insert--->

                 <cfloop query="getMRFsample">
                    <cfquery name="insertRecordsCurrent16" datasource="#session.global_dsn#" >
                        INSERT INTO GRGPERSONELREQUEST (   POSITIONCODE,
                                                           REQUISITIONNO,
                                                           COMPANYCODE,
                                                           REQUIREDNO,
                                                           DATELASTUPDATE,
                                                           SOURCENAME
                                                        )
                             VALUES ( <cfqueryparam cfsqltype="cf_sql_varchar" value="#POSITIONCODEFK#">,
                                      <cfqueryparam cfsqltype="cf_sql_varchar" value="#REQNO#">,
                                      <cfqueryparam cfsqltype="cf_sql_varchar" value="#COMPANYCODE#">,
                                      <cfqueryparam cfsqltype="cf_sql_integer" value="#REQUIREDNO#">,
                                      <cfqueryparam cfsqltype="cf_sql_date"    value="#DATEACTIONWASDONE#">,
                                      <cfqueryparam cfsqltype="cf_sql_varchar" value="iBOS/e">
                                    );


                   </cfquery>
                 </cfloop>

   </cffunction>



</cfcomponent>
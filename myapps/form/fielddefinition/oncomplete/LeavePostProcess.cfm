<!---
@Author: Mark Solis
@Module: Leave Form Post Process
@Date: Nov. 22, 2012
--->
 
<!---<CFTRY>--->
	<cfset ok=true>
    <CFSET LVHRS="">
    <CFSET ISWHLDY=0>
    <CFSET NOOFDYS=1>
    <CFSET LATEUNDRTIME = "NA">
    
    <CFQUERY NAME = "GETLVDTLS" DATASOURCE="#session.COMPANY_DSN#">
        SELECT *
        FROM CINLEAVEAPPSI
        WHERE EFORMID ='#eformid#' AND PROCESSID = '#processid#'
    </CFQUERY>
	
	<!---<CFTHROW message="#processid# --- #eformid# --- #session.COMPANY_DSN#" >--->
	
    <CFQUERY NAME = "GETWRKCODE" DATASOURCE="#session.COMPANY_DSN#">
        SELECT WORKINGDAYSCODE 
        FROM #session.maintable#
        WHERE PERSONNELIDNO ='#GETLVDTLS.PERSONNELIDNO#'
    </CFQUERY>
    <CFQUERY NAME = "GETWRKHR" DATASOURCE="#session.COMPANY_DSN#">
        SELECT WORKINGHOURSFORLV
        FROM CLKWORKINGDAYS
        WHERE WORKINGDAYSCODE ='#GETWRKCODE.WORKINGDAYSCODE#'
    </CFQUERY>

    <cfset wrkhr = 8>
    <cfif GETWRKHR.WORKINGHOURSFORLV neq "">
        <cfset wrkhr = #GETWRKHR.WORKINGHOURSFORLV#>
    </cfif>


    <CFSET LVHRS = DateDiff("h", GETLVDTLS.STARTINGTIME, GETLVDTLS.ENDINGTIME)>

	 
	<cfscript>
		if(GETLVDTLS.LATEUNDERTIME == 'AM' || GETLVDTLS.LATEUNDERTIME == 'PM') {
			TEMP = wrkhr / 2;
			ISWHLDY = LVHRS / 2;
		} else {
			TEMP = wrkhr;
			ISWHLDY = LVHRS;
		}
	</cfscript>
	

    <CFIF ISWHLDY GT TEMP>
        <CFSET ISWHLDY = 1>
        <CFSET LVHRS = #wrkhr#>
    <CFELSE>
        <CFSET ISWHLDY = 0>
        <CFSET LVHRS = #temp#>
        <CFSET LATEUNDRTIME = #GETLVDTLS.LATEUNDERTIME#>
    </CFIF>

    <CFSET NOOFDYS = DateDiff("d", GETLVDTLS.STARTINGDATE, GETLVDTLS.ENDINGDATE)>
    <CFSET NOOFDYS = #NOOFDYS# + 1>
    

    	<cftry>
            <CFQUERY NAME = "INSERTM" DATASOURCE="#session.company_dsn#">
                INSERT INTO CINLEAVEAPPSM (
							PERSONNELIDNO,
							DOCNUMBER,
							STARTINGDATE,
							ENDINGDATE,
							LEAVETYPE,
							APPROVED,
							LEAVEHOURS,
							WHOLEDAY,
							NOOFDAYS,
							ROUTED,
							LATEUNDERTIME,
							DATEACTIONWASDONE,
							RECCREATEDBY,
							RECDATECREATED,
							USERID,
							DATELASTUPDATE,
							TIMELASTUPDATE,	
							APPLICATIONDATE,
							WITHPAY
                )
                VALUES (
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#GETLVDTLS.PERSONNELIDNO#" >,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#GETLVDTLS.DOCNUMBER#" >,
                    <cfqueryparam cfsqltype="cf_sql_timestamp" value="#CreateODBCDate(GETLVDTLS.STARTINGDATE)#" >,
                    <cfqueryparam cfsqltype="cf_sql_timestamp" value="#CreateODBCDate(GETLVDTLS.ENDINGDATE)#" >,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#GETLVDTLS.LEAVETYPE#" >,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="Y" >,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#LVHRS#" >,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#ISWHLDY#" >,
                    <cfqueryparam cfsqltype="cf_sql_int" value="#NOOFDYS#" >,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="Y" >,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#LATEUNDRTIME#" >,
                    <cfqueryparam cfsqltype="cf_sql_timestamp" value="#CreateODBCDate(Now())#" >, 
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#GETLVDTLS.RECCREATEDBY#" >,
                    <cfqueryparam cfsqltype="cf_sql_timestamp" value="#CreateODBCDate(GETLVDTLS.RECDATECREATED)#" >,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#session.userid#" >,
                    <cfqueryparam cfsqltype="cf_sql_timestamp" value="#CreateODBCDate(Now())#" >,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#timeformat(Now(),'HH:mm:ss')#" >,
                    <cfqueryparam cfsqltype="cf_sql_timestamp" value="#GETLVDTLS.APPLICATIONDATE#" >,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#GETLVDTLS.WITHPAY#" >
                )
            </CFQUERY>
            
            <CFSET NOOFDYS = #NOOFDYS# -1>
            <CFLOOP INDEX = "i" to = "#NOOFDYS#" from ="0" >
                <CFQUERY NAME = "INSERTD" DATASOURCE="#session.COMPANY_DSN#">
                    INSERT INTO CINLEAVEAPPSD (
						PERSONNELIDNO, 
						DOCNUMBER,
						REFERENCEDATE, 
						APPROVED, 
						LEAVEHOURS, 
						WITHPAY,
						LEAVETYPE,
						RECCREATEDBY,
						RECDATECREATED,
						USERID,
						DATELASTUPDATE,
						TIMELASTUPDATE,
						LATEUNDERTIME) 
                    VALUES(
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#GETLVDTLS.PERSONNELIDNO#" >,
						<cfqueryparam cfsqltype="cf_sql_varchar" value="#GETLVDTLS.DOCNUMBER#" >,
                        <cfqueryparam cfsqltype="cf_sql_timestamp" value="#CreateODBCDate(DateAdd('d',i,GETLVDTLS.STARTINGDATE))#" >,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="Y" >,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#LVHRS#" >,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#GETLVDTLS.WITHPAY#" >,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#GETLVDTLS.LEAVETYPE#" >,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#GETLVDTLS.RECCREATEDBY#" >,
                        <cfqueryparam cfsqltype="cf_sql_timestamp" value="#CreateODBCDate(GETLVDTLS.RECDATECREATED)#" >,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#session.userid#" >,
                        <cfqueryparam cfsqltype="cf_sql_timestamp" value="#CreateODBCDate(Now())#" >,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#timeformat(Now(),'HH:mm:ss')#" >,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#LATEUNDRTIME#" >
                    )
                </CFQUERY>
            </CFLOOP>
            <cfcatch>
                <CFQUERY NAME = "ROLLBACK1" DATASOURCE="#session.COMPANY_DSN#">
					DELETE FROM CINLEAVEAPPSM WHERE DOCNUMBER = '#GETLVDTLS.DOCNUMBER#';
				</CFQUERY>
				<CFQUERY NAME = "ROLLBACK2" DATASOURCE="#session.COMPANY_DSN#">
					DELETE FROM CINLEAVEAPPSD WHERE DOCNUMBER = '#GETLVDTLS.DOCNUMBER#';
				</CFQUERY>
				<CFQUERY NAME = "ROLLBACK3" DATASOURCE="#session.COMPANY_DSN#">
					UPDATE FROM CINLEAVEAPPSI
					   SET APPROVED = 'S'
					 WHERE DOCNUMBER = '#GETLVDTLS.DOCNUMBER#';
				</CFQUERY>
              
            </cfcatch>
        </cftry>
        
        





















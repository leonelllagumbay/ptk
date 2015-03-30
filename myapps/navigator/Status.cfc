<cfcomponent name="Status">
	
<cffunction name="updateNPCounter" access="package" output="false" returntype="void" >
	<cfquery name="queryFormCounter" datasource="#session.global_dsn#" >
		SELECT COUNT(E.ACTION) AS NEWCOUNT,
			   A.EFORMID AS EFORMIDZ
		  FROM EGRGEFORMS A 
		       LEFT JOIN EGRTEFORMS B ON (A.EFORMID=B.EFORMID)
		       LEFT JOIN EGINFORMPROCESSDETAILS C ON (A.EFORMID=C.EFORMIDFK)
		       LEFT JOIN EGINROUTERDETAILS D ON (C.PROCESSDETAILSID=D.PROCESSIDFK)
		       LEFT JOIN EGINAPPROVERDETAILS E ON (D.ROUTERDETAILSID=E.ROUTERIDFK)
	     WHERE B.PERSONNELIDNO='#session.chapa#' AND E.PERSONNELIDNO='#session.chapa#' AND E.ISREAD='false' AND E.ACTION='CURRENT'
	  GROUP BY A.EFORMID
	</cfquery>
	<cfloop query="queryFormCounter" >
		<cfquery name="updateFormCounterNEW" datasource="#session.global_dsn#" >
			UPDATE EGINEFORMCOUNT
			   SET NEW = '#queryFormCounter.NEWCOUNT#'
			 WHERE EFORMID='#queryFormCounter.EFORMIDZ#' AND PERSONNELIDNO='#session.chapa#'
		</cfquery>
	</cfloop>
	<cfquery name="queryFormCounterPending" datasource="#session.global_dsn#" >
		SELECT COUNT(E.ACTION) AS PENDINGCOUNT,
			   A.EFORMID AS EFORMIDY
		  FROM EGRGEFORMS A 
		       LEFT JOIN EGRTEFORMS B ON (A.EFORMID=B.EFORMID)
		       LEFT JOIN EGINFORMPROCESSDETAILS C ON (A.EFORMID=C.EFORMIDFK)
		       LEFT JOIN EGINROUTERDETAILS D ON (C.PROCESSDETAILSID=D.PROCESSIDFK)
		       LEFT JOIN EGINAPPROVERDETAILS E ON (D.ROUTERDETAILSID=E.ROUTERIDFK)
	     WHERE B.PERSONNELIDNO='#session.chapa#' AND E.PERSONNELIDNO='#session.chapa#' AND E.ISREAD='true' AND E.ACTION='CURRENT'
	  GROUP BY A.EFORMID
	</cfquery>
	<cfloop query="queryFormCounterPending" >
		<cfquery name="updateFormCounterPENDING" datasource="#session.global_dsn#" >
			UPDATE EGINEFORMCOUNT
			   SET PENDING = '#queryFormCounterPending.PENDINGCOUNT#'
			 WHERE EFORMID='#queryFormCounterPending.EFORMIDY#' AND PERSONNELIDNO='#session.chapa#'
		</cfquery>
	</cfloop>
	
	
</cffunction>

<cffunction name="countNew" returntype="Query" output="false" access="package" >
	<cfquery name="cNew" datasource="#session.global_dsn#" >
		SELECT SUM(B.NEW + B.RETURNED + B.APPROVED + B.DISAPPROVED) AS TOTNEW
		  FROM EGRTEFORMS A,EGINEFORMCOUNT B 
		 WHERE A.PERSONNELIDNO = B.PERSONNELIDNO 
               AND A.EFORMID = B.EFORMID
			   AND B.PERSONNELIDNO = '#session.chapa#';
	</cfquery>
	<cfreturn cNew >
</cffunction>


<cffunction name="countPending" returntype="Query" output="false" access="package" >
	<cfquery name="cPending" datasource="#session.global_dsn#" >
		SELECT SUM(B.PENDING) AS TOTPENDING
		  FROM EGRTEFORMS A,EGINEFORMCOUNT B 
		 WHERE A.PERSONNELIDNO = B.PERSONNELIDNO 
               AND A.EFORMID = B.EFORMID
			   AND B.PERSONNELIDNO = '#session.chapa#';
	</cfquery>
	<cfreturn cPending >
</cffunction>



<cffunction name="countEachFormID" returntype="Query" output="false" access="package">
	<!---count specific forms--->
	<cfquery name="countEachForm" datasource="#session.global_dsn#" maxrows="50">
		SELECT 
				A.EFORMID  AS EFORMID, 
				A.EFORMNAME AS EFORMNAME,
				C.NEW AS NEW,
				C.PENDING AS PENDING,
				C.RETURNED AS RETURNED,
				C.APPROVED AS APPROVED,
				C.DISAPPROVED AS DISAPPROVED
		  FROM  EGRGEFORMS A LEFT JOIN EGRTEFORMS B ON (A.EFORMID=B.EFORMID)
				LEFT JOIN EGINEFORMCOUNT C ON (A.EFORMID=C.EFORMID)
		 WHERE  B.PERSONNELIDNO = '#session.chapa#' 
                AND B.PERSONNELIDNO = C.PERSONNELIDNO
				AND (C.PENDING > 0 OR C.NEW > 0 OR C.RETURNED > 0 OR C.APPROVED > 0 OR C.DISAPPROVED > 0)
	</cfquery>
	<cfreturn countEachForm >
</cffunction>

<cffunction name="countAllForm" returntype="Query" output="false" access="package">
	<cfquery name="theForms" datasource="#session.global_dsn#" maxrows="25">
		SELECT  A.EFORMID  AS EFORMID, 
				A.EFORMNAME AS EFORMNAME
		  FROM  EGRGEFORMS A LEFT JOIN EGRTEFORMS B ON (A.EFORMID=B.EFORMID)
		 WHERE  B.PERSONNELIDNO = '#session.chapa#'
	</cfquery>
	<cfreturn theForms >
</cffunction>



</cfcomponent>
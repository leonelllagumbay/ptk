<cfquery name="tat" datasource="IBOSEDATA" >
	INSERT INTO EGINEFORMCOUNT ( EFORMID, PERSONNELIDNO, NEW)
	      VALUES ( '#createuuid()#', '#createuuid()#', '#dateformat(now(), "YYYY-MM-DD")#')
	
</cfquery>
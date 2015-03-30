<cfquery name="queryecinqueryrowtoemail" datasource="#session.company_dsn#" maxrows="1">
	SELECT TASKNAME, TASKGROUP 
	  FROM ECINQUERYROWTOEMAIL
	 WHERE EFORMID = '#eformid#' AND PROCESSID = '#processid#'
</cfquery>


<cfschedule 
	action="delete"
	task="#queryecinqueryrowtoemail.TASKNAME#"
	group="#queryecinqueryrowtoemail.TASKGROUP#" 
>
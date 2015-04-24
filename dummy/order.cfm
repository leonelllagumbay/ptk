<cfset routerdetailsid = "aksdfas" >
<cfset eformid = "akdfsd">


<cfset approverQry = OrmExecuteQuery("SELECT APPROVERORDER, count(APPROVERORDER) AS APPROVERCOUNT
		                                        FROM EGINAPPROVERDETAILS WHERE ROUTERIDFK = '#routerdetailsid#'
		                                     GROUP BY APPROVERORDER") >
		<cfloop array="#approverQry#" index="appIndex" >
			<cfif appIndex[2] gt 1 >
			<cfset approverQryB = OrmExecuteQuery("SELECT A.PERSONNELIDNO, count(A.PERSONNELIDNO)
				                                        FROM EGINAPPROVERDETAILS A WHERE A.APPROVERORDER = #appIndex[1]#
				                                             AND A.PERSONNELIDNO IN (SELECT B.PERSONNELIDNO
		                                        									 FROM EGINAPPROVERDETAILS B WHERE B.ROUTERIDFK = '#routerdetailsid#' 
		                                        	 									  AND B.APPROVERORDER = #appIndex[1]# 
		                                        	 									  AND B.ACTION <> 'IGNORED'
		                                        	 									  AND B.ACTION <> 'DISAPPROVED'
		                                        	 									  AND B.ACTION <> 'APPROVED'
		                                        	 									  AND B.ACTION <> 'TIMEDOUT')  
				                                    GROUP BY A.PERSONNELIDNO   
													ORDER BY count(A.PERSONNELIDNO) ASC    
		                                     ") >
		                                     

			<cfdump var="#approverQryB#" >	
			</cfif>
		</cfloop>	                                   
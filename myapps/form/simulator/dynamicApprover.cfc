component  name="dynamicApprover" ExtDirect="true"
{
	public struct function isDynamic(required string routerOrderOrPID, required string eformid)
	ExtDirect="true" 
	{
		try
		{
			retstruct = structnew();
			retstruct.HASDYNAMIC = 'false';
			if(routerOrderOrPID == '1') //form flow not yet instantiated, therefore read direct through the template flow
			{
				//get the process of the eForm using the eformid passed
				formFlowProcess = ORMExecuteQuery("SELECT FORMFLOWPROCESS FROM EGRGEFORMS WHERE EFORMID = '#eformid#'", true );
				formRouterData = EntityLoad("EGINFORMROUTER", {PROCESSIDFK = #formFlowProcess#,ROUTERORDER=1});
				for(cnter=1;cnter<=ArrayLen(formRouterData);cnter++)
				{
					formApproversData = EntityLoad("EGINROUTERAPPROVERS", {PROCESSIDFK=#formFlowProcess#,APPROVERNAME='TOBESPECIFIED'});
					if(ArrayLen(formApproversData) > 0)
					{
						retstruct.HASDYNAMIC = 'true';
						retstruct.MAXIMUM    = ArrayLen(formApproversData);
						retstruct.ROUTERORDER= 1;
						retstruct.TEMPLATEROUTERID = formRouterData[cnter].getROUTERID();
						retstruct.EFORMID= eformid;
						break;
					}
				}
			} else
			{
				
			}
			return retstruct;
		}
		catch(any err)
		{
			retstruct.theerr =  err.message & ' ' & err.detail;
			return retstruct;
		}
	}
	
	
	public string function addApprover(string eformid, string piduser, string userrole, string templaterouterid)
	ExtDirect="true"
	{
		try
		{
			if(trim(userrole) == '') //individual user is used
			{
				newApprover = EntityNew("EGINDYNAMICAPPROVERS");
				newApprover.setEFORMIDFK(eformid);
				newApprover.setPERSONNELIDNO(piduser);
				newApprover.setROUTERIDFK(templaterouterid);
				newApprover.setOWNER(session.chapa);
				EntitySave(newApprover);
				ormflush();
			} else
			{
				formFlowProcess = ORMExecuteQuery("SELECT FORMFLOWPROCESS FROM EGRGEFORMS WHERE EFORMID = '#eformid#'", true );
						
				theSQL = "SELECT A.USERGRPMEMBERSIDX AS USERGRPMEMBERSIDX, B.USERID AS USERID, B.GUID AS GUID  
					        FROM EGRGROLEINDEX A LEFT JOIN EGRGUSERMASTER B ON (A.USERGRPMEMBERSIDX = B.USERID)
					       WHERE USERGRPID_FK = '#userrole#'";
					       
				getRoleFromGroup = CreateObject("component", "query");
				getRoleFromGroup.setName("AA");
				getRoleFromGroup.setDatasource("#session.global_dsn#");
				getRoleFromGroup.setSql(theSQL);
				qryres = getRoleFromGroup.execute();
				qryres = qryres.getResult();
				if(qryres.recordcount gt 0)
				{
				
					getPIDfromMainTable = CreateObject("component", "query");
				
					for(cntt=1;cntt<=qryres.recordcount;cntt++)
					{
						thePIDSQL = "SELECT #session.mainpk# AS PID 
								       FROM #session.maintable# 
								      WHERE GUID = '#qryres['GUID'][cntt]#' ";
					    getPIDfromMainTable.setName("BB");
					    getPIDfromMainTable.setDatasource("#session.company_dsn#");
					    getPIDfromMainTable.setSql(thePIDSQL);
					    getPIDfromMainTable.setMaxrows(1);
					    theres = getPIDfromMainTable.execute();
					    theres = theres.getResult();
					    if(theres.recordcount gt 0)
						{
						    for(cnttb=1;cnttb<=theres.recordcount;cnttb++)
							{
								newApprover = EntityNew("EGINDYNAMICAPPROVERS");
								newApprover.setEFORMIDFK(eformid);
								newApprover.setPERSONNELIDNO(theres["PID"][cnttb]);
								newApprover.setROUTERIDFK(templaterouterid);
								newApprover.setOWNER(session.chapa);
								EntitySave(newApprover);
								OrmFlush();
							}
						}
					}
				
				}
			}
			return "success";
		} catch(any err)
		{
			return err.message & ' ' & err.detail;
		}
	}
	
	public string function removeApprover(required string eformid, required string pid, required string routerid)
	ExtDirect="true"
	{
		try
		{
			theApprover = EntityLoad("EGINDYNAMICAPPROVERS", {EFORMIDFK=#eformid#,PERSONNELIDNO=#pid#,ROUTERIDFK=#routerid#,OWNER=#session.chapa#}, true );
			EntityDelete(theApprover);
			ormflush();
			return "success";
		} catch(any err)
		{
			return err.message & ' ' & err.detail;
		}
		
	}
	
}
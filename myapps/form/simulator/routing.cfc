component  displayname="routing" hint="Helper class for approving forms"
{

	public string function getDatasourceCF(required string tablelevel) 
	{
		if (tablelevel == 'G') 
		{
			theLevel = "#session.global_dsn#";
		}
		else if (tablelevel == 'C')
		{
			theLevel = "#session.company_dsn#";
		} 
		else if (tablelevel == 'S')
		{
			theLevel = "#session.subco_dsn#";
		} 
		else if (tablelevel == 'Q')
		{
			theLevel = "#session.query_dsn#";
		} 
		else if (tablelevel == 'T')
		{
			theLevel = "#session.transaction_dsn#";
		} 
		else if (tablelevel == 'SD')
		{
			theLevel = "#session.site_dsn#";
		} 
		else
		{
			theLevel = tablelevel;
		} 
		
		return theLevel;
	}

	public string function getDatasource(required string tablelevel)
	{ 
		if (session.dbms == 'MYSQL') 
		{
			if (tablelevel == 'G') 
			{
				theLevel = "#session.global_dsn#";
			}
			else if (tablelevel == 'C')
			{
				theLevel = "#session.company_dsn#";
			} 
			else if (tablelevel == 'S')
			{
				theLevel = "#session.subco_dsn#";
			} 
			else if (tablelevel == 'Q')
			{
				theLevel = "#session.query_dsn#";
			} 
			else if (tablelevel == 'T')
			{
				theLevel = "#session.transaction_dsn#";
			} 
			else if (tablelevel == 'SD')
			{
				theLevel = "#session.site_dsn#";
			} 
			else
			{
				theLevel = tablelevel;
			} 
		} 
		else if (session.dbms == 'MSSQL')
		{
			if (tablelevel == 'G') 
			{
				theLevel = "#session.global_dsn#" & ".dbo";
			}
			else if (tablelevel == 'C')
			{
				theLevel = "#session.company_dsn#" & ".dbo";
			} 
			else if (tablelevel == 'S')
			{
				theLevel = "#session.subco_dsn#" & ".dbo";
			} 
			else if (tablelevel == 'Q')
			{
				theLevel = "#session.query_dsn#" & ".dbo";
			} 
			else if (tablelevel == 'T')
			{
				theLevel = "#session.transaction_dsn#" & ".dbo";
			} 
			else if (tablelevel == 'SD')
			{
				theLevel = "#session.site_dsn#" & ".dbo";
			} 
			else
			{
				theLevel = tablelevel & ".dbo";
			} 
		}
		else
		{
			if (tablelevel == 'G') 
			{
				theLevel = "#session.global_dsn#";
			}
			else if (tablelevel == 'C')
			{
				theLevel = "#session.company_dsn#";
			} 
			else if (tablelevel == 'S')
			{
				theLevel = "#session.subco_dsn#";
			} 
			else if (tablelevel == 'Q')
			{
				theLevel = "#session.query_dsn#";
			} 
			else if (tablelevel == 'T')
			{
				theLevel = "#session.transaction_dsn#";
			} 
			else if (tablelevel == 'SD')
			{
				theLevel = "#session.site_dsn#";
			} 
			else
			{
				theLevel = tablelevel;
			} 
		}
		return theLevel;
	}
	
	
	
	public void function updateFormCount(required string eformid, required string personnelidno, required string theType)
	{
		if (theType == 'addnew')
		{
			updateCount = EntityLoad("EGINEFORMCOUNT", { EFORMID =#eformid#, PERSONNELIDNO = #personnelidno#}, true );
			if ( isdefined("updateCount") )
			{
				currentCount = updateCount.getNEW() + 1;
				updateCount.setNEW(currentCount);
				EntitySave(updateCount);
				ormflush();
			}	
		}
		else if (theType == 'subtractreturn')
		{
			updateCount = EntityLoad("EGINEFORMCOUNT", { EFORMID =#eformid#, PERSONNELIDNO = #personnelidno#}, true );
			if ( isdefined("updateCount") )
			{
				if ( updateCount.getRETURNED() > 0 )
				{
				currentCount = updateCount.getRETURNED() - 1;
				updateCount.setNEW(currentCount);
				EntitySave(updateCount);
				ormflush();
				}
			}	
			
		}
		else if (theType == 'updateornew')
		{
			updateCount = EntityLoad("EGINEFORMCOUNT", { EFORMID =#eformid#, PERSONNELIDNO = #personnelidno#}, true );
			if ( isdefined("updateCount") )
			{
				currentCount = updateCount.getNEW() + 1;
				updateCount.setRECEIVED(val(updateCount.getRECEIVED()) + 1);
				updateCount.setNEW(currentCount);
			}	
			else 
			{
				updateCount = EntityNew("EGINEFORMCOUNT");
				updateCount.setNEW("1");
				updateCount.setEFORMID(eformid);
				updateCount.setPERSONNELIDNO(personnelidno);
				updateCount.setPENDING("0");
				updateCount.setRETURNED("0");
				updateCount.setAPPROVED("0");
				updateCount.setDISAPPROVED("0");
				updateCount.setRECEIVED("1");
				updateCount.setDATELASTUPDATE("#dateformat(now(), 'YYYY-MM-DD')#");
			}
			EntitySave(updateCount);
			ormflush();
		}
		else if (theType == 'pendingadded')
		{
			updateCount = EntityLoad("EGINEFORMCOUNT", { EFORMID =#eformid#, PERSONNELIDNO = #personnelidno#}, true );
			if ( isdefined("updateCount") )
			{
				updateCount.setRECEIVED(val(updateCount.getRECEIVED()) + 1);
			}	
			else 
			{
				updateCount = EntityNew("EGINEFORMCOUNT");
				updateCount.setNEW("0");
				updateCount.setEFORMID(eformid);
				updateCount.setPERSONNELIDNO(personnelidno);
				updateCount.setPENDING("0");
				updateCount.setRETURNED("0");
				updateCount.setAPPROVED("0");
				updateCount.setDISAPPROVED("0");
				updateCount.setRECEIVED("1");
				updateCount.setDATELASTUPDATE("#dateformat(now(), 'YYYY-MM-DD')#");
			}
			EntitySave(updateCount);
			ormflush();
		}
		else if (theType == 'subtractneworpending')
		{
			updateCount = EntityLoad("EGINEFORMCOUNT", { EFORMID =#eformid#, PERSONNELIDNO = #personnelidno#}, true );
			if ( isdefined("updateCount") )
			{
				if ( updateCount.getPENDING() > 0 )
				{
					currentCount = updateCount.getPENDING() - 1;
					updateCount.setPENDING(currentCount);
				}
				else if (updateCount.getNEW() > 0)
				{
					currentCount = updateCount.getNEW() - 1;
					updateCount.setNEW(currentCount);
				}
				EntitySave(updateCount);
				ormflush();
			}	
		}
		else if (theType == 'disapproveone')
		{
			updateCount = EntityLoad("EGINEFORMCOUNT", { EFORMID =#eformid#, PERSONNELIDNO = #personnelidno#}, true );
			if ( isdefined("updateCount") )
			{
				currentCount = updateCount.getDISAPPROVED() + 1;
				updateCount.setDISAPPROVED(currentCount);
			}	
			else 
			{
				updateCount = EntityNew("EGINEFORMCOUNT");
				updateCount.setEFORMID(eformid);
				updateCount.setPERSONNELIDNO(personnelidno);
				updateCount.setNEW("0");
				updateCount.setPENDING("0");
				updateCount.setRETURNED("0");
				updateCount.setAPPROVED("0");
				updateCount.setDISAPPROVED("1");
				updateCount.setRECEIVED("0");
				updateCount.setDATELASTUPDATE("#dateformat(now(), 'YYYY-MM-DD')# #timeformat(now(), 'HH:MM:SS')#");
			}
			EntitySave(updateCount);
			ormflush();
		}
		else if (theType == 'returnone')
		{
			updateCount = EntityLoad("EGINEFORMCOUNT", { EFORMID =#eformid#, PERSONNELIDNO = #personnelidno#}, true );
			if ( isdefined("updateCount") )
			{
				currentCount = updateCount.getRETURNED() + 1;
				updateCount.setRETURNED(currentCount);
			}	
			else 
			{
				updateCount = EntityNew("EGINEFORMCOUNT");
				updateCount.setEFORMID(eformid);
				updateCount.setPERSONNELIDNO(personnelidno);
				updateCount.setNEW("0");
				updateCount.setPENDING("0");
				updateCount.setRETURNED("1");
				updateCount.setAPPROVED("0");
				updateCount.setDISAPPROVED("0");
				updateCount.setRECEIVED("0");
				updateCount.setDATELASTUPDATE("#dateformat(now(), 'YYYY-MM-DD')# #timeformat(now(), 'HH:MM:SS')#");
			}
			EntitySave(updateCount);
			ormflush();
		}
		else if (theType == 'approveone')
		{
			updateCount = EntityLoad("EGINEFORMCOUNT", { EFORMID =#eformid#, PERSONNELIDNO = #personnelidno#}, true );
			if ( isdefined("updateCount") )
			{
				currentCount = updateCount.getAPPROVED() + 1;
				updateCount.setAPPROVED(currentCount);
			}	
			else 
			{
				updateCount = EntityNew("EGINEFORMCOUNT");
				updateCount.setEFORMID(eformid);
				updateCount.setPERSONNELIDNO(personnelidno);
				updateCount.setNEW("0");
				updateCount.setPENDING("0");
				updateCount.setRETURNED("0");
				updateCount.setAPPROVED("1");
				updateCount.setDISAPPROVED("0");
				updateCount.setRECEIVED("0");
				updateCount.setDATELASTUPDATE("#dateformat(now(), 'YYYY-MM-DD')# #timeformat(now(), 'HH:MM:SS')#");
			}
			EntitySave(updateCount);
			ormflush();
		}
	
	}
}

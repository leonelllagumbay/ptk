<cfscript>
	dbinfoObj = CreateObject("component", "dbinfo");
	dbinfoObj.setDatasource("IBOSE_GLOBAL");
	dbinfoObj.setName("datasources");
	dbNames = dbinfoObj.dbnames();
	for(cnt=1;cnt<=dbNames.recordcount;cnt++)
	{
		try
		{
			theDbSource = dbNames.DATABASE_NAME[cnt];
			tbinfoObj = CreateObject("component", "dbinfo");
			tbinfoObj.setDatasource(theDbSource);
			tbinfoObj.setName("columns");
			tbinfoObj.setTable("usr_inbillinglst");
			colNames = tbinfoObj.columns();
			writedump(colNames);
			break;
		}
		catch(any err) {
			//writedump(err.message);
		}
		
	}
</cfscript>


<cfscript>
		dbInfoService = createObject("component", "dbinfo");
			dbInfoService.setDatasource("IBOSE_GLOBAL");
		dbInfoService.setName("columns");
		dbInfoService.setTable("EGRGQRYCOLUMN");

		columnsArr = dbInfoService.columns();

		/*for ( i=1; i<=columnsArr.recordcount; i++) {
			writeOutput('tmpresult["' & columnsArr.COLUMN_NAME[i] & '"] = dcolumn[i].get' & columnsArr.COLUMN_NAME[i] & '();');
			writeOutput('<br>');
		}*/

		/*for ( i=1; i<=columnsArr.recordcount; i++) {
			writeOutput('if(Not IsDefined("form.' & columnsArr.COLUMN_NAME[i] &  '") || form.' & columnsArr.COLUMN_NAME[i] & '== "" ) dsource.set' & columnsArr.COLUMN_NAME[i] & '(javacast("null",""));');
			writeOutput('<br>');
			writeOutput('else dsource.set' & columnsArr.COLUMN_NAME[i] & '(trim(form.' & columnsArr.COLUMN_NAME[i] & '));');
			writeOutput('<br>');
			writeOutput('<br>');
		}*/
		for ( i=1; i<=columnsArr.recordcount; i++) {
			writeOutput('if(Not IsDefined("form.' & columnsArr.COLUMN_NAME[i] &  '") || form.' & columnsArr.COLUMN_NAME[i] & ' == "" ) dcolumn.set' & columnsArr.COLUMN_NAME[i] & '(javacast("null",""));');
			writeOutput('<br>');
			writeOutput('else dcolumn.set' & columnsArr.COLUMN_NAME[i] & '(trim(form.' & columnsArr.COLUMN_NAME[i] & '));');
			writeOutput('<br>');
			writeOutput('<br>');
		}
</cfscript>
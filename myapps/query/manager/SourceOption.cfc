component
ExtDirect="true"
{
	public struct function getDatasource(required string page,required string start, required string limit, required any sort, required any filter)
	ExtDirect="true"
	{
		start = start + 1;
		limit = limit - 1;

		dbInfoService = createObject("component", "dbinfo");

		dbasename = dbInfoService.dbnames(datasource="#session.global_dsn#");

		rootstruct = StructNew();
		tmpresult = StructNew();
		sourceArr = ArrayNew(1);
		resultArr = ArrayNew(1);
		dbtypeStruct = StructNew();

		for ( i=1; i<=dbasename.recordcount; i++) {
			ArrayAppend(sourceArr,dbasename.DATABASE_NAME[i]);
			dbtypeStruct['#dbasename.DATABASE_NAME[i]#'] = dbasename.TYPE[i];
		}
		ArraySort(sourceArr,"text",sort[1].direction);

		try
        {
        	filter = deserializeJSON(filter);
        	filter = filter[1].value;
        	sourceArr = arrayFilter(sourceArr, function(thisValue) {
					   if(findnocase(filter, thisValue)) {
							return true;
						} else {
							return false;
						}
					});
        }
        catch(Any e)
        {
        }

		for ( i=#start#; i<=#start#+#limit#; i++) {
			tmpresult = StructNew();
			if(i <= ArrayLen(sourceArr)) {
				tmpresult['DATASOURCENAME'] = sourceArr[i];
				try { tmpresult['DATASOURCETYPE'] = dbtypeStruct['#dbasename.DATABASE_NAME[i]#']; }
                catch(Any e) { }
			    ArrayAppend(resultArr,tmpresult);
			} else {
				break;
			}
		}
		rootStruct['totalCount'] = ArrayLen(sourceArr);
		rootStruct['topics'] = resultArr;



		return rootStruct;
	}


	public struct function getTables(required string page,required string start, required string limit, required any sort, required any filter, required array dSource, required any dFilter)
	ExtDirect="true"
	{
		start = start + 1;
		limit = limit - 1;

		dbInfoService = createObject("component", "dbinfo");

		rootstruct = StructNew();
		tmpresult = StructNew();
		resultArr = ArrayNew(1);

		datacnt = 0;

		for(a=1;a<=ArrayLen(dSource);a++) {

			sourceArr = ArrayNew(1);
			typeStruct = StructNew();
			remarkStruct = StructNew();

			try
	        {
	        	filter = deserializeJSON(dFilter);
	        	filter = filter[1].value;
	        	dbInfoService.setPattern("%#filter#%");
	        }
	        catch(Any e)
	        {
	        }

			thisSource = trim(dSource[a]);
			dTable = dbInfoService.tables(datasource="#thisSource#");

			for ( i=1; i<=dTable.recordcount; i++) {
				ArrayAppend(sourceArr,dTable.TABLE_NAME[i]);
				typeStruct['#dTable.TABLE_NAME[i]#'] = dTable.TABLE_TYPE[i];
				remarkStruct['#dTable.TABLE_NAME[i]#'] = dTable.REMARKS[i];
			}
			ArraySort(sourceArr,"text",sort[1].direction);

			for ( i=#start#; i<=#start#+#limit#; i++) {
				tmpresult = StructNew();
				if(i <= ArrayLen(sourceArr)) {
					if(session.dbms == 'MSSQL') {
						tmpresult['TEMPTABLE'] 	= thisSource & ".dbo." & sourceArr[i];
						tmpresult['DATASOURCE'] = thisSource;
						tmpresult['TABLENAME'] 	= sourceArr[i];
						tmpresult['TABLEALIAS'] = sourceArr[i];
						try { tmpresult['TABLE_TYPE'] = typeStruct['#sourceArr[i]#']; }
		                catch(Any e) { }
		                try { tmpresult['REMARKS'] 	= remarkStruct['#sourceArr[i]#']; }
		                catch(Any e) { }
					} else {
						tmpresult['TEMPTABLE'] = thisSource & "." & sourceArr[i];
						tmpresult['DATASOURCE'] = thisSource;
						tmpresult['TABLENAME'] = sourceArr[i];
						tmpresult['TABLEALIAS'] = sourceArr[i];
						try { tmpresult['TABLE_TYPE'] = typeStruct['#sourceArr[i]#']; }
		                catch(Any e) { }
		                try { tmpresult['REMARKS'] 	= remarkStruct['#sourceArr[i]#']; }
		                catch(Any e) { }
					}
					ArrayAppend(resultArr,tmpresult);
				} else {
					break;
				}
			}

			datacnt += ArrayLen(sourceArr);

		}



		rootStruct['totalCount'] = datacnt;
		rootStruct['topics'] = resultArr;

		return rootStruct;
	}


	public struct function getFields(required string page,
								  required string start,
								  required string limit,
								  required any    sort,
								  required any    filter,
								  required array  dSource,
								  required array  dTable,
								  required array  dTableAlias,
								  required any dFilter)
	ExtDirect="true"
	{
		start = start + 1;
		limit = limit - 1;

		dbInfoService = createObject("component", "dbinfo");

		rootstruct = StructNew();
		tmpresult = StructNew();
		resultArr = ArrayNew(1);

		datacnt = 0;

		for(a=1; a<=ArrayLen(dSource); a++) {

			sourceArr     = ArrayNew(1);

			remarkStruct = StructNew();
			primarykeyStruct = StructNew();
			positionStruct = StructNew();
			typeStruct = StructNew();
			decimalStruct = StructNew();
			isNullableStruct = StructNew();
			defaultStruct = StructNew();
			octetStruct = StructNew();
			foreignkeyStruct = StructNew();
			refPrimaryKeyStruct = StructNew();
			refPrimaryKeyTableStruct = StructNew();

			var dbsource = dSource[a];
			var dbtable  = dTable[a];
			var dbtablealias  = dTableAlias[a];

			dbInfoService.setDatasource(dbsource);
			dbInfoService.setName("columns");
			dbInfoService.setTable(dbtable);

			try
	        {
	        	filter = deserializeJSON(dFilter);
	        	filter = filter[1].value;
	        	dbInfoService.setPattern("%#filter#%");
	        }
	        catch(Any e)
	        {
	        }

			columnsArr = dbInfoService.columns();


			for ( i=1; i<=columnsArr.recordcount; i++) {
				ArrayAppend(sourceArr,columnsArr.COLUMN_NAME[i]);
				remarkStruct['#dbtable##columnsArr.COLUMN_NAME[i]#'] = columnsArr.REMARKS[i];
				primarykeyStruct['#dbtable##columnsArr.COLUMN_NAME[i]#'] = columnsArr.IS_PRIMARYKEY[i];
				positionStruct['#dbtable##columnsArr.COLUMN_NAME[i]#'] = columnsArr.ORDINAL_POSITION[i];
				typeStruct['#dbtable##columnsArr.COLUMN_NAME[i]#'] = columnsArr.TYPE_NAME[i];
				decimalStruct['#dbtable##columnsArr.COLUMN_NAME[i]#'] = columnsArr.DECIMAL_DIGITS[i];
				isNullableStruct['#dbtable##columnsArr.COLUMN_NAME[i]#'] = columnsArr.IS_NULLABLE[i];
				defaultStruct['#dbtable##columnsArr.COLUMN_NAME[i]#'] = columnsArr.COLUMN_DEFAULT_VALUE[i];
				octetStruct['#dbtable##columnsArr.COLUMN_NAME[i]#'] = columnsArr.CHAR_OCTET_LENGTH[i];
				foreignkeyStruct['#dbtable##columnsArr.COLUMN_NAME[i]#'] = columnsArr.IS_FOREIGNKEY[i];
				refPrimaryKeyStruct['#dbtable##columnsArr.COLUMN_NAME[i]#'] = columnsArr.REFERENCED_PRIMARYKEY[i];
				refPrimaryKeyTableStruct['#dbtable##columnsArr.COLUMN_NAME[i]#'] = columnsArr.REFERENCED_PRIMARYKEY_TABLE[i];
			}
			ArraySort(sourceArr,"text",sort[1].direction);

			for ( i=#start#; i<=#start#+#limit#; i++) {
				tmpresult = StructNew();

				if(i <= ArrayLen(sourceArr)) {
					tmpresult['DISPLAY'] = dbtablealias & "." & sourceArr[i];
					tmpresult['TABLENAME'] = dbtable;
					tmpresult['FIELDNAME'] = sourceArr[i];
					try { tmpresult['FIELDALIAS'] = remarkStruct['#dbtable##sourceArr[i]#']; }
                    catch(Any e) { }
                    try { tmpresult['IS_PRIMARYKEY'] = primarykeyStruct['#dbtable##sourceArr[i]#']; }
                    catch(Any e) { }
                    try { tmpresult['ORDINAL_POSITION'] = positionStruct['#dbtable##sourceArr[i]#']; }
                    catch(Any e) { }
                    try { tmpresult['TYPE_NAME'] = typeStruct['#dbtable##sourceArr[i]#']; }
                    catch(Any e) { }
                    try { tmpresult['DECIMAL_DIGITS'] = decimalStruct['#dbtable##sourceArr[i]#']; }
                    catch(Any e) { }
                    try { tmpresult['IS_NULLABLE'] = isNullableStruct['#dbtable##sourceArr[i]#']; }
                    catch(Any e) { }
                    try { tmpresult['COLUMN_DEFAULT_VALUE'] = defaultStruct['#dbtable##sourceArr[i]#']; }
                    catch(Any e) { }
                    try { tmpresult['CHAR_OCTET_LENGTH'] = octetStruct['#dbtable##sourceArr[i]#']; }
                    catch(Any e) { }
                    try { tmpresult['IS_FOREIGNKEY'] = foreignkeyStruct['#dbtable##sourceArr[i]#']; }
                    catch(Any e) { }
                    try { tmpresult['REFERENCED_PRIMARYKEY'] = refPrimaryKeyStruct['#dbtable##sourceArr[i]#']; }
                    catch(Any e) { }
                    try { tmpresult['REFERENCED_PRIMARYKEY_TABLE'] = refPrimaryKeyTableStruct['#dbtable##sourceArr[i]#']; }
                    catch(Any e) { }

				    ArrayAppend(resultArr,tmpresult);
				} else {
					break;
				}
			}

			datacnt += ArrayLen(sourceArr);
			//StructClear(remarkStruct);

		}

		rootStruct['totalCount'] = datacnt;
		rootStruct['topics'] = resultArr;

		return rootStruct;
	}


	public any function getFunctions(required string page,required string start, required string limit, required any sort, required any filter)
	ExtDirect="true"
	{
		try
        {

			where             = " (";
            tmpdatafield      = "";
            tmpfilteroperator = "0";

			try {
				filter = deserializejson(filter);	//Deserialize JSON string coz Router forgets to do the work on filter but not on sort
			for(a=1;a<=ArrayLen(filter);a++) {

            	try {
					filterdatafield = filter[a].field;
				}
				catch(Any e)
                {
                  break;
                }

            	filterdatafield = filter[a].field;
				filterdatafield = replace(filterdatafield, "_", ".");
				filtervalue     = filter[a].value;
				filtertype      = filter[a].type;
				if( tmpdatafield == "" ) {
                	tmpdatafield = filterdatafield;
                } else if( tmpdatafield != filterdatafield ) {
                	where = "#where# ) AND ( ";
                } else if( tmpdatafield == filterdatafield ) {
                	if( tmpfilteroperator == 0 ) {
                    	where = "#where# AND ";
                    } else {
                    	where = "#where# OR ";
                    }
				}

                if( ucase(filtertype) == "STRING" ) {
					where = "#where##filterdatafield#  LIKE '%#filtervalue#%'";
				} else if(  ucase(filtertype) == "NUMERIC" ) {
					filtercondition = filterdata.comparison;
					expression = "#Ucase(Trim(filtercondition))#";
               			if( expression  == "LT" ) {
						   	where = "#where##filterdatafield#  < #filtervalue#";
						} else if( expression == "GT" ) {
							where = "#where##filterdatafield#  > #filtervalue#";
						} else if( expression == "EQ" ) {
							where = "#where##filterdatafield#  = #filtervalue#";
						}
				} else if(  ucase(filtertype) == "DATE" ) {
					filtercondition = filterdata.comparison;
					expression = "#Ucase(Trim(filtercondition))#";

						filtervalue = CreateODBCDateTime(filtervalue);
               			if( expression  == "LT") {
	               			where = "#where##filterdatafield#  < #filtervalue#";
						} else if( expression == "GT" ) {
							where = "#where##filterdatafield#  > #filtervalue#";
						} else if( expression == "EQ" ) {
							where = "#where##filterdatafield#  = #filtervalue#";
						} else {
							where = "#where##filterdatafield#  = #filtervalue#";
					    }
				} else {
					//boolean
					 where = "#where##filterdatafield#  LIKE '%#filtervalue#%'";
				}
                tmpdatafield      = filterdatafield;
			}
		}
		catch(Any e)
		{
			//Do nothing here since filter is not a valid JSON string
		}

        where = "#where#)";
		where = Replace(where, "''", "'" , "all");

		if( trim(where) != "()" ) {
			WHERE =  "WHERE #PreserveSingleQuotes(where)#";
		} else {
			WHERE = "";
		}

	  //Order By Arguments/Contents
	  thecnt = 1;
	  for(b=1;b<=ArrayLen(sort);b++) {
	  	  ORDERBY = "#replace(sort[b].property, '_', '.')# #sort[b].direction#";
	  	  if( thecnt == ArrayLen(sort) ) {
		  } else {
	  	  	ORDERBY = ORDERBY & ',';
		  }
		  thecnt = thecnt + 1;
	  }



			processedData = ORMExecuteQuery("FROM EGLKSQLFUNCTIONS #WHERE# ORDER BY #ORDERBY#", false, {offset=#start#, maxResults=#limit#, timeout=60} );

			countAll = ORMExecuteQuery("SELECT SQLCODE FROM EGLKSQLFUNCTIONS #WHERE#" );

			rootstruct = StructNew();
			tmpresult = StructNew();
			resultArr = ArrayNew(1);

			for(i=1; i<=ArrayLen(processedData); i++) {
				tmpresult = StructNew();
				tmpresult['SQLCODE'] = processedData[i].getSQLCODE();
				tmpresult['FUNCTIONNAME'] = processedData[i].getFUNCTIONNAME();
				tmpresult['CATEGORY'] = processedData[i].getCATEGORY();
				tmpresult['SYNTAX'] = processedData[i].getSYNTAX();
				tmpresult['DEFINITION'] = processedData[i].getDEFINITION();
				tmpresult['DBMSNAME'] = processedData[i].getDBMSNAME();
				tmpresult['TOTALNOOFARGS'] = processedData[i].getTOTALNOOFARGS();
				tmpresult['REQUIREDNOOFARGS'] = processedData[i].getREQUIREDNOOFARGS();
				tmpresult['DEFAULTTYPE'] = processedData[i].getDEFAULTTYPE();
				tmpresult['TOTALNOOFARGS'] = processedData[i].getTOTALNOOFARGS();
				ArrayAppend(resultArr,tmpresult);
			}

			rootstuct['totalCount'] = ArrayLen(countAll);
			rootstuct['topics'] = resultArr;
			return rootstuct;
    }
    catch(Any e)
    {
    	return e;
    }
  }


  public struct function getOrderBy(  required string page,
									  required string start,
									  required string limit,
									  required any    sort,
									  required any    filter,
									  required array  dSource,
									  required array  dTable,
									  required array  dTableAlias,
									  required any 	  dFilter)
	ExtDirect="true"
	{
		start = start + 1;
		limit = limit - 1;

		dbInfoService = createObject("component", "dbinfo");

		rootstruct 	= StructNew();
		tmpresult 	= StructNew();
		sourceArr	= ArrayNew(1);
		resultArr 	= ArrayNew(1);


		for(a=1; a<=ArrayLen(dSource); a++) {

			var dbsource = dSource[a];
			var dbtable  = dTable[a];
			var dbtablealias  = dTableAlias[a];

			dbInfoService.setDatasource(dbsource);
			dbInfoService.setName("columns");
			dbInfoService.setTable(dbtable);

			try
	        {
	        	filter = deserializeJSON(dFilter);
	        	filter = filter[1].value;
	        	dbInfoService.setPattern("%#filter#%");
	        }
	        catch(Any e)
	        {
	        }

			columnsArr = dbInfoService.columns();


			for ( i=1; i<=columnsArr.recordcount; i++) {
				ArrayAppend(sourceArr,columnsArr.COLUMN_NAME[i]);
			}
			ArraySort(sourceArr,"text",sort[1].direction);

			for ( i=#start#; i<=#start#+#limit#; i++) {
				tmpresult = StructNew();

				if(i <= ArrayLen(sourceArr)) {
					tmpresult['DISPLAY'] = dbtablealias & "." & sourceArr[i];
					tmpresult['FIELDNAME'] = sourceArr[i];
					tmpresult['ASCORDESC'] = "ASC";

				    ArrayAppend(resultArr,tmpresult);
				} else {
					break;
				}
			}

		}

		rootStruct['totalCount'] = ArrayLen(sourceArr);
		rootStruct['topics'] = resultArr;

		return rootStruct;
	}

}
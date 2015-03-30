component  name="applydefaultfield" ExtDirect="true"
{
	public array function applyDefaultFields(required string tableid, required string eformidfk, required string tablename)
	ExtDirect="true"
	{
		dbinfoObj = CreateObject("component", "dbinfo");
		dbinfoObj.setDatasource("IBOSE_GLOBAL");
		dbinfoObj.setName("datasources");
		dbNames = dbinfoObj.dbnames();
		errorlog = arraynew(1);
		arrayappend(errorlog, 'No error');
		
		for(cnt=1;cnt<=dbNames.recordcount;cnt++)
		{
			
			try
			{
				arrayappend(errorlog, dbNames.DATABASE_NAME[cnt]);
				theDbSource = dbNames.DATABASE_NAME[cnt];
				tbinfoObj = CreateObject("component", "dbinfo");
				tbinfoObj.setDatasource(theDbSource);
				tbinfoObj.setName("columns");
				tbinfoObj.setTable(tablename);
				
				//delete current data record
				deleteQ = CreateObject("component", "query");
				deleteQ.setDatasource("IBOSE_GLOBAL");
				deleteQ.setName("deleteQuery");
				theSQL1 = "DELETE FROM EGRGIBOSETABLEFIELDS WHERE TABLEIDFK = '#tableid#'";
				deleteQ.setSql(theSQL1);
				deleteQ.execute();	
				//end delete
				colNames = tbinfoObj.columns();
				prepareColumns(colNames,tableid); 
				
				
				break;
			}
			catch(any err) {
				arrayappend(errorlog, err.message);
			}
			
		}
		return errorlog;
		
	}
	
	private void function prepareColumns(required query colNames, required string tableid)
	{
		try
		{
			
		
		for(cnt=1;cnt<=colNames.recordcount;cnt++)
		{
			thecolType = colNames.TYPE_NAME[cnt];
			colRemarks = colNames.REMARKS[cnt];
			colName = colNames.COLUMN_NAME[cnt];
			colDefaultValue = colNames.COLUMN_DEFAULT_VALUE[cnt];
			colSize = colNames.COLUMN_SIZE[cnt];
			colIsNullable = colNames.IS_NULLABLE[cnt];
			colIsPrimaryKey = colNames.IS_PRIMARYKEY[cnt];
			colOrdinalPosition = colNames.ORDINAL_POSITION[cnt];
			
			//get column type
			eformColType = structnew();
			eformColType = geteFormColumnType(thecolType);
			columnType = eformColType.columntype;
			xtype = eformColType.xtype;
			
			if(colName == 'PERSONNELIDNO' || colName == 'PROCESSID' || colName == 'EFORMID' || colName == 'ACTIONBY' || colName == 'APPROVED' || colName == 'DATEACTIONWASDONE' || colName == 'RECDATECREATED' || colName == 'DATELASTUPDATE')
			{
				continue;  
			} else
			{
				prepRes = structnew();
				prepRes = setupDataToInsert(columnType, xtype,  colRemarks, colName, colDefaultValue, colSize, colIsNullable, colIsPrimaryKey, colOrdinalPosition);
			}
			
			
			//insert the default data record
				insertD = CreateObject("component", "query");
				insertD.setDatasource("IBOSE_GLOBAL");
				insertD.setName("insertQuery");
				theSQL2 = "INSERT INTO EGRGIBOSETABLEFIELDS ( COLUMNID,
															  TABLEIDFK,
															  COLUMNNAME,
															  FIELDLABEL,
															  COLUMNORDER,
															  COLUMNTYPE,
															  XTYPE,
															  COLUMNGROUP,
															  ALLOWBLANK,
															  WIDTH,
															  MININPUTVALUE,
															  MAXINPUTVALUE,
															  MINCHARLENGTH,
															  MAXCHARLENGTH,
															  PADDING,
															  INPUTVALUE,
															  XPOSITION,  
															  YPOSITION,
															  ANCHORPOSITION,
															  RENDERER,
															  ISHIDDEN,
															  ISREADONLY,
															  INPUTFORMAT,
															  STYLE,
															  FIELDLABELALIGN,
															  VTYPETEXT,
															  HEIGHT,
															  FIELDLABELWIDTH,
															  MARGIN,
															  VALIDATIONTYPE,
															  CSSCLASS,
															  ISDISABLED,
															  BORDER )
							                          VALUES (  
							                          		  '#prepRes.COLUMNID#', 
															  '#tableid#',
															  '#prepRes.COLUMNNAME#',
															  '#prepRes.FIELDLABEL#',
															  '#prepRes.COLUMNORDER#',
															  '#prepRes.COLUMNTYPE#',
															  '#prepRes.XTYPE#',
															  '#prepRes.COLUMNGROUP#',
															  '#prepRes.ALLOWBLANK#',
															  '#prepRes.WIDTH#',   
															  '#prepRes.MININPUTVALUE#',
															  '#prepRes.MAXINPUTVALUE#',
															  '#prepRes.MINCHARLENGTH#',
															  '#prepRes.MAXCHARLENGTH#',
															  '#prepRes.PADDING#',
															  '#prepRes.INPUTVALUE#',
															  '#prepRes.XPOSITION#',
															  '#prepRes.YPOSITION#',
															  '#prepRes.ANCHORPOSITION#',
															  '#prepRes.RENDERER#',
															  'false',
															  'false',
															  ' ',
															  ' ',
															  'left',
															  ' ',
															  ' ',
															  '160',
															  ' ',
															  ' ',
															  ' ',
															  'false',
															  ' '
							                          	      );";
				insertD.setSql(theSQL2);
				insertD.execute();
		}
		} //end try
		catch(any err)
		{
			arrayappend(errorlog, err.message);
			throw ("error");
		}
		
		
	}
	
	
	private struct function geteFormColumnType(required string thecolType)
	{
		coltype = structnew();
		if(thecolType == "BIGINT")
		{
			coltype["columntype"] = "int";
			coltype["xtype"] = "numberfield";
		} else
		if(thecolType == "BINARY")
		{
			coltype["columntype"] = "string";
			coltype["xtype"] = "textfield";
		} else
		if(thecolType == "BIT")
		{
			coltype["columntype"] = "string";
			coltype["xtype"] = "textfield";
		} else
		if(thecolType == "BLOB")
		{
			coltype["columntype"] = "string";
			coltype["xtype"] = "htmleditor";
		} else
		if(thecolType == "TINYINT")
		{
			coltype["columntype"] = "int";
			coltype["xtype"] = "numberfield";
		} else
		if(thecolType == "CHAR")
		{
			coltype["columntype"] = "string";
			coltype["xtype"] = "textfield";
		} else
		if(thecolType == "DATE")
		{
			coltype["columntype"] = "date";
			coltype["xtype"] = "datefield";
		} else
		if(thecolType == "DATETIME")
		{
			coltype["columntype"] = "date";
			coltype["xtype"] = "datefield";
		} else
		if(thecolType == "DECIMAL")
		{
			coltype["columntype"] = "float";
			coltype["xtype"] = "numberfield";
		} else
		if(thecolType == "DOUBLE")
		{
			coltype["columntype"] = "float";
			coltype["xtype"] = "numberfield";
		} else
		if(thecolType == "FLOAT")
		{
			coltype["columntype"] = "float";
			coltype["xtype"] = "numberfield";
		} else
		if(thecolType == "INT")
		{
			coltype["columntype"] = "int";
			coltype["xtype"] = "numberfield";
		} else
		if(thecolType == "LONGBLOB")
		{
			coltype["columntype"] = "string";
			coltype["xtype"] = "textareafield";
		} else
		if(thecolType == "LONGTEXT")
		{
			coltype["columntype"] = "string";
			coltype["xtype"] = "textareafield";
		} else
		if(thecolType == "MEDIUMBLOB")
		{
			coltype["columntype"] = "string";
			coltype["xtype"] = "textareafield";
		} else
		if(thecolType == "MEDIUMINT")
		{
			coltype["columntype"] = "int";
			coltype["xtype"] = "numberfield";
		} else
		if(thecolType == "MEDIUMTEXT")
		{
			coltype["columntype"] = "string";
			coltype["xtype"] = "textareafield";
		} else
		if(thecolType == "NUMERIC")
		{
			coltype["columntype"] = "float";
			coltype["xtype"] = "numberfield";
		} else
		if(thecolType == "SMALLINT")
		{
			coltype["columntype"] = "int";
			coltype["xtype"] = "numberfield";
		} else
		if(thecolType == "TEXT")
		{
			coltype["columntype"] = "string";
			coltype["xtype"] = "textareafield";
		} else
		if(thecolType == "TIME")
		{
			coltype["columntype"] = "string";
			coltype["xtype"] = "timefield";
		} else
		if(thecolType == "TIMESTAMP")
		{
			coltype["columntype"] = "date";
			coltype["xtype"] = "datefield";
		} else
		if(thecolType == "TINYBLOB")
		{
			coltype["columntype"] = "string";
			coltype["xtype"] = "textareafield";
		} else
		if(thecolType == "TINYINT")
		{
			coltype["columntype"] = "boolean";
			coltype["xtype"] = "checkboxgroup";
		} else
		if(thecolType == "BOOLEAN")
		{
			coltype["columntype"] = "boolean";
			coltype["xtype"] = "checkboxgroup";
		} else
		if(thecolType == "TINYTEXT")
		{
			coltype["columntype"] = "string";
			coltype["xtype"] = "textareafield";
		} else
		if(thecolType == "VARBINARY")
		{
			coltype["columntype"] = "string";
			coltype["xtype"] = "textareafield";
		} else
		if(thecolType == "VARCHAR")
		{
			coltype["columntype"] = "string";
			coltype["xtype"] = "textfield";
		} else
		if(thecolType == "YEAR")
		{
			coltype["columntype"] = "date";
			coltype["xtype"] = "datefield";
		} else
		if(thecolType == "MONEY")
		{
			coltype["columntype"] = "float";
			coltype["xtype"] = "numberfield";
		} else
		if(thecolType == "SMALLMONEY")
		{
			coltype["columntype"] = "float";
			coltype["xtype"] = "numberfield";
		} else
		if(thecolType == "DATETIME2")
		{
			coltype["columntype"] = "date";
			coltype["xtype"] = "datefield";
		} else
		if(thecolType == "DATETIMEOFFSET")
		{
			coltype["columntype"] = "date";
			coltype["xtype"] = "datefield";
		} else
		if(thecolType == "SMALLDATETIME")
		{
			coltype["columntype"] = "date";
			coltype["xtype"] = "datefield";
		} else
		if(thecolType == "NCHAR")
		{
			coltype["columntype"] = "string";
			coltype["xtype"] = "textfield";
		} else
		if(thecolType == "NTEXT")
		{
			coltype["columntype"] = "string";
			coltype["xtype"] = "textareafield";
		} else
		if(thecolType == "NVARCHAR")
		{
			coltype["columntype"] = "string";
			coltype["xtype"] = "textfield";
		} else
		if(thecolType == "IMAGE")
		{
			coltype["columntype"] = "string";
			coltype["xtype"] = "textareafield";
		} else
		if(thecolType == "CURSOR")
		{
			coltype["columntype"] = "string";
			coltype["xtype"] = "textfield";
		} else
		if(thecolType == "HIERARCHYID")
		{
			coltype["columntype"] = "string";
			coltype["xtype"] = "textfield";
		} else
		if(thecolType == "SQL_VARIENT")
		{
			coltype["columntype"] = "string";
			coltype["xtype"] = "textareafield";
		} else
		if(thecolType == "TABLE")
		{
			coltype["columntype"] = "string";
			coltype["xtype"] = "textfield";
		} else
		if(thecolType == "UNIQUEIDENTIFIER")
		{
			coltype["columntype"] = "string";
			coltype["xtype"] = "textfield";
		} else
		if(thecolType == "XML")
		{
			coltype["columntype"] = "string";
			coltype["xtype"] = "textareafield";
		} else
		if(thecolType == "SPATIAL TYPES")
		{
			coltype["columntype"] = "string";
			coltype["xtype"] = "textfield";
		} else
		{
			coltype["columntype"] = "string";
			coltype["xtype"] = "textfield";
		}
		
		return coltype;
		
	}	
	
	
	private struct function setupDataToInsert(string columnType, string xtype, string colRemarks, string colName, string colDefaultValue, numeric colSize, string colIsNullable, string colIsPrimaryKey, numeric colOrdinalPosition)
	{
		retStruct = structnew();
		
		
															  
		if(colIsPrimaryKey == 'YES')
		{
			xtype = "id";
		}
		
		
		if(colRemarks == '') {
			colRemarks = colName;
		}
		
		retStruct.COLUMNID 		= createuuid();
		retStruct.COLUMNNAME 	= colName;
		retStruct.FIELDLABEL 	= colRemarks;
		retStruct.COLUMNORDER 	= colOrdinalPosition;
		retStruct.COLUMNTYPE 	= columnType;
		retStruct.XTYPE 		= xtype;
		retStruct.COLUMNGROUP 	= '';
		
		if(colIsNullable == 'NO')
		{
			retStruct.ALLOWBLANK = 'false';
		} else
		{
			retStruct.ALLOWBLANK = 'true';
		}
		
		retStruct.WIDTH 		= '200';
		retStruct.MININPUTVALUE = 0;
		
		if(xtype == 'datefield') 
		{
			retStruct.MAXINPUTVALUE = 0;
		} else 
		{
			retStruct.MAXINPUTVALUE = colSize;
		}
		
		retStruct.MINCHARLENGTH = 0;
		retStruct.MAXCHARLENGTH = colSize;
		retStruct.PADDING 		= '5 5 5 5';
		retStruct.INPUTVALUE 	= colDefaultValue;
		retStruct.XPOSITION 	= 5;
		retStruct.YPOSITION 	= colOrdinalPosition*30+5;
		retStruct.ANCHORPOSITION= '50%';
		retStruct.RENDERER= '';
		
		return retStruct;
	}
	
}
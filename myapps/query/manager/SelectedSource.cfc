component
ExtDirect="true"
{
	public struct function getSelectedDatasource(required string page,required string start,required string limit,
											required any sort,required any filter,required string querycode)
	ExtDirect="true"
	{
		try
        {
        	rootstruct = StructNew();
			tmpresult = StructNew();
			resultArr = ArrayNew(1);

			dsource = EntityLoad("EGRGEVIEWDATASOURCE",{EQRYCODEFK="#querycode#"}, "COLUMNORDER ASC");

			for(i=1; i<=ArrayLen(dsource); i++) {
				tmpresult = StructNew();
				tmpresult['DATASOURCECODE'] = dsource[i].getDATASOURCECODE();
				tmpresult['EQRYCODEFK'] 	= dsource[i].getEQRYCODEFK();
				tmpresult['DATASOURCENAME'] = dsource[i].getDATASOURCENAME();
				tmpresult['COLUMNORDER'] 	= dsource[i].getCOLUMNORDER();
				ArrayAppend(resultArr,tmpresult);
			}

			rootstuct['totalCount'] = ArrayLen(dsource);
			rootstuct['topics'] = resultArr;
			return rootstuct;
        }
        catch(Any e)
        {
        	retStruct =StructNew();
			retStruct['err'] = e;
			return retStruct;
        }

	}

	public struct function getSelectedTable(required string page,required string start,required string limit,
										required any sort,required any filter,required string querycode)
	ExtDirect="true"
	{
		try
        {
			rootstruct = StructNew();
			tmpresult = StructNew();
			resultArr = ArrayNew(1);

			dsource = EntityLoad("EGRGEVIEWTABLES",{EQRYCODEFK="#querycode#"}, "COLUMNORDER ASC");

			for(i=1; i<=ArrayLen(dsource); i++) {
				tmpresult = StructNew();
				tmpresult['EVIEWTABLECODE'] 	= dsource[i].getEVIEWTABLECODE();
				tmpresult['DATASOURCECODEFK'] 	= dsource[i].getDATASOURCECODEFK();
				tmpresult['DATASOURCE'] 		= dsource[i].getDATASOURCECODEFK();
				tmpresult['EQRYCODEFK'] 		= dsource[i].getEQRYCODEFK();
				tmpresult['TABLENAME'] 			= dsource[i].getTABLENAME();
				tmpresult['TEMPTABLE'] 			= dsource[i].getTEMPTABLE();
				tmpresult['TABLEALIAS'] 		= dsource[i].getTABLEALIAS();
				tmpresult['COLUMNORDER'] 		= dsource[i].getCOLUMNORDER();
				ArrayAppend(resultArr,tmpresult);
			}

			rootstuct['totalCount'] = ArrayLen(dsource);
			rootstuct['topics'] = resultArr;
			return rootstuct;
        }
        catch(Any e)
        {
        	retStruct =StructNew();
			retStruct['err'] = e;
			return retStruct;
        }

	}


	public struct function getSelectedField(required string page,required string start, required string limit,
										required any sort, required any filter, required string querycode)
	ExtDirect="true"
	{
		try
        {
			rootstruct = StructNew();
			tmpresult = StructNew();
			resultArr = ArrayNew(1);

			dsource = EntityLoad("EGRGEVIEWFIELDS",{EQRYCODEFK="#querycode#"}, "COLUMNORDER ASC");

			for(i=1; i<=ArrayLen(dsource); i++) {
				tmpresult = StructNew();
				tmpresult['EVIEWFIELDCODE'] 	= dsource[i].getEVIEWFIELDCODE();
				tmpresult['TABLENAME'] 	= dsource[i].getTABLENAME();
				tmpresult['EQRYCODEFK'] 		= dsource[i].getEQRYCODEFK();
				tmpresult['FIELDNAME'] 			= dsource[i].getFIELDNAME();
				tmpresult['DISPLAY'] 			= dsource[i].getDISPLAY();
				tmpresult['FIELDALIAS'] 		= dsource[i].getFIELDALIAS();
				tmpresult['PRIORITYNO'] 		= dsource[i].getPRIORITYNO();
				tmpresult['AGGREGATEFUNC'] 		= dsource[i].getAGGREGATEFUNC();
				tmpresult['DATEANDSTRINGFUNC'] 	= dsource[i].getDATEANDSTRINGFUNC();
				tmpresult['NUMBERFORMAT'] 		= dsource[i].getNUMBERFORMAT();
				tmpresult['ISDISTINCT'] 		= dsource[i].getISDISTINCT();
				tmpresult['WRAPON'] 			= dsource[i].getWRAPON();
				tmpresult['SUPPRESSZERO'] 		= dsource[i].getSUPPRESSZERO();
				tmpresult['OVERRIDESTATEMENT'] 	= dsource[i].getOVERRIDESTATEMENT();
				tmpresult['COLUMNORDER'] 		= dsource[i].getCOLUMNORDER();

				tmpresult['IS_PRIMARYKEY'] 		= dsource[i].getIS_PRIMARYKEY();
				tmpresult['ORDINAL_POSITION'] 	= dsource[i].getORDINAL_POSITION();
				tmpresult['TYPE_NAME'] 			= dsource[i].getTYPE_NAME();
				tmpresult['DECIMAL_DIGITS'] 	= dsource[i].getDECIMAL_DIGITS();
				tmpresult['IS_NULLABLE'] 		= dsource[i].getIS_NULLABLE();
				tmpresult['COLUMN_DEFAULT_VALUE'] 			= dsource[i].getCOLUMN_DEFAULT_VALUE();
				tmpresult['CHAR_OCTET_LENGTH'] 	= dsource[i].getCHAR_OCTET_LENGTH();
				tmpresult['IS_FOREIGNKEY'] 		= dsource[i].getIS_FOREIGNKEY();
				tmpresult['REFERENCED_PRIMARYKEY'] 			= dsource[i].getREFERENCED_PRIMARYKEY();
				tmpresult['REFERENCED_PRIMARYKEY_TABLE'] 	= dsource[i].getREFERENCED_PRIMARYKEY_TABLE();
				ArrayAppend(resultArr,tmpresult);
			}

			rootstuct['totalCount'] = ArrayLen(dsource);
			rootstuct['topics'] = resultArr;
			return rootstuct;
        }
        catch(Any e)
        {
        	retStruct =StructNew();
			retStruct['err'] = e;
			return retStruct;
        }

	}


	public struct function getJoinedTables(required string page, required string start, required string limit,
										required any sort, required any filter, required string querycode)
	ExtDirect="true"
	{
		try
        {
			rootstruct = StructNew();
			tmpresult = StructNew();
			resultArr = ArrayNew(1);

			dsource = EntityLoad("EGRGEVIEWJOINEDTABLES",{EQRYCODEFK="#querycode#"}, "COLUMNORDER ASC");

			for(i=1; i<=ArrayLen(dsource); i++) {
				tmpresult = StructNew();
				tmpresult['EVIEWJOINEDTABLECODE'] 	= dsource[i].getEVIEWJOINEDTABLECODE();
				tmpresult['EQRYCODEFK'] 			= dsource[i].getEQRYCODEFK();
				tmpresult['JOINOPERATOR'] 			= dsource[i].getJOINOPERATOR();
				tmpresult['PRIORITYNO'] 			= dsource[i].getPRIORITYNO();
				tmpresult['TABLENAME'] 				= dsource[i].getTABLENAME();
				tmpresult['ONCOLUMN'] 				= dsource[i].getONCOLUMN();
				tmpresult['EQUALTOCOLUMN'] 			= dsource[i].getEQUALTOCOLUMN();
				tmpresult['DISPLAY'] 				= dsource[i].getDISPLAY();
				tmpresult['COLUMNORDER'] 			= dsource[i].getCOLUMNORDER();

				ArrayAppend(resultArr,tmpresult);
			}

			rootstuct['totalCount'] = ArrayLen(dsource);
			rootstuct['topics'] = resultArr;
			return rootstuct;
        }
        catch(Any e)
        {
        	retStruct =StructNew();
			retStruct['err'] = e;
			return retStruct;
        }

	}


	public struct function getCondition(required string page, required string start, required string limit,
										required any sort, required any filter, required string querycode)
	ExtDirect="true"
	{
		try
        {
			rootstruct = StructNew();
			tmpresult = StructNew();
			resultArr = ArrayNew(1);

			dsource = EntityLoad("EGRGEVIEWCONDITION",{EQRYCODEFK="#querycode#"}, "COLUMNORDER ASC");

			for(i=1; i<=ArrayLen(dsource); i++) {
				tmpresult = StructNew();
				tmpresult['EVIEWCONDITIONCODE'] = dsource[i].getEVIEWCONDITIONCODE();
				tmpresult['EQRYCODEFK'] = dsource[i].getEQRYCODEFK();
				tmpresult['PRIORITYNO'] = dsource[i].getPRIORITYNO();
				tmpresult['CONJUNCTIVEOPERATOR'] = dsource[i].getCONJUNCTIVEOPERATOR();
				tmpresult['ONCOLUMN'] = dsource[i].getONCOLUMN();
				tmpresult['CONDITIONOPERATOR'] = dsource[i].getCONDITIONOPERATOR();
				tmpresult['COLUMNVALUE'] = dsource[i].getCOLUMNVALUE();
				tmpresult['DISPLAY'] = dsource[i].getCONJUNCTIVEOPERATOR() & " " & dsource[i].getONCOLUMN() & " " & dsource[i].getCONDITIONOPERATOR() & " " & dsource[i].getCOLUMNVALUE();

				ArrayAppend(resultArr,tmpresult);
			}

			rootstuct['totalCount'] = ArrayLen(dsource);
			rootstuct['topics'] = resultArr;
			return rootstuct;
        }
        catch(Any e)
        {
        	retStruct =StructNew();
			retStruct['err'] = e;
			return retStruct;
        }

	}


	public struct function getGroupBy(required string page, required string start, required string limit,
									required any sort, required any filter, required string querycode)
	ExtDirect="true"
	{
		try
        {
			rootstruct = StructNew();
			tmpresult = StructNew();
			resultArr = ArrayNew(1);

			dsource = EntityLoad("EGRGEVIEWGROUPBY",{EQRYCODEFK="#querycode#"}, "COLUMNORDER ASC");

			for(i=1; i<=ArrayLen(dsource); i++) {
				tmpresult = StructNew();
				tmpresult['EVIEWGROUPBYCODE'] 	= dsource[i].getEVIEWGROUPBYCODE();
				tmpresult['EQRYCODEFK'] 		= dsource[i].getEQRYCODEFK();
				tmpresult['GROUPBYCOLUMN'] 		= dsource[i].getGROUPBYCOLUMN();
				tmpresult['PRIORITYNO'] 		= dsource[i].getPRIORITYNO();
				tmpresult['COLUMNORDER'] 		= dsource[i].getCOLUMNORDER();
				ArrayAppend(resultArr,tmpresult);
			}

			rootstuct['totalCount'] = ArrayLen(dsource);
			rootstuct['topics'] = resultArr;
			return rootstuct;
        }
        catch(Any e)
        {
        	retStruct =StructNew();
			retStruct['err'] = e;
			return retStruct;
        }

	}


	public struct function getGroupByHaving(required string page, required string start, required string limit,
											required any sort, required any filter, required string querycode)
	ExtDirect="true"
	{
		try
        {
			rootstruct = StructNew();
			tmpresult = StructNew();
			resultArr = ArrayNew(1);

			dsource = EntityLoad("EGRGEVIEWHAVING",{EQRYCODEFK="#querycode#"}, "COLUMNORDER ASC");

			for(i=1; i<=ArrayLen(dsource); i++) {
				tmpresult = StructNew();
				tmpresult['EVIEWHAVINGCODE'] 	= dsource[i].getEVIEWHAVINGCODE();
				tmpresult['EQRYCODEFK'] 		= dsource[i].getEQRYCODEFK();
				tmpresult['CONJUNCTIVEOPERATOR']= dsource[i].getCONJUNCTIVEOPERATOR();
				tmpresult['AGGREGATECOLUMN'] 	= dsource[i].getAGGREGATECOLUMN();
				tmpresult['CONDITIONOPERATOR'] 	= dsource[i].getCONDITIONOPERATOR();
				tmpresult['AGGREGATEVALUE'] 	= dsource[i].getAGGREGATEVALUE();
				tmpresult['DISPLAY'] 			= dsource[i].getDISPLAY();
				tmpresult['COLUMNORDER'] 		= dsource[i].getCOLUMNORDER();
				ArrayAppend(resultArr,tmpresult);
			}

			rootstuct['totalCount'] = ArrayLen(dsource);
			rootstuct['topics'] = resultArr;
			return rootstuct;
        }
        catch(Any e)
        {
        	retStruct =StructNew();
			retStruct['err'] = e;
			return retStruct;
        }

	}


	public struct function getSelectedOrderBy(required string page, required string start, required string limit,
												required any sort, required any filter, required string querycode)
	ExtDirect="true"
	{
		try
        {

			rootstruct = StructNew();
			tmpresult = StructNew();
			resultArr = ArrayNew(1);

			dsource = EntityLoad("EGRGEVIEWORDERBY",{EQRYCODEFK="#querycode#"}, "COLUMNORDER ASC");

			for(i=1; i<=ArrayLen(dsource); i++) {
				tmpresult = StructNew();
				tmpresult['EVIEWORDERBYCODE'] = dsource[i].getEVIEWORDERBYCODE();
				tmpresult['EQRYCODEFK'] = dsource[i].getEQRYCODEFK();
				tmpresult['PRIORITYNO'] = dsource[i].getPRIORITYNO();
				tmpresult['FIELDNAME'] = dsource[i].getFIELDNAME();
				tmpresult['DISPLAY'] = dsource[i].getDISPLAY();
				tmpresult['ASCORDESC'] = dsource[i].getASCORDESC();
				tmpresult['COLUMNORDER'] = dsource[i].getCOLUMNORDER();
				ArrayAppend(resultArr,tmpresult);
			}

			rootstuct['totalCount'] = ArrayLen(dsource);
			rootstuct['topics'] = resultArr;
			return rootstuct;
        }
        catch(Any e)
        {
        	retStruct =StructNew();
			retStruct['err'] = e;
			return retStruct;
        }

	}


	public struct function getQuery(required string querycode)
	ExtDirect="true"
	{
		try {
			retStruct =StructNew();
			dsource = EntityLoad("EGRGQUERY", querycode, true);
			retStruct['qry'] = dsource.getEQRYBODY();
			return retStruct;
		} catch (Any e) {
			retStruct =StructNew();
			retStruct['err'] = e;
			return retStruct;
		}

	}

}
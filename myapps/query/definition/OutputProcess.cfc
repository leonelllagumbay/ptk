/**
 * Component that processes the output of the query!
 *
 * @author LEONELL
 * @date 4/6/15
 **/
component displayname="OutputProcess" ExtDirect="true" accessors=true output=false persistent=false {

	public struct function Create(Args) ExtDirect="true" {
		ret = StructNew();

		return ret;
	}

	public struct function Read(required string page,
								required string start,
								required string limit,
								required any sort,
								required any filter,
								required string querycode,
								required array extraparams) ExtDirect="true" {

		qryObj = Createobject("component", "IBOSE.application.GridQuery");
		dresult = qryObj.buildCondition(page, start, limit, sort, filter);


		WHERE = dresult['where'];
		ORDERBY = dresult['orderby'];

		// SELECT part > DISPLAY & FIELDALIAS
		selectArr = ArrayNew(1);
		columnStruct = StructNew();
		selectObj = EntityLoad("EGRGEVIEWFIELDS", {EQRYCODEFK = "#querycode#"}, false);
		for (a = 1; a <= ArrayLen(selectObj); a++) {
			if(trim(selectObj[a].getFIELDALIAS()) eq "") {
				ArrayAppend(selectArr, selectObj[a].getDISPLAY());
				columnStruct["#selectObj[a].getFIELDNAME()#"] = "#selectObj[a].getTABLENAME()##selectObj[a].getFIELDNAME()#";
			} else {
				ArrayAppend(selectArr, selectObj[a].getDISPLAY() & " AS '" & selectObj[a].getFIELDALIAS() & "'");
				columnStruct["#selectObj[a].getFIELDALIAS()#"] = "#selectObj[a].getTABLENAME()##selectObj[a].getFIELDNAME()#";
			}

		}
		selectStr = ArrayToList(selectArr, ", ");

		// FROM part
		fromArr = ArrayNew(1);
		fromObj = EntityLoad("EGRGEVIEWJOINEDTABLES", {EQRYCODEFK = "#querycode#"}, "COLUMNORDER ASC");
		if (ArrayLen(fromObj) > 0) {
			for (a = 1; a <= ArrayLen(fromObj); a++) {
				ArrayAppend(fromArr, fromObj[a].getDISPLAY());
			}
			fromStr = ArrayToList(fromArr, " ");
		} else {
			fromObj = EntityLoad("EGRGEVIEWTABLES", {EQRYCODEFK = "#querycode#"}, "COLUMNORDER ASC");
			for (a = 1; a <= ArrayLen(fromObj); a++) {
				ArrayAppend(fromArr, fromObj[a].getTEMPTABLE() & " " & fromObj[a].getTABLEALIAS());
			}
			fromStr = ArrayToList(fromArr, ", ");
		}


		// WHERE part
		whereArr = ArrayNew(1);
		whereObj = EntityLoad("EGRGEVIEWCONDITION", {EQRYCODEFK = "#querycode#"}, "COLUMNORDER ASC");
		for (a = 1; a <= ArrayLen(whereObj); a++) {
			ArrayAppend(whereArr, whereObj[a].getCONJUNCTIVEOPERATOR() & " " & whereObj[a].getONCOLUMN() & " " & whereObj[a].getCONDITIONOPERATOR() & " " & whereObj[a].getCOLUMNVALUE());
		}
		whereStr = ArrayToList(whereArr, " ");

		// GROUP BY part
		groupbyArr = ArrayNew(1);
		groupbyObj = EntityLoad("EGRGEVIEWGROUPBY", {EQRYCODEFK = "#querycode#"}, "COLUMNORDER ASC");
		for (a = 1; a <= ArrayLen(groupbyObj); a++) {
			ArrayAppend(groupbyArr, groupbyObj[a].getGROUPBYCOLUMN());
		}
		groupbyStr = ArrayToList(groupbyArr, ", ");

		// HAVING part
		havingArr = ArrayNew(1);
		havingObj = EntityLoad("EGRGEVIEWHAVING", {EQRYCODEFK = "#querycode#"}, "COLUMNORDER ASC");
		for (a = 1; a <= ArrayLen(havingObj); a++) {
			ArrayAppend(havingArr, havingObj[a].getDISPLAY());
		}
		havingStr = ArrayToList(havingArr, " ");

		// ORDER BY part
		orderbyArr = ArrayNew(1);
		orderbyObj = EntityLoad("EGRGEVIEWORDERBY", {EQRYCODEFK = "#querycode#"}, "COLUMNORDER ASC");
		for (a = 1; a <= ArrayLen(orderbyObj); a++) {
			ArrayAppend(orderbyArr, orderbyObj[a].getDISPLAY() & " " & orderbyObj[a].getASCORDESC());
		}
		orderbyStr = ArrayToList(orderbyArr, ", ");

		if(trim(selectStr) eq "") {
			selectStr = "SELECT * ";
		} else {
			selectStr = "SELECT " & selectStr;
		}

		if(trim(fromStr) eq "") {
			throw(message="Table not specified", detail="Table not specified");
		} else {
			fromStr = "FROM " & fromStr;
		}

		if(trim(whereStr) eq "") {
			whereStr = "";
		} else {
			whereStr = "WHERE " & whereStr;
		}

		if(trim(groupbyStr) eq "") {
			groupbyStr = "";
		} else {
			groupbyStr = "GROUP BY " & groupbyStr;
		}

		if(trim(havingStr) eq "") {
			havingStr = "";
		} else {
			havingStr = "HAVING " & havingStr;
		}

		if(trim(orderbyStr) eq "") {
			orderbyStr = "";
		} else {
			orderbyStr = "ORDER BY " & orderbyStr;
		}

		Usql = "#selectStr# #fromStr# #whereStr# #groupbyStr# #havingStr# #orderbyStr#";

		queryService = new query();
		queryService.setDatasource("#session.global_dsn#");
   		queryService.setName("DQUERY");
		queryService.setSQL(Usql);
		theResultSet = queryService.execute();
		dquery = theResultSet.getResult();

		resultArr = ArrayNew(1);
		rootstuct = StructNew();
	    rootstuct['totalCount'] = dquery.recordCount;

	    /*Creates an array of structure to be converted to JSON using serializeJSON*/
	    collistArr = dquery.getColumnList();
	    for (b = 1; b <= dquery.recordCount; b++) {
	    	tmpresult = StructNew();

     		for (c = 1; c <= ArrayLen(collistArr); c++) {
     			gridDataIndex = columnStruct['#collistArr[c]#'];
     			tmpresult["#gridDataIndex#"] = dquery["#collistArr[c]#"][b];
     		}
     		ArrayAppend(resultArr, tmpresult);
		}

	    rootstuct['topics'] = resultArr;
		return rootstuct;

	}

	public struct function Update(Args) ExtDirect="true" {
		ret = StructNew();
		return ret;
	}

	public struct function Destroy(Args) ExtDirect="true" {
		ret = StructNew();
		return ret;
	}

}
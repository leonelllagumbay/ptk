/**
 * Home
 *
 * @author LEONELL
 * @date 2/11/15
 **/
component name="Home" ExtDirect="true" accessors=true output=false persistent=false {
	public struct function getCompanyTpl(required string dcompanycode) ExtDirect="true"
	{
		tpldata = "";
		globalSettings = CreateObject("component","IBOSE.administrator.Settings");
		globalSettings.setGlobalSettings();
		if(trim(dcompanycode) eq "") {
			dcompanycode = session.companycode;
		}
		queryService = new query();
		queryService.addParam(name="companycode",value="#trim(dcompanycode)#",cfsqltype="cf_sql_varchar");
		Usql = "SELECT TEMPLATECODE, TEMPLATEDATACODE
		          FROM EGRGCOMPANYSETTINGS
		         WHERE COMPANYCODE = :companycode ";
		queryService.setDatasource("#session.global_dsn#");
   		queryService.setName("selectTPL");
   		queryService.setMaxrows(1);
		dquery = queryService.execute(sql=Usql);
		dqueryresultset = dquery.getResult();
		retStruct = StructNew();
		retArray = ArrayNew(1);

		if(dqueryresultset.recordcount > 0) {
			tpldata = dqueryresultset[ "TEMPLATEDATACODE" ][ 1 ];
			qryTpl = new query();
			qryTpl.addParam(name="tplcode",value="#dqueryresultset[ "TEMPLATECODE" ][ 1 ]#",cfsqltype="cf_sql_varchar");
			Usql = "SELECT TEMPLATEBODY
			          FROM EGRGTEMPLATE
			         WHERE TEMPLATECODE = :tplcode ";
			qryTpl.setDatasource("#session.global_dsn#");
	   		qryTpl.setName("selectTPL");
	   		qryTpl.setMaxrows(1);
			dquerytpl = qryTpl.execute(sql=Usql);
			tplResultSet = dquerytpl.getResult();
			newl = CreateObject("java", "java.lang.System").getProperty("line.separator");
			for(cnt=1; cnt<= ListLen(tplResultSet[ "TEMPLATEBODY" ][ 1 ],newl); cnt++) {
				thisRowList = ListGetAt(tplResultSet[ "TEMPLATEBODY" ][ 1 ], cnt, newl);
				ArrayAppend(retArray,thisRowList);
			}
		}

		retStruct['tplarray'] = retArray;
		retStruct['tpldatacode'] = tpldata;
		return retStruct;
	}

	public struct function getCompanyTplData(required string tpldatacode) ExtDirect="true"
	{
		retStruct = StructNew();

		qryTpl = new query();
		qryTpl.addParam(name="tpldcode",value="#tpldatacode#",cfsqltype="cf_sql_varchar");
		Usql = "SELECT TEMPLATEDATA
		          FROM EGRGTEMPLATEDATA
		         WHERE TPLDATACODE = :tpldcode ";
		qryTpl.setDatasource("#session.global_dsn#");
   		qryTpl.setName("selectTPL");
   		qryTpl.setMaxrows(1);
		dquerytpl = qryTpl.execute(sql=Usql);
		tplResultSet = dquerytpl.getResult();

		if(tplResultSet.recordcount > 0) {
			dtpldata = tplResultSet[ "TEMPLATEDATA" ][ 1 ];
			retStruct = Deserializejson(dtpldata);
			return retStruct;
		} else {
			retStruct['error'] = "No template data found.";
			return retStruct;
		}

	}
}
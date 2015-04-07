/**
 * Preview
 *
 * @author LEONELL
 * @date 3/31/15
 **/
component accessors=true output=false persistent=false ExtDirect="true" {
	public struct function getFormDefinition(required string querycode) ExtDirect="true" {

		var disquery = EntityLoad("EGRGQRYGRID",trim(querycode),true);
		var returnedStruct = StructNew();
		var outputtype = "";
		if(Isdefined("disquery")) {
			outputtype = disquery.getOUTPUTTYPE();

			if(outputtype == "grid") {
				var gridObject = CreateObject("component","Grid");
				returnedStruct = gridObject.getGridDefinition(querycode);
			} else if(outputtype == "chart") {
				var chartObject = CreateObject("component","Chart");
				returnedStruct = chartObject.getChartDefinition(querycode);
			} else if(outputtype == "html") {
				var htmlObject = CreateObject("component","Html");
				returnedStruct = htmlObject.getHtmlDefinition(querycode);
			} else if(outputtype == "tree") {
				var treeObject = CreateObject("component","Tree");
				returnedStruct = treeObject.getTreeDefinition(querycode);
			} else if(outputtype == "menu") {
				var menuObject = CreateObject("component","Menu");
				returnedStruct = menuObject.getMenuDefinition(querycode);
			} else if(outputtype == "rss2") {
				var rss2Object = CreateObject("component","Rss2");
				returnedStruct = rss2Object.getRss2Definition(querycode);
			} else if(outputtype == "figure") {
				var figureObject = CreateObject("component","Figure");
				returnedStruct = figureObject.getFigureDefinition(querycode);
			} else if(outputtype == "form") {
				var formObject = CreateObject("component","Form");
				returnedStruct = formObject.getFormDefinition(querycode);
			} else if(outputtype == "api") {
				var apiObject = CreateObject("component","Api");
				returnedStruct = apiObject.getApiDefinition(querycode);
			} else { // Defaults to grid
				var gridObject = CreateObject("component","Grid");
				returnedStruct = gridObject.getGridDefinition(querycode);
			}
		}
		return returnedStruct;
	}
}

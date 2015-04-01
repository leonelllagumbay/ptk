/**
 * Hint
 *
 * @author LEONELL
 * @date 3/31/15
 **/
component accessors=true output=false persistent=false ExtDirect="true"{
	public struct function runQuery() ExtDirect="true"{
		var ret = structNew();
		ret["success"] = "true";
		return ret;
	}
}
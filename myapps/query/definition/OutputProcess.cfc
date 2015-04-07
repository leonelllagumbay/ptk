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

	public struct function Read(Args) ExtDirect="true" {
		ret = StructNew();
		return ret;
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
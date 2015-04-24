component  implements="wwwroot.CFIDE.AIR.ISyncManager" extends="comp extends" displayname="comp display" hint="component hint" output="false"
{
	property name="propOne" type="boolean" displayname="prop one display" hint="prop one hint" default="default value";

	property name="prop 2" type="array" displayname="prop 2 disp" hint="prop 2 hint" default="prop 2 default";

	package boolean function getPropOne()
	{
		return propOne;
	}

	public void function setPropOne( required boolean argPropOne )
	{
		propOne = argPropOne;
	}

	public any function sync(required array operations,required array clientobjects, array originalobjects)
	{

	}
	private numeric function funcTest(required date arg1="2014-01-01",required boolean arg2="1")
	 displayname="func test display" description="f discription" hint="f hint" output="false" roles="admin" returnFormat="JSON" secureJSON="yes" verifyClient="yes"
	{

	}

}
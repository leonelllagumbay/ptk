component 
{
	property name="propOne" type="numeric" displayname="p one" default="leonell";

	property name="prop 2" type="uuid";

	package numeric function getPropOne()
	{
		return propOne;
	}

	remote void function setPropOne( required numeric argPropOne )
	{
		propOne = argPropOne;
	}

	package  function d(required array argName1="1",date arg2="2014-01-01")
	 displayname="dd" description="dd" hint="d"
	{

	}

}
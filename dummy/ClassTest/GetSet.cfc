component  output="true" 
{
	property name="name" type="string" displayname="name" default="Leonell";

	public string function getName()
	{
		return name;
	}

	public void function setName( required string argName )
	{
		name = argName;
	}

	public boolean function test(required array argOne)
	 displayname="test" description="Just a test" output="true" roles="admin" returnFormat="JSON" secureJSON="yes" verifyClient="yes"
	{

	}
	
	public any function init(String name)
	{
		this.setName(name);
		return this;
	}

}
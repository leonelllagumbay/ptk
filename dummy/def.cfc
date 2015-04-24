component  displayname="def disp" hint="hint sample" output="true"
{
	property name="favColor" type="string" displayname="favColor" hint="hint favorit color" default="green";

	public string function getFavColor()
	{
		return favColor;
	}

	public void function setFavColor( required string argFavColor )
	{
		favColor = argFavColor;
	}

	public string function leftleft()
	 displayname="sampleleft" description="a sample left function" hint="hint a sample left function" returnFormat="plain"
	{

	}

}
component  displayname="ClassTest" output="true"
{
	public string function count()
	{
		getmeObj = new GetSet(name="Leonell Adizas");
	//getmeObj.setName("Lagumbay");
	myname = getmeObj.getName();
	writeoutput(myname);
		return 'success';
	}
	
	public void function main(required string hello) {
		writeoutput('hello');
//		return 0;
	}
}
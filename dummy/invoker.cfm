<cfscript>
	res = left("leonell",3);
	res = CreateObject("component","def");
	//c = res.getFavColor();
	//writedump(c);
	
	testQ = CreateObject("component","query");
	testQ.setName('test');
	testQ.setDataSource('IBOSEDATA');
	testQ.setSql('SELECT * FROM EGINEFORMCOUNT');
	result = testQ.execute();  
	
	
	
	writedump(result.getResult());
	
	rset = result.getResult();
	for(cnt=1;cnt<=rset.recordcount;cnt++) 
	{  
		writeoutput(rset.EFORMID); 
		writeoutput("</br>");
	}
	
	abc = aaa();
	writeoutput(abc);
	
	public string function aaa()
	{
		return 'hi';	
	}
	
	
</cfscript>
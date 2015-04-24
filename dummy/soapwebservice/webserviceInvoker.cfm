<!---<cfinvoke  
webservice="http://localhost:8500/dummy/soapwebservice/Hello.cfc?wsdl" 
method="helloWorld" 
returnvariable="aTemp"> 

</cfinvoke> 
<cfoutput>#aTemp#</cfoutput>--->


<cfdump var="#cgi#" >
<!---<cfscript>
  wsURL = "http://localhost:8500/dummy/soapwebservice/Hello.cfc";
  ws = CreateObject("webservice", wsURL);
  //result = ws.helloWorld();
  //writeoutput(result);
  writeoutput("done");
</cfscript>--->

<!---<cfhttp 
url="http://localhost:8500/dummy/soapwebservice/Hello.cfc?wsdl"
method="GET" >--->

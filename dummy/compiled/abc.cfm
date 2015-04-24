<!---<cftry>--->
<!---<cffile 
action="read"
variable="Settings"
file="#expandpath('/globalsettings/globalsettings.cfm')#" 
charset="utf-8"
>--->

<cfscript>
	Settings = "";
	myfile="#expandpath('/globalsettings/globalsettings.cfm')#";
	fileObj = fileOpen( myfile, "read" );
	fileObj.charset = "utf-8";
	while( NOT fileIsEOF( fileObj ) ){ 
			Settings &= fileReadLine( fileObj ); 
	}
	fileClose( fileObj );
</cfscript>



<!---	<cfcatch type="any">
		<cfoutput>App config error: "Global settings are undefined!"</cfoutput>
		<cfabort>
	</cfcatch>
</cftry>--->

<cfset jsonStruct = DeSerializeJSON(Settings) >

<cfoutput>#jsonStruct.DATA[1]#</cfoutput></br>
<cfoutput>#jsonStruct.DATA[2]#</cfoutput></br>
<cfoutput>#jsonStruct.DATA[3]#</cfoutput></br>
<cfoutput>#jsonStruct.DATA[4]#</cfoutput></br>
<cfoutput>#jsonStruct.DATA[5]#</cfoutput></br>
<cfoutput>#jsonStruct.DATA[6]#</cfoutput></br>
<cfoutput>#jsonStruct.DATA[7]#</cfoutput></br>
<cfoutput>#jsonStruct.DATA[8]#</cfoutput></br>
<cfoutput>#jsonStruct.DATA[9]#</cfoutput></br>
<cfoutput>#jsonStruct.DATA[10]#</cfoutput></br>
<cfoutput>#jsonStruct.DATA[11]#</cfoutput></br>
<cfoutput>#jsonStruct.DATA[12]#</cfoutput></br>
<cfoutput>#jsonStruct.DATA[13]#</cfoutput></br>
<cfoutput>#jsonStruct.DATA[14]#</cfoutput></br>
<cfoutput>#jsonStruct.DATA[15]#</cfoutput></br>
<cfoutput>#jsonStruct.DATA[16]#</cfoutput></br>
<cfoutput>#jsonStruct.DATA[17]#</cfoutput></br>
<cfoutput>#jsonStruct.DATA[18]#</cfoutput></br>
<cfoutput>#jsonStruct.DATA[19]#</cfoutput></br>


<cfscript>
	GlobalSettings = CreateObject("component","IBOSE.administrator.Settings");
	GlobalSettings.setGlobalSettings();
</cfscript>


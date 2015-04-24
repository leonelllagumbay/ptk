<!---<cfquery name="insertCmfpa" datasource="FBC_CBOSE" >
		SELECT FIRSTNAME 
		FROM CMFPA
		WHERE FIRSTNAME LIKE '%_%'
		ORDER BY FIRSTNAME 
		LIMIT 900, 950
	</cfquery>
	
	<cfloop query = "insertCmfpa" >
		<cfquery name="insertCmfpaB" datasource="FBC_CBOSE" > 
			UPDATE CMFPA
			   SET POSITIONCODE = '#insertCmfpa.FIRSTNAME#P'
			 WHERE FIRSTNAME = '#insertCmfpa.FIRSTNAME#'
		</cfquery>
	</cfloop> --->


<cfset charArr = ArrayNew(1) >

<cfset charArr[1] = "A" >
<cfset charArr[2] = "B" >
<cfset charArr[3] = "C" >
<cfset charArr[4] = "D" >
<cfset charArr[5] = "E" >
<cfset charArr[6] = "F" >
<cfset charArr[7] = "G" >
<cfset charArr[8] = "H" >
<cfset charArr[9] = "I" >
<cfset charArr[10] = "J" >
<cfset charArr[11] = "K" >
<cfset charArr[12] = "L" >
<cfset charArr[13] = "M" >
<cfset charArr[14] = "N" >
<cfset charArr[15] = "O" >
<cfset charArr[16] = "P" >
<cfset charArr[17] = "Q" >
<cfset charArr[18] = "R" >
<cfset charArr[19] = "S" >
<cfset charArr[20] = "T" >
<cfset charArr[21] = "U" >
<cfset charArr[22] = "V" >
<cfset charArr[23] = "W" >
<cfset charArr[24] = "X" >
<cfset charArr[25] = "Y" >
<cfset charArr[26] = "Z" >
<cfset charArr[27] = "AA" >
<cfset charArr[28] = "BB" >

<cfloop from="1" to="27" index="N" >
<cfloop from="700" to="900" index="loopindex" >   
<!---<cftry>--->
	<cfset cntr = numberformat(loopindex, 000) >
	
	
	
	<cfquery name="insertCmfpa" datasource="FBC_CBOSE" >
		INSERT INTO CLKPOSITION (POSITIONCODE, DESCRIPTION)
		VALUES (
			'#charArr[N]#_#cntr#_FP',
			'#charArr[N]#_#cntr#_FP'
		)
	</CFQUERY>
	<cfquery name="insertCmfpa" datasource="FBC_CBOSE" >
		INSERT INTO CLKDEPARTMENT (DEPARTMENTCODE, DESCRIPTION)
		VALUES (
			'#charArr[N]#_#cntr#_D',
			'#charArr[N]#_#cntr#_D'
		)
	</CFQUERY>
	<!---<cfquery name="insertCmfpa" datasource="FBC_CBOSE" >
		INSERT INTO CMFPA ( GUID, 
							PERSONNELIDNO, 
							FIRSTNAME, 
							LASTNAME, 
							MIDDLENAME, 
							DEPARTMENTCODE, 
							SUPERIORCODE)
		      VALUES(		'#charArr[N]#_#cntr#_G',
			  			    '#charArr[N]#_#cntr#_P',
							'#charArr[N]#_#cntr#_F',
							'#charArr[N]#_#cntr#_L',
							'#charArr[N]#_#cntr#_M',
							'#charArr[N]#_#cntr#_D',
							'#charArr[N+1]#_#cntr#_P'
							)
		
	</cfquery>
	
	<cfquery name="insertcin21info" datasource="FBC_CBOSE" >
		INSERT INTO cin21personalinfo ( GUID, 
							PERSONNELIDNO, 
							EMAILADDRESS)
		      VALUES(		'#charArr[N]#_#cntr#_G',
			  			    '#charArr[N]#_#cntr#_P',
							'leonelllagumbay@gmail.com'
							)
		
	</cfquery>
	
	<cfquery name="insertegrgusermaster" datasource="IBOSEDATA" >
		INSERT INTO egrgusermaster ( USERID, 
							GUID, 
							USERTYPE,
							PROFILENAME
							)
		      VALUES(		'#charArr[N]#_#cntr#_U',
			  			    '#charArr[N]#_#cntr#_G',
							'CLSSC',
							'#charArr[N]#_#cntr#@gmail.com,leonelllagumbay@gmail.com'
							)
		
	</cfquery>
	
	<cfimage
	    action = "captcha"
	    height = "106"
	    text = "#charArr[N]#_#cntr#"
		width = "106"
	    destination = "#expandpath('../unDB/images/fbc/pics201/')##charArr[N]#_#cntr#.png"
	    difficulty = "low"
		fontSize = "14"
	    overwrite = "yes"> 
	
	<cfquery name="insertecrgmyibose" datasource="FBC_CBOSE" >
		INSERT INTO ecrgmyibose ( PERSONNELIDNO, 
							MYMESSAGE, 
							AVATAR
							)
		      VALUES(		'#charArr[N]#_#cntr#_P',
			  			    '#charArr[N]#_#cntr#',
							'#charArr[N]#_#cntr#.png'
							)
		
	</cfquery>
	
	<cftry>
	<cfquery name="egrgusergroups" datasource="IBOSEDATA" >
		INSERT INTO egrgusergroups ( USERGRPID, 
							DESCRIPTION
							)
		      VALUES(		'#charArr[N]#',
			  			    '#charArr[N]#_#cntr#'
							)
		
	</cfquery>
	<cfcatch>
	</cfcatch>
	</cftry>
	
	<cfquery name="egrgroleindex" datasource="IBOSEDATA" >
		INSERT INTO egrgroleindex ( USERGRPID_FK, 
							USERGRPMEMBERSIDX
							)
		      VALUES(		'#charArr[N]#',
			  			    '#charArr[N]#_#cntr#_U'
							)
		
	</cfquery>
	---> 
<!---	<cfcatch>
		<cfoutput>#cfcatch.detail# #cfcatch.message#</cfoutput>
		<cfcontinue>
	</cfcatch>
</cftry>--->
</cfloop>
</cfloop>
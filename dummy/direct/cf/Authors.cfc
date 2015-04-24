<cfcomponent name="Authors" ExtDirect="true">
	<cffunction name="GetAll" ExtDirect="true">
	  <cfset var q = "" />
	  
	  
	  <cfquery name="qryAuthors" datasource="cfbookclub">
	    SELECT AuthorID,
	           FirstName,
	           LastName
	      FROM Authors
	  ORDER BY AuthorID
	  </cfquery>

	<cfset ecounter = 1 >
	<cfset resultArr = ArrayNew(1) >
	
	<!---Creates an array of structure to be converted to JSON using serializeJSON--->
	<cfloop query="qryAuthors">
		<cfset tmpresult = StructNew()            > <!---Creates new structure in every loop to be added to the array--->
		<cfset tmpresult['AuthorID']  = AuthorID  >
		<cfset tmpresult['FirstName'] = FirstName >
		<cfset tmpresult['LastName']  = LastName  >
		<cfset resultArr[ecounter] = tmpresult    >
		<cfset ecounter = ecounter + 1            >
	</cfloop>
		   
	<cfreturn resultArr />
	</cffunction>
	
	<cffunction name="add" ExtDirect="true">
		
	    <cfset resultArr = ArrayNew(1) >
	
		<cfset tmpresult = StructNew() > 
		<cfset tmpresult['success']  = true  >
		
		<cfset dataIn = StructNew() >
		<cfset dataIn['Name'] = "Eric Lagumbay" >
		<cfset dataIn['Age'] = 25 >
		<cfset dataIn['Address'] = "Calingcaguing" >
		<cfset resultArr[1] = dataIn  >
		
		<cfset dataIn = StructNew() >
		<cfset dataIn['Name'] = "Nora Lagumbay" >
		<cfset dataIn['Age'] = 24 >
		<cfset dataIn['Address'] = "Makati" >
		<cfset resultArr[2] = dataIn  >
		
		<cfset tmpresult['data'] = resultArr >
		
		
		
	
		   
	<cfreturn tmpresult />
	</cffunction>
	
	<cffunction name="update" ExtDirect="true">
		<cfoutput>
			[{
				"success": true,
				"data": [{
					"Name": "leonell lagumbay",
					"Address": "far away"
				}]
			}]
		</cfoutput>
	</cffunction>
	
	<cffunction name="destroy" ExtDirect="true">
		<cfoutput>
			[{
				"success": true,
				"data": [{
					"Name": "leonell lagumbay",
					"Address": "far away"
				}]
			}]
		</cfoutput>
	</cffunction>
	
</cfcomponent>
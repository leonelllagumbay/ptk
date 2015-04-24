<cfcomponent name="Authors" ExtDirect="true">
	<cffunction name="GetAll" ExtDirect="true">
		<cfargument name="page" >
		<cfargument name="start" >
		<cfargument name="limit" >
		<cfargument name="sort" >
		<cfargument name="filter" >
		<cfargument name="group" >
			
			
	  <cfset var qryAuthors = "" /> 
	  
	  
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
		<cfset tmpresult['AuthorID']  = AuthorID  & ' ' & page & ' ' & start & ' ' & limit>
		<cfset tmpresult['FirstName'] = FirstName >
		<cfset tmpresult['LastName']  = LastName  >
		<cfset resultArr[ecounter] = tmpresult    >
		<cfset ecounter = ecounter + 1            >
	</cfloop>
		   
	<cfreturn resultArr />
	</cffunction>
	
	<cffunction name="add" ExtDirect="true">
		<cfargument name="names" >
		<cfargument name="lastname" >
	    <cfset resultArr = ArrayNew(1) >
	
		<cfset tmpresult = StructNew() > 
		<cfset tmpresult['success']  = true  >
		
		<cfset dataIn = StructNew() >
		<cfset dataIn['Name'] = "#names#" >
		<cfset dataIn['Age'] = 25 >
		<cfset dataIn['Address'] = "Calingcaguing" >
		<cfset resultArr[1] = dataIn  >
		
		<cfset dataIn = StructNew() >
		<cfset dataIn['Name'] = "#lastname#" >
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
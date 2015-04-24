<cfdirectory
	action="list" 
	directory="#expandpath('.')#"
	name="totalCFCs"
	filter=".cfc"
	recurse="false" 
/>

<cfloop query="totalCFCs" >
	
<cfset cfcName = ListFirst(totalCFCs, name, '.') />
<cfset newCFCComponents = GetComponentMetaData(cfcName) />

<cfif StructKeyExists(newCFCComponents, "ExtDirect")>
	<cfset CFCApi = ArrayNew(1) />
	
	<cfset fnlen = ArrayLen(newCFCComponent.Functions) />
	
	<cfloop from="1" to="#fnlen#" index="i" >
		<cfset currFn = newCFCComponent.Functions[i] />
		<!---Check to see if MetaData attribute ExtDirect exists --->
			
		<cfif StructKeyExists(currFn, "ExtDirect")	>
			<cfset Fn = StructNew() />
			<cfset Fn['name'] = currFn.Name />
			<cfset Fn['len'] = ArrayLen(currFn.Parameters) />
			<cfif StructKeyExists(currFn, "ExtFormHandler") >
				<cfset Fn['formhandler'] = true />
			</cfif>
			<cfset ArrayAppend(CFCApi, Fn) />
		</cfif>
	</cfloop>
	<cfset jsonPacket['actions'][cfcName] = CFCApi />
</cfif>


</cfloop>

<!---Output API Descriptor as JSON or Javascript--->

<cfset script = serializejson(jsonPacket) />
<cfif arguments.format eq "javascript" >
	<cfoutput>
		<cfsavecontent variable = "script" >
			Ext.ns('#arguments.ns#');#arguments.ns#.#desc#=#script#,
		</cfsavecontent>
	</cfoutput>
	
</cfif>


<!---Request could be an array--->
<!---<cfoutput>#script#</cfoutput>--->
<!---<cfreturn script>--->


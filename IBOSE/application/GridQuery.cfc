<cfcomponent displayname="GridQuery">
	<cffunction name="buildQuery" access="public" returntype="Any" >
		<cfargument name="page" >
		<cfargument name="start" >
		<cfargument name="limit" >
		<cfargument name="sort" >
		<cfargument name="filter" >

		<cfset retResult = StructNew() >
		<cfset where             = " (" >
        <cfset tmpdatafield      = "" >
        <cfset tmpfilteroperator = "0" >

		<cftry>

			<cfset filter = deserializejson(filter) >	<!---Deserialize JSON string coz Router forgets to do the work on filter but not on sort--->

			<cfloop array=#filter# index="filterdata">
	        	<cftry>
					<cfset filterdatafield = filterdata.field />
					<cfcatch>
						<cfbreak>
					</cfcatch>
				</cftry>

	        	<cfset filterdatafield = filterdata.field /> <!---ex L__TABLE__COLUMN : isrequired--->

	        	<cfif listLen(filterdatafield,"__") gt 1 >
					<cfset filterdatafieldtable = listgetat(filterdatafield,2,'__') >
					<cfset filterdatafieldcolumn = listgetat(filterdatafield,3,'__') >
					<cfset filterdatafield = "#filterdatafieldtable#.#filterdatafieldcolumn#" >
	        	</cfif>

				<cfset filtervalue     = filterdata.value />
				<cfset filtertype      = filterdata.type />
				<cfif tmpdatafield EQ "" >
	            <cfset tmpdatafield = filterdatafield >
	            <cfelseif tmpdatafield NEQ filterdatafield >
	            	<cfset where = "#where# ) AND ( " >
	            <cfelseif tmpdatafield EQ filterdatafield >
	            	<cfif tmpfilteroperator EQ 0>
	                	<cfset where = "#where# AND " >
	                <cfelse>
	                	<cfset where = "#where# OR " >
	                </cfif>
				</cfif>

	            <cfif ucase(filtertype) EQ "STRING" >
					<cfset where = "#where##filterdatafield#  LIKE '%#filtervalue#%'" >
				<cfelseif  ucase(filtertype) EQ "NUMERIC" >
					<cfset filtercondition = filterdata.comparison >
					<cfset expression = "#Ucase(Trim(filtercondition))#" >
	           			<cfif expression  EQ "LT">
						   	<cfset where = "#where##filterdatafield#  < #filtervalue#">
						<cfelseif expression EQ "GT">
							<cfset where = "#where##filterdatafield#  > #filtervalue#">
						<cfelseif expression EQ "EQ">
							<cfset where = "#where##filterdatafield#  = #filtervalue#">
						<cfelse>
					</cfif>
				<cfelseif  ucase(filtertype) EQ "DATE" >
					<cfset filtercondition = filterdata.comparison >
					<cfset expression = "#Ucase(Trim(filtercondition))#" >

						<cfset filtervalue = CreateODBCDateTime(filtervalue) />
	           			<cfif expression  EQ "LT">
	               			<cfset where = "#where##filterdatafield#  < #filtervalue#">
						<cfelseif expression EQ "GT">
							<cfset where = "#where##filterdatafield#  > #filtervalue#">
						<cfelseif expression EQ "EQ">
							<cfset where = "#where##filterdatafield#  = #filtervalue#">
						<cfelse>
							<cfset where = "#where##filterdatafield#  = #filtervalue#">
					    </cfif>
				<cfelse>
					<!---boolean--->
					<cfset where = "#where##filterdatafield#  LIKE '%#filtervalue#%'" >
				</cfif>
	            <cfset tmpdatafield      = filterdatafield >
			</cfloop>

        	<cfcatch>
				<!---Do nothing here since filter is not a valid JSON string--->
			</cfcatch>
        </cftry>

        <cfset where = "#where#)" >
		<cfset where = Replace(where, "''", "'" , "all") />

		<cfif trim(where) NEQ "()">
			<cfset theFilterCondition =  "AND #PreserveSingleQuotes(where)#" >
		<cfelse>
			<cfset theFilterCondition = "" >
		</cfif>


	  <!--- Order By Arguments/Contents --->
	  <cfset thecnt = 1 >
	  <cfloop array=#sort# index="sortdata">
	  	<cfif listLen(sortdata.property,"__") gt 1 >
			<cfset filterdatafieldtable = listgetat(sortdata.property,2, '__') >
		    <cfset filterdatafieldcolumn = listgetat(sortdata.property,3, '__') >
	  	    <cfset ORDERBY = "#filterdatafieldtable#.#filterdatafieldcolumn# #sortdata.direction#" >
    	<cfelse>
    		<cfset ORDERBY = "#sortdata.property# #sortdata.direction#" >
    	</cfif>
	  	  <cfif thecnt EQ ArrayLen(sort) >
		  <cfelse>
	  	  	<cfset ORDERBY = ORDERBY & ',' >
		  </cfif>
		  <cfset thecnt = thecnt + 1 >
	  </cfloop>
	  <!--- End Order By Arguments/Contents --->

	  <cfset retResult["where"] = where >
	  <cfset retResult["orderby"] = ORDERBY >

	  <cfreturn retResult >

	</cffunction>

	<cffunction name="buildCondition" access="public" returntype="struct" >
		<cfargument name="page" >
		<cfargument name="start" >
		<cfargument name="limit" >
		<cfargument name="sort" type="any">
		<cfargument name="filter" type="any">

		<cfset retResult = StructNew() >
 	    <cfset where             = " (" >
           <cfset tmpdatafield      = "" >
           <cfset tmpfilteroperator = "0" >

		<cftry>
		<cfset filter = deserializejson(filter) >	<!---Deserialize JSON string coz Router forgets to do the work on filter but not on sort--->
		<cfloop array=#filter# index="filterdata">
           	<cftry>
				<cfset filterdatafield = filterdata.field />
				<cfcatch>
					<cfbreak>
				</cfcatch>
			</cftry>

           	<cfset filterdatafield = filterdata.field />
			<cfset filterdatafield = replace(filterdatafield, "_", ".") >
			<cfset filtervalue     = filterdata.value />
			<cfset filtertype      = filterdata.type />
			<cfif tmpdatafield EQ "" >
               <cfset tmpdatafield = filterdatafield >
               <cfelseif tmpdatafield NEQ filterdatafield >
               	<cfset where = "#where# ) AND ( " >
               <cfelseif tmpdatafield EQ filterdatafield >
               	<cfif tmpfilteroperator EQ 0>
                   	<cfset where = "#where# AND " >
                   <cfelse>
                   	<cfset where = "#where# OR " >
                   </cfif>
			</cfif>

               <cfif ucase(filtertype) EQ "STRING" >
				<cfset where = "#where##filterdatafield#  LIKE '%#filtervalue#%'" >
			<cfelseif  ucase(filtertype) EQ "NUMERIC" >
				<cfset filtercondition = filterdata.comparison >
				<cfset expression = "#Ucase(Trim(filtercondition))#" >
              			<cfif expression  EQ "LT">
					   	<cfset where = "#where##filterdatafield#  < #filtervalue#">
					<cfelseif expression EQ "GT">
						<cfset where = "#where##filterdatafield#  > #filtervalue#">
					<cfelseif expression EQ "EQ">
						<cfset where = "#where##filterdatafield#  = #filtervalue#">
					<cfelse>
				</cfif>
			<cfelseif  ucase(filtertype) EQ "DATE" >
				<cfset filtercondition = filterdata.comparison >
				<cfset expression = "#Ucase(Trim(filtercondition))#" >

					<cfset filtervalue = CreateODBCDateTime(filtervalue) />
              			<cfif expression  EQ "LT">
               			<cfset where = "#where##filterdatafield#  < #filtervalue#">
					<cfelseif expression EQ "GT">
						<cfset where = "#where##filterdatafield#  > #filtervalue#">
					<cfelseif expression EQ "EQ">
						<cfset where = "#where##filterdatafield#  = #filtervalue#">
					<cfelse>
						<cfset where = "#where##filterdatafield#  = #filtervalue#">
				    </cfif>
			<cfelse>
				<!---boolean--->
				<cfset where = "#where##filterdatafield#  LIKE '%#filtervalue#%'" >
			</cfif>
               <cfset tmpdatafield      = filterdatafield >
		</cfloop>
           	<cfcatch>
				<!---Do nothing here since filter is not a valid JSON string--->
			</cfcatch>
           </cftry>

           <cfset where = "#where#)" >
		<cfset where = Replace(where, "''", "'" , "all") />

		<cfif trim(where) NEQ "()">
			<cfset WHERE =  "WHERE #PreserveSingleQuotes(where)#" >
		<cfelse>
			<cfset WHERE = "" >
		</cfif>

      <!--- Order By Arguments/Contents --->
	  <cfset thecnt = 1 >
	  <cfloop array=#sort# index="sortdata">
	  	  <cfset ORDERBY = "#replace(sortdata.property, '_', '.')# #sortdata.direction#" >
	  	  <cfif thecnt EQ ArrayLen(sort) >
		  <cfelse>
	  	  	<cfset ORDERBY = ORDERBY & ',' >
		  </cfif>
		  <cfset thecnt = thecnt + 1 >
	  </cfloop>
	  <!--- End Order By Arguments/Contents --->

	  <cfset retResult["where"] = WHERE >
	  <cfset retResult["orderby"] = ORDERBY >

	  <cfreturn retResult >

	</cffunction>
</cfcomponent>
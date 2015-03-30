<cfcomponent output="no" hint="DataFetcher" displayname="DataFetcher">

	<cffunction name="isGuidUsed" 
    			access="remote"   
                description="isGuidUsed" 
                hint="Check the passed Uid if already exit. Returns 1 - true, 0 - false"
                output="no"
                returntype="string"
                >
           <cfargument name="idtocheck" 
                       required="yes"
                       type="string"
                       >
           <cfargument name="datasource" 
                       required="yes"
                       type="string"
                       >
           <cfargument name="tablename"
                       required="yes"
                       type="string"
                       >
           <cfargument name="label" 
                       required="yes"
                       type="string"
                       >
          
                       
            <cfquery name="queryresult" datasource="#datasource#" maxrows="1">
              SELECT   *
                FROM #tablename#
                WHERE #label# = '#idtocheck#';
            </cfquery>
            
            <cfif queryresult.recordcount GT 0 >
            	<cfreturn 1 >
            <cfelse>
            	<cfreturn 0 >
            
            </cfif>
                       
                
                
    </cffunction>
    
    
    <cffunction name="generateid" 
    			access="remote" 
                description="generateid" 
                hint="Generate new guid or applicant id, using the passed id, returns new ID (GUID)"
                output="no"
                returntype="string"
                >
                
                <cfargument name="idtochange" 
                			required="yes" 
                            type="string">
                            
                
                         
                <cfset idnumpart   = right(idtochange, 7) />
                <cfset idadded     = val(idnumpart) + 1 />
                
				
				<cfset idnew       = replace(idtochange,idnumpart,idadded,"All")  >
                
                <cfinvoke method="isGuidUsed"
                          returnvariable="status"
                          idtocheck="#idnew#"
                          datasource="#session.company_dsn#"
                          tablename="CMFAP"
                          label="GUID"
                          >
                
                
                
                <cfloop condition = "status EQ 1">
                
                	<cfinvoke method="generateid"
                              returnvariable="idnew"
                              idtochange="#idnew#"
                              >
                              
                         
                </cfloop>
                
                <cfreturn #idnew# >
                           
    </cffunction>
    
    
    <cffunction name="generateidapp" 
    			access="remote" 
                description="generateidapp" 
                hint="Generate new guid or applicant id, using the passed id, returns new ID (APPLICANTNUMBER)"
                output="no"
                returntype="string"
                >
                
                <cfargument name="idtochange" 
                			required="yes" 
                            type="string">
                            
                
                         
                <cfset idnumpart   = right(idtochange, 7) />
                <cfset idadded     = val(idnumpart) + 1 />
                
				
				<cfset idnew       = replace(idtochange,idnumpart,idadded,"All")  >
                
                <cfinvoke method="isGuidUsed"
                          returnvariable="status"
                          idtocheck="#idnew#"
                          datasource="#session.company_dsn#"
                          tablename="CMFAP"
                          label="APPLICANTNUMBER"
                          >
                
               
                <cfloop condition = "status EQ 1">
                
                	<cfinvoke method="generateidapp"
                              returnvariable="idnew"
                              idtochange="#idnew#"
                              >
                              
                         
                </cfloop>
                
                <cfreturn #idnew# >
                
                           
    </cffunction>




</cfcomponent>
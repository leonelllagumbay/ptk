<cfcomponent name="Myibose" ExtDirect="true" >

<cffunction name="getMyibose" access="public" ExtDirect="true" >

		<cfset retStruct = StructNew() >
		<cfset retStruct["success"] = "true" >
		
		<cfset dataStruct = StructNew() >
		
		<cftry>
			
			<cfquery name="selectMyIbose" datasource="#session.global_dsn#" >
				SELECT PROFILENAME, DEFAULTAPPID
				  FROM EGRGUSERMASTER
			     WHERE GUID = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(session.guid)#">
			</cfquery>
			
			<cfloop query="selectMyIbose" >
				<cfset dataStruct["PROFILENAME"] = selectMyIbose.PROFILENAME >
				<cfset  dataStruct["DEFAULTAPPID"] = selectMyIbose.DEFAULTAPPID >
			</cfloop>
			
			
			<cfquery name="selectMyIbose2" datasource="#session.company_dsn#" >
				SELECT AVATAR, MYMESSAGE, SIGNATURE
				  FROM ECRGMYIBOSE
				 WHERE PERSONNELIDNO = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(session.chapa)#">
			</cfquery>
			
			<cfloop query="selectMyIbose2" >
				<cfset  dataStruct["AVATAR"] = selectMyIbose2.AVATAR >
				<cfset  dataStruct["AVATARDISPLAY"] = "<img src='../../resource/image/pics201/#lcase(session.companycode)#/#selectMyIbose2.AVATAR#' width='150' height='150'>" >
				<cfset  dataStruct["MYMESSAGE"] = selectMyIbose2.MYMESSAGE >
				<cfset  dataStruct["SIGNATURE"] = selectMyIbose2.SIGNATURE >
			</cfloop>
			
			<cfset retStruct["data"] = dataStruct >
			
			<cfreturn retStruct >
		<cfcatch type="any" >
			retStruct["Error"] = e.Detail;
			retStruct["success"] = "false";
			return retStruct;
		</cfcatch>
		</cftry>
</cffunction>
	
	
<cffunction name="submitMyibose" access="public" ExtDirect="true" ExtFormHandler="true">
	
	<cfset dfile = "no" >
	<cfset derror = "no" >
	<cftry>
			<cfset currentpwd = form.currentpassword >
			<cfset newpwd = form.newpassword >
			<cfset retypenewpwd = form.retypenewpassword >
			<cfif trim(currentpwd) neq "" >
				<cfset currentpwd = hash(currentpwd) >
				<cfinvoke method="updatePwd" >
			</cfif>
			<!---<cfthrow detail="Test error" message="Test message" />--->
			
			<cfif (trim(form.AVATAR) neq  "") >
				<cfset formDir = ExpandPath( "../../resource/image/pics201/#lcase(session.companycode)#/" ) >
				<cftry>
					<cfif Not directoryExists(formDir) >
			            <cfdirectory action="create" directory="#formDir#" mode="777" >  
			        </cfif> 
			    <cfcatch></cfcatch>
			    </cftry>
			    
			    <cftry>
				    <cffile
						action="upload"
						destination="#formDir#"
						filefield="AVATAR"
						nameconflict="overwrite" 
						mode="777"
					/> 
				<cfcatch>
					<cfset derror = "yes" >
				</cfcatch>
			    </cftry>
				<cfset dfile = "yes" >
				<cfset retStruct["data"] = "#cffile.serverfile#" >
				
			<cfelse>
				<cfset dfile = "no" >
			</cfif>
			
			<cfif derror eq "no" >
				<cfquery name="updateMyIbose" datasource="#session.global_dsn#" >
					UPDATE EGRGUSERMASTER
				        SET PROFILENAME = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.PROFILENAME#">,
				            DEFAULTAPPID = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.DEFAULTAPPID#">
				      WHERE GUID = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(session.guid)#">
				</cfquery>
				
				<cfquery name="updateMyIbose2" datasource="#session.company_dsn#" maxrows="1">
					SELECT AVATAR, MYMESSAGE
					  FROM ECRGMYIBOSE
					 WHERE PERSONNELIDNO = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(session.chapa)#">
				</cfquery>
				
				<cfquery name="updateMyIbose" datasource="#session.company_dsn#" >
					UPDATE ECRGMYIBOSE
				        SET 
				            <cfif(dfile eq "yes") >
				        		AVATAR = <cfqueryparam cfsqltype="cf_sql_varchar" value="#cffile.serverfile#">,
				            </cfif>
				            MYMESSAGE = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.MYMESSAGE#">,
				            SIGNATURE = <cfqueryparam cfsqltype="cf_sql_varchar" value="#form.SIGNATURE#">
				      WHERE PERSONNELIDNO = <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(session.chapa)#">
				</cfquery>
				
				<cfset session.mymessage = form.MYMESSAGE >
				<cfset session.profilename = form.PROFILENAME >
				<cfset session.defaultuserapp = form.DEFAULTAPPID >
				<cfset session.mycurrentapp = form.DEFAULTAPPID >
				
				<cfif dfile eq "yes" >
					<cfset session.avatar = cffile.serverfile >
					<cfloop query="updateMyIbose2" >
						<cffile
							action="delete" 
							file="#formDir##updateMyIbose2.AVATAR#" 
						/> 
					</cfloop>
				</cfif>
				
				
				<cfset retStruct = StructNew() >
				<cfset retStruct["success"] = "true" >
				<cfset retStruct["data"] = "#session.chapa#" >
				<cfreturn retStruct >
			<cfelse>
				<cfset retStruct = StructNew() >
				<cfset retStruct["Error"] = "There is a problem uploading the file..." >
				<cfset retStruct["success"] = "false" >
				<cfreturn retStruct >
			</cfif>
			
			
			
			
		<cfcatch type="any" >
				<cfset retStruct = StructNew() >
				<cfset retStruct["detail"] = cfcatch.detail >
				<cfset retStruct["success"] = "false" >
				<cfreturn retStruct >
		</cfcatch>
	</cftry>
</cffunction>


<cffunction name="updatePwd" access="private" returntype="void" >
	<cfquery name="qryMyPassword" datasource="#session.global_dsn#">
		SELECT USERID, PASSWORD
		  FROM EGRGUSERMASTER
		 WHERE PASSWORD = '#currentpwd#' AND USERID = '#session.userid#';
	</cfquery>
	
	<cfif qryMyPassword.RecordCount gt 0 >
		<cfscript>
			try
		    {
		    	theOldHashedPassword = currentpwd;
				theUsername = session.userid;
				thePassword = newpwd;
				theConfirmPassword = retypenewpwd;
				if (thePassword == theConfirmPassword) {
					theRes = StructNew();
					authObj = CreateObject("component","IBOSE.login.userauthentication");
					theRes = authObj.changeUserPwdNative(theOldHashedPassword,theUsername,thePassword);
					if(theRes["message"] == "true") {
						WriteOutput("success");
					} else {
						//WriteOutput(theRes["message"]);
						throw (detail='#theRes["message"]#');
					}
				} else {
					throw (detail="Password confirmation is incorrect.");
				}
		    }
		    catch(Any e)
		    {
		    	throw (detail="#e.detail#");
		    }
		</cfscript>
	<cfelse>
		<cfthrow detail="Invalid current password." />
	</cfif>

	
</cffunction>


</cfcomponent>
<html>
<head>
    <title>iBOS/e Clearance Accountability Form</title>  
	<style type="text/css">
		.field-margin {
			margin: 5px;
		}
	</style>


</head>
<body>


<cfif isdefined("form.submitme") >
		
		<cfquery name="getPostcode" datasource="IBOSE_GLOBAL" maxrows="1">
			SELECT POSTCODE
		      FROM EGINCLREMAIL
		     WHERE IDFK = '#trim(form.referencenumber)#' AND POSTCODE = '#form.postemp#' AND EMAILADDRESS = '#trim(form.theemail)#'; 
		</cfquery>
		
		<cfif getPostcode.recordcount GT 0 >
			<cfset thectr = 1 >
			
			<!---notify post employment team also--->
			<cfquery name="getEmailClr" datasource="IBOSE_GLOBAL">
				SELECT EMAILADDRESS
			      FROM EGLKCLRDEPT
			     WHERE THEGROUP = 'POSTEMPLOYMENT';
			</cfquery>
			
			<cfloop list="#trim(form.dataindexsuffix)#" index="mysuffix" delimiters="," >
				
				<cfset remarks = listgetat(trim(form.remarks), thectr) >
				<cfset details = listgetat(trim(form.details), thectr) >
				
				<cfquery name="updateclrmntrng"  datasource="IBOSE_GLOBAL" >
					UPDATE EGINCLRMAIN
					   SET DATEREPLIED#mysuffix# = <cfqueryparam cfsqltype="cf_sql_date" value="#dateformat(now(), 'YYYY-MM-DD')#" >,
					       REMARKS#mysuffix# = <cfqueryparam cfsqltype="cf_sql_varchar" value="#remarks#" >,
						   DETAIL#mysuffix# = <cfqueryparam cfsqltype="cf_sql_varchar" value="#details#" >
					 WHERE ID = '#trim(form.referencenumber)#'
				</cfquery>	
				<cfset thectr = thectr + 1 >
				
				<cfquery name="qryClearingDeptQuick" datasource="IBOSE_GLOBAL" maxrows="1" >
					SELECT CLEARINGDEPT
				      FROM EGLKCLRDEPT
				     WHERE DATAINDEXSUFFIX = '#mysuffix#';
				</cfquery>
				
				<cfif qryClearingDeptQuick.recordcount GT 0 >
					<cfset clrdept = qryClearingDeptQuick.CLEARINGDEPT >
				<cfelse>
					<cfset clrdept = "#mysuffix#">
				</cfif>
				
				<cfset clrto = "">
				<cfset crlfrom = "#mysuffix#" >
				<cfset crlsubject = "Response from Clearing Department: #clrdept#" >
				<cfset crlbody = "<h2>Clearing Department: #clrdept#</h2><h2>Date Replied: #dateformat(now(), 'MM/DD/YYYY')#</h2><h3>Remarks: #remarks#</h3><h3>Details: #details#</h3>" >
				
				<cfset icnt = 1>
				<cfloop query="getEmailClr">
					<cfset clrto = clrto & ' ' & EMAILADDRESS >
					
					<cfif icnt NEQ getEmailClr.recordcount>
						<cfset clrto = clrto & ",">
					</cfif>
					
				</cfloop>
				
				<cfmail
						from="#clrdept#"
						to="#clrto#"
						subject="#crlsubject#"
						type="html"
				>
				 <cfoutput>#crlbody#</cfoutput>
				</cfmail>
				
			</cfloop>
			
			
			<cfoutput><h1>Process completed successfully.</h1></cfoutput>
		<cfelse>
			<cfoutput><h1>Post Employment code did not match. Please refresh the page to continue...</h1></cfoutput>	
		</cfif>
		
		
<cfelse>	
	


<cfif not isdefined("url.id") OR not isdefined("url.email") OR not isdefined("url.group") >
	<cfwindow 
    center="true" 
    closable="true" 
    destroyOnClose ="true" 
    draggable="true" 
    height="400" 
    initShow="true"
    modal="true" 
    name="accountabilitywindows" 
    title="Accountability" 
    width="600" 
		  >
		  <h2 align="center">Either the reference number or the email is missing. Please contact the Post Employment Team for immediate action.</h2>
	</cfwindow>
	
</cfif>
	
<cfwindow 
    center="true" 
    closable="true" 
    destroyOnClose ="true" 
    draggable="true" 
    height="400" 
    initShow="true"
    modal="true" 
    name="accountabilitywindow" 
    title="Accountability Form" 
    width="600" 
		  > 
    <cfform name="accountability" action="./" method="POST" >
		
		
	
		<cfquery name="qryClearingDepartment" datasource="IBOSE_GLOBAL" >
			SELECT ID, CLEARINGDEPT, THEGROUP, OWNER, EMAILADDRESS, DATAINDEXSUFFIX
		      FROM EGLKCLRDEPT
		     WHERE THEGROUP = '#trim(url.group)#' AND EMAILADDRESS = '#trim(url.email)#';
		</cfquery>
    <cfset countr = 0 >
	<cfloop query="qryClearingDepartment">
		<h2 align="left"><cfoutput>#CLEARINGDEPT#</cfoutput></h2>
		<p>
		<span style="margin: 10px;">	
		<label for="remarksidid<cfoutput>#countr#</cfoutput>">Remark</label>
		<select placeholder="Remark" name="remarks" id="remarksidid<cfoutput>#countr#</cfoutput>" style="height: 30px; width: 150px">
			<option>No Accountability</option>
			<option>With Accountability</option>
		</select>
		</span>
		
		<span style="margin: 10px;">	
		<label for="detailsidid<cfoutput>#countr#</cfoutput>">Details</label>
		<input placeholder="Details" type="text" name="details" id="detailsidid<cfoutput>#countr#</cfoutput>" style="width: 300px; height: 30px" maxlength="100">
		</span>
		</p>
		
		<input type="hidden" name="dataindexsuffix" value="<cfoutput>#DATAINDEXSUFFIX#</cfoutput>" >
		<cfset countr = countr + 1 >
		<hr />
	</cfloop> 
	<br />
	<label for="postidid">Post Employment Code:</label>
	<input type="password" name="postemp" id="postidid" style="height: 30px" maxlength="100">
	<input type="hidden" name="referencenumber" value="<cfoutput>#trim(url.id)#</cfoutput>" >
	<input type="hidden" name="thegroup" value="<cfoutput>#trim(url.group)#</cfoutput>" >
	<input type="hidden" name="theemail" value="<cfoutput>#trim(url.email)#</cfoutput>" >
	
    <p style="align: center;"> <input type="submit" name="submitme" value="Submit" > </p>
	
	</cfform>
  	

</cfwindow>
	
</cfif>

   
</body>
</html>

<cfsetting showdebugoutput="false" >  
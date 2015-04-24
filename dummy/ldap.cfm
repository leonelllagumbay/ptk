<!--- <cftry>
<cfldap action="query"
		start="CN=partition1,DC=localhost,DC=com"
	    attributes="CN,uid"
	    server="localhost"
		port="389"
		name="testa"
		username="ADMIN"
	    password="leonell"

	 >

	 <cfdump var="#testa.recordcount#" >
	 <cfcatch type="any">
		 <cfdump var="#cfcatch.detail#" >
		 <cfoutput>Invalid user name or password</cfoutput>
	 </cfcatch>
</cftry> --->
e
<cfscript>
	                    myldap = new ldap();
						myldap.setServer("localhost");
						myldap.setPort("389");
						myldap.setLdapAttributes("CN,uid");
						myldap.setUsername("ADMIN");
						myldap.setPassword("leonell");
						result = myldap.query(start="CN=partition1,DC=localhost,DC=com");
						writedump(result);

						lojb = CreateObject("component","IBOSE.login.Helper");
						ldapAtt = lojb.getLDAPAttributes("ADMINs");
						writedump(ldapAtt);
						if(ldapAtt["LDAPSERVER"] == "false") throw (message="Requires a valid ldap user!");
						myldap = new ldap();
						myldap.setServer(ldapAtt["LDAPSERVER"]);
						myldap.setPort(ldapAtt["LDAPPORT"]);
						myldap.setLdapAttributes(ldapAtt["LDAPATTRIBUTES"]);
						myldap.setUsername(form.username);
						myldap.setPassword(form.password);
						result = myldap.query(start="#ldapAtt['LDAPSTART']#");

						if(result.recordcount gt 0) {
						    lojb.getUser();
						    theUsername = form.username;
						    thePassword = form.password;
						    validationResult = authObj.validateUserNative(theUsername,thePassword);
						} else {
						    throw (message="Requires a valid ldap user!");
						}
</cfscript>
b

<!--- username="CN=Daniel,CN=Users,CN=partition1,DC=localhost,DC=com" --->
<!--- 	 <cfldap action="query"
		start="ou=system"
	    attributes="CN,ou"
	    server="localhost"
		port="389"
		name="test"
		username="uid=daniel+cn=Daniel+sn=Lagumbay,ou=system"
	    password="daniel"


	 >

	 <cfdump var="#test#" > --->




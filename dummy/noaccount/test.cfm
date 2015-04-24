<p>Hello Leonell</p>
<cfscript>
	session.global_dsn = 'IBOSE_GLOBAL';
	authObj = CreateObject("component","IBOSE.login.userauthentication");
	a = authObj.setupCompanySettings('FBC');
	WriteDump(a);
</cfscript>
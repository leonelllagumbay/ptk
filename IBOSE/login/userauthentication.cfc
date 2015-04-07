component  displayname="userauthentication" hint="Handles all the user authentication"
{
	public string function authType()
	{
		if (isdefined("form.authtype"))
		{
			return form.authtype;
		} else
		{
			return 'native';
		}

	}

	public struct function changeUserPwdNative(required string theoldhashedpassword,required string theusername, required string thepassword) {
		retStruct = StructNew();
		validationObj = CreateObject("component","IBOSE.login.Validation");
		var Tresult = validationObj.validatePassword(thepassword,theusername,theoldhashedpassword);
		if(Tresult == "true") {
			queryService = new query();
			queryService.addParam(name="newpwd",value="#Ucase(thepassword)#",cfsqltype="cf_sql_varchar");
			queryService.addParam(name="uname",value="#theusername#",cfsqltype="cf_sql_varchar");
			queryService.addParam(name="oldhashedpwd",value="#trim(theoldhashedpassword)#",cfsqltype="cf_sql_varchar");
			dateNow = dateformat(now(), "YYYY-MM-DD");
			timeNow = timeformat(now(), "HH:MM:SS");
			queryService.addParam(name="cdate",value="#dateNow# #timeNow#",cfsqltype="cf_sql_timestamp");
			Usql = "UPDATE EGRGUSERMASTER
			              SET PASSWORD = :newpwd,
			                  DATEPASSWORD = :cdate,
			                  CHANGEPWDNEXTLOGON = 'false'
			            WHERE PASSWORD = :oldhashedpwd AND USERID = :uname";
			queryService.setDatasource("#session.global_dsn#");
    		queryService.setName("updatep");
			queryService.execute(sql=Usql);
			validationObj.updatePwdHistory(theusername,Ucase(thepassword));
			retStruct["message"] = "true";
			return retStruct;
		} else {
			retStruct["message"] = Tresult;
			return retStruct;
		}
	}


	public struct function validateUserNative(required string theusername, required string thepassword)
	hint="check if the user is a valid user"
	{
		retStruct = StructNew();
		GlobalSettings = CreateObject("component","IBOSE.administrator.Settings");
		GlobalSettings.setGlobalSettings();

		retMsg = "<b style='color: red;'>Invalid username or password. <br>Please try again.<br><a href='./?forgot=yes'>Forgot password?</a>";
		thesql = "SELECT DISABLEACCOUNT,
						 USERID,
						 CHANGEPWDNEXTLOGON,
						 GUID,
						 USERTYPE,
						 PROFILENAME,
						 LOGINCOUNTER,
						 DEFAULTAPPID,
						 DISABLEACCOUNT,
						 DATEPASSWORD,
						 MAXPASSWORDAGE,
						 PWDNEVEREXPIRES,
						 ACCOUNTLOCKOUTDURATION,
						 ACCOUNTLOCKOUTTHRESHHOLD,
						 RESETACCOUNTLOCKOUTCOUNTERAFTER,
						 PWDCOUNTFAILEDATTEMPT,
						 DATELASTFAILEDATTEMPT
					FROM EGRGUSERMASTER
				   WHERE
						(USERID   = '#Ucase(theusername)#') AND
						(PASSWORD = '#Ucase(thepassword)#')";
		CheckedUser = executeQuery("CheckUser","#session.global_dsn#",thesql);

		if(CheckedUser.recordcount > 0) //user has initially valid login
		{
			//check if the account has been disabled
			for(cnt=1;cnt<=CheckedUser.recordcount;cnt++)
			{
				if(CheckedUser[ "DISABLEACCOUNT" ][ cnt ] == 'N')
				{
					retMsg = "true";

					// check if account was locked out when username & password is correct
					vObj = CreateObject("component","IBOSE.login.Validation");
					Lresult = StructNew();
					Lresult = vObj.checkAccountLockout(CheckedUser, theusername,thepassword);
					if(Lresult['message'] == "accountlockedout") {
						return Lresult;
					}
					// end check account lockout

					setSessionVariables = setSessionVars(CheckedUser);
					session.defaultuserapp = CheckedUser.DEFAULTAPPID; //especially used on after successful login
					if(CheckedUser.CHANGEPWDNEXTLOGON == 'true') {
						retMsg = "changepassword";
					}
					if(CheckedUser.PWDNEVEREXPIRES != true) {
						validationObj = CreateObject("component","IBOSE.login.Validation");
						cresult = validationObj.checkIfPwdIsExpired(CheckedUser.MAXPASSWORDAGE,CheckedUser.DATEPASSWORD);
						if(cresult == -1) {
							retMsg = "passwordisexpired";
						}
					}

				} else
				{
					retMsg = "<b style='color: red;'>Your account has been disabled.<br>Please notify your system administrator.</b>";
				}
			}
		} else
		{
			//invalid username or password
			thesql = "SELECT ACCOUNTLOCKOUTDURATION,
							 ACCOUNTLOCKOUTTHRESHHOLD,
							 RESETACCOUNTLOCKOUTCOUNTERAFTER,
							 PWDCOUNTFAILEDATTEMPT,
							 DATELASTFAILEDATTEMPT
						FROM EGRGUSERMASTER
					   WHERE
							USERID   = '#ucase(theusername)#'";
			CheckedUserOR = executeQuery("CheckUser","#session.global_dsn#",thesql);

			// check if account was locked out when username & password is incorrect
			vObj = CreateObject("component","IBOSE.login.Validation");
			Lresult = StructNew();
			Lresult = vObj.checkAccountLockout(CheckedUserOR, theusername,thepassword);
			return Lresult;
		}
		retStruct["message"] = retMsg;
		return retStruct;
	}

	public query function executeQuery(required string thename,required string thedatasource,required string thesql,string password,string blockfactor,string dbtype,string result,string cachedafter,string debug,string timeout,string cachedwithin,string maxrows,string username)
	{
		qry = CreateObject("component","query");
		qry.setName(thename);
		qry.setDatasource(thedatasource);
		qry.setSql(thesql);
		theResultSet = qry.execute();
		return theResultSet.getResult();
	}

	public string function setSessionVars(required query CheckedUser)
	{
		session.userid = "NoUserID";
		session.guid = "NoGuid";
		guid = "NoGuid";
		session.usertype = "NoUserType";
		usertype = "NoUserType";
		session.profilename = "NoProfileName@gmail.com";
		//session.logincounter = "NoLoginCounter";
		for(cntr=1;cntr<=CheckedUser.recordcount;cntr++)
		{
			//client variables will be replaced by session variables
			session.userid = CheckedUser[ "USERID" ][ cntr ];
			session.guid = CheckedUser[ "GUID" ][ cntr ];
			guid = CheckedUser[ "GUID" ][ cntr ];
			session.usertype = CheckedUser[ "USERTYPE" ][ cntr ];
			usertype = CheckedUser[ "USERTYPE" ][ cntr ];
			session.profilename = CheckedUser[ "PROFILENAME" ][ cntr ];
			//session.logincounter = CheckedUser[ "LOGINCOUNTER" ][ cntr ];

			thesql = "SELECT GUID,
							 SALUTATION,
							 FIRSTNAME,
							 MIDDLENAME,
							 LASTNAME,
							 NICKNAME,
							 SUFFIX,
							 COMPANYCODE,
							 SUBCOMPANYCODE
						FROM GMFPEOPLE
					   WHERE (GUID   = '#CheckedUser[ "GUID" ][ cntr ]#')";
					   //GUID is required to be unique and does exist
			qryGMFPEOPLE = executeQuery("qryGMFPEOPLE","#session.global_dsn#",thesql);

			session.SALUTATION = "NoSalutation";
			session.suffix = "NoSuffix";
			session.firstname = "NoFirstName";
			session.lastname = "NoLastName";
			session.middlename = "NoMiddleName";
			session.myname = "NoFullName";
			session.companycode = "NoCompanyCode";
			companycode = "NoCompanyCode";
			session.subcompany_code = "NoSubCompanyCode";

			for(cntg=1;cntg<=qryGMFPEOPLE.recordcount;cntg++)
			{
				session.SALUTATION = qryGMFPEOPLE[ "SALUTATION" ][ cntg ];
				session.suffix = qryGMFPEOPLE[ "SUFFIX" ][ cntg ];
				session.firstname = qryGMFPEOPLE[ "FIRSTNAME" ][ cntg ];
				session.lastname = qryGMFPEOPLE[ "LASTNAME" ][ cntg ];
				session.middlename = qryGMFPEOPLE[ "MIDDLENAME" ][ cntg ];
				session.myname = qryGMFPEOPLE[ "SALUTATION" ][ cntg ] & ' ' & qryGMFPEOPLE[ "LASTNAME" ][ cntg ] & ', ' & qryGMFPEOPLE[ "FIRSTNAME" ][ cntg ] & ' ' & qryGMFPEOPLE[ "MIDDLENAME" ][ cntg ];
				session.companycode = qryGMFPEOPLE[ "COMPANYCODE" ][ cntg ];
				companycode = qryGMFPEOPLE[ "COMPANYCODE" ][ cntg ];
				session.subcompany_code = qryGMFPEOPLE[ "SUBCOMPANYCODE" ][ cntg ];

			}

			setupCompanySettings(session.companycode);

			thesqC = "SELECT MAINTABLE,MAINKEY
						 FROM CLKUSERTYPE
					    WHERE (USERTYPE   = '#usertype#')";
			qryCLKUSERTYPE = executeQuery("qryCLKUSERTYPE","#companydsn#",thesqC);

			session.maintable = "NoMainTable";
			maintable = "NoMainTable";
			session.mainpk = "NoMainPK";
			mainpk = "NoMainPK";

			for(cnt=1;cnt<=qryCLKUSERTYPE.recordcount;cnt++)
			{
				session.maintable = qryCLKUSERTYPE[ "MAINTABLE" ][ cnt ];
				session.mainpk = qryCLKUSERTYPE[ "MAINKEY" ][ cnt ];
				mainpk = qryCLKUSERTYPE[ "MAINKEY" ][ cnt ];
				maintable = qryCLKUSERTYPE[ "MAINTABLE" ][ cnt ];
			}


			thesqD = "SELECT A.#mainpk# AS PID,
							 B.MYTHEME AS MYTHEME,
							 B.MYMESSAGE AS MYMESSAGE,
							 B.DEFAULTTHEME AS DEFAULTTHEME,
							 B.AVATAR AS AVATAR
						FROM #maintable# A LEFT JOIN ECRGMYIBOSE B ON (A.#mainpk# = B.PERSONNELIDNO)
					   WHERE (A.GUID   = '#guid#')";
			qryMAINTABLE = executeQuery("qryMAINTABLE","#companydsn#",thesqD);

			session.chapa = "NoPID";
			session.mytheme = "NoTheme";
			session.mymessage = "";
			session.defaulttheme =  "NoDefaultTheme";
			session.avatar = "NoAvatar";

			for(cnt=1;cnt<=qryMAINTABLE.recordcount;cnt++)
			{
				session.chapa = qryMAINTABLE[ "PID" ][ cnt ];
				session.mytheme = qryMAINTABLE[ "MYTHEME" ][ cnt ];
				session.mymessage = qryMAINTABLE[ "MYMESSAGE" ][ cnt ];
				session.defaulttheme = qryMAINTABLE[ "DEFAULTTHEME" ][ cnt ];
				session.avatar = qryMAINTABLE[ "AVATAR" ][ cnt ];
			}

			session.icon_path = "./resource/image/companylogo/";
			session.common_path  = "#root_undb#common/";
			session.image_path = "#root_undb#images/#lcase(session.companycode)#";
			session.imagepath = "#root_undb#forms/";
			root_path = "./";
			session.root_path = "#root_path#";
			session.theme_path = "#root_path#templates/themes/";
			session.wstheme_path = "#root_path#webshell/themes/";
			session.ek = "D!ginf0001";


			//insert user connection
			dateNow = dateformat(now(), "YYYY-MM-DD");
			timeNow = timeformat(now(), "HH:MM:SS");
			queryService = new query();

			queryService.addParam(name="cdate",value="#dateNow#",cfsqltype="cf_sql_date");
			queryService.addParam(name="ctime",value="#timeNow#",cfsqltype="cf_sql_varchar");
			queryService.addParam(name="uuid",value="#CreateUUID()#",cfsqltype="cf_sql_varchar");
			queryService.addParam(name="logtype",value="IN",cfsqltype="cf_sql_varchar");
			queryService.addParam(name="useridd",value="#session.USERID#",cfsqltype="cf_sql_varchar");
			queryService.addParam(name="remoteadd",value="#cgi.REMOTE_ADDR#",cfsqltype="cf_sql_varchar");
			queryService.addParam(name="gguuiidd",value="#session.GUID#",cfsqltype="cf_sql_varchar");
			queryService.addParam(name="ccfid",value="#session.CFID#",cfsqltype="cf_sql_varchar");
			queryService.addParam(name="ccftoken",value="#session.CFTOKEN#",cfsqltype="cf_sql_varchar");

			thesqlI = "INSERT INTO EGRGUSERCONNECTION (CONNECTIONDATE,
													   CONNECTIONTIME,
													   CONNECTIONID,
													   USERACCT,
													   IPADDRESS,
													   GUID,
													   USERID,
													   CFID,
													   CFTOKEN
													)
						VALUES (:cdate,
								:ctime,
								:uuid,
								:logtype,
								:remoteadd,
								:gguuiidd,
								:useridd,
								:ccfid,
								:ccftoken
						 )";
			queryService.setDatasource("#session.global_dsn#");
    		queryService.setName("insertConnection");
			queryService.execute(sql=thesqlI);

		}
	}

	public void function setupCompanySettings(required string companycode) {
		session.companycode = companycode;
		thesqlA = "    SELECT COMPANYCODE,
							  DESCRIPTION,
							  COMPANYTHEME,
							  WEBDOMAIN,
							  UNSTRUCDATALOC,
							  UNSTRUCTDATAMAP,
							  MOODLELOC,
							  WEBSITEEMAILADD,
							  SLOGAN,
							  EROOMSSERVER,
							  COMPANYDEFAULTAPP,
							  LDAPSERVER,
							  LDAPSTART,
							  LDAPATTRIBUTES,
							  LDAPPORT
						 FROM EGRGCOMPANYSETTINGS
					    WHERE (COMPANYCODE   = '#companycode#')";
			qryCOMPSETTINGS = executeQuery("qryCOMPSETTINGS","#session.global_dsn#",thesqlA);

			session.companyname = "No Company Name";
			session.companycsstheme = "ext-all";
			session.domain = "No Domain";
			session.undbmap = "No unDB Domain";
			session.root_undb = "No Root unDB";
			root_undb = "No Root unDB";
			session.moodle_path = "./moodle/";
			session.websiteemailadd = "noemailaddress@gmail.com";
			session.slogan = "No Slogan";
			session.eroomsserver = "./eroom/";
			session.ldapserver = "";
			session.ldapstart = "";
			session.ldapattributes = "";
			session.ldapport = "";
			for(cntCS=1;cntCS<=qryCOMPSETTINGS.recordcount;cntCS++)
			{
				session.companyname = qryCOMPSETTINGS[ "DESCRIPTION" ][ cntCS ];
				session.companycsstheme = qryCOMPSETTINGS[ "COMPANYTHEME" ][ cntCS ];
				session.domain = qryCOMPSETTINGS[ "WEBDOMAIN" ][ cntCS ];
				session.undbmap = qryCOMPSETTINGS[ "UNSTRUCTDATAMAP" ][ cntCS ];
				session.root_undb = qryCOMPSETTINGS[ "UNSTRUCDATALOC" ][ cntCS ];
				root_undb = qryCOMPSETTINGS[ "UNSTRUCDATALOC" ][ cntCS ];
				session.moodle_path = qryCOMPSETTINGS[ "MOODLELOC" ][ cntCS ];
				session.websiteemailadd = qryCOMPSETTINGS[ "WEBSITEEMAILADD" ][ cntCS ];
				session.slogan = qryCOMPSETTINGS[ "SLOGAN" ][ cntCS ];
				session.eroomsserver = qryCOMPSETTINGS[ "EROOMSSERVER" ][ cntCS ];
				if (IsDefined("session.defaultuserapp")) {
					if (trim(session.defaultuserapp) eq "") {
						session.defaultuserapp = qryCOMPSETTINGS[ "COMPANYDEFAULTAPP" ][ cntCS ];
					}
				} else {
					session.defaultuserapp = qryCOMPSETTINGS[ "COMPANYDEFAULTAPP" ][ cntCS ];
				}
				session.ldapserver = qryCOMPSETTINGS[ "LDAPSERVER" ][ cntCS ];
				session.ldapstart = qryCOMPSETTINGS[ "LDAPSTART" ][ cntCS ];
				session.ldapattributes = qryCOMPSETTINGS[ "LDAPATTRIBUTES" ][ cntCS ];
				session.ldapport = qryCOMPSETTINGS[ "LDAPPORT" ][ cntCS ];

			}

			thesqlB = "SELECT GLOBAL_DSN,COMPANY_DSN,SUBCO_DSN,TRANSACT_DSN,QUERY_DSN,SITE_DSN,VAR_DSN
						 FROM EGRGCOMPANY
					    WHERE (COMPANYCODE   = '#companycode#')";
			qryCOMPANY = executeQuery("qryCOMPANY","#session.global_dsn#",thesqlB);

			session.company_dsn = "NoCompanyDataSourceName";
			companydsn = "NoCompanyDataSourceName";
			session.subco_dsn = "NoSubCoDsn";
			session.transact_dsn = "NoTransactDsn";
			session.transaction_dsn = "NoTransactionDsn";
			session.query_dsn = "NoQueryDsn";
			session.site_dsn = "NoSiteDsn";
			session.var_dsn = "NoVarDsn";

			for(cntC=1;cntC<=qryCOMPANY.recordcount;cntC++)
			{
				session.company_dsn = qryCOMPANY[ "COMPANY_DSN" ][ cntC ];
				companydsn = qryCOMPANY[ "COMPANY_DSN" ][ cntC ];
				session.subco_dsn = qryCOMPANY[ "SUBCO_DSN" ][ cntC ];
				session.transact_dsn = qryCOMPANY[ "TRANSACT_DSN" ][ cntC ];
				session.transaction_dsn = qryCOMPANY[ "TRANSACT_DSN" ][ cntC ];
				session.query_dsn = qryCOMPANY[ "QUERY_DSN" ][ cntC ];
				session.site_dsn = qryCOMPANY[ "SITE_DSN" ][ cntC ];
				session.var_dsn = qryCOMPANY[ "VAR_DSN" ][ cntC ];
			}

			thesqlT = "SELECT COMPANYLOGO, MYIBOSELOGO
						 FROM EGRGTHEMES
					   WHERE COMPANYCODE = '#companycode#'";
			qryThemes = executeQuery("qryThemes","#session.global_dsn#",thesqlT);

			session.site_bannerlogo = "nocompanylogo.png";
			session.site_ibose  = "noicon.png";

			for(cnt=1;cnt<=qryThemes.recordcount;cnt++)
			{
				session.site_bannerlogo = qryThemes[ "COMPANYLOGO" ][ cnt ];
				session.site_ibose      = qryThemes[ "MYIBOSELOGO" ][ cnt ];
			}


	}


}
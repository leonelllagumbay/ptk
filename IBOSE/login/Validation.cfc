component 
displayname="Validation"  
{
	public string function validatePassword(required string thePwd, required string theusername, required string theOldPwdHashed) {
		//Check if the password meet the criterea
		// return false if it doesn't meet
		// return true otherwise
		queryService = new query();
		queryService.addParam(name="uname",value="#theusername#",cfsqltype="cf_sql_varchar");
		queryService.addParam(name="oldhashedpwd",value="#trim(theOldPwdHashed)#",cfsqltype="cf_sql_varchar");
		Usql = "SELECT MINPASSWORDLENGTH, PWDMUSTMEETCOMPLEXITY, USERID, GUID
				  FROM EGRGUSERMASTER
				 WHERE PASSWORD = :oldhashedpwd AND USERID = :uname";
		queryService.setDatasource("#session.global_dsn#"); 
		queryService.setName("selectPwdSettings"); 			 
		theResultSet = queryService.execute(sql=Usql);
		thequery = theResultSet.getResult();
		if(trim(thequery.MINPASSWORDLENGTH) == "") {
			reqLen = 4;
		} else {
			reqLen = thequery.MINPASSWORDLENGTH;
		}
		if(thequery.MINPASSWORDLENGTH > len(thePwd)) {
			return "Password requires at least " & reqLen & " characters.";
		}
		if(thequery.PWDMUSTMEETCOMPLEXITY == "true") {
			if(len(thePwd) >= 6) {
				if(findnocase(thequery.USERID, thePwd) > 0) {
					return "Password must not contain user's account name.";
				} else {
					queryService = new query();
					queryService.addParam(name="guid",value="#thequery.GUID#",cfsqltype="cf_sql_varchar");
					Usql = "SELECT FIRSTNAME, LASTNAME, MIDDLENAME
							  FROM GMFPEOPLE
							 WHERE GUID = :guid";
					queryService.setDatasource("#session.global_dsn#"); 
					queryService.setName("selectGMF"); 			 
					theResultSet = queryService.execute(sql=Usql);
					thequeryGMF = theResultSet.getResult();
					if(findnocase(thequeryGMF.FIRSTNAME, thePwd) > 0 || findnocase(thequeryGMF.LASTNAME, thePwd) > 0 || findnocase(thequeryGMF.MIDDLENAME, thePwd) > 0) {
						return "Password must not contain parts of the user's full name.";
					} else {
						// do the character tests
						if(refind("[a-z]",thePwd) == 0) {
							return "Password must contain English lowercase character.";
						}
						if(refind("[A-Z_]",thePwd) == 0) {
							return "Password must contain English uppercase character.";
						}
						if(refind("[0-9]",thePwd) == 0) {
							return "Password must contain base 10 digits 0-9";
						}
						if(refind("[\W]",thePwd) == 0) {
							return "Password must contain nonalphanumeric character ex. & % @";
						}
						queryService = new query();
						queryService.addParam(name="oldpwd",value="#Hash(thePwd)#",cfsqltype="cf_sql_varchar");
						Usql = "SELECT * 
								  FROM EGRGPWDHISTORY
								 WHERE PASSWORD = :oldpwd";
						queryService.setDatasource("#session.global_dsn#"); 
						queryService.setName("selectGMF"); 			 
						theResultSet = queryService.execute(sql=Usql);
						thequeryPH = theResultSet.getResult();
						if(thequeryPH.recordcount > 0) {
							return "Sorry, but your last 3 used passwords are remembered and cannot be used this time.";
						} else {
							return "true";
						}
					}
				}
			} else {
				return "Password requires at least 6 characters.";
			}
		}
		return "true";
	}
	
	public numeric function checkIfPwdIsExpired(required string pwdage, required date datechanged) {
		baseDate = datechanged;
		if(trim(pwdage) == "") {
			pwdage = "60:00:00:00";
		}
		
		mplenDays = trim(ListGetAt(pwdage,1,":"));
		mplenHours = trim(ListGetAt(pwdage,2,":"));
		mplenMinutes = trim(ListGetAt(pwdage,3,":"));
		mplenSeconds = trim(ListGetAt(pwdage,4,":"));
		
		exDate = DateAdd("d",mplenDays, baseDate);
		exDate = DateAdd("h",mplenHours, exDate);
		exDate = DateAdd("n",mplenMinutes, exDate);
		exDate = DateAdd("s",mplenSeconds, exDate);
		
		dateNow = dateformat(now(), "YYYY-MM-DD");
		timeNow = timeformat(now(), "HH:MM:SS");
		datetimenow = dateNow & " " & timeNow;
		
		datediffTB = DateCompare(exDate,datetimenow);
		// returns -1 if password is expired
		return datediffTB;
	}
	
	public void function updatePwdHistory(required string username, required string newpassword) {
		queryService = new query();
		queryService.addParam(name="newpwd",value="#newpassword#",cfsqltype="cf_sql_varchar");
		queryService.addParam(name="uname",value="#username#",cfsqltype="cf_sql_varchar");
		Usql = "SELECT * 
				  FROM EGRGPWDHISTORY
				 WHERE USERID = :uname
				 ORDER BY DATELASTUPDATE ASC";
		queryService.setDatasource("#session.global_dsn#"); 
		queryService.setName("selectGMF"); 			 
		theResultSet = queryService.execute(sql=Usql);
		thequeryPH = theResultSet.getResult();
		if(thequeryPH.RecordCount < 3) {
			qs = new query();
			qs.addParam(name="pwdcode",value="#CreateUuid()#",cfsqltype="cf_sql_varchar");
			qs.addParam(name="uname",value="#username#",cfsqltype="cf_sql_varchar");
			qs.addParam(name="newpwd",value="#newpassword#",cfsqltype="cf_sql_varchar");
			dateNow = dateformat(now(), "YYYY-MM-DD");
			timeNow = timeformat(now(), "HH:MM:SS");
			qs.addParam(name="cdate",value="#dateNow# #timeNow#",cfsqltype="cf_sql_timestamp"); 
			UsqlInsert = "INSERT INTO EGRGPWDHISTORY (PWDHISTORYCODE,USERID,PASSWORD,DATELASTUPDATE)
						  VALUES (:pwdcode,:uname,:newpwd,:cdate);";
			qs.setDatasource("#session.global_dsn#"); 
    		qs.setName("insertp"); 			 
			qs.execute(sql=UsqlInsert);
		} else {
			for(cntR=1;cntR<=thequeryPH.recordcount;cntR++) {
				if(cntR == 1) {
					qs = new query();
					qs.addParam(name="uname",value="#username#",cfsqltype="cf_sql_varchar");
					qs.addParam(name="newpwd",value="#newpassword#",cfsqltype="cf_sql_varchar");
					qs.addParam(name="pwRdcode",value="#thequeryPH['PWDHISTORYCODE' ][ 1 ]#",cfsqltype="cf_sql_varchar");
					dateNow = dateformat(now(), "YYYY-MM-DD");
					timeNow = timeformat(now(), "HH:MM:SS");
					qs.addParam(name="cdate",value="#dateNow# #timeNow#",cfsqltype="cf_sql_timestamp"); 
					UsqlInsert = "UPDATE EGRGPWDHISTORY
									 SET PASSWORD = :newpwd, DATELASTUPDATE = :cdate
								   WHERE PWDHISTORYCODE = :pwRdcode";
					qs.setDatasource("#session.global_dsn#"); 
		    		qs.setName("updatep"); 			 
					qs.execute(sql=UsqlInsert);
					break;
				} 
			}
		}
	}
	
	public any function checkAccountLockout(required query lockoutQry, required string theusername, required string thepassword) {
		
		maxThreshhold = lockoutQry.ACCOUNTLOCKOUTTHRESHHOLD;
		if(trim(maxThreshhold) == "") {
			maxThreshhold = 5;
		} 
		
		failAttemptCnt = lockoutQry.PWDCOUNTFAILEDATTEMPT;
		if(trim(failAttemptCnt) == "") {
			failAttemptCnt = 0;
		}
		
		retStruct = StructNew();
		
		if(maxThreshhold <= failAttemptCnt + 1) {
			// Account lockout threshhold was reached
			
			datelastfailattempt = lockoutQry.DATELASTFAILEDATTEMPT;
			accntLockoutDuration = lockoutQry.RESETACCOUNTLOCKOUTCOUNTERAFTER;
			if(trim(accntLockoutDuration) == "") {
				accntLockoutDuration = "00:00:30:00";
			}
			
			mplenDays = trim(ListGetAt(accntLockoutDuration,1,":"));
			mplenHours = trim(ListGetAt(accntLockoutDuration,2,":"));
			mplenMinutes = trim(ListGetAt(accntLockoutDuration,3,":"));
			mplenSeconds = trim(ListGetAt(accntLockoutDuration,4,":"));
			
			exDate = DateAdd("d",mplenDays, datelastfailattempt);
			exDate = DateAdd("h",mplenHours, exDate);
			exDate = DateAdd("n",mplenMinutes, exDate);
			exDate = DateAdd("s",mplenSeconds, exDate);
			
			dateNow = dateformat(now(), "YYYY-MM-DD");
			timeNow = timeformat(now(), "HH:MM:SS");
			totalDurationSec = DateDiff("s",dateNow & " " & timeNow, exDate);
			if(totalDurationSec < 1) {
				// Reset password lockout counter
				qs = new query();
				qs.addParam(name="uname",value="#ucase(theusername)#",cfsqltype="cf_sql_varchar");
				qs.addParam(name="threshholdval",value="0",cfsqltype="cf_sql_integer");
				dateNow = dateformat(now(), "YYYY-MM-DD");
				timeNow = timeformat(now(), "HH:MM:SS");
				qs.addParam(name="cdate",value="#dateNow# #timeNow#",cfsqltype="cf_sql_timestamp"); 
				UsqlInsert = "UPDATE EGRGUSERMASTER
								 SET PWDCOUNTFAILEDATTEMPT = :threshholdval, 
								     DATELASTFAILEDATTEMPT = :cdate
							   WHERE USERID   = :uname";
				qs.setDatasource("#session.global_dsn#"); 
	    		qs.setName("updatep"); 			 
				qs.execute(sql=UsqlInsert);
				retStruct["message"] = "lockoutreset";
				retStruct["duration"] = "5";
				retStruct["description"] = "Lockout counter was reset.";
			} else {
				retStruct["message"] = "accountlockedout";
				retStruct["duration"] = totalDurationSec;
				retStruct["description"] = "Sorry, your account has been locked out.";
			}
			
			
		} else {
			// Account lockout threshhold was not yet reached
			// Increment counter
			// Get Account lockout duration
			qs = new query();
			qs.addParam(name="uname",value="#ucase(theusername)#",cfsqltype="cf_sql_varchar");
			qs.addParam(name="pwd",value="#Hash(thepassword)#",cfsqltype="cf_sql_varchar");
			qs.addParam(name="threshholdval",value="#failAttemptCnt + 1#",cfsqltype="cf_sql_integer");
			dateNow = dateformat(now(), "YYYY-MM-DD");
			timeNow = timeformat(now(), "HH:MM:SS");
			qs.addParam(name="cdate",value="#dateNow# #timeNow#",cfsqltype="cf_sql_timestamp"); 
			UsqlInsert = "UPDATE EGRGUSERMASTER
							 SET PWDCOUNTFAILEDATTEMPT = :threshholdval, 
							     DATELASTFAILEDATTEMPT = :cdate
						   WHERE USERID   = :uname";
			qs.setDatasource("#session.global_dsn#"); 
    		qs.setName("updatep"); 			 
			qs.execute(sql=UsqlInsert);
			
			accntLockoutDuration = lockoutQry.ACCOUNTLOCKOUTDURATION;
			
			retStruct["description"] = "Invalid username or password. <br><a href='./templates/account/?forgot=yes&uname=#theusername#'>Forgot password?</a>";
			
			if(trim(accntLockoutDuration) == "") {
				accntLockoutDuration = "00:00:00:10";
			}
			
			mplenDays = trim(ListGetAt(accntLockoutDuration,1,":"));
			mplenHours = trim(ListGetAt(accntLockoutDuration,2,":"));
			mplenMinutes = trim(ListGetAt(accntLockoutDuration,3,":"));
			mplenSeconds = trim(ListGetAt(accntLockoutDuration,4,":"));
			
			exDate = DateAdd("d",mplenDays, lockoutQry.DATELASTFAILEDATTEMPT);
			exDate = DateAdd("h",mplenHours, exDate);
			exDate = DateAdd("n",mplenMinutes, exDate);
			exDate = DateAdd("s",mplenSeconds, exDate);
			
			dateNow = dateformat(now(), "YYYY-MM-DD");
			timeNow = timeformat(now(), "HH:MM:SS");
			totalDurationSec = DateDiff("s",dateNow & " " & timeNow, exDate);
			
			if(totalDurationSec > 0) {
				// this request is too early
				// put a delay to the requestor to avoid hack pwd attacks
				sleep(180000);
			} 
			
			mplenDays = mplenDays*24*60*60;
			mplenHours = mplenHours*60*60;
			mplenMinutes = mplenMinutes*60;
			
			totalSecDuration = mplenDays + mplenHours + mplenMinutes + mplenSeconds;
			retStruct["duration"] = totalSecDuration;
			retStruct["message"] = "invalidunameorpassword";
			
		}
		
		return retStruct;
	}
	
}
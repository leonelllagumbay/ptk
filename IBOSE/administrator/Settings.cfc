component 
{
	public void function setGlobalSettings()
	{
		try
        {
        	if(Not isdefined("session.global_dsn")) {
        		
        		Settings = "";
				myfile="#expandpath('/globalsettings/globalsettings.cfm')#";
				fileObj = fileOpen( myfile, "read" );
				fileObj.charset = "utf-8";
					while( NOT fileIsEOF( fileObj ) ) { 
							Settings &= fileReadLine( fileObj ); 
					}
				fileClose( fileObj );
				
				jsonStruct = DeSerializeJSON(Settings);
				applicationName = jsonStruct.DATA[2];
				applicationVersion = jsonStruct.DATA[3];
				globalDatabase = jsonStruct.DATA[4];
				session.global_dsn = jsonStruct.DATA[4];
				dateInstalled = jsonStruct.DATA[5];
				dateUnInstalled = jsonStruct.DATA[6];
				expirationDate = jsonStruct.DATA[7];
				dateNofityBeforeExp = jsonStruct.DATA[8];
				emailToExp = jsonStruct.DATA[9];
				licensedToCompany = jsonStruct.DATA[10];
				dbms = jsonStruct.DATA[11];
				session.dbms = jsonStruct.DATA[11];
				dbmsversion = jsonStruct.DATA[12];
				session.dbmsversion = jsonStruct.DATA[12];
				appMaxUsers = jsonStruct.DATA[13];
				appMaxSignedIn = jsonStruct.DATA[14];
				appSignature = jsonStruct.DATA[15];
				defaultCompany = jsonStruct.DATA[16];
				session.companycode=defaultCompany;
				client.companycode=defaultCompany;
				superUserName = jsonStruct.DATA[17];
				comment = jsonStruct.DATA[18];
				unDBpathmapping = jsonStruct.DATA[19];
				session.unDBpathmapping = jsonStruct.DATA[19];
				
				expirationDate = dateformat(expirationDate, "YYYY-MM-DD");
				datenow = dateformat(now(), "YYYY-MM-DD");
				
				diff = dateDiff("d", datenow, expirationDate);
				diffB = dateDiff("d", datenow, dateNofityBeforeExp);
				
				if(diff < 0) {
					savecontent variable="mailBody"{ 
		                WriteOutput("#licensedToCompany# iBOS/e expires on #expirationDate#"); 
		            } 
					mailObj = new mail();
					mailObj.setFrom("leonelllagumbay@gmail.com");
					mailObj.setTo("#emailToExp#");
					mailObj.setSubject("#licensedToCompany# iBOS/e expires");
					mailObj.send(body=mailBody);
					
					throw (message = "OR product has reached the expiration date.", type = "Contract", detail="Product is expired. Please renew the product to continue the service.");
				} else if(diffb < 0) {
					savecontent variable="mailBody"{ 
		                WriteOutput("#licensedToCompany# iBOS/e product will expire on #expirationDate#"); 
		            } 
					mailObj = new mail();
					mailObj.setFrom("leonelllagumbay@gmail.com");
					mailObj.setTo("#emailToExp#");
					mailObj.setSubject("#licensedToCompany# iBOS/e product will expire on #expirationDate#");
					mailObj.send(body=mailBody);
				} else {
					//check if max user login was reached; 
					//appMaxSignedIn
				}
				
			}
        }
        catch(Any e)
        {
        	throw (message = "App config error: Global settings are undefined! #e.message#", type = "Setting", detail="App config error: Global settings are undefined! #e.message#");
        }
        
    }

}
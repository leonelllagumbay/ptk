component  displayname="OnlineApplication" hint="Component for online applicants registration"
{
	public string function insertIntoEgmfap(required string guid, required string applicantnumber)
	{
		if(trim(form.SOURCEEMPLOYMENT) == "companysite") {
			thesource = "Company career site";
		} else if(trim(form.SOURCEEMPLOYMENT) == "online") {
			thesource = form.WEBSITE;
		} else if(trim(form.SOURCEEMPLOYMENT) == "walkin") {
			thesource = "Walk-in";
		} else if(trim(form.SOURCEEMPLOYMENT) == "jobfair") {
			thesource = form.SOURCEJOBFAIRWHERE & " " & form.SOURCEJOBFAIRDATE;
		} else if(trim(form.SOURCEEMPLOYMENT) == "referral") {
			thesource = "Referral";
		} else {
			thesource = form.SOURCEOTHERVALUE; //other
		}
		thesource = Left(thesource, 20);

		Egmfap = CreateObject("component","query");
		Egmfap.setName('Egmfap');
		Egmfap.setDataSource(client.global_dsn);
		Egmfap.addParam(name="guid",value='#guid#',cfsqltype='cf_sql_varchar');
		Egmfap.addParam(name="applicantnumber",value='#applicantnumber#',cfsqltype='cf_sql_varchar');
		Egmfap.addParam(name="SUFFIX",value='#trim(form.SUFFIX)#',cfsqltype='cf_sql_varchar');
		Egmfap.addParam(name="LASTNAME",value='#trim(form.LASTNAME)#',cfsqltype='cf_sql_varchar');
		Egmfap.addParam(name="FIRSTNAME",value='#trim(form.FIRSTNAME)#',cfsqltype='cf_sql_varchar');
		Egmfap.addParam(name="MIDDLENAME",value='#trim(form.MIDDLENAME)#',cfsqltype='cf_sql_varchar');
		Egmfap.addParam(name="dateapplied",value='#dateformat(now(), "YYYY-MM-DD")# #timeformat(now(), 'HH:MM:SS')#',cfsqltype='cf_sql_timestamp');
		Egmfap.addParam(name="PAGIBIGNUMBER",value='#Replace(trim(form.PAGIBIGNUMBER),',','-', 'all')#',cfsqltype='cf_sql_varchar');
		Egmfap.addParam(name="SOURCEREFERREDBY",value='#trim(form.SOURCEREFERREDBY)#',cfsqltype='cf_sql_varchar');
		Egmfap.addParam(name="SSSNUMBER",value='#Replace(trim(form.SSSNUMBER),',','-', 'all')#',cfsqltype='cf_sql_varchar');
		Egmfap.addParam(name="EXPECTEDSALARY",value='#trim(form.EXPECTEDSALARY)#',cfsqltype='cf_sql_integer');
		Egmfap.addParam(name="TINNUMBER",value='#Replace(trim(form.TINNUMBER),',','-', 'all')#',cfsqltype='cf_sql_varchar');
		Egmfap.addParam(name="EMAILADDRESS",value='#trim(form.EMAILADDRESS)#',cfsqltype='cf_sql_varchar');
		Egmfap.addParam(name="POSITIONFIRSTPRIORITY",value='#trim(form.POSITIONFIRSTPRIORITY)#',cfsqltype='cf_sql_varchar');
		Egmfap.addParam(name="POSITIONSECONDPRIORITY",value='#trim(form.POSITIONSECONDPRIORITY)#',cfsqltype='cf_sql_varchar');
		Egmfap.addParam(name="POSITIONTHIRDPRIORITY",value='#trim(form.POSITIONTHIRDPRIORITY)#',cfsqltype='cf_sql_varchar');
		Egmfap.addParam(name="thesource",value='#thesource#',cfsqltype='cf_sql_varchar');
		Egmfap.addParam(name="reserved",value='N',cfsqltype='cf_sql_varchar');
		Egmfap.addParam(name="CURRENTSALARY",value='#trim(form.CURRENTSALARY)#',cfsqltype='cf_sql_integer');
		Egmfap.addParam(name="RECDATECREATED",value='#dateformat(now(), 'YYYY-MM-DD')#',cfsqltype='cf_sql_date');
		Egmfap.addParam(name="DATELASTUPDATE",value='#dateformat(now(), "YYYY-MM-DD")# #timeformat(now(), 'HH:MM:SS')#',cfsqltype='cf_sql_timestamp');
		Egmfap.addParam(name="YESREVERT",value='#trim(form.SEQREFERENCE)#',cfsqltype='cf_sql_varchar');
		Egmfap.addParam(name="COMPANYCODE",value='#trim(form.COMPANYFIRSTPRIORITY)#',cfsqltype='cf_sql_varchar');
		Egmfap.addParam(name="POSTGRADSCHOOL",value='#trim(form.POSTGRADSCHOOL)#',cfsqltype='cf_sql_varchar');
		Egmfap.addParam(name="POSTGRADCOURSE",value='#trim(form.POSTGRADCOURSE)#',cfsqltype='cf_sql_varchar');
		Egmfap.addParam(name="POSTGRADISGRAD",value='#trim(form.POSTGRADISGRAD)#',cfsqltype='cf_sql_varchar');
		Egmfap.addParam(name="COLLEGESCHOOL",value='#trim(ListGetAt(form.COLLEGESCHOOL,"1",",",true))#',cfsqltype='cf_sql_varchar');
		Egmfap.addParam(name="COLLEGECOURSE",value='#trim(ListGetAt(form.COLLEGECOURSE,"1",",",true))#',cfsqltype='cf_sql_varchar');
		Egmfap.addParam(name="COLLEGEISGRAD",value='#trim(form.COLLEGEISGRAD1)#',cfsqltype='cf_sql_varchar');
		Egmfap.addParam(name="VOCATIONALSCHOOL",value='#trim(form.VOCATIONALSCHOOL)#',cfsqltype='cf_sql_varchar');
		Egmfap.addParam(name="VOCATIONALCOURSE",value='#trim(form.VOCATIONALCOURSE)#',cfsqltype='cf_sql_varchar');
		Egmfap.addParam(name="VOCATIONALISGRAD",value='#trim(form.VOCATIONALISGRAD)#',cfsqltype='cf_sql_varchar');
		Egmfap.addParam(name="REFERENCECODE",value='#trim(form.REFERENCECODE)#',cfsqltype='cf_sql_varchar');
		Egmfap.setSql("
			INSERT INTO EGMFAP ( GUID,APPLICANTNUMBER,YESREVERT,COMPANYCODE,SUFFIX,LASTNAME,FIRSTNAME,MIDDLENAME,APPLICATIONDATE,PAGIBIGNUMBER,REFERREDBY,SSSNUMBER,STARTINGSALARY,TIN,EMAILADD,POSITIONCODE,POSITIONSECONDPRIORITY,POSITIONTHIRDPRIORITY,SOURCE,RESERVED,WORKEXPRATING,RECDATECREATED,DATELASTUPDATE,POSTGRADSCHOOL,POSTGRADCOURSE,POSTGRADISGRAD,COLLEGESCHOOL,COLLEGECOURSE,COLLEGEISGRAD,VOCATIONALSCHOOL,VOCATIONALCOURSE,VOCATIONALISGRAD,REFERENCECODE)
					    VALUES ( :guid,:applicantnumber,:YESREVERT,:COMPANYCODE,:SUFFIX,:LASTNAME,:FIRSTNAME,:MIDDLENAME,:dateapplied,:PAGIBIGNUMBER,:SOURCEREFERREDBY,:SSSNUMBER,:EXPECTEDSALARY,:TINNUMBER,:EMAILADDRESS,:POSITIONFIRSTPRIORITY,:POSITIONSECONDPRIORITY,:POSITIONTHIRDPRIORITY,:thesource,:reserved,:CURRENTSALARY,:RECDATECREATED,:DATELASTUPDATE,:POSTGRADSCHOOL,:POSTGRADCOURSE,:POSTGRADISGRAD,:COLLEGESCHOOL,:COLLEGECOURSE,:COLLEGEISGRAD,:VOCATIONALSCHOOL,:VOCATIONALCOURSE,:VOCATIONALISGRAD,:REFERENCECODE);
		");
		result = Egmfap.execute();
		return 'true';
	}

	public string function insertIntoEgin21personalinfo(required string guid, required string applicantnumber)
	{
		Egin21personalinfo = CreateObject("component","query");
		Egin21personalinfo.setName('Egin21personalinfo');
		Egin21personalinfo.setDataSource(client.global_dsn);
		Egin21personalinfo.addParam(name="guid",value='#guid#',cfsqltype='cf_sql_varchar');
		Egin21personalinfo.addParam(name="applicantnumber",value='#applicantnumber#',cfsqltype='cf_sql_varchar');
		Egin21personalinfo.addParam(name="PRESENTADDRESSPOSTAL",value='#trim(form.PRESENTADDRESSPOSTAL)#',cfsqltype='cf_sql_varchar');
		Egin21personalinfo.addParam(name="PROVINCIALADDRESSPOSTAL",value='#trim(form.PROVINCIALADDRESSPOSTAL)#',cfsqltype='cf_sql_varchar');
		Egin21personalinfo.addParam(name="DATEOFBIRTH",value='#trim(form.DATEOFBIRTH)#',cfsqltype='cf_sql_date');
		Egin21personalinfo.addParam(name="PLACEOFBIRTH",value='#trim(form.PLACEOFBIRTH)#',cfsqltype='cf_sql_varchar');
		Egin21personalinfo.addParam(name="AGE",value='#trim(form.AGE)#',cfsqltype='cf_sql_varchar');
		Egin21personalinfo.addParam(name="GENDER",value='#trim(form.GENDER)#',cfsqltype='cf_sql_varchar');
		Egin21personalinfo.addParam(name="CIVILSTATUS",value='#trim(form.CIVILSTATUS)#',cfsqltype='cf_sql_varchar');
		Egin21personalinfo.addParam(name="CITIZENSHIP",value='#trim(form.CITIZENSHIP)#',cfsqltype='cf_sql_varchar');
		Egin21personalinfo.addParam(name="ACRNUMBER",value='#trim(form.ACRNUMBER)#',cfsqltype='cf_sql_varchar');
		Egin21personalinfo.addParam(name="RELIGION",value='#trim(form.RELIGION)#',cfsqltype='cf_sql_varchar');
		Egin21personalinfo.addParam(name="CELLPHONENUMBER",value='#trim(form.CELLPHONENUMBER)#',cfsqltype='cf_sql_varchar');
		Egin21personalinfo.addParam(name="LANDLINENUMBER",value='#trim(form.LANDLINENUMBER)#',cfsqltype='cf_sql_varchar');
		Egin21personalinfo.addParam(name="EMAILADDRESS",value='#trim(form.EMAILADDRESS)#',cfsqltype='cf_sql_varchar');
		Egin21personalinfo.addParam(name="HEIGHT",value='#trim(form.HEIGHT)#',cfsqltype='cf_sql_varchar');
		Egin21personalinfo.addParam(name="WEIGHT",value='#trim(form.WEIGHT)#',cfsqltype='cf_sql_varchar');
		Egin21personalinfo.addParam(name="LANGUAGESPOKEN",value='#trim(form.LANGUAGESPOKEN)#',cfsqltype='cf_sql_varchar');
		Egin21personalinfo.addParam(name="INCASEEMERNAME",value='#trim(form.INCASEEMERNAME)#',cfsqltype='cf_sql_varchar');
		Egin21personalinfo.addParam(name="INCASEEMERRELATION",value='#trim(form.INCASEEMERRELATION)#',cfsqltype='cf_sql_varchar');
		Egin21personalinfo.addParam(name="INCASEEMERTELNUM",value='#trim(form.INCASEEMERTELNUM)#',cfsqltype='cf_sql_varchar');
		Egin21personalinfo.addParam(name="INCASEEMERCELLNUM",value='#trim(form.INCASEEMERCELLNUM)#',cfsqltype='cf_sql_varchar');
		Egin21personalinfo.addParam(name="PRESENTADDRESSOWN",value='#trim(form.PRESENTADDRESSOWN)#',cfsqltype='cf_sql_varchar');
		Egin21personalinfo.addParam(name="PROVINCEADDRESSOWN",value='#trim(form.PROVINCEADDRESSOWN)#',cfsqltype='cf_sql_varchar');
		Egin21personalinfo.addParam(name="PHOTOIDNAME",value='#trim(form.PHOTOIDNAME)#',cfsqltype='cf_sql_varchar');
		Egin21personalinfo.addParam(name="PREVEMPLOYED",value='#trim(form.PREVEMPLOYED)#, #trim(form.PREVEMPLOYEDFROM)# to #trim(form.PREVEMPLOYEDTO)#',cfsqltype='cf_sql_varchar');
		Egin21personalinfo.addParam(name="PREVAPPLIED",value='#trim(form.PREVAPPLIED)#, #trim(form.PREVAPPLIEDLAST)#',cfsqltype='cf_sql_varchar');
		Egin21personalinfo.addParam(name="DATEAVAILEMP",value='#trim(form.DATEAVAILEMP)#',cfsqltype='cf_sql_date');
		Egin21personalinfo.addParam(name="REFERENCECODE",value='#trim(form.REFERENCECODE)#',cfsqltype='cf_sql_varchar');
		Egin21personalinfo.setSql("
			INSERT INTO EGIN21PERSONALINFO (GUID,PERSONNELIDNO,CONTACTADDRESS,PROVINCIALADDRESS,BIRTHDAY,BIRTHPLACE,AGE,SEX,CIVILSTATUS,CITIZENSHIP,RELIGIONCODE,CONTACTCELLNUMBER,CONTACTTELNO,EMAILADDRESS,HEIGHT,WEIGHT,LANGUAGESPOKEN,PERSONTOCONTACT,RELATIONSHIP,TELEPHONENUMBER,PERCELLNUMBER,PREVIOUSADDRESS,PROVPERIODOFRES,LANGUAGEWRITTEN,CONTACTADDRESS2,CONTACTADDRESS3,ACREXPIRATIONDATE,REFERENCECODE )
                                    VALUES (:guid,:applicantnumber,:PRESENTADDRESSPOSTAL,:PROVINCIALADDRESSPOSTAL,:DATEOFBIRTH,:PLACEOFBIRTH,:AGE,:GENDER,:CIVILSTATUS,:CITIZENSHIP,:RELIGION,:CELLPHONENUMBER,:LANDLINENUMBER,:EMAILADDRESS,:HEIGHT,:WEIGHT,:LANGUAGESPOKEN,:INCASEEMERNAME,:INCASEEMERRELATION,:INCASEEMERTELNUM,:INCASEEMERCELLNUM,:PRESENTADDRESSOWN,:PROVINCEADDRESSOWN,:PHOTOIDNAME,:PREVEMPLOYED,:PREVAPPLIED,:DATEAVAILEMP,:REFERENCECODE );
		");
		result = Egin21personalinfo.execute();
		return 'true';
	}

	public string function insertIntoEgin21positnapld(required string guid, required string applicantnumber)
	{
		if(trim(form.POSITIONFIRSTPRIORITY) != "" && ucase(trim(form.POSITIONFIRSTPRIORITY)) != "NA" && ucase(trim(form.POSITIONFIRSTPRIORITY)) != "N/A")
		{
			Egin21positnapld = CreateObject("component","query");
			Egin21positnapld.setName('Egin21positnapld');
			Egin21positnapld.setDataSource(client.global_dsn);
			Egin21positnapld.addParam(name="guid",value='#guid#',cfsqltype='cf_sql_varchar');
			Egin21positnapld.addParam(name="applicantnumber",value='#applicantnumber#',cfsqltype='cf_sql_varchar');
			Egin21positnapld.addParam(name="POSITIONFIRSTPRIORITY",value='#trim(form.POSITIONFIRSTPRIORITY)#',cfsqltype='cf_sql_varchar');
			Egin21positnapld.addParam(name="COMPANYFIRSTPRIORITY",value='#trim(form.COMPANYFIRSTPRIORITY)#',cfsqltype='cf_sql_varchar');
			Egin21positnapld.addParam(name="PRIORITY",value='1',cfsqltype='cf_sql_integer');
			Egin21positnapld.addParam(name="REFERENCECODE",value='#trim(form.REFERENCECODE)#',cfsqltype='cf_sql_varchar');
			Egin21positnapld.setSql("
				INSERT INTO EGIN21POSITNAPLD (GUID,PERSONNELIDNO,POSITIONCODE,COMPANYCODE,PRIORITY,REFERENCECODE)
	                                  VALUES (:guid,:applicantnumber,:POSITIONFIRSTPRIORITY,:COMPANYFIRSTPRIORITY,:PRIORITY,:REFERENCECODE);
			");
			result = Egin21positnapld.execute();
		}

		if(trim(form.POSITIONSECONDPRIORITY) != "" && ucase(trim(form.POSITIONSECONDPRIORITY)) != "NA" && ucase(trim(form.POSITIONSECONDPRIORITY)) != "N/A")
		{
			Egin21positnapldb = CreateObject("component","query");
			Egin21positnapldb.setName('Egin21positnapldb');
			Egin21positnapldb.setDataSource(client.global_dsn);
			Egin21positnapldb.addParam(name="guid",value='#guid#',cfsqltype='cf_sql_varchar');
			Egin21positnapldb.addParam(name="applicantnumber",value='#applicantnumber#',cfsqltype='cf_sql_varchar');
			Egin21positnapldb.addParam(name="POSITIONSECONDPRIORITY",value='#trim(form.POSITIONSECONDPRIORITY)#',cfsqltype='cf_sql_varchar');
			Egin21positnapldb.addParam(name="COMPANYSECONDPRIORITY",value='#trim(form.COMPANYSECONDPRIORITY)#',cfsqltype='cf_sql_varchar');
			Egin21positnapldb.addParam(name="PRIORITY",value='2',cfsqltype='cf_sql_integer');
			Egin21positnapldb.addParam(name="REFERENCECODE",value='#trim(form.REFERENCECODE)#',cfsqltype='cf_sql_varchar');
			Egin21positnapldb.setSql("
				INSERT INTO EGIN21POSITNAPLD (GUID,PERSONNELIDNO,POSITIONCODE,COMPANYCODE,PRIORITY,REFERENCECODE)
	                                  VALUES (:guid,:applicantnumber,:POSITIONSECONDPRIORITY,:COMPANYSECONDPRIORITY,:PRIORITY,:REFERENCECODE);
			");
			result = Egin21positnapldb.execute();
		}

		if(trim(form.POSITIONTHIRDPRIORITY) != "" && ucase(trim(form.POSITIONTHIRDPRIORITY)) != "NA" && ucase(trim(form.POSITIONTHIRDPRIORITY)) != "N/A")
		{
			Egin21positnapldc = CreateObject("component","query");
			Egin21positnapldc.setName('Egin21positnapldc');
			Egin21positnapldc.setDataSource(client.global_dsn);
			Egin21positnapldc.addParam(name="guid",value='#guid#',cfsqltype='cf_sql_varchar');
			Egin21positnapldc.addParam(name="applicantnumber",value='#applicantnumber#',cfsqltype='cf_sql_varchar');
			Egin21positnapldc.addParam(name="POSITIONTHIRDPRIORITY",value='#trim(form.POSITIONTHIRDPRIORITY)#',cfsqltype='cf_sql_varchar');
			Egin21positnapldc.addParam(name="COMPANYTHIRDPRIORITY",value='#trim(form.COMPANYTHIRDPRIORITY)#',cfsqltype='cf_sql_varchar');
			Egin21positnapldc.addParam(name="PRIORITY",value='3',cfsqltype='cf_sql_integer');
			Egin21positnapldc.addParam(name="REFERENCECODE",value='#trim(form.REFERENCECODE)#',cfsqltype='cf_sql_varchar');
			Egin21positnapldc.setSql("
				INSERT INTO EGIN21POSITNAPLD (GUID,PERSONNELIDNO,POSITIONCODE,COMPANYCODE,PRIORITY,REFERENCECODE)
	                                  VALUES (:guid,:applicantnumber,:POSITIONTHIRDPRIORITY,:COMPANYTHIRDPRIORITY,:PRIORITY,:REFERENCECODE);
			");
			result = Egin21positnapldc.execute();
		}
		return 'true';
	}

	public string function insertIntoEgin21familybkgrnd(required string guid, required string applicantnumber, required string prefix, required string rel, required numeric a)
	{
		Egin21familybkgrnda = CreateObject("component","query");
		Egin21familybkgrnda.setName('Egin21familybkgrnda');
		Egin21familybkgrnda.setDataSource(client.global_dsn);
		Egin21familybkgrnda.addParam(name="guid",value='#guid#',cfsqltype='cf_sql_varchar');
		Egin21familybkgrnda.addParam(name="applicantnumber",value='#applicantnumber#',cfsqltype='cf_sql_varchar');
		if(ListLen(evaluate("form.#prefix#FULLNAME"),",",true) >= a) {
			Egin21familybkgrnda.addParam(name="FULLNAME",value='#trim(ListGetAt(evaluate("form.#prefix#FULLNAME"),a,",",true))#',cfsqltype='cf_sql_varchar');
		} else {
			return "true";
		}
		if(ListLen(evaluate("form.#prefix#AGE"),",",true) >= a) {
			Egin21familybkgrnda.addParam(name="AGE",value='#trim(ListGetAt(evaluate("form.#prefix#AGE"),a,",",true))#',cfsqltype='cf_sql_integer');
		} else {
			Egin21familybkgrnda.addParam(name="AGE",null="true",cfsqltype='cf_sql_integer');
		}
		if(ListLen(evaluate("form.#prefix#COMPANY"),",",true) >= a) {
			Egin21familybkgrnda.addParam(name="COMPANY",value='#trim(ListGetAt(evaluate("form.#prefix#COMPANY"),a,",",true))#',cfsqltype='cf_sql_varchar');
		} else {
			Egin21familybkgrnda.addParam(name="COMPANY",null="true",cfsqltype='cf_sql_varchar');
		}
		if(ListLen(evaluate("form.#prefix#OCCUPATION"),",",true) >= a) {
			Egin21familybkgrnda.addParam(name="OCCUPATION",value='#trim(ListGetAt(evaluate("form.#prefix#OCCUPATION"),a,",",true))#',cfsqltype='cf_sql_varchar');
		} else {
			Egin21familybkgrnda.addParam(name="OCCUPATION",null="true",cfsqltype='cf_sql_varchar');
		}
		if(ListLen(evaluate("form.#prefix#CONTACTNO"),",",true) >= a) {
			Egin21familybkgrnda.addParam(name="CONTACTNO",value='#trim(ListGetAt(evaluate("form.#prefix#CONTACTNO"),a,",",true))#',cfsqltype='cf_sql_varchar');
		} else {
			Egin21familybkgrnda.addParam(name="CONTACTNO",null="true",cfsqltype='cf_sql_varchar');
		}
		if(ListLen(evaluate("form.#prefix#BIRTHDAY"),",",true) >= a) {
			Egin21familybkgrnda.addParam(name="BIRTHDAY",value='#trim(ListGetAt(evaluate("form.#prefix#BIRTHDAY"),a,",",true))#',cfsqltype='cf_sql_date');
		} else {
			Egin21familybkgrnda.addParam(name="BIRTHDAY",null="true",cfsqltype='cf_sql_date');
		}
		try {
			if(ListLen(evaluate("form.#prefix#DECEASED"),",",true) >= a) {
				if(trim(ListGetAt(evaluate("form.#prefix#DECEASED"),a,",",true)) eq "on" OR trim(ListGetAt(evaluate("form.#prefix#DECEASED"),a,",",true)) eq "yes" or trim(ListGetAt(evaluate("form.#prefix#DECEASED"),a,",",true)) eq "Y") {
					deceased = "Y";
				} else {
					deceased = "N";
				}
				Egin21familybkgrnda.addParam(name="DECEASED",value='#deceased#',cfsqltype='cf_sql_varchar');
			} else {
				Egin21familybkgrnda.addParam(name="DECEASED",null="true",cfsqltype='cf_sql_varchar');
			}
		} catch(Any e) {
			Egin21familybkgrnda.addParam(name="DECEASED",null="true",cfsqltype='cf_sql_varchar');
		}

		Egin21familybkgrnda.addParam(name="rel",value='#rel#',cfsqltype='cf_sql_varchar');
		Egin21familybkgrnda.addParam(name="REFERENCECODE",value='#trim(form.REFERENCECODE)#',cfsqltype='cf_sql_varchar');
		Egin21familybkgrnda.setSql("
			INSERT INTO EGIN21FAMILYBKGRND (GUID,PERSONNELIDNO,NAME,AGE,COMPANY,OCCUPATION,RELATIONSHIP,TELEPHONENUMBER,REFERENCECODE,BIRTHDAY,LIVINGORDEAD)
						            VALUES (:guid,:applicantnumber,:FULLNAME,:AGE,:COMPANY,:OCCUPATION,:rel,:CONTACTNO,:REFERENCECODE,:BIRTHDAY,:DECEASED);
		");
		result = Egin21familybkgrnda.execute();

		return 'true';
	}

	public string function insertIntoEgin21education(required string guid, required string applicantnumber)
	{
		if(trim(form.POSTGRADSCHOOL) != "" && ucase(trim(form.POSTGRADSCHOOL)) != "NA" && ucase(trim(form.POSTGRADSCHOOL)) != "N/A")
		{
			Egin21education = CreateObject("component","query");
			Egin21education.setName('Egin21education');
			Egin21education.setDataSource(client.global_dsn);
			Egin21education.addParam(name="guid",value='#guid#',cfsqltype='cf_sql_varchar');
			Egin21education.addParam(name="applicantnumber",value='#applicantnumber#',cfsqltype='cf_sql_varchar');
			Egin21education.addParam(name="POSTGRADSCHOOL",value='#trim(form.POSTGRADSCHOOL)#',cfsqltype='cf_sql_varchar');
			Egin21education.addParam(name="POSTGRAD",value='POSTGRAD',cfsqltype='cf_sql_varchar');
			Egin21education.addParam(name="POSTGRADLOCATION",value='#trim(form.POSTGRADLOCATION)#',cfsqltype='cf_sql_varchar');
			Egin21education.addParam(name="POSTGRADCOURSE",value='#trim(form.POSTGRADCOURSE)#',cfsqltype='cf_sql_varchar');
			if(trim(form.POSTGRADFROM) == "")
			{
				Egin21education.addParam(name="POSTGRADFROM",value='#dateformat(now(),"YYYY-MM-DD")#',cfsqltype='cf_sql_date');
			}
			else
			{
				Egin21education.addParam(name="POSTGRADFROM",value='#trim(form.POSTGRADFROM)#',cfsqltype='cf_sql_date');
			}
			Egin21education.addParam(name="POSTGRADTO",value='#trim(form.POSTGRADTO)#',cfsqltype='cf_sql_date');
			Egin21education.addParam(name="POSTGRADISGRAD",value='#trim(form.POSTGRADISGRAD)#',cfsqltype='cf_sql_varchar');
			Egin21education.addParam(name="POSTGRADHONORS",value='#trim(form.POSTGRADHONORS)#',cfsqltype='cf_sql_varchar');
			Egin21education.addParam(name="REFERENCECODE",value='#trim(form.REFERENCECODE)#',cfsqltype='cf_sql_varchar');
			Egin21education.setSql("
				INSERT INTO EGIN21EDUCATION (GUID,PERSONNELIDNO,SCHOOLNAME,EDUCLEVEL,LOCATION,COURSECODE,SCHOOLCODE,DATEBEGIN,DATEFINISHED,GRADUATE,HONORSRECEIVED,REFERENCECODE)
	                                 VALUES (:guid,:applicantnumber,:POSTGRADSCHOOL,:POSTGRAD,:POSTGRADLOCATION,:POSTGRADCOURSE,:POSTGRADSCHOOL,:POSTGRADFROM,:POSTGRADTO,:POSTGRADISGRAD,:POSTGRADHONORS,:REFERENCECODE);
			");
			result = Egin21education.execute();
		}

		for(a=1; a<=ListLen(form.COLLEGESCHOOL,",",true); a++) {
			if(trim(ListGetAt(form.COLLEGESCHOOL,a,",",true)) != "" && ucase(trim(ListGetAt(form.COLLEGESCHOOL,a,",",true))) != "NA" && ucase(trim(ListGetAt(form.COLLEGESCHOOL,a,",",true))) != "N/A")
			{

				Egin21educationb = CreateObject("component","query");
				Egin21educationb.setName('Egin21educationb');
				Egin21educationb.setDataSource(client.global_dsn);
				Egin21educationb.addParam(name="guid",value='#guid#',cfsqltype='cf_sql_varchar');

				Egin21educationb.addParam(name="applicantnumber",value='#applicantnumber#',cfsqltype='cf_sql_varchar');

				Egin21educationb.addParam(name="COLLEGESCHOOL",value='#trim(ListGetAt(form.COLLEGESCHOOL,a,",",true))#',cfsqltype='cf_sql_varchar');

				Egin21educationb.addParam(name="COLLEGE",value='COLLEGE',cfsqltype='cf_sql_varchar');

				Egin21educationb.addParam(name="COLLEGELOCATION",value='#trim(ListGetAt(form.COLLEGELOCATION,a,",",true))#',cfsqltype='cf_sql_varchar');

				Egin21educationb.addParam(name="COLLEGECOURSE",value='#trim(ListGetAt(form.COLLEGECOURSE,a,",",true))#',cfsqltype='cf_sql_varchar');
				if(ListLen(form.COLLEGEFROM,",",true) >= a) {
					if(trim(ListGetAt(form.COLLEGEFROM,a,",",true)) == "")
					{
						Egin21educationb.addParam(name="COLLEGEFROM",value='#dateformat(now(),"YYYY-MM-DD")#',cfsqltype='cf_sql_date');
					}
					else
					{
						Egin21educationb.addParam(name="COLLEGEFROM",value='#trim(ListGetAt(form.COLLEGEFROM,a,",",true))#',cfsqltype='cf_sql_date');
					}
				} else {
					Egin21educationb.addParam(name="COLLEGEFROM",value='#dateformat(now(),"YYYY-MM-DD")#',cfsqltype='cf_sql_date');
				}
				if(ListLen(form.COLLEGETO,",",true) >= a) {
					Egin21educationb.addParam(name="COLLEGETO",value='#trim(ListGetAt(form.COLLEGETO,a,",",true))#',cfsqltype='cf_sql_date');
				} else {
					Egin21educationb.addParam(name="COLLEGETO",null="true",cfsqltype='cf_sql_date');
				}
				if(Isdefined("form.COLLEGEISGRAD#a#")) {
					if(ListLen(evaluate("form.COLLEGEISGRAD#a#"),",",true) >= a) {
						Egin21educationb.addParam(name="COLLEGEISGRAD",value='#trim(ListGetAt(evaluate("form.COLLEGEISGRAD#a#"),a,",",true))#',cfsqltype='cf_sql_varchar');
					} else {
						Egin21educationb.addParam(name="COLLEGEISGRAD",null="true",cfsqltype='cf_sql_varchar');
					}
				} else {
					Egin21educationb.addParam(name="COLLEGEISGRAD",null="true",cfsqltype='cf_sql_varchar');
				}
				if(ListLen(form.COLLEGEHONORS,",",true) >= a) {
					Egin21educationb.addParam(name="COLLEGEHONORS",value='#trim(ListGetAt(form.COLLEGEHONORS,a,",",true))#',cfsqltype='cf_sql_varchar');
				} else {
					Egin21educationb.addParam(name="COLLEGEHONORS",null="true",cfsqltype='cf_sql_varchar');
				}
				Egin21educationb.addParam(name="REFERENCECODE",value='#trim(form.REFERENCECODE)#',cfsqltype='cf_sql_varchar');
				Egin21educationb.setSql("
					INSERT INTO EGIN21EDUCATION (GUID,PERSONNELIDNO,SCHOOLNAME,EDUCLEVEL,LOCATION,COURSECODE,SCHOOLCODE,DATEBEGIN,DATEFINISHED,GRADUATE,HONORSRECEIVED,REFERENCECODE)
		                                 VALUES (:guid,:applicantnumber,:COLLEGESCHOOL,:COLLEGE,:COLLEGELOCATION,:COLLEGECOURSE,:COLLEGESCHOOL,:COLLEGEFROM,:COLLEGETO,:COLLEGEISGRAD,:COLLEGEHONORS,:REFERENCECODE);
				");
				result = Egin21educationb.execute();
			}
		}

		if(trim(form.VOCATIONALSCHOOL) != "" && ucase(trim(form.VOCATIONALSCHOOL)) != "NA" && ucase(trim(form.VOCATIONALSCHOOL)) != "N/A")
		{
			Egin21educationc = CreateObject("component","query");
			Egin21educationc.setName('Egin21educationc');
			Egin21educationc.setDataSource(client.global_dsn);
			Egin21educationc.addParam(name="guid",value='#guid#',cfsqltype='cf_sql_varchar');
			Egin21educationc.addParam(name="applicantnumber",value='#applicantnumber#',cfsqltype='cf_sql_varchar');
			Egin21educationc.addParam(name="VOCATIONALSCHOOL",value='#trim(form.VOCATIONALSCHOOL)#',cfsqltype='cf_sql_varchar');
			Egin21educationc.addParam(name="VOCATIONAL",value='VOCATIONAL',cfsqltype='cf_sql_varchar');
			Egin21educationc.addParam(name="VOCATIONALLOCATION",value='#trim(form.VOCATIONALLOCATION)#',cfsqltype='cf_sql_varchar');
			Egin21educationc.addParam(name="VOCATIONALCOURSE",value='#trim(form.VOCATIONALCOURSE)#',cfsqltype='cf_sql_varchar');
			if(trim(form.VOCATIONALFROM) == "")
			{
				Egin21educationc.addParam(name="VOCATIONALFROM",value='#dateformat(now(),"YYYY-MM-DD")#',cfsqltype='cf_sql_date');
			}
			else
			{
				Egin21educationc.addParam(name="VOCATIONALFROM",value='#trim(form.VOCATIONALFROM)#',cfsqltype='cf_sql_date');
			}
			Egin21educationc.addParam(name="VOCATIONALTO",value='#trim(form.VOCATIONALTO)#',cfsqltype='cf_sql_date');
			Egin21educationc.addParam(name="VOCATIONALISGRAD",value='#trim(form.VOCATIONALISGRAD)#',cfsqltype='cf_sql_varchar');
			Egin21educationc.addParam(name="VOCATIONALHONORS",value='#trim(form.VOCATIONALHONORS)#',cfsqltype='cf_sql_varchar');
			Egin21educationc.addParam(name="REFERENCECODE",value='#trim(form.REFERENCECODE)#',cfsqltype='cf_sql_varchar');
			Egin21educationc.setSql("
				INSERT INTO EGIN21EDUCATION (GUID,PERSONNELIDNO,SCHOOLNAME,EDUCLEVEL,LOCATION,COURSECODE,SCHOOLCODE,DATEBEGIN,DATEFINISHED,GRADUATE,HONORSRECEIVED,REFERENCECODE)
	                                 VALUES (:guid,:applicantnumber,:VOCATIONALSCHOOL,:VOCATIONAL,:VOCATIONALLOCATION,:VOCATIONALCOURSE,:VOCATIONALSCHOOL,:VOCATIONALFROM,:VOCATIONALTO,:VOCATIONALISGRAD,:VOCATIONALHONORS,:REFERENCECODE);
			");
			result = Egin21educationc.execute();
		}

		if(trim(form.SECONDARYSCHOOL) != "" && ucase(trim(form.SECONDARYSCHOOL)) != "NA" && ucase(trim(form.SECONDARYSCHOOL)) != "N/A")
		{
			Egin21educationd = CreateObject("component","query");
			Egin21educationd.setName('Egin21educationd');
			Egin21educationd.setDataSource(client.global_dsn);
			Egin21educationd.addParam(name="guid",value='#guid#',cfsqltype='cf_sql_varchar');
			Egin21educationd.addParam(name="applicantnumber",value='#applicantnumber#',cfsqltype='cf_sql_varchar');
			Egin21educationd.addParam(name="SECONDARYSCHOOL",value='#trim(form.SECONDARYSCHOOL)#',cfsqltype='cf_sql_varchar');
			Egin21educationd.addParam(name="SECONDARY",value='SECONDARY',cfsqltype='cf_sql_varchar');
			Egin21educationd.addParam(name="SECONDARYLOCATION",value='#trim(form.SECONDARYLOCATION)#',cfsqltype='cf_sql_varchar');
			Egin21educationd.addParam(name="SECONDARYCOURSE",value='#trim(form.SECONDARYCOURSE)#',cfsqltype='cf_sql_varchar');
			if(trim(form.SECONDARYFROM) == "")
			{
				Egin21educationd.addParam(name="SECONDARYFROM",value='#dateformat(now(),"YYYY-MM-DD")#',cfsqltype='cf_sql_date');
			}
			else
			{
				Egin21educationd.addParam(name="SECONDARYFROM",value='#trim(form.SECONDARYFROM)#',cfsqltype='cf_sql_date');
			}
			Egin21educationd.addParam(name="SECONDARYTO",value='#trim(form.SECONDARYTO)#',cfsqltype='cf_sql_date');
			Egin21educationd.addParam(name="SECONDARYISGRAD",value='#trim(form.SECONDARYISGRAD)#',cfsqltype='cf_sql_varchar');
			Egin21educationd.addParam(name="SECONDARYHONORS",value='#trim(form.SECONDARYHONORS)#',cfsqltype='cf_sql_varchar');
			Egin21educationd.addParam(name="REFERENCECODE",value='#trim(form.REFERENCECODE)#',cfsqltype='cf_sql_varchar');
			Egin21educationd.setSql("
				INSERT INTO EGIN21EDUCATION (GUID,PERSONNELIDNO,SCHOOLNAME,EDUCLEVEL,LOCATION,COURSECODE,SCHOOLCODE,DATEBEGIN,DATEFINISHED,GRADUATE,HONORSRECEIVED,REFERENCECODE)
	                                 VALUES (:guid,:applicantnumber,:SECONDARYSCHOOL,:SECONDARY,:SECONDARYLOCATION,:SECONDARYCOURSE,:SECONDARYSCHOOL, :SECONDARYFROM,:SECONDARYTO,:SECONDARYISGRAD,:SECONDARYHONORS,:REFERENCECODE);
			");
			result = Egin21educationd.execute();
		}

		return 'true';
	}

	public string function insertIntoEgin21empextra(required string guid, required string applicantnumber, required numeric a)
	{

		Egin21empextra = CreateObject("component","query");
		Egin21empextra.setName('Egin21empextra');
		Egin21empextra.setDataSource(client.global_dsn);
		Egin21empextra.addParam(name="guid",value='#guid#',cfsqltype='cf_sql_varchar');
		Egin21empextra.addParam(name="applicantnumber",value='#applicantnumber#',cfsqltype='cf_sql_varchar');
		if(ListLen(form.EXTRAORGNAME,",",true) >= a) {
			Egin21empextra.addParam(name="EXTRAORGNAME",value='#trim(ListGetAt(form.EXTRAORGNAME,a,",",true))#',cfsqltype='cf_sql_varchar');
		} else {
			return "true";
		}
		if(ListLen(form.EXTRAORGHIGHPOSHELD,",",true) >= a) {
			Egin21empextra.addParam(name="EXTRAORGHIGHPOSHELD",value='#trim(ListGetAt(form.EXTRAORGHIGHPOSHELD,a,",",true))#',cfsqltype='cf_sql_varchar');
		} else {
			Egin21empextra.addParam(name="EXTRAORGHIGHPOSHELD",value=" ",cfsqltype='cf_sql_varchar');
		}
		if(ListLen(form.EXTRAORGIDATE,",",true) >= a) {
			orgdate1 = trim(ListGetAt(form.EXTRAORGIDATE,a,",",true));
		} else {
			orgdate1 = "";
		}
		if(ListLen(form.EXTRAORGIDATE2,",",true) >= a) {
			orgdate2 = trim(ListGetAt(form.EXTRAORGIDATE2,a,",",true));
		} else {
			orgdate2 = "";
		}
		Egin21empextra.addParam(name="EXTRAORGIDATE",value='#orgdate1# - #orgdate2#',cfsqltype='cf_sql_varchar');
		Egin21empextra.addParam(name="REFERENCECODE",value='#trim(form.REFERENCECODE)#',cfsqltype='cf_sql_varchar');
		Egin21empextra.setSql("
			INSERT INTO EGIN21EMPEXTRA (GUID,PERSONNELIDNO,ORGANIZATION,PERIODCOVERED,HIGHESTPOSITION,REFERENCECODE)
                                VALUES (:guid,:applicantnumber,:EXTRAORGNAME,:EXTRAORGIDATE,:EXTRAORGHIGHPOSHELD,:REFERENCECODE);
		");
		result = Egin21empextra.execute();
		return 'true';
	}

	public string function insertIntoEgin21exampass(required string guid, required string applicantnumber, required numeric a)
	{
		Egin21exampass = CreateObject("component","query");
		Egin21exampass.setName('Egin21exampass');
		Egin21exampass.setDataSource(client.global_dsn);
		Egin21exampass.addParam(name="guid",value='#guid#',cfsqltype='cf_sql_varchar');
		Egin21exampass.addParam(name="applicantnumber",value='#applicantnumber#',cfsqltype='cf_sql_varchar');
		if(ListLen(form.GOVEXAMPASSED,",",true) >= a) {
			Egin21exampass.addParam(name="GOVEXAMPASSED",value='#trim(ListGetAt(form.GOVEXAMPASSED,a,",",true))#',cfsqltype='cf_sql_varchar');
		} else {
			return "true";
		}
		if(ListLen(form.GOVEXAMDATE,",",true) >= a) {
			Egin21exampass.addParam(name="GOVEXAMDATE",value='#Createodbcdatetime(trim(ListGetAt(form.GOVEXAMDATE,a,",",true)))#',cfsqltype='cf_sql_date');
		} else {
			Egin21exampass.addParam(name="GOVEXAMDATE",null="true",cfsqltype='cf_sql_date');
		}
		if(ListLen(form.GOVEXAMRATING,",",true) >= a) {
			Egin21exampass.addParam(name="GOVEXAMRATING",value='#trim(ListGetAt(form.GOVEXAMRATING,a,",",true))#',cfsqltype='cf_sql_varchar');
		} else {
			Egin21exampass.addParam(name="GOVEXAMRATING",null="true",cfsqltype='cf_sql_varchar');
		}
		Egin21exampass.addParam(name="REFERENCECODE",value='#trim(form.REFERENCECODE)#',cfsqltype='cf_sql_varchar');
		Egin21exampass.setSql("
			INSERT INTO EGIN21EXAMPASS (GUID,PERSONNELIDNO,DATETAKENPASSED,RATING,TYPEOFEXAM,REFERENCECODE)
								VALUES (:guid,:applicantnumber,:GOVEXAMDATE,:GOVEXAMRATING,:GOVEXAMPASSED,:REFERENCECODE);
		");

		result = Egin21exampass.execute();
		return 'true';
	}

	public string function insertIntoEgin21achievements(required string guid, required string applicantnumber)
	{
		if(trim(form.BOARDEXAMRESULT) != "" && ucase(trim(form.BOARDEXAMRESULT)) != "NA" && ucase(trim(form.BOARDEXAMRESULT)) != "N/A")
		{
			Egin21exampass = CreateObject("component","query");
			Egin21exampass.setName('Egin21exampass');
			Egin21exampass.setDataSource(client.global_dsn);
			Egin21exampass.addParam(name="guid",value='#guid#',cfsqltype='cf_sql_varchar');
			Egin21exampass.addParam(name="applicantnumber",value='#applicantnumber#',cfsqltype='cf_sql_varchar');
			Egin21exampass.addParam(name="EXAMPASSED",value='#trim(form.BOARDEXAMRESULT)#',cfsqltype='cf_sql_varchar');
			Egin21exampass.addParam(name="EXAMRATING",value='#trim(form.LICENSECERT)#',cfsqltype='cf_sql_varchar');
			Egin21exampass.addParam(name="LICENSENUMBER",value='#trim(form.LICENSENUMBER)#',cfsqltype='cf_sql_varchar');
			Egin21exampass.addParam(name="REFERENCECODE",value='#trim(form.REFERENCECODE)#',cfsqltype='cf_sql_varchar');
			Egin21exampass.addParam(name="DATETAKENPASSED",value='#CreateODBCDateTime(now())#',cfsqltype='cf_sql_date');
			Egin21exampass.setSql("
				INSERT INTO EGIN21EXAMPASS (GUID,PERSONNELIDNO,RATING,TYPEOFEXAM,LICENSENUMBER,DATETAKENPASSED,REFERENCECODE)
									VALUES (:guid,:applicantnumber,:EXAMRATING,:EXAMPASSED,:LICENSENUMBER,:DATETAKENPASSED,:REFERENCECODE);
			");
			result = Egin21exampass.execute();
		}

		return 'true';
	}

	public string function insertIntoEgin21medhistory(required string guid, required string applicantnumber)
	{
		if(trim(form.BLOODTYPE) != "" && ucase(trim(form.BLOODTYPE)) != "NA" && ucase(trim(form.BLOODTYPE)) != "N/A")
		{
			Egin21medhistory = CreateObject("component","query");
			Egin21medhistory.setName('Egin21medhistory');
			Egin21medhistory.setDataSource(client.global_dsn);
			Egin21medhistory.addParam(name="guid",value='#guid#',cfsqltype='cf_sql_varchar');
			Egin21medhistory.addParam(name="applicantnumber",value='#applicantnumber#',cfsqltype='cf_sql_varchar');
			Egin21medhistory.addParam(name="BLOODTYPE",value='#trim(form.BLOODTYPE)#',cfsqltype='cf_sql_varchar');
			Egin21medhistory.addParam(name="REFERENCECODE",value='#trim(form.REFERENCECODE)#',cfsqltype='cf_sql_varchar');
			Egin21medhistory.setSql("
				INSERT INTO EGIN21MEDHISTORY (GUID,PERSONNELIDNO,BLOODTYPE,REFERENCECODE)
									  VALUES (:guid,:applicantnumber,:BLOODTYPE,:REFERENCECODE);
			");
			result = Egin21medhistory.execute();
		}

		return 'true';
	}

	public string function insertIntoEgin21training(required string guid, required string applicantnumber, required numeric a)
	{
		Egin21training = CreateObject("component","query");
		Egin21training.setName('Egin21training');
		Egin21training.setDataSource(client.global_dsn);
		Egin21training.addParam(name="guid",value='#guid#',cfsqltype='cf_sql_varchar');
		Egin21training.addParam(name="applicantnumber",value='#applicantnumber#',cfsqltype='cf_sql_varchar');
		if(ListLen(form.SEMINARTOPIC,",",true) >= a) {
			Egin21training.addParam(name="SEMINARTOPIC",value='#trim(ListGetAt(form.SEMINARTOPIC,a,",",true))#',cfsqltype='cf_sql_varchar');
		} else {
			return "true";
		}
		if(ListLen(form.SEMINARDATE,",",true) >= a) {
			Egin21training.addParam(name="SEMINARDATE",value='#trim(ListGetAt(form.SEMINARDATE,a,",",true))#',cfsqltype='cf_sql_varchar');
		} else {
			Egin21training.addParam(name="SEMINARDATE",null="true",cfsqltype='cf_sql_varchar');
		}

		if(ListLen(form.SEMINARORGANIZER,",",true) >= a) {
			Egin21training.addParam(name="SEMINARORGANIZER",value='#trim(ListGetAt(form.SEMINARORGANIZER,a,",",true))#',cfsqltype='cf_sql_varchar');
		} else {
			Egin21training.addParam(name="SEMINARORGANIZER",null="true",cfsqltype='cf_sql_varchar');
		}

		Egin21training.addParam(name="SEQREFERENCE",value='#trim(form.REFERENCECODE)#',cfsqltype='cf_sql_varchar');
		Egin21training.setSql("
			INSERT INTO EGIN21TRAINING (GUID,PERSONNELIDNO,INCLUSIVEDATE,TOPIC,REMARKS,REFERENCECODE)
								VALUES (:guid,:applicantnumber,:SEMINARDATE,:SEMINARTOPIC,:SEMINARORGANIZER,:SEQREFERENCE);
		");
		result = Egin21training.execute();
		return 'true';
	}

	public string function insertIntoEgin21workhistory(required string guid, required string applicantnumber, required numeric a)
	{
		Egin21workhistory = CreateObject("component","query");
		Egin21workhistory.setName('Egin21workhistory');
		Egin21workhistory.setDataSource(client.global_dsn);
		Egin21workhistory.addParam(name="guid",value='#guid#',cfsqltype='cf_sql_varchar');
		Egin21workhistory.addParam(name="applicantnumber",value='#applicantnumber#',cfsqltype='cf_sql_varchar');
		if(ListLen(form.EMPHISTORYNAME,",",true) >= a) {
			Egin21workhistory.addParam(name="EMPHISTORYNAME",value='#trim(ListGetAt(form.EMPHISTORYNAME,a,",",true))#',cfsqltype='cf_sql_varchar');
		} else {
			return "true";
		}
		if(ListLen(form.EMPHISTORYADDRESS,",",true) >= a) {
			Egin21workhistory.addParam(name="EMPHISTORYADDRESS",value='#trim(ListGetAt(form.EMPHISTORYADDRESS,a,",",true))#',cfsqltype='cf_sql_varchar');
		} else {
			Egin21workhistory.addParam(name="EMPHISTORYADDRESS",null="true",cfsqltype='cf_sql_varchar');
		}
		if(ListLen(form.EMPHISTORYDATEEMP,",",true) >= a) {
			Egin21workhistory.addParam(name="EMPHISTORYDATEEMP",value='#trim(ListGetAt(form.EMPHISTORYDATEEMP,a,",",true))#',cfsqltype='cf_sql_date');
		} else {
			Egin21workhistory.addParam(name="EMPHISTORYDATEEMP",null="true",cfsqltype='cf_sql_date');
		}
		if(ListLen(form.EMPHISTORYDATESEP,",",true) >= a) {
			Egin21workhistory.addParam(name="EMPHISTORYDATESEP",value='#trim(ListGetAt(form.EMPHISTORYDATESEP,a,",",true))#',cfsqltype='cf_sql_date');
		} else {
			Egin21workhistory.addParam(name="EMPHISTORYDATESEP",null="true",cfsqltype='cf_sql_date');
		}
		if(ListLen(form.EMPHISTORYINISALARY,",",true) >= a) {
			Egin21workhistory.addParam(name="EMPHISTORYINISALARY",value='#trim(ListGetAt(form.EMPHISTORYINISALARY,a,",",true))#',cfsqltype='cf_sql_integer');
		} else {
			Egin21workhistory.addParam(name="EMPHISTORYINISALARY",null="true",cfsqltype='cf_sql_integer');
		}
		if(ListLen(form.EMPHISTORYLASTSALARY,",",true) >= a) {
			Egin21workhistory.addParam(name="EMPHISTORYLASTSALARY",value='#trim(ListGetAt(form.EMPHISTORYLASTSALARY,a,",",true))#',cfsqltype='cf_sql_integer');
		} else {
			Egin21workhistory.addParam(name="EMPHISTORYLASTSALARY",null="true",cfsqltype='cf_sql_integer');
		}
		if(ListLen(form.EMPHISTORYLASTPOS,",",true) >= a) {
			Egin21workhistory.addParam(name="EMPHISTORYLASTPOS",value='#trim(ListGetAt(form.EMPHISTORYLASTPOS,a,",",true))#',cfsqltype='cf_sql_varchar');
		} else {
			Egin21workhistory.addParam(name="EMPHISTORYLASTPOS",null="true",cfsqltype='cf_sql_varchar');
		}
		if(ListLen(form.EMPHISTORYSUPERIOR,",",true) >= a) {
			Egin21workhistory.addParam(name="EMPHISTORYSUPERIOR",value='#trim(ListGetAt(form.EMPHISTORYSUPERIOR,a,",",true))#',cfsqltype='cf_sql_varchar');
		} else {
			Egin21workhistory.addParam(name="EMPHISTORYSUPERIOR",null="true",cfsqltype='cf_sql_varchar');
		}
		if(ListLen(form.EMPHISTORYLEAVEREASONS,",",true) >= a) {
			Egin21workhistory.addParam(name="EMPHISTORYLEAVEREASONS",value='#trim(ListGetAt(form.EMPHISTORYLEAVEREASONS,a,",",true))#',cfsqltype='cf_sql_varchar');
		} else {
			Egin21workhistory.addParam(name="EMPHISTORYLEAVEREASONS",null="true",cfsqltype='cf_sql_varchar');
		}
		if(ListLen(form.EMPHISTORYPOSITION,",",true) >= a) {
			Egin21workhistory.addParam(name="EMPHISTORYPOSITION",value='#trim(ListGetAt(form.EMPHISTORYPOSITION,a,",",true))#',cfsqltype='cf_sql_varchar');
		} else {
			Egin21workhistory.addParam(name="EMPHISTORYPOSITION",null="true",cfsqltype='cf_sql_varchar');
		}
		if(ListLen(form.EMPHISTORYCONTACTNO,",",true) >= a) {
			Egin21workhistory.addParam(name="EMPHISTORYCONTACTNO",value='#trim(ListGetAt(form.EMPHISTORYCONTACTNO,a,",",true))#',cfsqltype='cf_sql_varchar');
		} else {
			Egin21workhistory.addParam(name="EMPHISTORYCONTACTNO",null="true",cfsqltype='cf_sql_varchar');
		}
		if(ListLen(form.EMPHISTORYCONTACTINFO,",",true) >= a) {
			Egin21workhistory.addParam(name="EMPHISTORYCONTACTINFO",value='#trim(ListGetAt(form.EMPHISTORYCONTACTINFO,a,",",true))#',cfsqltype='cf_sql_varchar');
		} else {
			Egin21workhistory.addParam(name="EMPHISTORYCONTACTINFO",null="true",cfsqltype='cf_sql_varchar');
		}
		if(ListLen(form.EMPHISTORYACCOMPLISHMENT,",",true) >= a) {
			Egin21workhistory.addParam(name="EMPHISTORYACCOMPLISHMENT",value='#trim(ListGetAt(form.EMPHISTORYACCOMPLISHMENT,a,",",true))#',cfsqltype='cf_sql_varchar');
		} else {
			Egin21workhistory.addParam(name="EMPHISTORYACCOMPLISHMENT",null="true",cfsqltype='cf_sql_varchar');
		}


		Egin21workhistory.addParam(name="REFERENCECODE",value='#trim(form.REFERENCECODE)#',cfsqltype='cf_sql_varchar');
		Egin21workhistory.setSql("
			INSERT INTO EGIN21WORKHISTORY (GUID,PERSONNELIDNO,ENTITYCODE,MAINDUTIES,DATEHIRED,SEPARATIONDATE,WORKSTARTINGSALARY,WORKENDINGSALARY,LASTPOSITIONHELD,SUPERIOR,REASONFORLEAVING,SUPERIORPOSITION,SUPERIORCONTACT,COMPANYCONTACT,ACCOMPLISHMENT,REFERENCECODE)
							       VALUES (:guid,:applicantnumber,:EMPHISTORYNAME,:EMPHISTORYADDRESS,:EMPHISTORYDATEEMP,:EMPHISTORYDATESEP,:EMPHISTORYINISALARY,:EMPHISTORYLASTSALARY,:EMPHISTORYLASTPOS,:EMPHISTORYSUPERIOR,:EMPHISTORYLEAVEREASONS,:EMPHISTORYPOSITION,:EMPHISTORYCONTACTNO,:EMPHISTORYCONTACTINFO,:EMPHISTORYACCOMPLISHMENT,:REFERENCECODE);
		");
		result = Egin21workhistory.execute();
		return 'true';
	}

	public string function insertIntoEgin21relative(required string guid, required string applicantnumber)
	{
		if(trim(form.RELWORKINNAMEONE) != "" && ucase(trim(form.RELWORKINNAMEONE)) != "NA" && ucase(trim(form.RELWORKINNAMEONE)) != "N/A")
		{
			Egin21relative = CreateObject("component","query");
			Egin21relative.setName('Egin21relative');
			Egin21relative.setDataSource(client.global_dsn);
			Egin21relative.addParam(name="guid",value='#guid#',cfsqltype='cf_sql_varchar');
			Egin21relative.addParam(name="applicantnumber",value='#applicantnumber#',cfsqltype='cf_sql_varchar');
			Egin21relative.addParam(name="RELWORKINNAMEONE",value='#trim(form.RELWORKINNAMEONE)#',cfsqltype='cf_sql_varchar');
			Egin21relative.addParam(name="RELWORKINCOMPONE",value='#trim(form.RELWORKINCOMPONE)#',cfsqltype='cf_sql_varchar');
			Egin21relative.addParam(name="RELWORKINAFINITYONE",value='#trim(form.RELWORKINAFINITYONE)#',cfsqltype='cf_sql_varchar');
			Egin21relative.addParam(name="REFERENCECODE",value='#trim(form.REFERENCECODE)#',cfsqltype='cf_sql_varchar');
			Egin21relative.setSql("
				INSERT INTO EGIN21RELATIVE (GUID,PERSONNELIDNO,NAME,COMPANY,POSITION,REFERENCECODE)
								   VALUES (:guid,:applicantnumber,:RELWORKINNAMEONE,:RELWORKINCOMPONE,:RELWORKINAFINITYONE,:REFERENCECODE);
			");
			result = Egin21relative.execute();
		}

		if(trim(form.RELWORKINNAMETWO) != "" && ucase(trim(form.RELWORKINNAMETWO)) != "NA" && ucase(trim(form.RELWORKINNAMETWO)) != "N/A")
		{
			Egin21relativeb = CreateObject("component","query");
			Egin21relativeb.setName('Egin21relativeb');
			Egin21relativeb.setDataSource(client.global_dsn);
			Egin21relativeb.addParam(name="guid",value='#guid#',cfsqltype='cf_sql_varchar');
			Egin21relativeb.addParam(name="applicantnumber",value='#applicantnumber#',cfsqltype='cf_sql_varchar');
			Egin21relativeb.addParam(name="RELWORKINNAMETWO",value='#trim(form.RELWORKINNAMETWO)#',cfsqltype='cf_sql_varchar');
			Egin21relativeb.addParam(name="RELWORKINCOMPTWO",value='#trim(form.RELWORKINCOMPTWO)#',cfsqltype='cf_sql_varchar');
			Egin21relativeb.addParam(name="RELWORKINAFINITYTWO",value='#trim(form.RELWORKINAFINITYTWO)#',cfsqltype='cf_sql_varchar');
			Egin21relativeb.addParam(name="REFERENCECODE",value='#trim(form.REFERENCECODE)#',cfsqltype='cf_sql_varchar');
			Egin21relativeb.setSql("
				INSERT INTO EGIN21RELATIVE ( GUID,PERSONNELIDNO,NAME,COMPANY,POSITION,REFERENCECODE)
								    VALUES (:guid,:applicantnumber,:RELWORKINNAMETWO,:RELWORKINCOMPTWO,:RELWORKINAFINITYTWO,:REFERENCECODE);
			");
			result = Egin21relativeb.execute();
		}

		if(trim(form.RELWORKINNAMETHREE) != "" && ucase(trim(form.RELWORKINNAMETHREE)) != "NA" && ucase(trim(form.RELWORKINNAMETHREE)) != "N/A")
		{
			Egin21relativec = CreateObject("component","query");
			Egin21relativec.setName('Egin21relativec');
			Egin21relativec.setDataSource(client.global_dsn);
			Egin21relativec.addParam(name="guid",value='#guid#',cfsqltype='cf_sql_varchar');
			Egin21relativec.addParam(name="applicantnumber",value='#applicantnumber#',cfsqltype='cf_sql_varchar');
			Egin21relativec.addParam(name="RELWORKINNAMETHREE",value='#trim(form.RELWORKINNAMETHREE)#',cfsqltype='cf_sql_varchar');
			Egin21relativec.addParam(name="RELWORKINCOMPTHREE",value='#trim(form.RELWORKINCOMPTHREE)#',cfsqltype='cf_sql_varchar');
			Egin21relativec.addParam(name="RELWORKINAFINITYTHREE",value='#trim(form.RELWORKINAFINITYTHREE)#',cfsqltype='cf_sql_varchar');
			Egin21relativec.addParam(name="REFERENCECODE",value='#trim(form.REFERENCECODE)#',cfsqltype='cf_sql_varchar');
			Egin21relativec.setSql("
				INSERT INTO EGIN21RELATIVE (GUID,PERSONNELIDNO,NAME,COMPANY,POSITION,REFERENCECODE)
								    VALUES (:guid,:applicantnumber,:RELWORKINNAMETHREE,:RELWORKINCOMPTHREE,:RELWORKINAFINITYTHREE,:REFERENCECODE);
			");
			result = Egin21relativec.execute();
		}

		return 'true';
	}

	public string function insertIntoEgin21miscinfo1(required string guid, required string applicantnumber, required numeric a)
	{
		Egin21miscinfo1 = CreateObject("component","query");
		Egin21miscinfo1.setName('Egin21miscinfo1');
		Egin21miscinfo1.setDataSource(client.global_dsn);
		Egin21miscinfo1.addParam(name="guid",value='#guid#',cfsqltype='cf_sql_varchar');
		Egin21miscinfo1.addParam(name="applicantnumber",value='#applicantnumber#',cfsqltype='cf_sql_varchar');
		if(ListLen(form.SPECIALSKILLS,",",true) >= a) {
			Egin21miscinfo1.addParam(name="SPECIALSKILLS",value='#trim(ListGetAt(form.SPECIALSKILLS,a,",",true))#',cfsqltype='cf_sql_varchar');
		} else {
			return "true";
		}
		if(ListLen(form.SPECIALSKILLSYEARSP,",",true) >= a) {
			Egin21miscinfo1.addParam(name="SPECIALSKILLSYEARSP",value='#trim(ListGetAt(form.SPECIALSKILLSYEARSP,a,",",true))#',cfsqltype='cf_sql_varchar');
		} else {
			Egin21miscinfo1.addParam(name="SPECIALSKILLSYEARSP",null="true",cfsqltype='cf_sql_varchar');
		}
		if(ListLen(form.SPECIALSKILLSLEVEL,",",true) >= a) {
			Egin21miscinfo1.addParam(name="SPECIALSKILLSLEVEL",value='#trim(ListGetAt(form.SPECIALSKILLSLEVEL,a,",",true))#',cfsqltype='cf_sql_varchar');
		} else {
			Egin21miscinfo1.addParam(name="SPECIALSKILLSLEVEL",null="true",cfsqltype='cf_sql_varchar');
		}
		Egin21miscinfo1.addParam(name="REFERENCECODE",value='#trim(form.REFERENCECODE)#',cfsqltype='cf_sql_varchar');
		Egin21miscinfo1.setSql("
			INSERT INTO EGIN21MISCINFO1 (GUID,PERSONNELIDNO,SPECIALTALENTS,CLASSIFICATION,RANKHELD,REFERENCECODE)
							     VALUES (:guid,:applicantnumber,:SPECIALSKILLS,:SPECIALSKILLSYEARSP,:SPECIALSKILLSLEVEL,:REFERENCECODE);
		");
		result = Egin21miscinfo1.execute();
		return 'true';
	}

	public string function insertIntoEgin21chareference(required string guid, required string applicantnumber)
	{
		if(trim(form.REFERENCENAME1) != "" && ucase(trim(form.REFERENCENAME1)) != "NA" && ucase(trim(form.REFERENCENAME1)) != "N/A")
		{
			Egin21chareference = CreateObject("component","query");
			Egin21chareference.setName('Egin21chareference');
			Egin21chareference.setDataSource(client.global_dsn);
			Egin21chareference.addParam(name="guid",value='#guid#',cfsqltype='cf_sql_varchar');
			Egin21chareference.addParam(name="applicantnumber",value='#applicantnumber#',cfsqltype='cf_sql_varchar');
			Egin21chareference.addParam(name="REFERENCENAME1",value='#trim(form.REFERENCENAME1)#',cfsqltype='cf_sql_varchar');
			Egin21chareference.addParam(name="REFERENCEOCCUPATION1",value='#trim(form.REFERENCEOCCUPATION1)#',cfsqltype='cf_sql_varchar');
			Egin21chareference.addParam(name="REFERENCECOMPANY1",value='#trim(form.REFERENCECOMPANY1)#',cfsqltype='cf_sql_varchar');
			Egin21chareference.addParam(name="REFERENCECONTACT1",value='#trim(form.REFERENCECONTACT1)#',cfsqltype='cf_sql_varchar');
			Egin21chareference.addParam(name="REFERENCECODE",value='#trim(form.REFERENCECODE)#',cfsqltype='cf_sql_varchar');
			Egin21chareference.setSql("
				INSERT INTO  EGIN21CHAREFERENCE (GUID,PERSONNELIDNO,NAME,OCCUPATION,COMPANY,CELLULARPHONE,REFERENCECODE)
										 VALUES (:guid,:applicantnumber,:REFERENCENAME1,:REFERENCEOCCUPATION1,:REFERENCECOMPANY1,:REFERENCECONTACT1,:REFERENCECODE);
			");
			result = Egin21chareference.execute();
		}

		if(trim(form.REFERENCENAME2) != "" && ucase(trim(form.REFERENCENAME2)) != "NA" && ucase(trim(form.REFERENCENAME2)) != "N/A")
		{
			Egin21chareferenceb = CreateObject("component","query");
			Egin21chareferenceb.setName('Egin21chareferenceb');
			Egin21chareferenceb.setDataSource(client.global_dsn);
			Egin21chareferenceb.addParam(name="guid",value='#guid#',cfsqltype='cf_sql_varchar');
			Egin21chareferenceb.addParam(name="applicantnumber",value='#applicantnumber#',cfsqltype='cf_sql_varchar');
			Egin21chareferenceb.addParam(name="REFERENCENAME2",value='#trim(form.REFERENCENAME2)#',cfsqltype='cf_sql_varchar');
			Egin21chareferenceb.addParam(name="REFERENCEOCCUPATION2",value='#trim(form.REFERENCEOCCUPATION2)#',cfsqltype='cf_sql_varchar');
			Egin21chareferenceb.addParam(name="REFERENCECOMPANY2",value='#trim(form.REFERENCECOMPANY2)#',cfsqltype='cf_sql_varchar');
			Egin21chareferenceb.addParam(name="REFERENCECONTACT2",value='#trim(form.REFERENCECONTACT2)#',cfsqltype='cf_sql_varchar');
			Egin21chareferenceb.addParam(name="REFERENCECODE",value='#trim(form.REFERENCECODE)#',cfsqltype='cf_sql_varchar');
			Egin21chareferenceb.setSql("
				INSERT INTO  EGIN21CHAREFERENCE (GUID,PERSONNELIDNO,NAME,OCCUPATION,COMPANY,CELLULARPHONE,REFERENCECODE)
										 VALUES (:guid,:applicantnumber,:REFERENCENAME2,:REFERENCEOCCUPATION2,:REFERENCECOMPANY2,:REFERENCECONTACT2,:REFERENCECODE);
			");
			result = Egin21chareferenceb.execute();
		}

		if(trim(form.REFERENCENAME3) != "" && ucase(trim(form.REFERENCENAME3)) != "NA" && ucase(trim(form.REFERENCENAME3)) != "N/A")
		{
			Egin21chareferencec = CreateObject("component","query");
			Egin21chareferencec.setName('Egin21chareferencec');
			Egin21chareferencec.setDataSource(client.global_dsn);
			Egin21chareferencec.addParam(name="guid",value='#guid#',cfsqltype='cf_sql_varchar');
			Egin21chareferencec.addParam(name="applicantnumber",value='#applicantnumber#',cfsqltype='cf_sql_varchar');
			Egin21chareferencec.addParam(name="REFERENCENAME3",value='#trim(form.REFERENCENAME3)#',cfsqltype='cf_sql_varchar');
			Egin21chareferencec.addParam(name="REFERENCEOCCUPATION3",value='#trim(form.REFERENCEOCCUPATION3)#',cfsqltype='cf_sql_varchar');
			Egin21chareferencec.addParam(name="REFERENCECOMPANY3",value='#trim(form.REFERENCECOMPANY3)#',cfsqltype='cf_sql_varchar');
			Egin21chareferencec.addParam(name="REFERENCECONTACT3",value='#trim(form.REFERENCECONTACT3)#',cfsqltype='cf_sql_varchar');
			Egin21chareferencec.addParam(name="REFERENCECODE",value='#trim(form.REFERENCECODE)#',cfsqltype='cf_sql_varchar');
			Egin21chareferencec.setSql("
				INSERT INTO  EGIN21CHAREFERENCE (GUID,PERSONNELIDNO,NAME,OCCUPATION,COMPANY,CELLULARPHONE,REFERENCECODE)
										 VALUES (:guid,:applicantnumber,:REFERENCENAME3,:REFERENCEOCCUPATION3,:REFERENCECOMPANY3,:REFERENCECONTACT3,:REFERENCECODE);
			");
			result = Egin21chareferencec.execute();
		}

		return 'true';
	}

	public string function insertIntoEgin21empviol(required string guid, required string applicantnumber)
	{
		Egin21empviol = CreateObject("component","query");
		Egin21empviol.setName('Egin21empviol');
		Egin21empviol.setDataSource(client.global_dsn);
		Egin21empviol.addParam(name="guid",value='#guid#',cfsqltype='cf_sql_varchar');
		Egin21empviol.addParam(name="applicantnumber",value='#applicantnumber#',cfsqltype='cf_sql_varchar');
		Egin21empviol.addParam(name="defects",value='defects',cfsqltype='cf_sql_varchar');
		Egin21empviol.addParam(name="HASPHYSICALDEFFECTS",value='#trim(form.HASPHYSICALDEFFECTS)#',cfsqltype='cf_sql_varchar');
		Egin21empviol.addParam(name="HASPHYSICALDEFFECTSNATURE",value='#trim(form.HASPHYSICALDEFFECTSNATURE)#',cfsqltype='cf_sql_varchar');
		Egin21empviol.addParam(name="REFERENCECODE",value='#trim(form.REFERENCECODE)#',cfsqltype='cf_sql_varchar');
		Egin21empviol.setSql("
			INSERT INTO EGIN21EMPVIOL (GUID,PERSONNELIDNO,CASENUMBER,CASENAME,CASESTATUS,REFERENCECODE)
							   VALUES (:guid,:applicantnumber,:defects,:HASPHYSICALDEFFECTS,:HASPHYSICALDEFFECTSNATURE,:REFERENCECODE);
		");
		result = Egin21empviol.execute();

		Egin21empviolb = CreateObject("component","query");
		Egin21empviolb.setName('Egin21empviolb');
		Egin21empviolb.setDataSource(client.global_dsn);
		Egin21empviolb.addParam(name="guid",value='#guid#',cfsqltype='cf_sql_varchar');
		Egin21empviolb.addParam(name="applicantnumber",value='#applicantnumber#',cfsqltype='cf_sql_varchar');
		Egin21empviolb.addParam(name="illness",value='illness',cfsqltype='cf_sql_varchar');
		Egin21empviolb.addParam(name="HASOPILLNESS",value='#trim(form.HASOPILLNESS)#',cfsqltype='cf_sql_varchar');
		Egin21empviolb.addParam(name="HASOPILLNESSNATURE",value='#trim(form.HASOPILLNESSNATURE)#',cfsqltype='cf_sql_varchar');
		Egin21empviolb.addParam(name="REFERENCECODE",value='#trim(form.REFERENCECODE)#',cfsqltype='cf_sql_varchar');
		Egin21empviolb.setSql("
			INSERT INTO EGIN21EMPVIOL (GUID,PERSONNELIDNO,CASENUMBER,CASENAME,CASESTATUS,REFERENCECODE)
							   VALUES (:guid,:applicantnumber,:illness,:HASOPILLNESS,:HASOPILLNESSNATURE,:REFERENCECODE );
		");
		result = Egin21empviolb.execute();

		Egin21empviolc = CreateObject("component","query");
		Egin21empviolc.setName('Egin21empviolc');
		Egin21empviolc.setDataSource(client.global_dsn);
		Egin21empviolc.addParam(name="guid",value='#guid#',cfsqltype='cf_sql_varchar');
		Egin21empviolc.addParam(name="applicantnumber",value='#applicantnumber#',cfsqltype='cf_sql_varchar');
		Egin21empviolc.addParam(name="sensitive",value='sensitive',cfsqltype='cf_sql_varchar');
		Egin21empviolc.addParam(name="HASDRUGSENSITIVE",value='#trim(form.HASDRUGSENSITIVE)#',cfsqltype='cf_sql_varchar');
		Egin21empviolc.addParam(name="HASDRUGSENSITIVENATURE",value='#trim(form.HASDRUGSENSITIVENATURE)#',cfsqltype='cf_sql_varchar');
		Egin21empviolc.addParam(name="REFERENCECODE",value='#trim(form.REFERENCECODE)#',cfsqltype='cf_sql_varchar');
		Egin21empviolc.setSql("
			INSERT INTO EGIN21EMPVIOL (GUID,PERSONNELIDNO,CASENUMBER,CASENAME,CASESTATUS,REFERENCECODE)
							   VALUES (:guid,:applicantnumber,:sensitive,:HASDRUGSENSITIVE,:HASDRUGSENSITIVENATURE,:REFERENCECODE);
		");
		result = Egin21empviolc.execute();

		Egin21empviold = CreateObject("component","query");
		Egin21empviold.setName('Egin21empviold');
		Egin21empviold.setDataSource(client.global_dsn);
		Egin21empviold.addParam(name="guid",value='#guid#',cfsqltype='cf_sql_varchar');
		Egin21empviold.addParam(name="applicantnumber",value='#applicantnumber#',cfsqltype='cf_sql_varchar');
		Egin21empviold.addParam(name="dangerous",value='dangerous',cfsqltype='cf_sql_varchar');
		Egin21empviold.addParam(name="HASENGAGEDRUGS",value='#trim(form.HASENGAGEDRUGS)#',cfsqltype='cf_sql_varchar');
		Egin21empviold.addParam(name="HASENGAGEDRUGSNATURE",value='#trim(form.HASENGAGEDRUGSNATURE)#',cfsqltype='cf_sql_varchar');
		Egin21empviold.addParam(name="REFERENCECODE",value='#trim(form.REFERENCECODE)#',cfsqltype='cf_sql_varchar');
		Egin21empviold.setSql("
			INSERT INTO EGIN21EMPVIOL (GUID,PERSONNELIDNO,CASENUMBER,CASENAME,CASESTATUS,REFERENCECODE)
							   VALUES (:guid,:applicantnumber,:dangerous,:HASENGAGEDRUGS,:HASENGAGEDRUGSNATURE,:REFERENCECODE);
		");
		result = Egin21empviold.execute();

		Egin21empviole = CreateObject("component","query");
		Egin21empviole.setName('Egin21empviole');
		Egin21empviole.setDataSource(client.global_dsn);
		Egin21empviole.addParam(name="guid",value='#guid#',cfsqltype='cf_sql_varchar');
		Egin21empviole.addParam(name="applicantnumber",value='#applicantnumber#',cfsqltype='cf_sql_varchar');
		Egin21empviole.addParam(name="business",value='business',cfsqltype='cf_sql_varchar');
		Egin21empviole.addParam(name="HASINVOLVEBUSI",value='#trim(form.HASINVOLVEBUSI)#',cfsqltype='cf_sql_varchar');
		Egin21empviole.addParam(name="HASINVOLVEBUSINATURE",value='#trim(form.HASINVOLVEBUSINATURE)#',cfsqltype='cf_sql_varchar');
		Egin21empviole.addParam(name="REFERENCECODE",value='#trim(form.REFERENCECODE)#',cfsqltype='cf_sql_varchar');
		Egin21empviole.setSql("
			INSERT INTO EGIN21EMPVIOL (GUID,PERSONNELIDNO,CASENUMBER,CASENAME,CASESTATUS,REFERENCECODE)
							   VALUES (:guid,:applicantnumber,:business,:HASINVOLVEBUSI,:HASINVOLVEBUSINATURE,:REFERENCECODE);
		");
		result = Egin21empviole.execute();

		Egin21empviolf = CreateObject("component","query");
		Egin21empviolf.setName('Egin21empviolf');
		Egin21empviolf.setDataSource(client.global_dsn);
		Egin21empviolf.addParam(name="guid",value='#guid#',cfsqltype='cf_sql_varchar');
		Egin21empviolf.addParam(name="applicantnumber",value='#applicantnumber#',cfsqltype='cf_sql_varchar');
		Egin21empviolf.addParam(name="suspended",value='suspended',cfsqltype='cf_sql_varchar');
		Egin21empviolf.addParam(name="HASSUSPENDED",value='#trim(form.HASSUSPENDED)#',cfsqltype='cf_sql_varchar');
		Egin21empviolf.addParam(name="HASSUSPENDEDNATURE",value='#trim(form.HASSUSPENDEDNATURE)#',cfsqltype='cf_sql_varchar');
		Egin21empviolf.addParam(name="REFERENCECODE",value='#trim(form.REFERENCECODE)#',cfsqltype='cf_sql_varchar');
		Egin21empviolf.setSql("
			INSERT INTO EGIN21EMPVIOL (GUID,PERSONNELIDNO,CASENUMBER,CASENAME,CASESTATUS,REFERENCECODE)
							   VALUES (:guid,:applicantnumber,:suspended,:HASSUSPENDED,:HASSUSPENDEDNATURE,:REFERENCECODE);
		");
		result = Egin21empviolf.execute();

		Egin21empviolg = CreateObject("component","query");
		Egin21empviolg.setName('Egin21empviolg');
		Egin21empviolg.setDataSource(client.global_dsn);
		Egin21empviolg.addParam(name="guid",value='#guid#',cfsqltype='cf_sql_varchar');
		Egin21empviolg.addParam(name="applicantnumber",value='#applicantnumber#',cfsqltype='cf_sql_varchar');
		Egin21empviolg.addParam(name="convicted",value='convicted',cfsqltype='cf_sql_varchar');
		Egin21empviolg.addParam(name="HASCRIMINAL",value='#trim(form.HASCRIMINAL)#',cfsqltype='cf_sql_varchar');
		Egin21empviolg.addParam(name="HASCRIMINALNATURE",value='#trim(form.HASCRIMINALNATURE)#',cfsqltype='cf_sql_varchar');
		Egin21empviolg.addParam(name="REFERENCECODE",value='#trim(form.REFERENCECODE)#',cfsqltype='cf_sql_varchar');
		Egin21empviolg.setSql("
			INSERT INTO EGIN21EMPVIOL (GUID,PERSONNELIDNO,CASENUMBER,CASENAME,CASESTATUS,REFERENCECODE)
							   VALUES (:guid,:applicantnumber,:convicted,:HASCRIMINAL,:HASCRIMINALNATURE,:REFERENCECODE);
		");
		result = Egin21empviolg.execute();

		return 'true';
	}

	public string function rollBackInsertedGobalPool()
	{
		Egmfap = CreateObject("component","query");
		Egmfap.setName('Egmfap');
		Egmfap.setDataSource(client.global_dsn);
		Egmfap.setSql("DELETE FROM Egmfap WHERE REFERENCECODE = '#trim(form.REFERENCECODE)#' ");
		result = Egmfap.execute();

		Egin21personalinfo = CreateObject("component","query");
		Egin21personalinfo.setName('Egin21personalinfo');
		Egin21personalinfo.setDataSource(client.global_dsn);
		Egin21personalinfo.setSql("DELETE FROM Egin21personalinfo WHERE REFERENCECODE = '#trim(form.REFERENCECODE)#' ");
		result = Egin21personalinfo.execute();

		Egin21positnapld = CreateObject("component","query");
		Egin21positnapld.setName('Egin21positnapld');
		Egin21positnapld.setDataSource(client.global_dsn);
		Egin21positnapld.setSql("DELETE FROM Egin21positnapld WHERE REFERENCECODE = '#trim(form.REFERENCECODE)#' ");
		result = Egin21positnapld.execute();

		Egin21familybkgrnd = CreateObject("component","query");
		Egin21familybkgrnd.setName('Egin21familybkgrnd');
		Egin21familybkgrnd.setDataSource(client.global_dsn);
		Egin21familybkgrnd.setSql("DELETE FROM Egin21familybkgrnd WHERE REFERENCECODE = '#trim(form.REFERENCECODE)#' ");
		result = Egin21familybkgrnd.execute();

		Egin21education = CreateObject("component","query");
		Egin21education.setName('Egin21education');
		Egin21education.setDataSource(client.global_dsn);
		Egin21education.setSql("DELETE FROM Egin21education WHERE REFERENCECODE = '#trim(form.REFERENCECODE)#' ");
		result = Egin21education.execute();

		Egin21empextra = CreateObject("component","query");
		Egin21empextra.setName('Egin21empextra');
		Egin21empextra.setDataSource(client.global_dsn);
		Egin21empextra.setSql("DELETE FROM Egin21empextra WHERE REFERENCECODE = '#trim(form.REFERENCECODE)#' ");
		result = Egin21empextra.execute();

		Egin21exampass = CreateObject("component","query");
		Egin21exampass.setName('Egin21exampass');
		Egin21exampass.setDataSource(client.global_dsn);
		Egin21exampass.setSql("DELETE FROM Egin21exampass WHERE REFERENCECODE = '#trim(form.REFERENCECODE)#' ");
		result = Egin21exampass.execute();

		Egin21achievements = CreateObject("component","query");
		Egin21achievements.setName('Egin21achievements');
		Egin21achievements.setDataSource(client.global_dsn);
		Egin21achievements.setSql("DELETE FROM Egin21achievements WHERE REFERENCECODE = '#trim(form.REFERENCECODE)#' ");
		result = Egin21achievements.execute();

		Egin21medhistory = CreateObject("component","query");
		Egin21medhistory.setName('Egin21medhistory');
		Egin21medhistory.setDataSource(client.global_dsn);
		Egin21medhistory.setSql("DELETE FROM Egin21medhistory WHERE REFERENCECODE = '#trim(form.REFERENCECODE)#' ");
		result = Egin21medhistory.execute();

		Egin21training = CreateObject("component","query");
		Egin21training.setName('Egin21training');
		Egin21training.setDataSource(client.global_dsn);
		Egin21training.setSql("DELETE FROM Egin21training WHERE REFERENCECODE = '#trim(form.REFERENCECODE)#' ");
		result = Egin21training.execute();

		Egin21workhistory = CreateObject("component","query");
		Egin21workhistory.setName('Egin21workhistory');
		Egin21workhistory.setDataSource(client.global_dsn);
		Egin21workhistory.setSql("DELETE FROM Egin21workhistory WHERE REFERENCECODE = '#trim(form.REFERENCECODE)#' ");
		result = Egin21workhistory.execute();

		Egin21relative = CreateObject("component","query");
		Egin21relative.setName('Egin21relative');
		Egin21relative.setDataSource(client.global_dsn);
		Egin21relative.setSql("DELETE FROM Egin21relative WHERE REFERENCECODE = '#trim(form.REFERENCECODE)#' ");
		result = Egin21relative.execute();

		Egin21miscinfo1 = CreateObject("component","query");
		Egin21miscinfo1.setName('Egin21miscinfo1');
		Egin21miscinfo1.setDataSource(client.global_dsn);
		Egin21miscinfo1.setSql("DELETE FROM Egin21miscinfo1 WHERE REFERENCECODE = '#trim(form.REFERENCECODE)#' ");
		result = Egin21miscinfo1.execute();

		Egin21chareference = CreateObject("component","query");
		Egin21chareference.setName('Egin21chareference');
		Egin21chareference.setDataSource(client.global_dsn);
		Egin21chareference.setSql("DELETE FROM Egin21chareference WHERE REFERENCECODE = '#trim(form.REFERENCECODE)#' ");
		result = Egin21chareference.execute();

		Egin21empviol = CreateObject("component","query");
		Egin21empviol.setName('Egin21empviol');
		Egin21empviol.setDataSource(client.global_dsn);
		Egin21empviol.setSql("DELETE FROM Egin21empviol WHERE REFERENCECODE = '#trim(form.REFERENCECODE)#' ");
		result = Egin21empviol.execute();

		return 'true';
	}



}
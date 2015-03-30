<cfset thelist = trim(url.refnum) /> 
<cfset count = ListLen(thelist, "~", "no")> 
   
<!---Initialize variables here--->

<cfset FIRSTNAME         			= "">
<cfset MIDDLENAME        			= "">  
<cfset LASTNAME          			= "">                      
<cfset PAGIBIGNUMBER     			= "">
<cfset SSSNUMBER         			= "">
<cfset TINNUMBER         			= "">
<cfset LANDLINENUMBER    			= "">  
<cfset COMPANYCODE       			= "">
<cfset CELLPHONENUMBER   			= "">
<cfset EMAILADDRESS      			= "">
<cfset REFERENCECODE     			= "">
<cfset REFERENCECODE     			= "">
<cfset SUFFIX            = "">
<cfset LASTNAME          = "">
<cfset FIRSTNAME         = "">
<cfset MIDDLENAME        = "">
<cfset DATEOFAPPLICATION = "">
<cfset POSITIONFIRSTPRIORITY = "">
<cfset SOURCEEMPLOYMENT  = "">
<cfset SOURCEOTHERVALUE  = "">
<cfset SOURCEJOBFAIRWHERE= "">
<cfset SOURCEJOBFAIRDATE = "">
<cfset SOURCEREFERREDBY  = "">
<cfset PAGIBIGNUMBER     = "">
<cfset SSSNUMBER         = "">
<cfset EXPECTEDSALARY    = 0>
<cfset TINNUMBER         = "">
<cfset EMAILADDRESS      = ""> 
<cfset CURRENTSALARY     = 0> 
<cfset PRESENTADDRESSPOSTAL = "">
<cfset PROVINCIALADDRESSPOSTAL = "">
<cfset DATEOFBIRTH       = "_">
<cfset PLACEOFBIRTH      = "">
<cfset AGE               = 0>
<cfset GENDER  			 = "">
<cfset CIVILSTATUS       = "">
<cfset CITIZENSHIP       = "">
<cfset RELIGION          = "">
<cfset CELLPHONENUMBER   = "">
<cfset LANDLINENUMBER    = "">
<cfset EMAILADDRESS      = ""> 
<cfset HEIGHT            = "">
<cfset WEIGHT            = "">
<cfset LANGUAGESPOKEN    = "">
<cfset INCASEEMERNAME    = "">					
<cfset INCASEEMERRELATION= "">
<cfset INCASEEMERTELNUM  = "">
<cfset INCASEEMERCELLNUM = "">  
<cfset PRESENTADDRESSOWN = "">
<cfset PROVINCEADDRESSOWN= "">
<cfset POSITIONFIRSTPRIORITY   = "">
<cfset POSITIONSECONDPRIORITY  = "">
<cfset POSITIONTHIRDPRIORITY   = "">
<cfset COMPANYFIRSTPRIORITY    = "">
<cfset COMPANYSECONDPRIORITY   = "">
<cfset COMPANYTHIRDPRIORITY    = "">
<cfset FATHERFULLNAME       = "">
<cfset FATHERAGE            = 0>
<cfset FATHEROCCUPATION     = "">
<cfset FATHERCOMPANY        = "">
<cfset FATHERCONTACTNO      = ""> 

<cfset MOTHERFULLNAME       = "">
<cfset MOTHERAGE            = 0>
<cfset MOTHEROCCUPATION     = "">
<cfset MOTHERCOMPANY        = "">
<cfset MOTHERCONTACTNO      = "">    

<cfset SPOUSEFULLNAME       = "">
<cfset SPOUSEAGE            = 0>
<cfset SPOUSEOCCUPATION     = "">
<cfset SPOUSECOMPANY        = "">
<cfset SPOUSECONTACTNO      = ""> 

<cfset FIRSTCHILDFULLNAME   = "">
<cfset FIRSTCHILDAGE        = 0>
<cfset FIRSTCHILDOCCUPATION = "">
<cfset FIRSTCHILDCOMPANY    = "">
<cfset FIRSTCHILDCONTACTNO  = ""> 

<cfset SECONDCHILDFULLNAME  = "">
<cfset SECONDCHILDAGE       = 0>
<cfset SECONDCHILDOCCUPATION= "">
<cfset SECONDCHILDCOMPANY   = "">
<cfset SECONDCHILDCONTACTNO = ""> 

<cfset THIRDCHILDFULLNAME   = "">
<cfset THIRDCHILDAGE        = 0>
<cfset THIRDCHILDOCCUPATION = "">
<cfset THIRDCHILDCOMPANY    = "">
<cfset THIRDCHILDCONTACTNO  = ""> 

<cfset FOURTHCHILDFULLNAME  = "">
<cfset FOURTHCHILDAGE       = 0>
<cfset FOURTHCHILDOCCUPATION= "">
<cfset FOURTHCHILDCOMPANY   = "">
<cfset FOURTHCHILDCONTACTNO = ""> 

<cfset FIFTHCHILDFULLNAME   = "">
<cfset FIFTHCHILDAGE        = 0>
<cfset FIFTHCHILDOCCUPATION = "">
<cfset FIFTHCHILDCOMPANY    = "">
<cfset FIFTHCHILDCONTACTNO  = ""> 

<cfset FIRSTBROFULLNAME     = "">
<cfset FIRSTBROAGE          = 0>
<cfset FIRSTBROOCCUPATION   = "">
<cfset FIRSTBROCOMPANY      = "">
<cfset FIRSTBROCONTACTNO    = ""> 

<cfset SECONDBROFULLNAME    = "">
<cfset SECONDBROAGE         = 0>
<cfset SECONDBROOCCUPATION  = "">
<cfset SECONDBROCOMPANY     = "">
<cfset SECONDBROCONTACTNO   = "">

<cfset THIRDBROFULLNAME     = "">
<cfset THIRDBROAGE          = 0>
<cfset THIRDBROOCCUPATION   = "">
<cfset THIRDBROCOMPANY      = "">
<cfset THIRDBROCONTACTNO    = ""> 

<cfset FOURTHBROFULLNAME    = "">
<cfset FOURTHBROAGE         = 0>
<cfset FOURTHBROOCCUPATION  = "">
<cfset FOURTHBROCOMPANY     = "">
<cfset FOURTHBROCONTACTNO   = ""> 

<cfset FIFTHBROFULLNAME     = "">
<cfset FIFTHBROAGE          = 0>
<cfset FIFTHBROOCCUPATION   = "">
<cfset FIFTHBROCOMPANY      = "">
<cfset FIFTHBROCONTACTNO    = ""> 


<cfset SIXTHCHILDFULLNAME    = "">
<cfset SIXTHCHILDAGE    = "0">
<cfset SIXTHCHILDOCCUPATION    = "">
<cfset SIXTHCHILDCOMPANY    = "">
<cfset SIXTHCHILDCONTACTNO    = "">
<cfset SEVENTHCHILDFULLNAME    = "">
<cfset SEVENTHCHILDAGE    = "0">
<cfset SEVENTHCHILDOCCUPATION    = "">
<cfset SEVENTHCHILDCOMPANY    = "">
<cfset SEVENTHCHILDCONTACTNO    = "">
<cfset EIGHTHCHILDFULLNAME    = "">
<cfset EIGHTHCHILDAGE    = "0">
<cfset EIGHTHCHILDOCCUPATION    = "">
<cfset EIGHTHCHILDCOMPANY    = "">
<cfset EIGHTHCHILDCONTACTNO    = "">
<cfset NINTHCHILDFULLNAME    = "">
<cfset NINTHCHILDAGE    = "0">
<cfset NINTHCHILDOCCUPATION    = "">
<cfset NINTHCHILDCOMPANY    = "">
<cfset NINTHCHILDCONTACTNO    = "">
<cfset TENTHCHILDFULLNAME    = "">
<cfset TENTHCHILDAGE    = "0">
<cfset TENTHCHILDOCCUPATION    = "">
<cfset TENTHCHILDCOMPANY    = "">
<cfset TENTHCHILDCONTACTNO    = "">
<cfset ELEVENTHCHILDFULLNAME    = "">
<cfset ELEVENTHCHILDAGE    = "0">
<cfset ELEVENTHCHILDOCCUPATION    = "">
<cfset ELEVENTHCHILDCOMPANY    = "">
<cfset ELEVENTHCHILDCONTACTNO    = "">
<cfset TWELVECHILDFULLNAME    = "">
<cfset TWELVECHILDAGE    = "0">
<cfset TWELVECHILDOCCUPATION    = "">
<cfset TWELVECHILDCOMPANY    = "">
<cfset TWELVECHILDCONTACTNO    = "">
<cfset THIRTEENTHCHILDFULLNAME    = "">
<cfset THIRTEENTHCHILDAGE    = "0">
<cfset THIRTEENTHCHILDOCCUPATION    = "">
<cfset THIRTEENTHCHILDCOMPANY    = "">
<cfset THIRTEENTHCHILDCONTACTNO    = "">
<cfset FOURTEENTHCHILDFULLNAME    = "">
<cfset FOURTEENTHCHILDAGE    = "0">
<cfset FOURTEENTHCHILDOCCUPATION    = "">
<cfset FOURTEENTHCHILDCOMPANY    = "">
<cfset FOURTEENTHCHILDCONTACTNO    = "">
<cfset FIFTEENTHCHILDFULLNAME    = "">
<cfset FIFTEENTHCHILDAGE    = "0">
<cfset FIFTEENTHCHILDOCCUPATION    = "">
<cfset FIFTEENTHCHILDCOMPANY    = "">
<cfset FIFTEENTHCHILDCONTACTNO    = "">

<cfset SIXTHBROFULLNAME    = "">
<cfset SIXTHBROAGE    = "0">
<cfset SIXTHBROOCCUPATION    = "">
<cfset SIXTHBROCOMPANY    = "">
<cfset SIXTHBROCONTACTNO    = "">
<cfset SEVENTHBROFULLNAME    = "">
<cfset SEVENTHBROAGE    = "0">
<cfset SEVENTHBROOCCUPATION    = "">
<cfset SEVENTHBROCOMPANY    = "">
<cfset SEVENTHBROCONTACTNO    = "">
<cfset EIGHTHBROFULLNAME    = "">
<cfset EIGHTHBROAGE    = "0">
<cfset EIGHTHBROOCCUPATION    = "">
<cfset EIGHTHBROCOMPANY    = "">
<cfset EIGHTHBROCONTACTNO    = "">
<cfset NINTHBROFULLNAME    = "">
<cfset NINTHBROAGE    = "0">
<cfset NINTHBROOCCUPATION    = "">
<cfset NINTHBROCOMPANY    = "">
<cfset NINTHBROCONTACTNO    = "">
<cfset TENTHBROFULLNAME    = "">
<cfset TENTHBROAGE    = "0">
<cfset TENTHBROOCCUPATION    = "">
<cfset TENTHBROCOMPANY    = "">
<cfset TENTHBROCONTACTNO    = "">
<cfset ELEVENTHBROFULLNAME    = "">
<cfset ELEVENTHBROAGE    = "0">
<cfset ELEVENTHBROOCCUPATION    = "">
<cfset ELEVENTHBROCOMPANY    = "">
<cfset ELEVENTHBROCONTACTNO    = "">
<cfset TWELVEBROFULLNAME    = "">
<cfset TWELVEBROAGE    = "0">
<cfset TWELVEBROOCCUPATION    = "">
<cfset TWELVEBROCOMPANY    = "">
<cfset TWELVEBROCONTACTNO    = "">
<cfset THIRTEENTHBROFULLNAME    = "">
<cfset THIRTEENTHBROAGE    = "0">
<cfset THIRTEENTHBROOCCUPATION    = "">
<cfset THIRTEENTHBROCOMPANY    = "">
<cfset THIRTEENTHBROCONTACTNO    = "">
<cfset FOURTEENTHBROFULLNAME    = "">
<cfset FOURTEENTHBROAGE    = "0">
<cfset FOURTEENTHBROOCCUPATION    = "">
<cfset FOURTEENTHBROCOMPANY    = "">
<cfset FOURTEENTHBROCONTACTNO    = "">
<cfset FIFTEENTHBROFULLNAME    = "">
<cfset FIFTEENTHBROAGE    = "0">
<cfset FIFTEENTHBROOCCUPATION    = "">
<cfset FIFTEENTHBROCOMPANY    = "">
<cfset FIFTEENTHBROCONTACTNO    = "">

<cfset POSTGRADSCHOOL     = "">
<cfset COLLEGESCHOOL      = "">
<cfset VOCATIONALSCHOOL   = "">
<cfset SECONDARYSCHOOL    = "">

<cfset POSTGRADCOURSE     = "">
<cfset COLLEGECOURSE      = "">
<cfset VOCATIONALCOURSE   = "">
<cfset SECONDARYCOURSE    = "">

<cfset POSTGRADFIELD      = "">
<cfset COLLEGEFIELD       = "">
<cfset VOCATIONALFIELD    = "">
<cfset SECONDARYFIELD     = "">

<cfset POSTGRADFROM       = "">
<cfset COLLEGEFROM        = "">
<cfset VOCATIONALFROM     = "">
<cfset SECONDARYFROM      = "">

<cfset POSTGRADTO         = "">
<cfset COLLEGETO          = "">
<cfset VOCATIONALTO       = "">     
<cfset SECONDARYTO        = "">

<cfset POSTGRADISGRAD     = "">
<cfset COLLEGEISGRAD      = "">
<cfset VOCATIONALISGRAD   = "">
<cfset SECONDARYISGRAD    = "">

<cfset POSTGRADHONORS     = "">
<cfset COLLEGEHONORS      = "">
<cfset VOCATIONALHONORS   = "">
<cfset SECONDARYHONORS    = "">
<cfset FIRSTEXTRAORGNAME        = "">
<cfset FIRSTEXTRAORGIDATE       = "">
<cfset FIRSTEXTRAORGHIGHPOSHELD = "">
<cfset SECONDEXTRAORGNAME       = "">
<cfset SECONDEXTRAORGIDATE      = "">
<cfset SECONDEXTRAORGHIGHPOSHELD= "">
<cfset THIRDEXTRAORGNAME        = "">
<cfset THIRDEXTRAORGIDATE       = "">
<cfset THIRDEXTRAORGHIGHPOSHELD = "">
<cfset FOURTHEXTRAORGNAME       = "">
<cfset FOURTHEXTRAORGIDATE      = "">
<cfset FOURTHEXTRAORGHIGHPOSHELD= "">
<cfset FIFTHEXTRAORGNAME        = "">
<cfset FIFTHEXTRAORGIDATE       = "">
<cfset FIFTHEXTRAORGHIGHPOSHELD = "">
<cfset FIRSTGOVEXAMPASSED = "">
<cfset FIRSTGOVEXAMDATE   = "">
<cfset FIRSTGOVEXAMRATING = "">

<cfset SECONDGOVEXAMPASSED= "">
<cfset SECONDGOVEXAMDATE  = "">
<cfset SECONDGOVEXAMRATING= "">

<cfset THIRDGOVEXAMPASSED = "">
<cfset THIRDGOVEXAMDATE   = "">
<cfset THIRDGOVEXAMRATING = "">

<cfset FOURTHGOVEXAMPASSED= "">
<cfset FOURTHGOVEXAMDATE  = "">
<cfset FOURTHGOVEXAMRATING= "">
<cfset BOARDEXAMRESULT    = "">
<cfset LICENSECERT        = "">

<cfset BLOODTYPE                 = "">
<cfset FIRSTSEMINARTOPIC         = "">
<cfset FIRSTSEMINARDATE          = "">
<cfset FIRSTSEMINARORGANIZER     = "">

<cfset SECONDSEMINARTOPIC        = "">
<cfset SECONDSEMINARDATE         = "">
<cfset SECONDSEMINARORGANIZER    = "">

<cfset THIRDSEMINARTOPIC         = "">
<cfset THIRDSEMINARDATE          = "">
<cfset THIRDSEMINARORGANIZER     = "">

<cfset FOURTHSEMINARTOPIC        = "">
<cfset FOURTHSEMINARDATE         = "">
<cfset FOURTHSEMINARORGANIZER    = "">

<cfset FIFTHSEMINARTOPIC         = "">
<cfset FIFTHSEMINARDATE          = "">
<cfset FIFTHSEMINARORGANIZER     = "">

<cfset SIXTHSEMINARTOPIC         = "">
<cfset SIXTHSEMINARDATE          = "">
<cfset SIXTHSEMINARORGANIZER     = "">

<cfset FIRSTEMPHISTORYNAME          = "">	
<cfset FIRSTEMPHISTORYADDRESS       = "">	

<cfset FIRSTEMPHISTORYPOSITION      = "">
<cfset FIRSTEMPHISTORYCONTACTNO     = "">

<cfset FIRSTEMPHISTORYDATEEMP       = "">
<cfset FIRSTEMPHISTORYDATESEP       = "">
<cfset FIRSTEMPHISTORYINISALARY     = "0">
<cfset FIRSTEMPHISTORYLASTSALARY    = "0">
<cfset FIRSTEMPHISTORYLASTPOS       = "">
<cfset FIRSTEMPHISTORYSUPERIOR      = "">
<cfset FIRSTEMPHISTORYLEAVEREASONS  = "">


<cfset SECONDEMPHISTORYNAME         = "">	
<cfset SECONDEMPHISTORYADDRESS      = "">	

<cfset SECONDEMPHISTORYPOSITION     = "">
<cfset SECONDEMPHISTORYCONTACTNO    = "">

<cfset SECONDEMPHISTORYDATEEMP       = "">
<cfset SECONDEMPHISTORYDATESEP       = "">
<cfset SECONDEMPHISTORYINISALARY     = "0">
<cfset SECONDEMPHISTORYLASTSALARY    = "0">
<cfset SECONDEMPHISTORYLASTPOS       = "">
<cfset SECONDEMPHISTORYSUPERIOR      = "">
<cfset SECONDEMPHISTORYLEAVEREASONS  = "">
 

	<cfset THIRDEMPHISTORYNAME          = "">	
<cfset THIRDEMPHISTORYADDRESS       = "">	

<cfset THIRDEMPHISTORYPOSITION      = "">
<cfset THIRDEMPHISTORYCONTACTNO     = "">

<cfset THIRDEMPHISTORYDATEEMP       = "">
<cfset THIRDEMPHISTORYDATESEP       = "">
<cfset THIRDEMPHISTORYINISALARY     = 0>
<cfset THIRDEMPHISTORYLASTSALARY    = 0>
<cfset THIRDEMPHISTORYLASTPOS       = "">
<cfset THIRDEMPHISTORYSUPERIOR      = "">
<cfset THIRDEMPHISTORYLEAVEREASONS  = "">


<cfset FOURTHEMPHISTORYNAME          = "">	
<cfset FOURTHEMPHISTORYADDRESS       = "">	

<cfset FOURTHEMPHISTORYPOSITION      = "">
<cfset FOURTHEMPHISTORYCONTACTNO     = "">

<cfset FOURTHEMPHISTORYDATEEMP       = "">
<cfset FOURTHEMPHISTORYDATESEP       = "">
<cfset FOURTHEMPHISTORYINISALARY     = 0>
<cfset FOURTHEMPHISTORYLASTSALARY    = 0>
<cfset FOURTHEMPHISTORYLASTPOS       = "">
<cfset FOURTHEMPHISTORYSUPERIOR      = "">
<cfset FOURTHEMPHISTORYLEAVEREASONS  = "">


<cfset FIFTHEMPHISTORYNAME          = "">	
<cfset FIFTHEMPHISTORYADDRESS       = "">	

<cfset FIFTHEMPHISTORYPOSITION      = "">
<cfset FIFTHEMPHISTORYCONTACTNO     = "">

<cfset FIFTHEMPHISTORYDATEEMP       = "">
<cfset FIFTHEMPHISTORYDATESEP       = "">
<cfset FIFTHEMPHISTORYINISALARY     = 0>
<cfset FIFTHEMPHISTORYLASTSALARY    = 0>
<cfset FIFTHEMPHISTORYLASTPOS       = "">
<cfset FIFTHEMPHISTORYSUPERIOR      = "">
<cfset FIFTHEMPHISTORYLEAVEREASONS  = "">

<cfset RELWORKINNAMEONE           = "">	
<cfset RELWORKINCOMPONE           = "">	
<cfset RELWORKINAFINITYONE        = "">

<cfset RELWORKINNAMETWO           = "">	
<cfset RELWORKINCOMPTWO           = "">	
<cfset RELWORKINAFINITYTWO        = "">

<cfset RELWORKINNAMETHREE           = "">	
<cfset RELWORKINCOMPTHREE           = "">	
<cfset RELWORKINAFINITYTHREE        = "">

        
<cfset SPECIALSKILLSONE           = "">	
<cfset SPECIALSKILLSYEARSPONE     = 0>	
<cfset SPECIALSKILLSLEVELONE      = "">

<cfset SPECIALSKILLSTWO           = "">	
<cfset SPECIALSKILLSYEARSPTWO     = 0>	
<cfset SPECIALSKILLSLEVELTWO      = "">

<cfset SPECIALSKILLSTHREE           = "">	
<cfset SPECIALSKILLSYEARSPTHREE     = 0>	
<cfset SPECIALSKILLSLEVELTHREE      = "">

<cfset SPECIALSKILLSFOUR           = "">	
<cfset SPECIALSKILLSYEARSPFOUR     = 0>	
<cfset SPECIALSKILLSLEVELFOUR      = "">

<cfset SPECIALSKILLSFIVE           = "">	
<cfset SPECIALSKILLSYEARSPFIVE     = 0>	
<cfset SPECIALSKILLSLEVELFIVE      = "">

<cfset REFERENCENAME1 = "">
<cfset REFERENCENAME2 = "">
<cfset REFERENCENAME3 = "">

<cfset REFERENCEOCCUPATION1 = "">
<cfset REFERENCEOCCUPATION2 = "">
<cfset REFERENCEOCCUPATION3 = "">

<cfset REFERENCECOMPANY1 = "">
<cfset REFERENCECOMPANY2 = "">
<cfset REFERENCECOMPANY3 = "">

<cfset REFERENCECONTACT1 = "">
<cfset REFERENCECONTACT2 = "">
<cfset REFERENCECONTACT3 = "">

<cfset HASPHYSICALDEFFECTS           = "">	
<cfset HASPHYSICALDEFFECTSNATURE     = "">

<cfset HASOPILLNESS       			 = "">
<cfset HASOPILLNESSNATURE      		 = "">

<cfset HASDRUGSENSITIVE      		 = "">
<cfset HASDRUGSENSITIVENATURE      	 = "">

<cfset HASENGAGEDRUGS      			 = "">
<cfset HASENGAGEDRUGSNATURE      	 = "">

<cfset HASINVOLVEBUSI      			 = "">
<cfset HASINVOLVEBUSINATURE      	 = "">

<cfset HASSUSPENDED     		     = "">
<cfset HASSUSPENDEDNATURE      		 = "">

<cfset HASCRIMINAL      			 = "">
<cfset HASCRIMINALNATURE      	     = "">

<cfset PHOTOIDNAME      	     = "">

<cfset PHILHEALTHNUMBER      	     = "">

<cfset PREVEMPLOYED = ''>
<cfset PREVAPPLIED = ''>
<cfset DATEAVAILEMP = ''>

<cfset PREVEMPLOYEDFROM = ''>
<cfset PREVEMPLOYEDTO = ''>
<cfset PREVAPPLIEDLAST = ''>

                            

<!---End initialization--->



<cfdocument
    format = "PDF"
    name = "#session.userid#"
    orientation = "portrait"
    overwrite = "yes"
    pageType = "letter"
	filename = "#session.userid#.pdf"
    >

<cfloop index="countme" from="1" to="#count#">

	<cfset refcode = ListGetAt(thelist, countme, "~", "no")>

	<cfquery name="qryEGMFAP" datasource="#session.global_dsn#" maxrows="1"> 
			   SELECT   GUID,
	                    APPLICANTNUMBER,
	                    SUFFIX,
	                    LASTNAME,
	                    FIRSTNAME,
	                    MIDDLENAME,
	                    APPLICATIONDATE,
	                    PAGIBIGNUMBER,
	                    REFERREDBY,
	                    SSSNUMBER,
	                    STARTINGSALARY,
	                    TIN,
	                    EMAILADD,
	                    POSITIONCODE,
	                    SOURCE,
	                    RESERVED,
	                    WORKEXPRATING
				 FROM   EGMFAP
				WHERE   REFERENCECODE = '#refcode#';
	</cfquery>

	<cfquery name="getpositiondesc" datasource="#session.company_dsn#" maxrows="1">
	                   
	    SELECT DESCRIPTION 
	      FROM CLKPOSITION
	     WHERE POSITIONCODE = '#qryEGMFAP.POSITIONCODE#'
	    ;
	                   
	</cfquery>
        
	<cfset POSITIONFIRSTPRIORITY = '#getpositiondesc.DESCRIPTION#'>

	<cfloop query="qryEGMFAP">
			<cfset SUFFIX                = '#SUFFIX#'>
	        <cfset LASTNAME              = '#LASTNAME#'>
	        <cfset FIRSTNAME             = '#FIRSTNAME#'>
	        <cfset MIDDLENAME            = '#MIDDLENAME#'>
	        <cfset DATEOFAPPLICATION     = '#APPLICATIONDATE#'>
	        <cfset PAGIBIGNUMBER         = '#PAGIBIGNUMBER#'>
	        <cfset SOURCEREFERREDBY      = '#REFERREDBY#'>
	        <cfset SSSNUMBER             = '#SSSNUMBER#'>
	        <cfset EXPECTEDSALARY        = '#EXPECTEDSALARY#'>
	        <cfset TINNUMBER             = '#TIN#'>
	        <cfset EMAILADDRESS          = '#EMAILADD#'> 
	        <cfset POSITIONFIRSTPRIORITY = '#POSITIONFIRSTPRIORITY#'>
	        <cfset SOURCEEMPLOYMENT      = '#SOURCE#'>
	        <cfset CURRENTSALARY         = '#WORKEXPRATING#'>
	        <cfset SOURCEOTHERVALUE      = '#SOURCE#'>
	        <cfset SOURCEJOBFAIRWHERE    = ''>
	        <cfset SOURCEJOBFAIRDATE     = ''>
	</cfloop>

	<cfquery name="qryEGIN21PERSONALINFO" datasource="#session.global_dsn#" maxrows="1"> 
			   SELECT   GUID,
	                    PERSONNELIDNO,
	                    CONTACTADDRESS,
	                    PROVINCIALADDRESS,
	                    BIRTHDAY,
	                    BIRTHPLACE,
	                    AGE,
	                    SEX,
	                    CIVILSTATUS,
	                    CITIZENSHIP,
	                    RELIGIONCODE,
	                    CONTACTCELLNUMBER,
	                    CONTACTTELNO,
	                    EMAILADDRESS,
	                    HEIGHT,
	                    WEIGHT,
	                    LANGUAGESPOKEN,
	                    PERSONTOCONTACT,
	                    RELATIONSHIP,
	                    TELEPHONENUMBER,
	                    PERCELLNUMBER,
	                    PREVIOUSADDRESS,
	                    PROVPERIODOFRES,
	                    LANGUAGEWRITTEN,
	                    CONTACTADDRESS2,
	                    CONTACTADDRESS3,
	                    ACREXPIRATIONDATE
				 FROM   EGIN21PERSONALINFO
				WHERE   REFERENCECODE = '#refcode#';
	</cfquery>

	<cfquery name="religiontodesc" datasource="#session.global_dsn#" maxrows="1">
	    SELECT DESCRIPTION
	      FROM GLKRELIGION
	     WHERE RELIGIONCODE = '#qryEGIN21PERSONALINFO.RELIGIONCODE#';
	</cfquery>

	<cfset RELIGIONDESC = religiontodesc.DESCRIPTION >

	<cfloop query="qryEGIN21PERSONALINFO">
			<cfset PRESENTADDRESSPOSTAL    = '#CONTACTADDRESS#'>
	        <cfset PROVINCIALADDRESSPOSTAL 	= '#PROVINCIALADDRESS#'>
	        <cfset DATEOFBIRTH             	= '#BIRTHDAY#'>
	        <cfset PLACEOFBIRTH            	= '#BIRTHPLACE#'>
	        <cfset AGE                     	= '#AGE#'>
	        <cfset GENDER                  	= '#SEX#'>
	        <cfset CIVILSTATUS 			   	= '#CIVILSTATUS#'>
	        <cfset CITIZENSHIP    		   	= '#CITIZENSHIP#'>
	        <cfset RELIGION     		   	= '#RELIGIONDESC#'>
	        <cfset CELLPHONENUMBER 		   	= '#CONTACTCELLNUMBER#'>
	        <cfset LANDLINENUMBER 		   	= '#CONTACTTELNO#'>
	        <cfset EMAILADDRESS     	   	= '#EMAILADDRESS#'> 
	        <cfset HEIGHT     			   	= '#HEIGHT#'>
	        <cfset WEIGHT     			   	= '#WEIGHT#'>
	        <cfset LANGUAGESPOKEN     	   	= '#LANGUAGESPOKEN#'>
	        <cfset INCASEEMERNAME 		   	= '#PERSONTOCONTACT#'>					
	        <cfset INCASEEMERRELATION 	   	= '#RELATIONSHIP#'>
	        <cfset INCASEEMERTELNUM        	= '#TELEPHONENUMBER#'>
	        <cfset INCASEEMERCELLNUM 	   	= '#PERCELLNUMBER#'>  
	        <cfset PRESENTADDRESSOWN 	   	= '#PREVIOUSADDRESS#'>
	        <cfset PROVINCEADDRESSOWN 	   	= '#PROVPERIODOFRES#'>
			<cfset PHOTOIDNAME 	           	= '#LANGUAGEWRITTEN#'>
	        <cfset PREVEMPLOYED 			= '#CONTACTADDRESS2#'>
			<cfset PREVAPPLIED 				= '#CONTACTADDRESS3#'>
	        <cfset DATEAVAILEMP 			= '#ACREXPIRATIONDATE#'>
	</cfloop>


	<cfquery name="qryEGIN21POSITNAPLD1" datasource="#session.global_dsn#" maxrows="1"> 
	   SELECT POSITIONCODE,COMPANYCODE,PRIORITY
		 FROM EGIN21POSITNAPLD
		WHERE REFERENCECODE = '#refcode#' AND PRIORITY = 1;
	</cfquery>

	<cfloop query="qryEGIN21POSITNAPLD1">
		<cfquery name="getpositiondes1" datasource="#session.company_dsn#" maxrows="1">
	        SELECT DESCRIPTION  
	          FROM CLKPOSITION
	         WHERE POSITIONCODE = '#POSITIONCODE#';
	    </cfquery>				
		<cfset POSITIONFIRSTPRIORITY   = '#getpositiondes1.DESCRIPTION#'>
	    <cfquery name="getcompanydes1" datasource="#session.company_dsn#" maxrows="1">
	        SELECT DESCRIPTION,COMPANYCODE  
	          FROM CLKCOMPANY
	         WHERE COMPANYCODE = '#COMPANYCODE#';
	    </cfquery>	
	    <cfset COMPANYFIRSTPRIORITY = '#getcompanydes1.DESCRIPTION#'>  
	</cfloop>

	<cfquery name="qryEGIN21POSITNAPLD2" datasource="#session.global_dsn#" maxrows="1"> 
	   SELECT   POSITIONCODE,COMPANYCODE,PRIORITY
		 FROM   EGIN21POSITNAPLD
		WHERE   REFERENCECODE = '#refcode#' AND PRIORITY = 2;
	</cfquery>

	<cfloop query="qryEGIN21POSITNAPLD2">
		<cfquery name="getpositiondes2" datasource="#session.company_dsn#" maxrows="1">
	        SELECT DESCRIPTION  
	          FROM CLKPOSITION
	         WHERE POSITIONCODE = '#POSITIONCODE#';
	    </cfquery>				
		<cfset POSITIONSECONDPRIORITY   = '#getpositiondes2.DESCRIPTION#'>
	    <cfquery name="getcompanydes2" datasource="#session.company_dsn#" maxrows="1">
	        SELECT DESCRIPTION  FROM CLKCOMPANY
	         WHERE  COMPANYCODE = '#COMPANYCODE#';
	    </cfquery>	
		<cfset COMPANYSECONDPRIORITY   = '#getcompanydes2.DESCRIPTION#'>      
	</cfloop>

	<cfquery name="qryEGIN21POSITNAPLD3" datasource="#session.global_dsn#" maxrows="1"> 
	   SELECT POSITIONCODE,COMPANYCODE
		 FROM EGIN21POSITNAPLD
		WHERE REFERENCECODE = '#refcode#' AND PRIORITY = 3;
	</cfquery>

	<cfloop query="qryEGIN21POSITNAPLD3">
		<cfquery name="getpositiondes3" datasource="#session.company_dsn#" maxrows="1">
	        SELECT DESCRIPTION  
	          FROM CLKPOSITION
	         WHERE POSITIONCODE = '#POSITIONCODE#';
	    </cfquery>				
		<cfset POSITIONTHIRDPRIORITY   = '#getpositiondes3.DESCRIPTION#'>
	    <cfquery name="getcompanydes3" datasource="#session.company_dsn#" maxrows="1">
	        SELECT DESCRIPTION  FROM CLKCOMPANY
	         WHERE  COMPANYCODE = '#COMPANYCODE#';
	    </cfquery>	
	    <cfset COMPANYTHIRDPRIORITY   = '#getcompanydes3.DESCRIPTION#'>
	</cfloop>



<cfquery name="qryEGIN21FAMILYBKGRNDF" datasource="#session.global_dsn#" maxrows="1"> 
		   SELECT GUID,
                    PERSONNELIDNO,
                    NAME,
                    AGE,
                    COMPANY,
                    OCCUPATION,
                    RELATIONSHIP, 
                    TELEPHONENUMBER
			 FROM   EGIN21FAMILYBKGRND
			WHERE   REFERENCECODE = '#refcode#' AND RELATIONSHIP LIKE '%FATHER%';
</cfquery>

<cfloop query="qryEGIN21FAMILYBKGRNDF">
					
	<cfset FATHERFULLNAME       = '#NAME#'>
    <cfset FATHERAGE            = '#AGE#'>
    <cfset FATHEROCCUPATION     = '#OCCUPATION#'>
    <cfset FATHERCOMPANY        = '#COMPANY#'>
    <cfset FATHERCONTACTNO      = '#TELEPHONENUMBER#'> 
    
</cfloop>

<cfquery name="qryEGIN21FAMILYBKGRNDM" datasource="#session.global_dsn#" maxrows="1"> 
		   SELECT   GUID,
                    PERSONNELIDNO,
                    NAME,
                    AGE,
                    COMPANY,
                    OCCUPATION,
                    RELATIONSHIP, 
                    TELEPHONENUMBER
			 FROM   EGIN21FAMILYBKGRND
			WHERE REFERENCECODE = '#refcode#' AND RELATIONSHIP LIKE '%MOTHER%';
</cfquery>

<cfloop query="qryEGIN21FAMILYBKGRNDM">
					
	<cfset MOTHERFULLNAME       = '#NAME#'>
    <cfset MOTHERAGE            = '#AGE#'>
    <cfset MOTHEROCCUPATION     = '#OCCUPATION#'>
    <cfset MOTHERCOMPANY        = '#COMPANY#'>
    <cfset MOTHERCONTACTNO      = '#TELEPHONENUMBER#'> 
    
</cfloop>

<cfquery name="qryEGIN21FAMILYBKGRNDS" datasource="#session.global_dsn#" maxrows="1"> 
		   SELECT   GUID,
                    PERSONNELIDNO,
                    NAME,
                    AGE,
                    COMPANY,
                    OCCUPATION,
                    RELATIONSHIP, 
                    TELEPHONENUMBER 
			 FROM   EGIN21FAMILYBKGRND
			WHERE REFERENCECODE = '#refcode#' AND RELATIONSHIP LIKE '%SPOUSE%';
</cfquery>

<cfloop query="qryEGIN21FAMILYBKGRNDS">
					
	<cfset SPOUSEFULLNAME       = '#NAME#'>
    <cfset SPOUSEAGE            = '#AGE#'>
    <cfset SPOUSEOCCUPATION     = '#OCCUPATION#'>
    <cfset SPOUSECOMPANY        = '#COMPANY#'>
    <cfset SPOUSECONTACTNO      = '#TELEPHONENUMBER#'> 
    
</cfloop>

<cfquery name="qryEGIN21FAMILYBKGRNDSD" datasource="#session.global_dsn#"> 
		   SELECT   GUID,
                    PERSONNELIDNO,
                    NAME,
                    AGE,
                    COMPANY,
                    OCCUPATION,
                    RELATIONSHIP, 
                    TELEPHONENUMBER
			 FROM   EGIN21FAMILYBKGRND
			WHERE REFERENCECODE = '#refcode#' AND RELATIONSHIP LIKE '%SON%';
</cfquery>

<cfset counter = 1 >

<cfloop query="qryEGIN21FAMILYBKGRNDSD">

   <cfif counter EQ 1>
					
		<cfset FIRSTCHILDFULLNAME       = '#NAME#'>
        <cfset FIRSTCHILDAGE            = '#AGE#'>
        <cfset FIRSTCHILDOCCUPATION     = '#OCCUPATION#'>
        <cfset FIRSTCHILDCOMPANY        = '#COMPANY#'>
        <cfset FIRSTCHILDCONTACTNO      = '#TELEPHONENUMBER#'> 
      
      <cfset counter = counter + 1>
    
    <cfelseif counter EQ 2 >
    
        <cfset SECONDCHILDFULLNAME       = '#NAME#'>
        <cfset SECONDCHILDAGE            = '#AGE#'>
        <cfset SECONDCHILDOCCUPATION     = '#OCCUPATION#'>
        <cfset SECONDCHILDCOMPANY        = '#COMPANY#'>
        <cfset SECONDCHILDCONTACTNO      = '#TELEPHONENUMBER#'> 
      
      <cfset counter = counter + 1>
      
    <cfelseif counter EQ 3 >
    
        <cfset THIRDCHILDFULLNAME       = '#NAME#'>
        <cfset THIRDCHILDAGE            = '#AGE#'>
        <cfset THIRDCHILDOCCUPATION     = '#OCCUPATION#'>
        <cfset THIRDCHILDCOMPANY        = '#COMPANY#'>
        <cfset THIRDCHILDCONTACTNO      = '#TELEPHONENUMBER#'> 
      
      <cfset counter = counter + 1>
      
    <cfelseif counter EQ 4 >
    
        <cfset FOURTHCHILDFULLNAME       = '#NAME#'>
        <cfset FOURTHCHILDAGE            = '#AGE#'>
        <cfset FOURTHCHILDOCCUPATION     = '#OCCUPATION#'>
        <cfset FOURTHCHILDCOMPANY        = '#COMPANY#'>
        <cfset FOURTHCHILDCONTACTNO      = '#TELEPHONENUMBER#'> 
      
      <cfset counter = counter + 1>
      
    <cfelseif counter EQ 5 >
    
        <cfset FIFTHCHILDFULLNAME       = '#NAME#'>
        <cfset FIFTHCHILDAGE            = '#AGE#'>
        <cfset FIFTHCHILDOCCUPATION     = '#OCCUPATION#'>
        <cfset FIFTHCHILDCOMPANY        = '#COMPANY#'>
        <cfset FIFTHCHILDCONTACTNO      = '#TELEPHONENUMBER#'> 
		<cfset counter = counter + 1>
		
	<cfelseif counter EQ 6 >
    
        <cfset SIXTHCHILDFULLNAME       = '#NAME#'>
        <cfset SIXTHCHILDAGE            = '#AGE#'>
        <cfset SIXTHCHILDOCCUPATION     = '#OCCUPATION#'>
        <cfset SIXTHCHILDCOMPANY        = '#COMPANY#'>
        <cfset SIXTHCHILDCONTACTNO      = '#TELEPHONENUMBER#'> 
		<cfset counter = counter + 1>	
	
	<cfelseif counter EQ 7 >
    
        <cfset SEVENTHCHILDFULLNAME       = '#NAME#'>
        <cfset SEVENTHCHILDAGE            = '#AGE#'>
        <cfset SEVENTHCHILDOCCUPATION     = '#OCCUPATION#'>
        <cfset SEVENTHCHILDCOMPANY        = '#COMPANY#'>
        <cfset SEVENTHCHILDCONTACTNO      = '#TELEPHONENUMBER#'> 
		<cfset counter = counter + 1>	
    
    <cfelseif counter EQ 8 >
    
        <cfset EIGHTHCHILDFULLNAME       = '#NAME#'>
        <cfset EIGHTHCHILDAGE            = '#AGE#'>
        <cfset EIGHTHCHILDOCCUPATION     = '#OCCUPATION#'>
        <cfset EIGHTHCHILDCOMPANY        = '#COMPANY#'>
        <cfset EIGHTHCHILDCONTACTNO      = '#TELEPHONENUMBER#'>  
		<cfset counter = counter + 1>
	<cfelseif counter EQ 9 >
    
        <cfset NINTHCHILDFULLNAME       = '#NAME#'>
        <cfset NINTHCHILDAGE            = '#AGE#'>
        <cfset NINTHCHILDOCCUPATION     = '#OCCUPATION#'>
        <cfset NINTHCHILDCOMPANY        = '#COMPANY#'>
        <cfset NINTHCHILDCONTACTNO      = '#TELEPHONENUMBER#'> 
		<cfset counter = counter + 1>
	<cfelseif counter EQ 10 >
    
        <cfset TENTHCHILDFULLNAME       = '#NAME#'>
        <cfset TENTHCHILDAGE            = '#AGE#'>
        <cfset TENTHCHILDOCCUPATION     = '#OCCUPATION#'>
        <cfset TENTHCHILDCOMPANY        = '#COMPANY#'>
        <cfset TENTHCHILDCONTACTNO      = '#TELEPHONENUMBER#'> 
		<cfset counter = counter + 1>
	<cfelseif counter EQ 11 >
    
        <cfset ELEVENTHCHILDFULLNAME       = '#NAME#'>
        <cfset ELEVENTHCHILDAGE            = '#AGE#'>
        <cfset ELEVENTHCHILDOCCUPATION     = '#OCCUPATION#'>
        <cfset ELEVENTHCHILDCOMPANY        = '#COMPANY#'>
        <cfset ELEVENTHCHILDCONTACTNO      = '#TELEPHONENUMBER#'> 
		<cfset counter = counter + 1>
	<cfelseif counter EQ 12 >
    
        <cfset TWELVECHILDFULLNAME       = '#NAME#'>
        <cfset TWELVECHILDAGE            = '#AGE#'>
        <cfset TWELVECHILDOCCUPATION     = '#OCCUPATION#'>
        <cfset TWELVECHILDCOMPANY        = '#COMPANY#'>
        <cfset TWELVECHILDCONTACTNO      = '#TELEPHONENUMBER#'> 
		<cfset counter = counter + 1>
	<cfelseif counter EQ 13 >
    
        <cfset THIRTEENTHCHILDFULLNAME       = '#NAME#'>
        <cfset THIRTEENTHCHILDAGE            = '#AGE#'>
        <cfset THIRTEENTHCHILDOCCUPATION     = '#OCCUPATION#'>
        <cfset THIRTEENTHCHILDCOMPANY        = '#COMPANY#'>
        <cfset THIRTEENTHCHILDCONTACTNO      = '#TELEPHONENUMBER#'> 
		<cfset counter = counter + 1>
	<cfelseif counter EQ 14 >
    
        <cfset FOURTEENTHCHILDFULLNAME       = '#NAME#'>
        <cfset FOURTEENTHCHILDAGE            = '#AGE#'>
        <cfset FOURTEENTHCHILDOCCUPATION     = '#OCCUPATION#'>
        <cfset FOURTEENTHCHILDCOMPANY        = '#COMPANY#'>
        <cfset FOURTEENTHCHILDCONTACTNO      = '#TELEPHONENUMBER#'> 
		<cfset counter = counter + 1>
	<cfelseif counter EQ 15 >
    
        <cfset FIFTEENTHCHILDFULLNAME       = '#NAME#'>
        <cfset FIFTEENTHCHILDAGE            = '#AGE#'>
        <cfset FIFTEENTHCHILDOCCUPATION     = '#OCCUPATION#'>
        <cfset FIFTEENTHCHILDCOMPANY        = '#COMPANY#'>
        <cfset FIFTEENTHCHILDCONTACTNO      = '#TELEPHONENUMBER#'> 
		
    </cfif>
    
</cfloop>

<cfquery name="qryEGIN21FAMILYBKGRNDBS" datasource="#session.global_dsn#"> 
		   SELECT   GUID,
                    PERSONNELIDNO,
                    NAME,
                    AGE,
                    COMPANY,
                    OCCUPATION,
                    RELATIONSHIP, 
                    TELEPHONENUMBER 
			 FROM   EGIN21FAMILYBKGRND
			WHERE REFERENCECODE = '#refcode#' AND RELATIONSHIP LIKE  '%BRO%';
</cfquery>

<cfset counter = 1 >

<cfloop query="qryEGIN21FAMILYBKGRNDBS">

   <cfif counter EQ 1>
					
		<cfset FIRSTBROFULLNAME       = '#NAME#'>
        <cfset FIRSTBROAGE            = '#AGE#'>
        <cfset FIRSTBROOCCUPATION     = '#OCCUPATION#'>
        <cfset FIRSTBROCOMPANY        = '#COMPANY#'>
        <cfset FIRSTBROCONTACTNO      = '#TELEPHONENUMBER#'> 
      
      <cfset counter = counter + 1>
    
    <cfelseif counter EQ 2 >
    
        <cfset SECONDBROFULLNAME       = '#NAME#'>
        <cfset SECONDBROAGE            = '#AGE#'>
        <cfset SECONDBROOCCUPATION     = '#OCCUPATION#'>
        <cfset SECONDBROCOMPANY        = '#COMPANY#'>
        <cfset SECONDBROCONTACTNO      = '#TELEPHONENUMBER#'> 
      
      <cfset counter = counter + 1>
      
    <cfelseif counter EQ 3 >
    
        <cfset THIRDBROFULLNAME       = '#NAME#'>
        <cfset THIRDBROAGE            = '#AGE#'>
        <cfset THIRDBROOCCUPATION     = '#OCCUPATION#'>
        <cfset THIRDBROCOMPANY        = '#COMPANY#'>
        <cfset THIRDBROCONTACTNO      = '#TELEPHONENUMBER#'> 
      
      <cfset counter = counter + 1>
      
    <cfelseif counter EQ 4 >
    
        <cfset FOURTHBROFULLNAME       = '#NAME#'>
        <cfset FOURTHBROAGE            = '#AGE#'>
        <cfset FOURTHBROOCCUPATION     = '#OCCUPATION#'>
        <cfset FOURTHBROCOMPANY        = '#COMPANY#'>
        <cfset FOURTHBROCONTACTNO      = '#TELEPHONENUMBER#'> 
      
      <cfset counter = counter + 1>
      
    <cfelseif counter EQ 5 >
    
        <cfset FIFTHBROFULLNAME       = '#NAME#'>
        <cfset FIFTHBROAGE            = '#AGE#'>
        <cfset FIFTHBROOCCUPATION     = '#OCCUPATION#'>
        <cfset FIFTHBROCOMPANY        = '#COMPANY#'>
        <cfset FIFTHBROCONTACTNO      = '#TELEPHONENUMBER#'> 
        <cfset counter = counter + 1>	
    <cfelseif counter EQ 6 >
    
        <cfset SIXTHBROFULLNAME       = '#NAME#'>
        <cfset SIXTHBROAGE            = '#AGE#'>
        <cfset SIXTHBROOCCUPATION     = '#OCCUPATION#'>
        <cfset SIXTHBROCOMPANY        = '#COMPANY#'>
        <cfset SIXTHBROCONTACTNO      = '#TELEPHONENUMBER#'> 
		<cfset counter = counter + 1>	
	
	<cfelseif counter EQ 7 >
    
        <cfset SEVENTHBROFULLNAME       = '#NAME#'>
        <cfset SEVENTHBROAGE            = '#AGE#'>
        <cfset SEVENTHBROOCCUPATION     = '#OCCUPATION#'>
        <cfset SEVENTHBROCOMPANY        = '#COMPANY#'>
        <cfset SEVENTHBROCONTACTNO      = '#TELEPHONENUMBER#'> 
		<cfset counter = counter + 1>	
    
    <cfelseif counter EQ 8 >
    
        <cfset EIGHTHBROFULLNAME       = '#NAME#'>
        <cfset EIGHTHBROAGE            = '#AGE#'>
        <cfset EIGHTHBROOCCUPATION     = '#OCCUPATION#'>
        <cfset EIGHTHBROCOMPANY        = '#COMPANY#'>
        <cfset EIGHTHBROCONTACTNO      = '#TELEPHONENUMBER#'>  
		<cfset counter = counter + 1>
	<cfelseif counter EQ 9 >
    
        <cfset NINTHBROFULLNAME       = '#NAME#'>
        <cfset NINTHBROAGE            = '#AGE#'>
        <cfset NINTHBROOCCUPATION     = '#OCCUPATION#'>
        <cfset NINTHBROCOMPANY        = '#COMPANY#'>
        <cfset NINTHBROCONTACTNO      = '#TELEPHONENUMBER#'> 
		<cfset counter = counter + 1>
	<cfelseif counter EQ 10 >
    
        <cfset TENTHBROFULLNAME       = '#NAME#'>
        <cfset TENTHBROAGE            = '#AGE#'>
        <cfset TENTHBROOCCUPATION     = '#OCCUPATION#'>
        <cfset TENTHBROCOMPANY        = '#COMPANY#'>
        <cfset TENTHBROCONTACTNO      = '#TELEPHONENUMBER#'> 
		<cfset counter = counter + 1>
	<cfelseif counter EQ 11 >
    
        <cfset ELEVENTHBROFULLNAME       = '#NAME#'>
        <cfset ELEVENTHBROAGE            = '#AGE#'>
        <cfset ELEVENTHBROOCCUPATION     = '#OCCUPATION#'>
        <cfset ELEVENTHBROCOMPANY        = '#COMPANY#'>
        <cfset ELEVENTHBROCONTACTNO      = '#TELEPHONENUMBER#'> 
		<cfset counter = counter + 1>
	<cfelseif counter EQ 12 >
    
        <cfset TWELVEBROFULLNAME       = '#NAME#'>
        <cfset TWELVEBROAGE            = '#AGE#'>
        <cfset TWELVEBROOCCUPATION     = '#OCCUPATION#'>
        <cfset TWELVEBROCOMPANY        = '#COMPANY#'>
        <cfset TWELVEBROCONTACTNO      = '#TELEPHONENUMBER#'> 
		<cfset counter = counter + 1>
	<cfelseif counter EQ 13 >
    
        <cfset THIRTEENTHBROFULLNAME       = '#NAME#'>
        <cfset THIRTEENTHBROAGE            = '#AGE#'>
        <cfset THIRTEENTHBROOCCUPATION     = '#OCCUPATION#'>
        <cfset THIRTEENTHBROCOMPANY        = '#COMPANY#'>
        <cfset THIRTEENTHBROCONTACTNO      = '#TELEPHONENUMBER#'> 
		<cfset counter = counter + 1>
	<cfelseif counter EQ 14 >
    
        <cfset FOURTEENTHBROFULLNAME       = '#NAME#'>
        <cfset FOURTEENTHBROAGE            = '#AGE#'>
        <cfset FOURTEENTHBROOCCUPATION     = '#OCCUPATION#'>
        <cfset FOURTEENTHBROCOMPANY        = '#COMPANY#'>
        <cfset FOURTEENTHBROCONTACTNO      = '#TELEPHONENUMBER#'> 
		<cfset counter = counter + 1>
	<cfelseif counter EQ 15 >
    
        <cfset FIFTEENTHBROFULLNAME       = '#NAME#'>
        <cfset FIFTEENTHBROAGE            = '#AGE#'>
        <cfset FIFTEENTHBROOCCUPATION     = '#OCCUPATION#'>
        <cfset FIFTEENTHBROCOMPANY        = '#COMPANY#'>
        <cfset FIFTEENTHBROCONTACTNO      = '#TELEPHONENUMBER#'> 
		
    </cfif>
    
</cfloop>


<cfquery name="qryEGIN21EDUCATIONP" datasource="#session.global_dsn#" maxrows="1"> 
		   SELECT   GUID,
                    PERSONNELIDNO,
                    SCHOOLNAME,    
                    EDUCLEVEL,
                    MAJORDEGREE,
                    COURSECODE,
                    SCHOOLCODE,
                    DATEBEGIN,
                    DATEFINISHED,
                    GRADUATE,
                    HONORSRECEIVED        
			 FROM   EGIN21EDUCATION
			WHERE REFERENCECODE = '#refcode#' AND EDUCLEVEL LIKE '%POSTGRAD%';
</cfquery>

<cfquery name="getschooldesc" datasource="#session.global_dsn#" maxrows="1">
    SELECT SCHOOLNAME
      FROM GLKSCHOOL
     WHERE SCHOOLCODE= '#qryEGIN21EDUCATIONP.SCHOOLCODE#';
</cfquery>

<cfset POSTGRADSCHOOL = '#getschooldesc.SCHOOLNAME#'>
            
<cfquery name="geteducfield" datasource="#session.global_dsn#" maxrows="1">
    SELECT DESCRIPTION  
      FROM GLKDEGREE
     WHERE DEGREECODE = '#qryEGIN21EDUCATIONP.MAJORDEGREE#';
</cfquery>
<cfset POSTGRADFIELD = '#geteducfield.DESCRIPTION#'>
            
<cfquery name="getcoursedesc" datasource="#session.global_dsn#" maxrows="1">
    SELECT DESCRIPTION  
      FROM GLKCOURSE
     WHERE COURSECODE = '#qryEGIN21EDUCATIONP.COURSECODE#'; 
</cfquery>
<cfset POSTGRADCOURSE = '#getcoursedesc.DESCRIPTION#'>


<cfloop query="qryEGIN21EDUCATIONP">
					
	<cfset POSTGRADSCHOOL     = '#POSTGRADSCHOOL#'>
    <cfset POSTGRADCOURSE     = '#POSTGRADCOURSE#'>
    <cfset POSTGRADFIELD      = '#POSTGRADFIELD#'>
    <cfset POSTGRADFROM       = '#DATEBEGIN#'>
    <cfset POSTGRADTO         = '#DATEFINISHED#'>
    <cfset POSTGRADISGRAD     = '#GRADUATE#'>
    <cfset POSTGRADHONORS     = '#HONORSRECEIVED#'>
    
</cfloop>

<cfquery name="qryEGIN21EDUCATIONC" datasource="#session.global_dsn#"> 
		   SELECT   GUID,
                    PERSONNELIDNO,
                    SCHOOLNAME,    
                    EDUCLEVEL,
                    MAJORDEGREE,
                    COURSECODE,
                    SCHOOLCODE,
                    DATEBEGIN,
                    DATEFINISHED,
                    GRADUATE,
                    HONORSRECEIVED  
			 FROM   EGIN21EDUCATION
			WHERE REFERENCECODE = '#refcode#' AND EDUCLEVEL LIKE '%COLLEGE%';
</cfquery>


<cfquery name="getschooldesc" datasource="#session.global_dsn#" maxrows="1">
    SELECT SCHOOLNAME
      FROM GLKSCHOOL
     WHERE SCHOOLCODE= '#qryEGIN21EDUCATIONC.SCHOOLCODE#';
</cfquery>

<cfset COLLEGESCHOOL = '#getschooldesc.SCHOOLNAME#'>
            
<cfquery name="geteducfield" datasource="#session.global_dsn#" maxrows="1">
    SELECT DESCRIPTION  
      FROM GLKDEGREE
     WHERE DEGREECODE = '#qryEGIN21EDUCATIONC.MAJORDEGREE#';
</cfquery>
<cfset COLLEGEFIELD = '#geteducfield.DESCRIPTION#'>
            
<cfquery name="getcoursedesc" datasource="#session.global_dsn#" maxrows="1">
    SELECT DESCRIPTION  
      FROM GLKCOURSE
     WHERE COURSECODE = '#qryEGIN21EDUCATIONC.COURSECODE#'; 
</cfquery>
<cfset COLLEGECOURSE = '#getcoursedesc.DESCRIPTION#'>


<cfloop query="qryEGIN21EDUCATIONC">
					
	<cfset COLLEGESCHOOL     = '#COLLEGESCHOOL#'>
    <cfset COLLEGECOURSE     = '#COLLEGECOURSE#'>
    <cfset COLLEGEFIELD      = '#COLLEGEFIELD#'>
    <cfset COLLEGEFROM       = '#DATEBEGIN#'>
    <cfset COLLEGETO         = '#DATEFINISHED#'>
    <cfset COLLEGEISGRAD     = '#GRADUATE#'>
    <cfset COLLEGEHONORS     = '#HONORSRECEIVED#'>
    
</cfloop>


<cfquery name="qryEGIN21EDUCATIONV" datasource="#session.global_dsn#"> 
		   SELECT   GUID,
                    PERSONNELIDNO,
                    SCHOOLNAME,    
                    EDUCLEVEL,
                    MAJORDEGREE,
                    COURSECODE,
                    SCHOOLCODE,
                    DATEBEGIN,
                    DATEFINISHED,
                    GRADUATE,
                    HONORSRECEIVED  
			 FROM   EGIN21EDUCATION
			WHERE REFERENCECODE = '#refcode#' AND EDUCLEVEL LIKE '%VOCATIONAL%';
</cfquery>


<cfquery name="getschooldesc" datasource="#session.global_dsn#" maxrows="1">
    SELECT SCHOOLNAME
      FROM GLKSCHOOL
     WHERE SCHOOLCODE= '#qryEGIN21EDUCATIONV.SCHOOLCODE#';
</cfquery>

<cfset VOCATIONALSCHOOL = '#getschooldesc.SCHOOLNAME#'>
            
<cfquery name="geteducfield" datasource="#session.global_dsn#" maxrows="1">
    SELECT DESCRIPTION  
      FROM GLKDEGREE
     WHERE DEGREECODE = '#qryEGIN21EDUCATIONV.MAJORDEGREE#';
</cfquery>
<cfset VOCATIONALFIELD = '#geteducfield.DESCRIPTION#'>
            
<cfquery name="getcoursedesc" datasource="#session.global_dsn#" maxrows="1">
    SELECT DESCRIPTION  
      FROM GLKCOURSE
     WHERE COURSECODE = '#qryEGIN21EDUCATIONV.COURSECODE#'; 
</cfquery>
<cfset VOCATIONALCOURSE = '#getcoursedesc.DESCRIPTION#'>


<cfloop query="qryEGIN21EDUCATIONV">
					
	<cfset VOCATIONALSCHOOL     = '#VOCATIONALSCHOOL#'>
    <cfset VOCATIONALCOURSE     = '#VOCATIONALCOURSE#'>
    <cfset VOCATIONALFIELD      = '#VOCATIONALFIELD#'>
    <cfset VOCATIONALFROM       = '#DATEBEGIN#'>
    <cfset VOCATIONALTO         = '#DATEFINISHED#'>
    <cfset VOCATIONALISGRAD     = '#GRADUATE#'>
    <cfset VOCATIONALHONORS     = '#HONORSRECEIVED#'>
    
</cfloop>

<cfquery name="qryEGIN21EDUCATIONS" datasource="#session.global_dsn#"> 
		   SELECT   GUID,
                    PERSONNELIDNO,
                    SCHOOLNAME,    
                    EDUCLEVEL,
                    MAJORDEGREE,
                    COURSECODE,
                    SCHOOLCODE,
                    DATEBEGIN,
                    DATEFINISHED,
                    GRADUATE,
                    HONORSRECEIVED  
			 FROM   EGIN21EDUCATION
			WHERE REFERENCECODE = '#refcode#' AND EDUCLEVEL LIKE '%SECONDARY%';
</cfquery>


<cfquery name="getschooldesc" datasource="#session.global_dsn#" maxrows="1">
    SELECT SCHOOLNAME
      FROM GLKSCHOOL
     WHERE SCHOOLCODE= '#qryEGIN21EDUCATIONS.SCHOOLCODE#';
</cfquery>

<cfset SECONDARYSCHOOL = '#getschooldesc.SCHOOLNAME#'>
            
<cfquery name="geteducfield" datasource="#session.global_dsn#" maxrows="1">
    SELECT DESCRIPTION  
      FROM GLKDEGREE
     WHERE DEGREECODE = '#qryEGIN21EDUCATIONS.MAJORDEGREE#';
</cfquery>
<cfset SECONDARYFIELD = '#geteducfield.DESCRIPTION#'>
            
<cfquery name="getcoursedesc" datasource="#session.global_dsn#" maxrows="1">
    SELECT DESCRIPTION  
      FROM GLKCOURSE
     WHERE COURSECODE = '#qryEGIN21EDUCATIONS.COURSECODE#'; 
</cfquery>
<cfset SECONDARYCOURSE = '#getcoursedesc.DESCRIPTION#'>


<cfloop query="qryEGIN21EDUCATIONS">
					
	<cfset SECONDARYSCHOOL     = '#SECONDARYSCHOOL#'>
    <cfset SECONDARYCOURSE     = '#SECONDARYCOURSE#'>
    <cfset SECONDARYFIELD      = '#SECONDARYFIELD#'>
    <cfset SECONDARYFROM       = '#DATEBEGIN#'>
    <cfset SECONDARYTO         = '#DATEFINISHED#'>  
    <cfset SECONDARYISGRAD     = '#GRADUATE#'>
    <cfset SECONDARYHONORS     = '#HONORSRECEIVED#'>
    
</cfloop>


<cfquery name="qryEGIN21EMPEXTRA" datasource="#session.global_dsn#"> 
		   SELECT   GUID,
                    PERSONNELIDNO,
                    ORGANIZATION,
                    PERIODCOVERED,
                    HIGHESTPOSITION
			 FROM   EGIN21EMPEXTRA
			WHERE REFERENCECODE = '#refcode#';
</cfquery>

<cfset counter = 1 >


<cfloop query="qryEGIN21EMPEXTRA">
			
  <cfif counter EQ 1 >   
         		
	<cfset FIRSTEXTRAORGNAME        = '#ORGANIZATION#'>
    <cfset FIRSTEXTRAORGIDATE       = '#PERIODCOVERED#'>
    <cfset FIRSTEXTRAORGHIGHPOSHELD = '#HIGHESTPOSITION#'>
    
    <cfset counter = counter + 1 >
    
  <cfelseif counter EQ 2 >  
          		
	<cfset SECONDEXTRAORGNAME        = '#ORGANIZATION#'>
    <cfset SECONDEXTRAORGIDATE       = '#PERIODCOVERED#'>
    <cfset SECONDEXTRAORGHIGHPOSHELD = '#HIGHESTPOSITION#'>
    
    <cfset counter = counter + 1 >
    
  <cfelseif counter EQ 3 >  
          		
	<cfset THIRDEXTRAORGNAME        = '#ORGANIZATION#'>
    <cfset THIRDEXTRAORGIDATE       = '#PERIODCOVERED#'>
    <cfset THIRDEXTRAORGHIGHPOSHELD = '#HIGHESTPOSITION#'>
    
    <cfset counter = counter + 1 >
    
  <cfelseif counter EQ 4 >  
          		
	<cfset FOURTHEXTRAORGNAME        = '#ORGANIZATION#'>
    <cfset FOURTHEXTRAORGIDATE       = '#PERIODCOVERED#'>
    <cfset FOURTHEXTRAORGHIGHPOSHELD = '#HIGHESTPOSITION#'>
    
    <cfset counter = counter + 1 >
  
  <cfelseif counter EQ 5 >  
          		
	<cfset FIFTHEXTRAORGNAME        = '#ORGANIZATION#'>
    <cfset FIFTHEXTRAORGIDATE       = '#PERIODCOVERED#'>
    <cfset FIFTHEXTRAORGHIGHPOSHELD = '#HIGHESTPOSITION#'>
      
  </cfif>
    
</cfloop>

<cfquery name="qryEGIN21EXAMPASS" datasource="#session.global_dsn#"> 
		   SELECT   GUID,
                    PERSONNELIDNO,
                    DATETAKENPASSED,
                    PASSED,
                    RATING,
                    TYPEOFEXAM	
			 FROM   EGIN21EXAMPASS
			WHERE REFERENCECODE = '#refcode#';
</cfquery>


<cfset counter = 1 >

<cfloop query="qryEGIN21EXAMPASS">
			
  <cfif counter EQ 1 >   
         		
	<cfset FIRSTGOVEXAMPASSED  = '#TYPEOFEXAM#'>
    <cfset FIRSTGOVEXAMDATE    = '#DATETAKENPASSED#'>
    <cfset FIRSTGOVEXAMRATING  = '#RATING#'>
    
    <cfset counter = counter + 1 >
    
  <cfelseif counter EQ 2 >  
          		
	<cfset SECONDGOVEXAMPASSED  = '#TYPEOFEXAM#'>
    <cfset SECONDGOVEXAMDATE    = '#DATETAKENPASSED#'>
    <cfset SECONDGOVEXAMRATING  = '#RATING#'>
    
    <cfset counter = counter + 1 >
    
  <cfelseif counter EQ 3 >  
          		
	<cfset THIRDGOVEXAMPASSED  = '#TYPEOFEXAM#'>
    <cfset THIRDGOVEXAMDATE    = '#DATETAKENPASSED#'>
    <cfset THIRDGOVEXAMRATING  = '#RATING#'>
    
    <cfset counter = counter + 1 >
    
  <cfelseif counter EQ 4 >  
          		
	<cfset FOURTHGOVEXAMPASSED  = '#TYPEOFEXAM#'>
    <cfset FOURTHGOVEXAMDATE    = '#DATETAKENPASSED#'>
    <cfset FOURTHGOVEXAMRATING  = '#RATING#'>
    
  </cfif>
    
</cfloop>

<cfquery name="qryEGIN21ACHIEVEMENTSB" datasource="#session.global_dsn#" maxrows="1"> 
		   SELECT   GUID,
                    PERSONNELIDNO,
                    AWARDTITLE,
                    DATEGIVEN,
                    NATURECATEGORY	
			 FROM   EGIN21ACHIEVEMENTS
			WHERE REFERENCECODE = '#refcode#' AND AWARDTITLE LIKE '%BOARD%';
</cfquery>

<cfloop query="qryEGIN21ACHIEVEMENTSB">
					
	<cfset BOARDEXAMRESULT = '#NATURECATEGORY#'>
    
</cfloop>

<cfquery name="qryEGIN21ACHIEVEMENTSL" datasource="#session.global_dsn#" maxrows="1"> 
		   SELECT   GUID,
                    PERSONNELIDNO,
                    AWARDTITLE,
                    DATEGIVEN,
                    NATURECATEGORY	
			 FROM   EGIN21ACHIEVEMENTS
			WHERE REFERENCECODE = '#refcode#' AND AWARDTITLE LIKE '%LICENSE%';
</cfquery>

<cfloop query="qryEGIN21ACHIEVEMENTSL">
	
    <cfset LICENSECERT     = '#NATURECATEGORY#'>
    
</cfloop>


<cfquery name="qryEGIN21MEDHISTORY" datasource="#session.global_dsn#" maxrows="1"> 
		   SELECT   GUID,
                    PERSONNELIDNO,
                    BLOODTYPE
			 FROM   EGIN21MEDHISTORY
			WHERE REFERENCECODE = '#refcode#';
</cfquery>

<cfloop query="qryEGIN21MEDHISTORY">
					
	<cfset BLOODTYPE = '#BLOODTYPE#'>
    
</cfloop>





<cfquery name="qryEGIN21TRAINING" datasource="#session.global_dsn#"> 
		   SELECT   GUID,
                    PERSONNELIDNO,
                    INCLUSIVEDATE,
                    TOPIC,
                    REMARKS
			 FROM   EGIN21TRAINING
			WHERE REFERENCECODE = '#refcode#';
</cfquery>

<cfset counter = 1 >

<cfloop query="qryEGIN21TRAINING">
					
  <cfif counter EQ 1 >   
                 
	<cfset FIRSTSEMINARTOPIC         = '#TOPIC#'>
    <cfset FIRSTSEMINARDATE          = '#INCLUSIVEDATE#'>
    <cfset FIRSTSEMINARORGANIZER     = '#REMARKS#'>
    
    <cfset counter = counter + 1 >
    
  <cfelseif counter EQ 2 >
  
  	<cfset SECONDSEMINARTOPIC         = '#TOPIC#'>
    <cfset SECONDSEMINARDATE          = '#INCLUSIVEDATE#'>
    <cfset SECONDSEMINARORGANIZER     = '#REMARKS#'>
    
    <cfset counter = counter + 1 >
    
  <cfelseif counter EQ 3 >
  
  	<cfset THIRDSEMINARTOPIC         = '#TOPIC#'>
    <cfset THIRDSEMINARDATE          = '#INCLUSIVEDATE#'>
    <cfset THIRDSEMINARORGANIZER     = '#REMARKS#'>
    
    <cfset counter = counter + 1 >
    
  <cfelseif counter EQ 4 >
  
  	<cfset FOURTHSEMINARTOPIC         = '#TOPIC#'>
    <cfset FOURTHSEMINARDATE          = '#INCLUSIVEDATE#'>
    <cfset FOURTHSEMINARORGANIZER     = '#REMARKS#'>
    
    <cfset counter = counter + 1 >
    
  <cfelseif counter EQ 5 >
  
  	<cfset FIFTHSEMINARTOPIC         = '#TOPIC#'>
    <cfset FIFTHSEMINARDATE          = '#INCLUSIVEDATE#'>
    <cfset FIFTHSEMINARORGANIZER     = '#REMARKS#'>
    
  <cfelseif counter EQ 6 >
  
  	<cfset SIXTHSEMINARTOPIC         = '#TOPIC#'>
    <cfset SIXTHSEMINARDATE          = '#INCLUSIVEDATE#'>
    <cfset SIXTHSEMINARORGANIZER     = '#REMARKS#'>
  
  </cfif>
  
   
 </cfloop>

<cfquery name="qryEGIN21WORKHISTORY" datasource="#session.global_dsn#"> 
		   SELECT  GUID,
                   PERSONNELIDNO,
                   ENTITYCODE,
                   MAINDUTIES,
                   DATEHIRED,
                   SEPARATIONDATE,
                   WORKSTARTINGSALARY,
                   WORKENDINGSALARY,
                   LASTPOSITIONHELD,
                   SUPERIOR,
                   REASONFORLEAVING 
			 FROM  EGIN21WORKHISTORY
			WHERE REFERENCECODE = '#refcode#';
</cfquery>

<cfset counter = 1 >

<cfloop query="qryEGIN21WORKHISTORY">

  <cfif counter EQ 1 >
                    
	<cfset FIRSTEMPHISTORYNAME          = '#ENTITYCODE#'>	
    <cfset FIRSTEMPHISTORYADDRESS       = '#MAINDUTIES#'>	
    <cfset FIRSTEMPHISTORYDATEEMP       = '#DATEHIRED#'>
    <cfset FIRSTEMPHISTORYDATESEP       = '#SEPARATIONDATE#'>
    <cfset FIRSTEMPHISTORYINISALARY     = '#WORKSTARTINGSALARY#'>
    <cfset FIRSTEMPHISTORYLASTSALARY    = '#WORKENDINGSALARY#'>
    <cfset FIRSTEMPHISTORYLASTPOS       = '#LASTPOSITIONHELD#'>
    <cfset FIRSTEMPHISTORYSUPERIOR      = '#SUPERIOR#'>
    <cfset FIRSTEMPHISTORYLEAVEREASONS  = '#REASONFORLEAVING#'>
    
    <cfset counter = counter + 1 >
    
  <cfelseif counter EQ 2 >
                    
	<cfset SECONDEMPHISTORYNAME          = '#ENTITYCODE#'>	
    <cfset SECONDEMPHISTORYADDRESS       = '#MAINDUTIES#'>	
    <cfset SECONDEMPHISTORYDATEEMP       = '#DATEHIRED#'>
    <cfset SECONDEMPHISTORYDATESEP       = '#SEPARATIONDATE#'>
    <cfset SECONDEMPHISTORYINISALARY     = '#WORKSTARTINGSALARY#'>
    <cfset SECONDEMPHISTORYLASTSALARY    = '#WORKENDINGSALARY#'>
    <cfset SECONDEMPHISTORYLASTPOS       = '#LASTPOSITIONHELD#'>
    <cfset SECONDEMPHISTORYSUPERIOR      = '#SUPERIOR#'>
    <cfset SECONDEMPHISTORYLEAVEREASONS  = '#REASONFORLEAVING#'>
    
    <cfset counter = counter + 1 >
    
  <cfelseif counter EQ 3 >
                    
	<cfset THIRDEMPHISTORYNAME          = '#ENTITYCODE#'>	
    <cfset THIRDEMPHISTORYADDRESS       = '#MAINDUTIES#'>	
    <cfset THIRDEMPHISTORYDATEEMP       = '#DATEHIRED#'>
    <cfset THIRDEMPHISTORYDATESEP       = '#SEPARATIONDATE#'>
    <cfset THIRDEMPHISTORYINISALARY     = '#WORKSTARTINGSALARY#'>
    <cfset THIRDEMPHISTORYLASTSALARY    = '#WORKENDINGSALARY#'>
    <cfset THIRDEMPHISTORYLASTPOS       = '#LASTPOSITIONHELD#'>
    <cfset THIRDEMPHISTORYSUPERIOR      = '#SUPERIOR#'>
    <cfset THIRDEMPHISTORYLEAVEREASONS  = '#REASONFORLEAVING#'>
    
    <cfset counter = counter + 1 >
    
  <cfelseif counter EQ 4 >
                    
	<cfset FOURTHEMPHISTORYNAME          = '#ENTITYCODE#'>	
    <cfset FOURTHEMPHISTORYADDRESS       = '#MAINDUTIES#'>	
    <cfset FOURTHEMPHISTORYDATEEMP       = '#DATEHIRED#'>
    <cfset FOURTHEMPHISTORYDATESEP       = '#SEPARATIONDATE#'>
    <cfset FOURTHEMPHISTORYINISALARY     = '#WORKSTARTINGSALARY#'>
    <cfset FOURTHEMPHISTORYLASTSALARY    = '#WORKENDINGSALARY#'>
    <cfset FOURTHEMPHISTORYLASTPOS       = '#LASTPOSITIONHELD#'>
    <cfset FOURTHEMPHISTORYSUPERIOR      = '#SUPERIOR#'>
    <cfset FOURTHEMPHISTORYLEAVEREASONS  = '#REASONFORLEAVING#'>
    
    <cfset counter = counter + 1 >
    
  <cfelseif counter EQ 5 >
                    
	<cfset FIFTHEMPHISTORYNAME          = '#ENTITYCODE#'>	
    <cfset FIFTHEMPHISTORYADDRESS       = '#MAINDUTIES#'>	
    <cfset FIFTHEMPHISTORYDATEEMP       = '#DATEHIRED#'>
    <cfset FIFTHEMPHISTORYDATESEP       = '#SEPARATIONDATE#'>
    <cfset FIFTHEMPHISTORYINISALARY     = '#WORKSTARTINGSALARY#'>
    <cfset FIFTHEMPHISTORYLASTSALARY    = '#WORKENDINGSALARY#'>
    <cfset FIFTHEMPHISTORYLASTPOS       = '#LASTPOSITIONHELD#'>
    <cfset FIFTHEMPHISTORYSUPERIOR      = '#SUPERIOR#'>
    <cfset FIFTHEMPHISTORYLEAVEREASONS  = '#REASONFORLEAVING#'>
    
  </cfif>
 
</cfloop>



<cfquery name="qryEGIN21RELATIVE" datasource="#session.global_dsn#"> 
		   SELECT  GUID,
                   PERSONNELIDNO,
                   NAME,
                   COMPANY,
                   POSITION
			 FROM  EGIN21RELATIVE
			WHERE REFERENCECODE = '#refcode#';
</cfquery>

<cfset counter = 1 >

<cfloop query="qryEGIN21RELATIVE">

  <cfif counter EQ 1 >
                    
	<cfset RELWORKINNAMEONE           = '#NAME#'>	
    <cfset RELWORKINCOMPONE           = '#COMPANY#'>	
    <cfset RELWORKINAFINITYONE        = '#POSITION#'>
    
    <cfset couner = counter + 1 >
    
 <cfelseif counter EQ 2 >
                    
	<cfset RELWORKINNAMETWO           = '#NAME#'>	
    <cfset RELWORKINCOMPTWO           = '#COMPANY#'>	
    <cfset RELWORKINAFINITYTWO        = '#POSITION#'>
    
    <cfset couner = counter + 1 >
    
 <cfelseif counter EQ 3 >
                    
	<cfset RELWORKINNAMETHREE           = '#NAME#'>	
    <cfset RELWORKINCOMPTHREE           = '#COMPANY#'>	
    <cfset RELWORKINAFINITYTHREE        = '#POSITION#'>
    
 </cfif>
    
</cfloop>

<cfquery name="qryEGIN21MISCINFO1" datasource="#session.global_dsn#"> 
		   SELECT  GUID,
                   PERSONNELIDNO,
                   SPECIALTALENTS,
                   CLASSIFICATION,
                   RANKHELD
			 FROM  EGIN21MISCINFO1
			WHERE REFERENCECODE = '#refcode#';
</cfquery>

<cfset counter = 1 >

<cfloop query="qryEGIN21MISCINFO1">

  <cfif counter EQ 1 >
                    
	<cfset SPECIALSKILLSONE           = '#SPECIALTALENTS#'>	
    <cfset SPECIALSKILLSYEARSPONE     = '#CLASSIFICATION#'>	
    <cfset SPECIALSKILLSLEVELONE      = '#RANKHELD#'>
    
    <cfset counter = counter + 1 >
    
  <cfelseif counter EQ 2 >
                    
	<cfset SPECIALSKILLSTWO           = '#SPECIALTALENTS#'>	
    <cfset SPECIALSKILLSYEARSPTWO     = '#CLASSIFICATION#'>	
    <cfset SPECIALSKILLSLEVELTWO      = '#RANKHELD#'>
    
    <cfset counter = counter + 1 >
    
  <cfelseif counter EQ 3 >
                    
	<cfset SPECIALSKILLSTHREE           = '#SPECIALTALENTS#'>	
    <cfset SPECIALSKILLSYEARSPTHREE     = '#CLASSIFICATION#'>	
    <cfset SPECIALSKILLSLEVELTHREE      = '#RANKHELD#'>
    
    <cfset counter = counter + 1 >
   
  <cfelseif counter EQ 4 >
                    
	<cfset SPECIALSKILLSFOUR           = '#SPECIALTALENTS#'>	
    <cfset SPECIALSKILLSYEARSPFOUR     = '#CLASSIFICATION#'>	
    <cfset SPECIALSKILLSLEVELFOUR      = '#RANKHELD#'>
    
    <cfset counter = counter + 1 > 
    
  <cfelseif counter EQ 5 >
                    
	<cfset SPECIALSKILLSFIVE           = '#SPECIALTALENTS#'>	
    <cfset SPECIALSKILLSYEARSPFIVE     = '#CLASSIFICATION#'>	
    <cfset SPECIALSKILLSLEVELFIVE      = '#RANKHELD#'>
    
  </cfif>
    
</cfloop>

<cfquery name="qryEGIN21CHAREFERENCE" datasource="#session.global_dsn#"> 
		   SELECT  GUID,
                   PERSONNELIDNO,
                   NAME,
                   OCCUPATION,
                   COMPANY,
                   CELLULARPHONE
			 FROM  EGIN21CHAREFERENCE
			WHERE REFERENCECODE = '#refcode#';
</cfquery>

<cfset counter = 1 >

<cfloop query="qryEGIN21CHAREFERENCE">

  <cfif counter EQ 1 >
                    
	<cfset REFERENCENAME1       = '#NAME#'>
    <cfset REFERENCEOCCUPATION1 = '#OCCUPATION#'>
    <cfset REFERENCECOMPANY1    = '#COMPANY#'>
    <cfset REFERENCECONTACT1    = '#CELLULARPHONE#'>
    
    <cfset counter = counter + 1 >
    
  <cfelseif counter EQ 2 >
                    
	<cfset REFERENCENAME2       = '#NAME#'>
    <cfset REFERENCEOCCUPATION2 = '#OCCUPATION#'>
    <cfset REFERENCECOMPANY2    = '#COMPANY#'>
    <cfset REFERENCECONTACT2    = '#CELLULARPHONE#'>
    
    <cfset counter = counter + 1 >
    
  <cfelseif counter EQ 3 >
                    
	<cfset REFERENCENAME3       = '#NAME#'>
    <cfset REFERENCEOCCUPATION3 = '#OCCUPATION#'>
    <cfset REFERENCECOMPANY3    = '#COMPANY#'>
    <cfset REFERENCECONTACT3    = '#CELLULARPHONE#'>
  
  </cfif> 
   
</cfloop>

<cfquery name="qryEGIN21EMPVIOL1" datasource="#session.global_dsn#"> 
		   SELECT  GUID,
                   PERSONNELIDNO,
                   CASENUMBER,
                   CASENAME,
                   CASESTATUS
			 FROM  EGIN21EMPVIOL
			WHERE REFERENCECODE = '#refcode#' AND CASENUMBER LIKE '%defects%';
</cfquery>

<cfloop query="qryEGIN21EMPVIOL1">
                    
	<cfset HASPHYSICALDEFFECTS           = '#CASENAME#'>	
	<cfset HASPHYSICALDEFFECTSNATURE     = '#CASESTATUS#'>

</cfloop>

<cfquery name="qryEGIN21EMPVIOL2" datasource="#session.global_dsn#"> 
		   SELECT  GUID,
                   PERSONNELIDNO,
                   CASENUMBER,
                   CASENAME,
                   CASESTATUS
			 FROM  EGIN21EMPVIOL
			WHERE REFERENCECODE = '#refcode#' AND CASENUMBER LIKE '%illness%';
</cfquery>

<cfloop query="qryEGIN21EMPVIOL2">
                    
	<cfset HASOPILLNESS           = '#CASENAME#'>	
	<cfset HASOPILLNESSNATURE     = '#CASESTATUS#'>

</cfloop>

<cfquery name="qryEGIN21EMPVIOL3" datasource="#session.global_dsn#"> 
		   SELECT  GUID,
                   PERSONNELIDNO,
                   CASENUMBER,
                   CASENAME,
                   CASESTATUS
			 FROM  EGIN21EMPVIOL
			WHERE REFERENCECODE = '#refcode#' AND CASENUMBER LIKE '%sensitive%';
</cfquery>

<cfloop query="qryEGIN21EMPVIOL3">
                    
	<cfset HASDRUGSENSITIVE           = '#CASENAME#'>	
	<cfset HASDRUGSENSITIVENATURE     = '#CASESTATUS#'>

</cfloop>

<cfquery name="qryEGIN21EMPVIOL4" datasource="#session.global_dsn#"> 
		   SELECT  GUID,
                   PERSONNELIDNO,
                   CASENUMBER,
                   CASENAME,
                   CASESTATUS
			 FROM  EGIN21EMPVIOL
			WHERE REFERENCECODE = '#refcode#' AND CASENUMBER LIKE '%dangerous drugs%';
</cfquery>

<cfloop query="qryEGIN21EMPVIOL4">
                    
	<cfset HASENGAGEDRUGS           = '#CASENAME#'>	
	<cfset HASENGAGEDRUGSNATURE     = '#CASESTATUS#'>

</cfloop>

<cfquery name="qryEGIN21EMPVIOL5" datasource="#session.global_dsn#"> 
		   SELECT  GUID,
                   PERSONNELIDNO,
                   CASENUMBER,
                   CASENAME,
                   CASESTATUS
			 FROM  EGIN21EMPVIOL
			WHERE REFERENCECODE = '#refcode#' AND CASENUMBER LIKE '%business%';
</cfquery>

<cfloop query="qryEGIN21EMPVIOL5">
                    
	<cfset HASINVOLVEBUSI           = '#CASENAME#'>	
	<cfset HASINVOLVEBUSINATURE     = '#CASESTATUS#'>

</cfloop>
 
<cfquery name="qryEGIN21EMPVIOLN6" datasource="#session.global_dsn#"> 
		   SELECT  GUID,
                   PERSONNELIDNO,
                   CASENUMBER,
                   CASENAME,
                   CASESTATUS
			 FROM  EGIN21EMPVIOL
			WHERE REFERENCECODE = '#refcode#' AND CASENUMBER LIKE '%suspended%';
</cfquery>

<cfloop query="qryEGIN21EMPVIOLN6">
                    
	<cfset HASSUSPENDED           = '#CASENAME#'>	
	<cfset HASSUSPENDEDNATURE     = '#CASESTATUS#'>

</cfloop>

<cfquery name="qryEGIN21EMPVIOL7" datasource="#session.global_dsn#"> 
		   SELECT  GUID,
                   PERSONNELIDNO,
                   CASENUMBER,
                   CASENAME,
                   CASESTATUS
			 FROM  EGIN21EMPVIOL
			WHERE REFERENCECODE = '#refcode#' AND CASENUMBER LIKE '%convicted%';
</cfquery>
 
<cfloop query="qryEGIN21EMPVIOL7">
                    
	<cfset HASCRIMINAL           = '#CASENAME#'>	
	<cfset HASCRIMINALNATURE     = '#CASESTATUS#'>

</cfloop>    

    
    <h2 style="text-align: center;"><cfoutput>#session.companyname#</cfoutput></h2>
    <h3 style="text-align: center;">EMPLOYMENT APPLICATION FORM</h3>
    <br />
    <img src="../../../unDB/images/globalphoto/<cfoutput>#PHOTOIDNAME#</cfoutput>" width="200" height="200" alt="NO PHOTO">
    <h4><cfoutput>#LASTNAME#, #FIRSTNAME# #MIDDLENAME#</cfoutput></h4> 
    
	<table style="font-size: 12px; font-family: Arial, Helvetica, sans-serif; border: 1px solid #666;">
		<tr>
			<th style="border-bottom: 1px solid #CCC;">&nbsp;</th>
			<th style="border-bottom: 1px solid #CCC;">&nbsp;</th>
		</tr>
		
        <tr>
			<td style="border-bottom: 2px solid #333; border-top: 2px solid #333;"><strong>PERSONAL INFORMATION</strong></td>
			<td style="border-bottom: 2px solid #333; border-top: 2px solid #333;"></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;"></td>
			<td style="border-bottom: 1px solid #CCC;"></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Last Name</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#LASTNAME#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">First Name</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#FIRSTNAME#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Suffix</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#SUFFIX#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Middle Name</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#MIDDLENAME#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Present Address and Postal Code</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#PRESENTADDRESSPOSTAL#</cfoutput></td>
		</tr> 
        <tr>
			<td style="border-bottom: 1px solid #CCC;"></td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#PRESENTADDRESSOWN#</cfoutput></td>
		</tr>
        
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Provincial Address and Postal Code</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#PROVINCIALADDRESSPOSTAL#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;"></td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#PROVINCEADDRESSOWN#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Date of Birth</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#DATEOFBIRTH#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Age</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#AGE#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Gender</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#GENDER#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Place of Birth</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#PLACEOFBIRTH#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Civil Status</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#CIVILSTATUS#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">SSS No.</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#SSSNUMBER#</cfoutput></td>
		</tr>
        
        <tr>
			<td style="border-bottom: 1px solid #CCC;">TIN</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#TINNUMBER#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">PhilHealth No.</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#PHILHEALTHNUMBER#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">PAG-IBIG No.</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#PAGIBIGNUMBER#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Cellphone Number</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#CELLPHONENUMBER#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Landline Number</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#LANDLINENUMBER#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Email Address</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#EMAILADDRESS#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Citizenship</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#CITIZENSHIP#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Religion</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#RELIGION#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Height</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#HEIGHT#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Weight</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#WEIGHT#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Blood Type</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#BLOODTYPE#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;"></td>
			<td style="border-bottom: 1px solid #CCC;"></td>
		</tr>
        
        
        
        <tr>
			<td style="border-bottom: 2px solid #333; border-top: 2px solid #333;"><strong>EMPLOYMENT INFORMATION<strong></td>
			<td style="border-bottom: 2px solid #333; border-top: 2px solid #333;"></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;"></td>
			<td style="border-bottom: 1px solid #CCC;"></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Position First Choice</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#POSITIONFIRSTPRIORITY#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Position First Choice Company</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#COMPANYFIRSTPRIORITY#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Position Second Choice</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#POSITIONSECONDPRIORITY#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Position Second Choice Company</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#COMPANYSECONDPRIORITY#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Position Third Choice</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#POSITIONTHIRDPRIORITY#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Position Third Choice Company</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#COMPANYTHIRDPRIORITY#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Expected Salary</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#EXPECTEDSALARY#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Current Salary</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#CURRENTSALARY#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Previously Employed With Any <cfoutput>#COMPANYCODE#</cfoutput> Group Offices?</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#PREVEMPLOYED# From: #PREVEMPLOYEDFROM#  To: #PREVEMPLOYEDTO#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Previously Applied Here? </td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#PREVAPPLIED#  last:  #PREVAPPLIEDLAST#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Date Available for Employment?</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#DATEAVAILEMP#</cfoutput></td>
		</tr>
        
        
        <tr>
			<td style="border-bottom: 2px solid #333; border-top: 2px solid #333;"><strong>FAMILY BACKGROUND<strong></td>
			<td style="border-bottom: 2px solid #333; border-top: 2px solid #333;"></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;"></td>
			<td style="border-bottom: 1px solid #CCC;"></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Father</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#FATHERFULLNAME#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Age</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#FATHERAGE#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Occupation</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#FATHEROCCUPATION#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Company</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#FATHERCOMPANY#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Contact Number</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#FATHERCONTACTNO#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;"></td>
			<td style="border-bottom: 1px solid #CCC;"></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Mother</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#MOTHERFULLNAME#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Age</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#MOTHERAGE#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Occupation</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#MOTHEROCCUPATION#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Company</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#MOTHERCOMPANY#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Contact Number</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#MOTHERCONTACTNO#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;"></td>
			<td style="border-bottom: 1px solid #CCC;"></td>
		</tr>
        <cfif len(SPOUSEFULLNAME) GT 0 AND Ucase(SPOUSEFULLNAME) NEQ 'NA'>
        	
        <tr>
			<td style="border-bottom: 1px solid #CCC;"></td>
			<td style="border-bottom: 1px solid #CCC;"></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Spouse</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#SPOUSEFULLNAME#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Age</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#SPOUSEAGE#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Occupation</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#SPOUSEOCCUPATION#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Company</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#SPOUSECOMPANY#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Contact Number</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#SPOUSECONTACTNO#</cfoutput></td>
		</tr>
        </cfif>
        <tr>
			<td style="border-bottom: 1px solid #CCC;"></td>
			<td style="border-bottom: 1px solid #CCC;"></td>
		</tr>
        
        <tr>
			<td style="border-bottom: 2px solid #333; border-top: 2px solid #333;"><strong>Children</strong></td>
			<td style="border-bottom: 2px solid #333; border-top: 2px solid #333;"></td>
		</tr>
        
        <cfset counts = 0 >
        <cfif len(FIRSTCHILDFULLNAME) GT 0 AND Ucase(FIRSTCHILDFULLNAME) NEQ 'NA'>
        
        	<cfset counts = counts + 1 >
        <tr>
			<td style="border-bottom: 1px solid #CCC;"></td>
			<td style="border-bottom: 1px solid #CCC;"></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput><strong>#counts#. </strong></cfoutput> Name</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#FIRSTCHILDFULLNAME#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Age</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#FIRSTCHILDAGE#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Occupation</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#FIRSTCHILDOCCUPATION#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Company</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#FIRSTCHILDCOMPANY#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Contact Number</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#FIRSTCHILDCONTACTNO#</cfoutput></td>
		</tr>
        </cfif>
        
        <cfif len(SECONDCHILDFULLNAME) GT 0 AND Ucase(SECONDCHILDFULLNAME) NEQ 'NA'>
        
        	<cfset counts = counts + 1 >
        <tr>
			<td style="border-bottom: 1px solid #CCC;"></td>
			<td style="border-bottom: 1px solid #CCC;"></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput><strong>#counts#. </strong></cfoutput> Name</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#SECONDCHILDFULLNAME#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Age</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#SECONDCHILDAGE#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Occupation</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#SECONDCHILDOCCUPATION#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Company</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#SECONDCHILDCOMPANY#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Contact Number</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#SECONDCHILDCONTACTNO#</cfoutput></td>
		</tr>
        </cfif>
        
        <cfif len(THIRDCHILDFULLNAME) GT 0 AND Ucase(THIRDCHILDFULLNAME) NEQ 'NA'>
        
        	<cfset counts = counts + 1 >
        <tr>
			<td style="border-bottom: 1px solid #CCC;"></td>
			<td style="border-bottom: 1px solid #CCC;"></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput><strong>#counts#. </strong></cfoutput> Name</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#THIRDCHILDFULLNAME#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Age</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#THIRDCHILDAGE#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Occupation</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#THIRDCHILDOCCUPATION#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Company</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#THIRDCHILDCOMPANY#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Contact Number</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#THIRDCHILDCONTACTNO#</cfoutput></td>
		</tr>
        </cfif>
        
        <cfif len(FOURTHCHILDFULLNAME) GT 0 AND Ucase(FOURTHCHILDFULLNAME) NEQ 'NA'>
        
        	<cfset counts = counts + 1 >
        <tr>
			<td style="border-bottom: 1px solid #CCC;"></td>
			<td style="border-bottom: 1px solid #CCC;"></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput><strong>#counts#. </strong></cfoutput> Name</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#FOURTHCHILDFULLNAME#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Age</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#FOURTHCHILDAGE#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Occupation</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#FOURTHCHILDOCCUPATION#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Company</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#FOURTHCHILDCOMPANY#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Contact Number</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#FOURTHCHILDCONTACTNO#</cfoutput></td>
		</tr>
        </cfif>
        
        <cfif len(FIFTHCHILDFULLNAME) GT 0 AND Ucase(FIFTHCHILDFULLNAME) NEQ 'NA'>
        
        	<cfset counts = counts + 1 >
        <tr>
			<td style="border-bottom: 1px solid #CCC;"></td>
			<td style="border-bottom: 1px solid #CCC;"></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput><strong>#counts#. </strong></cfoutput> Name</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#FIFTHCHILDFULLNAME#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Age</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#FIFTHCHILDAGE#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Occupation</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#FIFTHCHILDOCCUPATION#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Company</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#FIFTHCHILDCOMPANY#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Contact Number</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#FIFTHCHILDCONTACTNO#</cfoutput></td>
		</tr>
		</cfif>
		
		<cfif len(SIXTHCHILDFULLNAME) GT 0 AND Ucase(SIXTHCHILDFULLNAME) NEQ 'NA'>
        
        	<cfset counts = counts + 1 >
	        <tr>
				<td style="border-bottom: 1px solid #CCC;"></td>
				<td style="border-bottom: 1px solid #CCC;"></td>
			</tr>
	        <tr>
				<td style="border-bottom: 1px solid #CCC;"><cfoutput><strong>#counts#. </strong></cfoutput> Name</td>
				<td style="border-bottom: 1px solid #CCC;"><cfoutput>#SIXTHCHILDFULLNAME#</cfoutput></td>
			</tr>
	        <tr>
				<td style="border-bottom: 1px solid #CCC;">Age</td>
				<td style="border-bottom: 1px solid #CCC;"><cfoutput>#SIXTHCHILDAGE#</cfoutput></td>
			</tr>
	        <tr>
				<td style="border-bottom: 1px solid #CCC;">Occupation</td>
				<td style="border-bottom: 1px solid #CCC;"><cfoutput>#SIXTHCHILDOCCUPATION#</cfoutput></td>
			</tr>
	        <tr>
				<td style="border-bottom: 1px solid #CCC;">Company</td>
				<td style="border-bottom: 1px solid #CCC;"><cfoutput>#SIXTHCHILDCOMPANY#</cfoutput></td>
			</tr>
	        <tr>
				<td style="border-bottom: 1px solid #CCC;">Contact Number</td>
				<td style="border-bottom: 1px solid #CCC;"><cfoutput>#SIXTHCHILDCONTACTNO#</cfoutput></td>
			</tr>
        </cfif>
        
        <cfif len(SEVENTHCHILDFULLNAME) GT 0 AND Ucase(SEVENTHCHILDFULLNAME) NEQ 'NA'>
        
        	<cfset counts = counts + 1 >
	        <tr>
				<td style="border-bottom: 1px solid #CCC;"></td>
				<td style="border-bottom: 1px solid #CCC;"></td>
			</tr>
	        <tr>
				<td style="border-bottom: 1px solid #CCC;"><cfoutput><strong>#counts#. </strong></cfoutput> Name</td>
				<td style="border-bottom: 1px solid #CCC;"><cfoutput>#SEVENTHCHILDFULLNAME#</cfoutput></td>
			</tr>
	        <tr>
				<td style="border-bottom: 1px solid #CCC;">Age</td>
				<td style="border-bottom: 1px solid #CCC;"><cfoutput>#SEVENTHCHILDAGE#</cfoutput></td>
			</tr>
	        <tr>
				<td style="border-bottom: 1px solid #CCC;">Occupation</td>
				<td style="border-bottom: 1px solid #CCC;"><cfoutput>#SEVENTHCHILDOCCUPATION#</cfoutput></td>
			</tr>
	        <tr>
				<td style="border-bottom: 1px solid #CCC;">Company</td>
				<td style="border-bottom: 1px solid #CCC;"><cfoutput>#SEVENTHCHILDCOMPANY#</cfoutput></td>
			</tr>
	        <tr>
				<td style="border-bottom: 1px solid #CCC;">Contact Number</td>
				<td style="border-bottom: 1px solid #CCC;"><cfoutput>#SEVENTHCHILDCONTACTNO#</cfoutput></td>
			</tr>
        </cfif>
        
        <cfif len(EIGHTHCHILDFULLNAME) GT 0 AND Ucase(EIGHTHCHILDFULLNAME) NEQ 'NA'>
        
        	<cfset counts = counts + 1 >
	        <tr>
				<td style="border-bottom: 1px solid #CCC;"></td>
				<td style="border-bottom: 1px solid #CCC;"></td>
			</tr>
	        <tr>
				<td style="border-bottom: 1px solid #CCC;"><cfoutput><strong>#counts#. </strong></cfoutput> Name</td>
				<td style="border-bottom: 1px solid #CCC;"><cfoutput>#EIGHTHCHILDFULLNAME#</cfoutput></td>
			</tr>
	        <tr>
				<td style="border-bottom: 1px solid #CCC;">Age</td>
				<td style="border-bottom: 1px solid #CCC;"><cfoutput>#EIGHTHCHILDAGE#</cfoutput></td>
			</tr>
	        <tr>
				<td style="border-bottom: 1px solid #CCC;">Occupation</td>
				<td style="border-bottom: 1px solid #CCC;"><cfoutput>#EIGHTHCHILDOCCUPATION#</cfoutput></td>
			</tr>
	        <tr>
				<td style="border-bottom: 1px solid #CCC;">Company</td>
				<td style="border-bottom: 1px solid #CCC;"><cfoutput>#EIGHTHCHILDCOMPANY#</cfoutput></td>
			</tr>
	        <tr>
				<td style="border-bottom: 1px solid #CCC;">Contact Number</td>
				<td style="border-bottom: 1px solid #CCC;"><cfoutput>#EIGHTHCHILDCONTACTNO#</cfoutput></td>
			</tr>
        </cfif>
        
        <cfif len(NINTHCHILDFULLNAME) GT 0 AND Ucase(NINTHCHILDFULLNAME) NEQ 'NA'>
        
        	<cfset counts = counts + 1 >
	        <tr>
				<td style="border-bottom: 1px solid #CCC;"></td>
				<td style="border-bottom: 1px solid #CCC;"></td>
			</tr>
	        <tr>
				<td style="border-bottom: 1px solid #CCC;"><cfoutput><strong>#counts#. </strong></cfoutput> Name</td>
				<td style="border-bottom: 1px solid #CCC;"><cfoutput>#NINTHCHILDFULLNAME#</cfoutput></td>
			</tr>
	        <tr>
				<td style="border-bottom: 1px solid #CCC;">Age</td>
				<td style="border-bottom: 1px solid #CCC;"><cfoutput>#NINTHCHILDAGE#</cfoutput></td>
			</tr>
	        <tr>
				<td style="border-bottom: 1px solid #CCC;">Occupation</td>
				<td style="border-bottom: 1px solid #CCC;"><cfoutput>#NINTHCHILDOCCUPATION#</cfoutput></td>
			</tr>
	        <tr>
				<td style="border-bottom: 1px solid #CCC;">Company</td>
				<td style="border-bottom: 1px solid #CCC;"><cfoutput>#NINTHCHILDCOMPANY#</cfoutput></td>
			</tr>
	        <tr>
				<td style="border-bottom: 1px solid #CCC;">Contact Number</td>
				<td style="border-bottom: 1px solid #CCC;"><cfoutput>#NINTHCHILDCONTACTNO#</cfoutput></td>
			</tr>
        </cfif>
        
        <cfif len(TENTHCHILDFULLNAME) GT 0 AND Ucase(TENTHCHILDFULLNAME) NEQ 'NA'>
        
        	<cfset counts = counts + 1 >
	        <tr>
				<td style="border-bottom: 1px solid #CCC;"></td>
				<td style="border-bottom: 1px solid #CCC;"></td>
			</tr>
	        <tr>
				<td style="border-bottom: 1px solid #CCC;"><cfoutput><strong>#counts#. </strong></cfoutput> Name</td>
				<td style="border-bottom: 1px solid #CCC;"><cfoutput>#TENTHCHILDFULLNAME#</cfoutput></td>
			</tr>
	        <tr>
				<td style="border-bottom: 1px solid #CCC;">Age</td>
				<td style="border-bottom: 1px solid #CCC;"><cfoutput>#TENTHCHILDAGE#</cfoutput></td>
			</tr>
	        <tr>
				<td style="border-bottom: 1px solid #CCC;">Occupation</td>
				<td style="border-bottom: 1px solid #CCC;"><cfoutput>#TENTHCHILDOCCUPATION#</cfoutput></td>
			</tr>
	        <tr>
				<td style="border-bottom: 1px solid #CCC;">Company</td>
				<td style="border-bottom: 1px solid #CCC;"><cfoutput>#TENTHCHILDCOMPANY#</cfoutput></td>
			</tr>
	        <tr>
				<td style="border-bottom: 1px solid #CCC;">Contact Number</td>
				<td style="border-bottom: 1px solid #CCC;"><cfoutput>#TENTHCHILDCONTACTNO#</cfoutput></td>
			</tr>
        </cfif>
        
        <cfif len(ELEVENTHCHILDFULLNAME) GT 0 AND Ucase(ELEVENTHCHILDFULLNAME) NEQ 'NA'>
        
        	<cfset counts = counts + 1 >
	        <tr>
				<td style="border-bottom: 1px solid #CCC;"></td>
				<td style="border-bottom: 1px solid #CCC;"></td>
			</tr>
	        <tr>
				<td style="border-bottom: 1px solid #CCC;"><cfoutput><strong>#counts#. </strong></cfoutput> Name</td>
				<td style="border-bottom: 1px solid #CCC;"><cfoutput>#ELEVENTHCHILDFULLNAME#</cfoutput></td>
			</tr>
	        <tr>
				<td style="border-bottom: 1px solid #CCC;">Age</td>
				<td style="border-bottom: 1px solid #CCC;"><cfoutput>#ELEVENTHCHILDAGE#</cfoutput></td>
			</tr>
	        <tr>
				<td style="border-bottom: 1px solid #CCC;">Occupation</td>
				<td style="border-bottom: 1px solid #CCC;"><cfoutput>#ELEVENTHCHILDOCCUPATION#</cfoutput></td>
			</tr>
	        <tr>
				<td style="border-bottom: 1px solid #CCC;">Company</td>
				<td style="border-bottom: 1px solid #CCC;"><cfoutput>#ELEVENTHCHILDCOMPANY#</cfoutput></td>
			</tr>
	        <tr>
				<td style="border-bottom: 1px solid #CCC;">Contact Number</td>
				<td style="border-bottom: 1px solid #CCC;"><cfoutput>#ELEVENTHCHILDCONTACTNO#</cfoutput></td>
			</tr>
        </cfif>
        
        <cfif len(TWELVECHILDFULLNAME) GT 0 AND Ucase(TWELVECHILDFULLNAME) NEQ 'NA'>
        
        	<cfset counts = counts + 1 >
	        <tr>
				<td style="border-bottom: 1px solid #CCC;"></td>
				<td style="border-bottom: 1px solid #CCC;"></td>
			</tr>
	        <tr>
				<td style="border-bottom: 1px solid #CCC;"><cfoutput><strong>#counts#. </strong></cfoutput> Name</td>
				<td style="border-bottom: 1px solid #CCC;"><cfoutput>#TWELVECHILDFULLNAME#</cfoutput></td>
			</tr>
	        <tr>
				<td style="border-bottom: 1px solid #CCC;">Age</td>
				<td style="border-bottom: 1px solid #CCC;"><cfoutput>#TWELVECHILDAGE#</cfoutput></td>
			</tr>
	        <tr>
				<td style="border-bottom: 1px solid #CCC;">Occupation</td>
				<td style="border-bottom: 1px solid #CCC;"><cfoutput>#TWELVECHILDOCCUPATION#</cfoutput></td>
			</tr>
	        <tr>
				<td style="border-bottom: 1px solid #CCC;">Company</td>
				<td style="border-bottom: 1px solid #CCC;"><cfoutput>#TWELVECHILDCOMPANY#</cfoutput></td>
			</tr>
	        <tr>
				<td style="border-bottom: 1px solid #CCC;">Contact Number</td>
				<td style="border-bottom: 1px solid #CCC;"><cfoutput>#TWELVECHILDCONTACTNO#</cfoutput></td>
			</tr>
        </cfif>
        
        <cfif len(THIRTEENTHCHILDFULLNAME) GT 0 AND Ucase(THIRTEENTHCHILDFULLNAME) NEQ 'NA'>
        
        	<cfset counts = counts + 1 >
	        <tr>
				<td style="border-bottom: 1px solid #CCC;"></td>
				<td style="border-bottom: 1px solid #CCC;"></td>
			</tr>
	        <tr>
				<td style="border-bottom: 1px solid #CCC;"><cfoutput><strong>#counts#. </strong></cfoutput> Name</td>
				<td style="border-bottom: 1px solid #CCC;"><cfoutput>#THIRTEENTHCHILDFULLNAME#</cfoutput></td>
			</tr>
	        <tr>
				<td style="border-bottom: 1px solid #CCC;">Age</td>
				<td style="border-bottom: 1px solid #CCC;"><cfoutput>#THIRTEENTHCHILDAGE#</cfoutput></td>
			</tr>
	        <tr>
				<td style="border-bottom: 1px solid #CCC;">Occupation</td>
				<td style="border-bottom: 1px solid #CCC;"><cfoutput>#THIRTEENTHCHILDOCCUPATION#</cfoutput></td>
			</tr>
	        <tr>
				<td style="border-bottom: 1px solid #CCC;">Company</td>
				<td style="border-bottom: 1px solid #CCC;"><cfoutput>#THIRTEENTHCHILDCOMPANY#</cfoutput></td>
			</tr>
	        <tr>
				<td style="border-bottom: 1px solid #CCC;">Contact Number</td>
				<td style="border-bottom: 1px solid #CCC;"><cfoutput>#THIRTEENTHCHILDCONTACTNO#</cfoutput></td>
			</tr>
        </cfif>
        
        <cfif len(FOURTEENTHCHILDFULLNAME) GT 0 AND Ucase(FOURTEENTHCHILDFULLNAME) NEQ 'NA'>
        
        	<cfset counts = counts + 1 >
	        <tr>
				<td style="border-bottom: 1px solid #CCC;"></td>
				<td style="border-bottom: 1px solid #CCC;"></td>
			</tr>
	        <tr>
				<td style="border-bottom: 1px solid #CCC;"><cfoutput><strong>#counts#. </strong></cfoutput> Name</td>
				<td style="border-bottom: 1px solid #CCC;"><cfoutput>#FOURTEENTHCHILDFULLNAME#</cfoutput></td>
			</tr>
	        <tr>
				<td style="border-bottom: 1px solid #CCC;">Age</td>
				<td style="border-bottom: 1px solid #CCC;"><cfoutput>#FOURTEENTHCHILDAGE#</cfoutput></td>
			</tr>
	        <tr>
				<td style="border-bottom: 1px solid #CCC;">Occupation</td>
				<td style="border-bottom: 1px solid #CCC;"><cfoutput>#FOURTEENTHCHILDOCCUPATION#</cfoutput></td>
			</tr>
	        <tr>
				<td style="border-bottom: 1px solid #CCC;">Company</td>
				<td style="border-bottom: 1px solid #CCC;"><cfoutput>#FOURTEENTHCHILDCOMPANY#</cfoutput></td>
			</tr>
	        <tr>
				<td style="border-bottom: 1px solid #CCC;">Contact Number</td>
				<td style="border-bottom: 1px solid #CCC;"><cfoutput>#FOURTEENTHCHILDCONTACTNO#</cfoutput></td>
			</tr>
        </cfif>
        
        <cfif len(FIFTEENTHCHILDFULLNAME) GT 0 AND Ucase(FIFTEENTHCHILDFULLNAME) NEQ 'NA'>
        
        	<cfset counts = counts + 1 >
	        <tr>
				<td style="border-bottom: 1px solid #CCC;"></td>
				<td style="border-bottom: 1px solid #CCC;"></td>
			</tr>
	        <tr>
				<td style="border-bottom: 1px solid #CCC;"><cfoutput><strong>#counts#. </strong></cfoutput> Name</td>
				<td style="border-bottom: 1px solid #CCC;"><cfoutput>#FIFTEENTHCHILDFULLNAME#</cfoutput></td>
			</tr>
	        <tr>
				<td style="border-bottom: 1px solid #CCC;">Age</td>
				<td style="border-bottom: 1px solid #CCC;"><cfoutput>#FIFTEENTHCHILDAGE#</cfoutput></td>
			</tr>
	        <tr>
				<td style="border-bottom: 1px solid #CCC;">Occupation</td>
				<td style="border-bottom: 1px solid #CCC;"><cfoutput>#FIFTEENTHCHILDOCCUPATION#</cfoutput></td>
			</tr>
	        <tr>
				<td style="border-bottom: 1px solid #CCC;">Company</td>
				<td style="border-bottom: 1px solid #CCC;"><cfoutput>#FIFTEENTHCHILDCOMPANY#</cfoutput></td>
			</tr>
	        <tr>
				<td style="border-bottom: 1px solid #CCC;">Contact Number</td>
				<td style="border-bottom: 1px solid #CCC;"><cfoutput>#FIFTEENTHCHILDCONTACTNO#</cfoutput></td>
			</tr>
        </cfif>



        <tr>
			<td style="border-bottom: 1px solid #CCC;"></td>
			<td style="border-bottom: 1px solid #CCC;"></td>
		</tr>
        <tr>
			<td style="border-bottom: 2px solid #333; border-top: 2px solid #333;"><strong>Brother(s)/Sister(s)</strong></td>
			<td style="border-bottom: 2px solid #333; border-top: 2px solid #333;"></td>
		</tr>
        
        <cfset counts = 0 >
       
       <cfif len(FIRSTBROFULLNAME) GT 0 AND Ucase(FIRSTBROFULLNAME) NEQ 'NA'>
        
        	<cfset counts = counts + 1 >
        <tr>
			<td style="border-bottom: 1px solid #CCC;"></td>
			<td style="border-bottom: 1px solid #CCC;"></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput><strong>#counts#. </strong></cfoutput> Name</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#FIRSTBROFULLNAME#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Age</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#FIRSTBROAGE#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Occupation</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#FIRSTBROOCCUPATION#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Company</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#FIRSTBROCOMPANY#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Contact Number</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#FIRSTBROCONTACTNO#</cfoutput></td>
		</tr>
        </cfif>
        
        <cfif len(SECONDBROFULLNAME) GT 0 AND Ucase(SECONDBROFULLNAME) NEQ 'NA'>
        
        	<cfset counts = counts + 1 >
        <tr>
			<td style="border-bottom: 1px solid #CCC;"></td>
			<td style="border-bottom: 1px solid #CCC;"></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput><strong>#counts#. </strong></cfoutput> Name</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#SECONDBROFULLNAME#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Age</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#SECONDBROAGE#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Occupation</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#SECONDBROOCCUPATION#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Company</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#SECONDBROCOMPANY#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Contact Number</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#SECONDBROCONTACTNO#</cfoutput></td>
		</tr>
        </cfif>
        
        <cfif len(THIRDBROFULLNAME) GT 0 AND Ucase(THIRDBROFULLNAME) NEQ 'NA'>
        
        	<cfset counts = counts + 1 >
        <tr>
			<td style="border-bottom: 1px solid #CCC;"></td>
			<td style="border-bottom: 1px solid #CCC;"></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput><strong>#counts#. </strong></cfoutput> Name</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#THIRDBROFULLNAME#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Age</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#THIRDBROAGE#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Occupation</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#THIRDBROOCCUPATION#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Company</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#THIRDBROCOMPANY#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Contact Number</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#THIRDBROCONTACTNO#</cfoutput></td>
		</tr>
        </cfif>
        
        <cfif len(FOURTHBROFULLNAME) GT 0 AND Ucase(FOURTHBROFULLNAME) NEQ 'NA' >
        
        	<cfset counts = counts + 1 >
        <tr>
			<td style="border-bottom: 1px solid #CCC;"></td>
			<td style="border-bottom: 1px solid #CCC;"></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput><strong>#counts#. </strong></cfoutput> Name</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#FOURTHBROFULLNAME#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Age</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#FOURTHBROAGE#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Occupation</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#FOURTHBROOCCUPATION#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Company</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#FOURTHBROCOMPANY#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Contact Number</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#FOURTHBROCONTACTNO#</cfoutput></td>
		</tr>
        </cfif>
        
        <cfif len(FIFTHBROFULLNAME) GT 0 AND Ucase(FIFTHBROFULLNAME) NEQ 'NA' >
        
        	<cfset counts = counts + 1 >
        <tr>
			<td style="border-bottom: 1px solid #CCC;"></td>
			<td style="border-bottom: 1px solid #CCC;"></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput><strong>#counts#. </strong></cfoutput> Name</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#FIFTHBROFULLNAME#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Age</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#FIFTHBROAGE#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Occupation</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#FIFTHBROOCCUPATION#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Company</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#FIFTHBROCOMPANY#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Contact Number</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#FIFTHBROCONTACTNO#</cfoutput></td>
		</tr>
        </cfif>
		
		<cfif len(SIXTHBROFULLNAME) GT 0 AND Ucase(SIXTHBROFULLNAME) NEQ 'NA'>
        
        	<cfset counts = counts + 1 >
	        <tr>
				<td style="border-bottom: 1px solid #CCC;"></td>
				<td style="border-bottom: 1px solid #CCC;"></td>
			</tr>
	        <tr>
				<td style="border-bottom: 1px solid #CCC;"><cfoutput><strong>#counts#. </strong></cfoutput> Name</td>
				<td style="border-bottom: 1px solid #CCC;"><cfoutput>#SIXTHBROFULLNAME#</cfoutput></td>
			</tr>
	        <tr>
				<td style="border-bottom: 1px solid #CCC;">Age</td>
				<td style="border-bottom: 1px solid #CCC;"><cfoutput>#SIXTHBROAGE#</cfoutput></td>
			</tr>
	        <tr>
				<td style="border-bottom: 1px solid #CCC;">Occupation</td>
				<td style="border-bottom: 1px solid #CCC;"><cfoutput>#SIXTHBROOCCUPATION#</cfoutput></td>
			</tr>
	        <tr>
				<td style="border-bottom: 1px solid #CCC;">Company</td>
				<td style="border-bottom: 1px solid #CCC;"><cfoutput>#SIXTHBROCOMPANY#</cfoutput></td>
			</tr>
	        <tr>
				<td style="border-bottom: 1px solid #CCC;">Contact Number</td>
				<td style="border-bottom: 1px solid #CCC;"><cfoutput>#SIXTHBROCONTACTNO#</cfoutput></td>
			</tr>
        </cfif>
        
        <cfif len(SEVENTHBROFULLNAME) GT 0 AND Ucase(SEVENTHBROFULLNAME) NEQ 'NA'>
        
        	<cfset counts = counts + 1 >
	        <tr>
				<td style="border-bottom: 1px solid #CCC;"></td>
				<td style="border-bottom: 1px solid #CCC;"></td>
			</tr>
	        <tr>
				<td style="border-bottom: 1px solid #CCC;"><cfoutput><strong>#counts#. </strong></cfoutput> Name</td>
				<td style="border-bottom: 1px solid #CCC;"><cfoutput>#SEVENTHBROFULLNAME#</cfoutput></td>
			</tr>
	        <tr>
				<td style="border-bottom: 1px solid #CCC;">Age</td>
				<td style="border-bottom: 1px solid #CCC;"><cfoutput>#SEVENTHBROAGE#</cfoutput></td>
			</tr>
	        <tr>
				<td style="border-bottom: 1px solid #CCC;">Occupation</td>
				<td style="border-bottom: 1px solid #CCC;"><cfoutput>#SEVENTHBROOCCUPATION#</cfoutput></td>
			</tr>
	        <tr>
				<td style="border-bottom: 1px solid #CCC;">Company</td>
				<td style="border-bottom: 1px solid #CCC;"><cfoutput>#SEVENTHBROCOMPANY#</cfoutput></td>
			</tr>
	        <tr>
				<td style="border-bottom: 1px solid #CCC;">Contact Number</td>
				<td style="border-bottom: 1px solid #CCC;"><cfoutput>#SEVENTHBROCONTACTNO#</cfoutput></td>
			</tr>
        </cfif>
        
        <cfif len(EIGHTHBROFULLNAME) GT 0 AND Ucase(EIGHTHBROFULLNAME) NEQ 'NA'>
        
        	<cfset counts = counts + 1 >
	        <tr>
				<td style="border-bottom: 1px solid #CCC;"></td>
				<td style="border-bottom: 1px solid #CCC;"></td>
			</tr>
	        <tr>
				<td style="border-bottom: 1px solid #CCC;"><cfoutput><strong>#counts#. </strong></cfoutput> Name</td>
				<td style="border-bottom: 1px solid #CCC;"><cfoutput>#EIGHTHBROFULLNAME#</cfoutput></td>
			</tr>
	        <tr>
				<td style="border-bottom: 1px solid #CCC;">Age</td>
				<td style="border-bottom: 1px solid #CCC;"><cfoutput>#EIGHTHBROAGE#</cfoutput></td>
			</tr>
	        <tr>
				<td style="border-bottom: 1px solid #CCC;">Occupation</td>
				<td style="border-bottom: 1px solid #CCC;"><cfoutput>#EIGHTHBROOCCUPATION#</cfoutput></td>
			</tr>
	        <tr>
				<td style="border-bottom: 1px solid #CCC;">Company</td>
				<td style="border-bottom: 1px solid #CCC;"><cfoutput>#EIGHTHBROCOMPANY#</cfoutput></td>
			</tr>
	        <tr>
				<td style="border-bottom: 1px solid #CCC;">Contact Number</td>
				<td style="border-bottom: 1px solid #CCC;"><cfoutput>#EIGHTHBROCONTACTNO#</cfoutput></td>
			</tr>
        </cfif>
        
        <cfif len(NINTHBROFULLNAME) GT 0 AND Ucase(NINTHBROFULLNAME) NEQ 'NA'>
        
        	<cfset counts = counts + 1 >
	        <tr>
				<td style="border-bottom: 1px solid #CCC;"></td>
				<td style="border-bottom: 1px solid #CCC;"></td>
			</tr>
	        <tr>
				<td style="border-bottom: 1px solid #CCC;"><cfoutput><strong>#counts#. </strong></cfoutput> Name</td>
				<td style="border-bottom: 1px solid #CCC;"><cfoutput>#NINTHBROFULLNAME#</cfoutput></td>
			</tr>
	        <tr>
				<td style="border-bottom: 1px solid #CCC;">Age</td>
				<td style="border-bottom: 1px solid #CCC;"><cfoutput>#NINTHBROAGE#</cfoutput></td>
			</tr>
	        <tr>
				<td style="border-bottom: 1px solid #CCC;">Occupation</td>
				<td style="border-bottom: 1px solid #CCC;"><cfoutput>#NINTHBROOCCUPATION#</cfoutput></td>
			</tr>
	        <tr>
				<td style="border-bottom: 1px solid #CCC;">Company</td>
				<td style="border-bottom: 1px solid #CCC;"><cfoutput>#NINTHBROCOMPANY#</cfoutput></td>
			</tr>
	        <tr>
				<td style="border-bottom: 1px solid #CCC;">Contact Number</td>
				<td style="border-bottom: 1px solid #CCC;"><cfoutput>#NINTHBROCONTACTNO#</cfoutput></td>
			</tr>
        </cfif>
        
        <cfif len(TENTHBROFULLNAME) GT 0 AND Ucase(TENTHBROFULLNAME) NEQ 'NA'>
        
        	<cfset counts = counts + 1 >
	        <tr>
				<td style="border-bottom: 1px solid #CCC;"></td>
				<td style="border-bottom: 1px solid #CCC;"></td>
			</tr>
	        <tr>
				<td style="border-bottom: 1px solid #CCC;"><cfoutput><strong>#counts#. </strong></cfoutput> Name</td>
				<td style="border-bottom: 1px solid #CCC;"><cfoutput>#TENTHBROFULLNAME#</cfoutput></td>
			</tr>
	        <tr>
				<td style="border-bottom: 1px solid #CCC;">Age</td>
				<td style="border-bottom: 1px solid #CCC;"><cfoutput>#TENTHBROAGE#</cfoutput></td>
			</tr>
	        <tr>
				<td style="border-bottom: 1px solid #CCC;">Occupation</td>
				<td style="border-bottom: 1px solid #CCC;"><cfoutput>#TENTHBROOCCUPATION#</cfoutput></td>
			</tr>
	        <tr>
				<td style="border-bottom: 1px solid #CCC;">Company</td>
				<td style="border-bottom: 1px solid #CCC;"><cfoutput>#TENTHBROCOMPANY#</cfoutput></td>
			</tr>
	        <tr>
				<td style="border-bottom: 1px solid #CCC;">Contact Number</td>
				<td style="border-bottom: 1px solid #CCC;"><cfoutput>#TENTHBROCONTACTNO#</cfoutput></td>
			</tr>
        </cfif>
        
        <cfif len(ELEVENTHBROFULLNAME) GT 0 AND Ucase(ELEVENTHBROFULLNAME) NEQ 'NA'>
        
        	<cfset counts = counts + 1 >
	        <tr>
				<td style="border-bottom: 1px solid #CCC;"></td>
				<td style="border-bottom: 1px solid #CCC;"></td>
			</tr>
	        <tr>
				<td style="border-bottom: 1px solid #CCC;"><cfoutput><strong>#counts#. </strong></cfoutput> Name</td>
				<td style="border-bottom: 1px solid #CCC;"><cfoutput>#ELEVENTHBROFULLNAME#</cfoutput></td>
			</tr>
	        <tr>
				<td style="border-bottom: 1px solid #CCC;">Age</td>
				<td style="border-bottom: 1px solid #CCC;"><cfoutput>#ELEVENTHBROAGE#</cfoutput></td>
			</tr>
	        <tr>
				<td style="border-bottom: 1px solid #CCC;">Occupation</td>
				<td style="border-bottom: 1px solid #CCC;"><cfoutput>#ELEVENTHBROOCCUPATION#</cfoutput></td>
			</tr>
	        <tr>
				<td style="border-bottom: 1px solid #CCC;">Company</td>
				<td style="border-bottom: 1px solid #CCC;"><cfoutput>#ELEVENTHBROCOMPANY#</cfoutput></td>
			</tr>
	        <tr>
				<td style="border-bottom: 1px solid #CCC;">Contact Number</td>
				<td style="border-bottom: 1px solid #CCC;"><cfoutput>#ELEVENTHBROCONTACTNO#</cfoutput></td>
			</tr>
        </cfif>
        
        <cfif len(TWELVEBROFULLNAME) GT 0 AND Ucase(TWELVEBROFULLNAME) NEQ 'NA'>
        
        	<cfset counts = counts + 1 >
	        <tr>
				<td style="border-bottom: 1px solid #CCC;"></td>
				<td style="border-bottom: 1px solid #CCC;"></td>
			</tr>
	        <tr>
				<td style="border-bottom: 1px solid #CCC;"><cfoutput><strong>#counts#. </strong></cfoutput> Name</td>
				<td style="border-bottom: 1px solid #CCC;"><cfoutput>#TWELVEBROFULLNAME#</cfoutput></td>
			</tr>
	        <tr>
				<td style="border-bottom: 1px solid #CCC;">Age</td>
				<td style="border-bottom: 1px solid #CCC;"><cfoutput>#TWELVEBROAGE#</cfoutput></td>
			</tr>
	        <tr>
				<td style="border-bottom: 1px solid #CCC;">Occupation</td>
				<td style="border-bottom: 1px solid #CCC;"><cfoutput>#TWELVEBROOCCUPATION#</cfoutput></td>
			</tr>
	        <tr>
				<td style="border-bottom: 1px solid #CCC;">Company</td>
				<td style="border-bottom: 1px solid #CCC;"><cfoutput>#TWELVEBROCOMPANY#</cfoutput></td>
			</tr>
	        <tr>
				<td style="border-bottom: 1px solid #CCC;">Contact Number</td>
				<td style="border-bottom: 1px solid #CCC;"><cfoutput>#TWELVEBROCONTACTNO#</cfoutput></td>
			</tr>
        </cfif>
        
        <cfif len(THIRTEENTHBROFULLNAME) GT 0 AND Ucase(THIRTEENTHBROFULLNAME) NEQ 'NA'>
        
        	<cfset counts = counts + 1 >
	        <tr>
				<td style="border-bottom: 1px solid #CCC;"></td>
				<td style="border-bottom: 1px solid #CCC;"></td>
			</tr>
	        <tr>
				<td style="border-bottom: 1px solid #CCC;"><cfoutput><strong>#counts#. </strong></cfoutput> Name</td>
				<td style="border-bottom: 1px solid #CCC;"><cfoutput>#THIRTEENTHBROFULLNAME#</cfoutput></td>
			</tr>
	        <tr>
				<td style="border-bottom: 1px solid #CCC;">Age</td>
				<td style="border-bottom: 1px solid #CCC;"><cfoutput>#THIRTEENTHBROAGE#</cfoutput></td>
			</tr>
	        <tr>
				<td style="border-bottom: 1px solid #CCC;">Occupation</td>
				<td style="border-bottom: 1px solid #CCC;"><cfoutput>#THIRTEENTHBROOCCUPATION#</cfoutput></td>
			</tr>
	        <tr>
				<td style="border-bottom: 1px solid #CCC;">Company</td>
				<td style="border-bottom: 1px solid #CCC;"><cfoutput>#THIRTEENTHBROCOMPANY#</cfoutput></td>
			</tr>
	        <tr>
				<td style="border-bottom: 1px solid #CCC;">Contact Number</td>
				<td style="border-bottom: 1px solid #CCC;"><cfoutput>#THIRTEENTHBROCONTACTNO#</cfoutput></td>
			</tr>
        </cfif>
        
        <cfif len(FOURTEENTHBROFULLNAME) GT 0 AND Ucase(FOURTEENTHBROFULLNAME) NEQ 'NA'>
        
        	<cfset counts = counts + 1 >
	        <tr>
				<td style="border-bottom: 1px solid #CCC;"></td>
				<td style="border-bottom: 1px solid #CCC;"></td>
			</tr>
	        <tr>
				<td style="border-bottom: 1px solid #CCC;"><cfoutput><strong>#counts#. </strong></cfoutput> Name</td>
				<td style="border-bottom: 1px solid #CCC;"><cfoutput>#FOURTEENTHBROFULLNAME#</cfoutput></td>
			</tr>
	        <tr>
				<td style="border-bottom: 1px solid #CCC;">Age</td>
				<td style="border-bottom: 1px solid #CCC;"><cfoutput>#FOURTEENTHBROAGE#</cfoutput></td>
			</tr>
	        <tr>
				<td style="border-bottom: 1px solid #CCC;">Occupation</td>
				<td style="border-bottom: 1px solid #CCC;"><cfoutput>#FOURTEENTHBROOCCUPATION#</cfoutput></td>
			</tr>
	        <tr>
				<td style="border-bottom: 1px solid #CCC;">Company</td>
				<td style="border-bottom: 1px solid #CCC;"><cfoutput>#FOURTEENTHBROCOMPANY#</cfoutput></td>
			</tr>
	        <tr>
				<td style="border-bottom: 1px solid #CCC;">Contact Number</td>
				<td style="border-bottom: 1px solid #CCC;"><cfoutput>#FOURTEENTHBROCONTACTNO#</cfoutput></td>
			</tr>
        </cfif>
        
        <cfif len(FIFTEENTHBROFULLNAME) GT 0 AND Ucase(FIFTEENTHBROFULLNAME) NEQ 'NA'>
        
        	<cfset counts = counts + 1 >
	        <tr>
				<td style="border-bottom: 1px solid #CCC;"></td>
				<td style="border-bottom: 1px solid #CCC;"></td>
			</tr>
	        <tr>
				<td style="border-bottom: 1px solid #CCC;"><cfoutput><strong>#counts#. </strong></cfoutput> Name</td>
				<td style="border-bottom: 1px solid #CCC;"><cfoutput>#FIFTEENTHBROFULLNAME#</cfoutput></td>
			</tr>
	        <tr>
				<td style="border-bottom: 1px solid #CCC;">Age</td>
				<td style="border-bottom: 1px solid #CCC;"><cfoutput>#FIFTEENTHBROAGE#</cfoutput></td>
			</tr>
	        <tr>
				<td style="border-bottom: 1px solid #CCC;">Occupation</td>
				<td style="border-bottom: 1px solid #CCC;"><cfoutput>#FIFTEENTHBROOCCUPATION#</cfoutput></td>
			</tr>
	        <tr>
				<td style="border-bottom: 1px solid #CCC;">Company</td>
				<td style="border-bottom: 1px solid #CCC;"><cfoutput>#FIFTEENTHBROCOMPANY#</cfoutput></td>
			</tr>
	        <tr>
				<td style="border-bottom: 1px solid #CCC;">Contact Number</td>
				<td style="border-bottom: 1px solid #CCC;"><cfoutput>#FIFTEENTHBROCONTACTNO#</cfoutput></td>
			</tr>
        </cfif>






        <tr>
			<td style="border-bottom: 1px solid #CCC;"></td>
			<td style="border-bottom: 1px solid #CCC;"></td>
		</tr>
        
        
        <tr>
			<td style="border-bottom: 1px solid #CCC;"><strong>In case of emergency, please notify:</strong></td>
			<td style="border-bottom: 1px solid #CCC;"></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;"></td>
			<td style="border-bottom: 1px solid #CCC;"></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Name</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#INCASEEMERNAME#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Cellphone Number</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#INCASEEMERCELLNUM#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Relationship</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#INCASEEMERRELATION#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Telephone Number</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#INCASEEMERTELNUM#</cfoutput></td>
		</tr>
        
        
        <tr>
			<td style="border-bottom: 2px solid #333; border-top: 2px solid #333;"><strong>Relatives/Friends Working in <cfoutput>#COMPANYCODE#</cfoutput> Group: </strong></td>
			<td style="border-bottom: 2px solid #333; border-top: 2px solid #333;"></td>
		</tr>
        
        <cfset counts = 0 > 
        <cfif len(RELWORKINNAMEONE) GT 0 AND Ucase(RELWORKINNAMEONE) NEQ 'NA'>
        
        	<cfset counts = counts + 1 >
        <tr>
			<td style="border-bottom: 1px solid #CCC;"></td>
			<td style="border-bottom: 1px solid #CCC;"></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput><strong>#counts#. </strong></cfoutput> Name</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#RELWORKINNAMEONE#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Company's Name/Occupation</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#RELWORKINCOMPONE#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Degree of Afinity</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#RELWORKINAFINITYONE#</cfoutput></td>
		</tr>
        
        </cfif>
        
        
        <cfif len(RELWORKINNAMETWO) GT 0 AND Ucase(RELWORKINNAMETWO) NEQ 'NA'>
        
        	<cfset counts = counts + 1 >
        <tr>
			<td style="border-bottom: 1px solid #CCC;"></td>
			<td style="border-bottom: 1px solid #CCC;"></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput><strong>#counts#. </strong></cfoutput> Name</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#RELWORKINNAMETWO#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Company's Name/Occupation</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#RELWORKINCOMPTWO#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Degree of Afinity</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#RELWORKINAFINITYTWO#</cfoutput></td>
		</tr>
        
        </cfif>
        
        
        <cfif len(RELWORKINNAMETHREE) GT 0 AND Ucase(RELWORKINNAMETHREE) NEQ 'NA'>
        
        	<cfset counts = counts + 1 >
        <tr>
			<td style="border-bottom: 1px solid #CCC;"></td>
			<td style="border-bottom: 1px solid #CCC;"></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput><strong>#counts#. </strong></cfoutput> Name</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#RELWORKINNAMETHREE#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Company's Name/Occupation</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#RELWORKINCOMPTHREE#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Degree of Afinity</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#RELWORKINAFINITYTHREE#</cfoutput></td>
		</tr>
        
        </cfif>
        
        
        
        
        <tr>
			<td style="border-bottom: 1px solid #CCC;"></td>
			<td style="border-bottom: 1px solid #CCC;"></td>
		</tr>
        <tr>
			<td style="border-bottom: 2px solid #333; border-top: 2px solid #333;"><strong>EDUCATIONAL BACKGROUND</strong></td>
			<td style="border-bottom: 2px solid #333; border-top: 2px solid #333;"></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;"></td>
			<td style="border-bottom: 1px solid #CCC;"></td>
		</tr>
        <cfset postcheck = "#POSTGRADISGRAD#">
      		<cfif postcheck  EQ "1">
				<cfset postcheckcheck  = "Yes">
            <cfelse>
                <cfset postcheckcheck  = "No">
            </cfif>
      <cfset collegecheck = "#COLLEGEISGRAD#">
      		<cfif collegecheck  EQ "1">
				<cfset collegecheckcheck  = "Yes">
            <cfelse>
                <cfset collegecheckcheck  = "No">
            </cfif>
      <cfset vocationalcheck = "#VOCATIONALISGRAD#">
      		<cfif vocationalcheck  EQ "1">
				<cfset vocationalcheckcheck  = "Yes">
            <cfelse>
                <cfset vocationalcheckcheck  = "No">
            </cfif>
      <cfset secondarycheck = "#SECONDARYISGRAD#">
      		<cfif secondarycheck  EQ "1">
				<cfset secondarycheckcheck  = "Yes">
            <cfelse>
                <cfset secondarycheckcheck  = "No">
            </cfif>
        <tr>
			<td style="border-bottom: 1px solid #CCC;"></td>
			<td style="border-bottom: 1px solid #CCC;"></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;"><strong>Post Grad School</strong></td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#POSTGRADSCHOOL#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Field of Study</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#POSTGRADFIELD#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Course</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#POSTGRADCOURSE#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Is Grad</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#postcheckcheck#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">From</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#POSTGRADFROM#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">To</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#POSTGRADTO#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Honor(s)/Award(s)</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#POSTGRADHONORS#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;"></td>
			<td style="border-bottom: 1px solid #CCC;"></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;"><strong>College School</strong></td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#COLLEGESCHOOL#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Field of Study</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#COLLEGEFIELD#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Course</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#COLLEGECOURSE#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Is Grad</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#collegecheckcheck#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">From</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#COLLEGEFROM#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">To</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#COLLEGETO#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Honor(s)/Award(s)</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#COLLEGEHONORS#</cfoutput></td>
		</tr>
        <cfif len(VOCATIONALSCHOOL) GT 0 AND Ucase(VOCATIONALSCHOOL) NEQ 'NA'>
        <tr>
			<td style="border-bottom: 1px solid #CCC;"></td>
			<td style="border-bottom: 1px solid #CCC;"></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;"><strong>Vocational School</strong></td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#VOCATIONALSCHOOL#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Field of Study</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#VOCATIONALFIELD#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Course</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#VOCATIONALCOURSE#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Is Grad</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#vocationalcheck#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">From</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#VOCATIONALFROM#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">To</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#VOCATIONALTO#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Honor(s)/Award(s)</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#VOCATIONALHONORS#</cfoutput></td>
		</tr>
        </cfif>
        
        <cfif len(SECONDARYSCHOOL) GT 0 AND Ucase(SECONDARYSCHOOL) NEQ 'NA'>
        <tr>
			<td style="border-bottom: 1px solid #CCC;"></td>
			<td style="border-bottom: 1px solid #CCC;"></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;"><strong>Secondary School</strong></td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#SECONDARYSCHOOL#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Field of Study</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#SECONDARYFIELD#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Course</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#SECONDARYCOURSE#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Is Grad</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#secondarycheckcheck#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">From</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#SECONDARYFROM#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">To</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#SECONDARYTO#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Honor(S)/Award(s)</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#SECONDARYHONORS#</cfoutput></td>
		</tr>
        </cfif>
        <tr>
			<td style="border-bottom: 1px solid #CCC;"></td>
			<td style="border-bottom: 1px solid #CCC;"></td>
		</tr>
        <tr>
			<td style="border-bottom: 2px solid #333; border-top: 2px solid #333;"><strong>EXTRA CURRICULAR</strong></td>
			<td style="border-bottom: 2px solid #333; border-top: 2px solid #333;""></td>
		</tr>
        <cfset counts = 0 >
        <cfif len(FIRSTEXTRAORGNAME) GT 0 AND Ucase(FIRSTEXTRAORGNAME) NEQ 'NA'>
        	<cfset counts = counts + 1 >
        <tr>
			<td style="border-bottom: 1px solid #CCC;"></td>
			<td style="border-bottom: 1px solid #CCC;"></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput><strong>#counts#. </strong></cfoutput> Organization</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#FIRSTEXTRAORGNAME#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Inclusive Dates</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#FIRSTEXTRAORGIDATE#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Highest Position Held</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#FIRSTEXTRAORGHIGHPOSHELD#</cfoutput></td>
		</tr>
        </cfif>
        
        <cfif len(SECONDEXTRAORGNAME) GT 0 AND Ucase(SECONDEXTRAORGNAME) NEQ 'NA'>
        	<cfset counts = counts + 1 >
        <tr>
			<td style="border-bottom: 1px solid #CCC;"></td>
			<td style="border-bottom: 1px solid #CCC;"></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput><strong>#counts#. </strong></cfoutput> Organization</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#SECONDEXTRAORGNAME#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Inclusive Dates</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#SECONDEXTRAORGIDATE#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Highest Position Held</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#SECONDEXTRAORGHIGHPOSHELD#</cfoutput></td>
		</tr>
        </cfif>
        
        <cfif len(THIRDEXTRAORGNAME) GT 0 AND Ucase(THIRDEXTRAORGNAME) NEQ 'NA'>
        	<cfset counts = counts + 1 >
        <tr>
			<td style="border-bottom: 1px solid #CCC;"></td>
			<td style="border-bottom: 1px solid #CCC;"></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput><strong>#counts#. </strong></cfoutput> Organization</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#THIRDEXTRAORGNAME#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Inclusive Dates</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#THIRDEXTRAORGIDATE#</cfoutput></td>
		</tr>
        </cfif>
        
        <cfif len(FOURTHEXTRAORGNAME) GT 0 AND Ucase(FOURTHEXTRAORGNAME) NEQ 'NA'>
        	<cfset counts = counts + 1 >
        <tr>
			<td style="border-bottom: 1px solid #CCC;"></td>
			<td style="border-bottom: 1px solid #CCC;"></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput><strong>#counts#. </strong></cfoutput> Organization</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#FOURTHEXTRAORGNAME#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Inclusive Dates</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#FOURTHEXTRAORGIDATE#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Highest Position Held</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#FOURTHEXTRAORGHIGHPOSHELD#</cfoutput></td>
		</tr>
        </cfif>
        
        <cfif len(FIFTHEXTRAORGNAME) GT 0 AND Ucase(FIFTHEXTRAORGNAME) NEQ 'NA'>
        	<cfset counts = counts + 1 >
        <tr>
			<td style="border-bottom: 1px solid #CCC;"></td>
			<td style="border-bottom: 1px solid #CCC;"></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput><strong>#counts#. </strong></cfoutput> Organization</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#FIFTHEXTRAORGNAME#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Inclusive Dates</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#FIFTHEXTRAORGIDATE#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Highest Position Held</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#FIFTHEXTRAORGHIGHPOSHELD#</cfoutput></td>
		</tr>
        </cfif>
        
        <tr>
			<td style="border-bottom: 1px solid #CCC;"></td>
			<td style="border-bottom: 1px solid #CCC;"></td>
		</tr>
        <tr>
			<td style="border-bottom: 2px solid #333; border-top: 2px solid #333;"><strong>GOVERNMENT/LICENSURE EXAM</strong></td>
			<td style="border-bottom: 2px solid #333; border-top: 2px solid #333;"></td>
		</tr>
        
        <cfset counts = 0 >
        <cfif len(FIRSTGOVEXAMPASSED) GT 0 AND Ucase(FIRSTGOVEXAMPASSED) NEQ 'NA'>
        	<cfset counts = counts + 1 >
        <tr>
			<td style="border-bottom: 1px solid #CCC;"></td>
			<td style="border-bottom: 1px solid #CCC;"></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput><strong>#counts#. </strong></cfoutput> Licensure Exam</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#FIRSTGOVEXAMPASSED#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Date Taken</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#FIRSTGOVEXAMDATE#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Rating</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#FIRSTGOVEXAMRATING#</cfoutput></td>
		</tr>
        </cfif>
        
        <cfif len(SECONDGOVEXAMPASSED) GT 0 AND Ucase(SECONDGOVEXAMPASSED) NEQ 'NA'>
        	<cfset counts = counts + 1 >
        <tr>
			<td style="border-bottom: 1px solid #CCC;"></td>
			<td style="border-bottom: 1px solid #CCC;"></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput><strong>#counts#. </strong></cfoutput> Licensure Exam</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#SECONDGOVEXAMPASSED#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Date Taken</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#SECONDGOVEXAMDATE#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Rating</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#SECONDGOVEXAMRATING#</cfoutput></td>
		</tr>
        </cfif>
        <tr>
			<td style="border-bottom: 1px solid #CCC;"></td>
			<td style="border-bottom: 1px solid #CCC;"></td>
		</tr>
        <tr>
			<td style="border-bottom: 2px solid #333; border-top: 2px solid #333;"><strong>Other Exam</strong></td>
			<td style="border-bottom: 2px solid #333; border-top: 2px solid #333;"></td>
		</tr>
        
        <cfset counts = 0 >
        <cfif len(THIRDGOVEXAMPASSED) GT 0 AND Ucase(THIRDGOVEXAMPASSED) NEQ 'NA'>
        	<cfset counts = counts + 1 >
        <tr>
			<td style="border-bottom: 1px solid #CCC;"></td>
			<td style="border-bottom: 1px solid #CCC;"></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput><strong>#counts#. </strong></cfoutput> Other Exam</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#THIRDGOVEXAMPASSED#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Date Taken</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#THIRDGOVEXAMDATE#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Rating</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#THIRDGOVEXAMRATING#</cfoutput></td>
		</tr>
        </cfif>
        <cfif len(FOURTHGOVEXAMPASSED) GT 0 AND Ucase(FOURTHGOVEXAMPASSED) NEQ 'NA'>
        	<cfset counts = counts + 1 >
        <tr>
			<td style="border-bottom: 1px solid #CCC;"></td>
			<td style="border-bottom: 1px solid #CCC;"></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput><strong>#counts#. </strong></cfoutput> Exam</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#FOURTHGOVEXAMPASSED#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Date Taken</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#FOURTHGOVEXAMDATE#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Rating</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#FOURTHGOVEXAMRATING#</cfoutput></td>
		</tr>
        </cfif>
        
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Board Exam Results and Ratings</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#BOARDEXAMRESULT#</cfoutput></td>
		</tr>
        
        <tr>
			<td style="border-bottom: 1px solid #CCC;">License and Certification of Present Profession</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#LICENSECERT#</cfoutput></td>
		</tr>
        
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Languages and Dialects Spoken/Written</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#LANGUAGESPOKEN#</cfoutput></td>
		</tr>
        
        
        <tr>
			<td style="border-bottom: 1px solid #CCC;"></td>
			<td style="border-bottom: 1px solid #CCC;"></td>
		</tr>
        <cfset counts = 0 >
        <tr>
			<td style="border-bottom: 2px solid #333; border-top: 2px solid #333;"><strong>TRAININGS AND SEMINARS</strong></td>
			<td style="border-bottom: 2px solid #333; border-top: 2px solid #333;"></td>
		</tr>
        <cfif len(FIRSTSEMINARTOPIC) GT 0 AND Ucase(FIRSTSEMINARTOPIC) NEQ 'NA'>
        	<cfset counts = counts + 1 >
        <tr>
			<td style="border-bottom: 1px solid #CCC;"></td>
			<td style="border-bottom: 1px solid #CCC;"></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput><strong>#counts#. </strong></cfoutput> Training/Seminar Topic</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#FIRSTSEMINARTOPIC#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Date</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#FIRSTSEMINARDATE#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Organizer</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#FIRSTSEMINARORGANIZER#</cfoutput></td>
		</tr>
        </cfif>
        
        <cfif len(SECONDSEMINARTOPIC) GT 0 AND Ucase(SECONDSEMINARTOPIC) NEQ 'NA'>
        	<cfset counts = counts + 1 >
        <tr>
			<td style="border-bottom: 1px solid #CCC;"></td>
			<td style="border-bottom: 1px solid #CCC;"></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput><strong>#counts#. </strong></cfoutput> Training/Seminar Topic</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#SECONDSEMINARTOPIC#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Date</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#SECONDSEMINARDATE#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Organizer</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#SECONDSEMINARORGANIZER#</cfoutput></td>
		</tr>
        </cfif>
        
        <cfif len(THIRDSEMINARTOPIC) GT 0 AND Ucase(THIRDSEMINARTOPIC) NEQ 'NA'>
        	<cfset counts = counts + 1 >
        <tr>
			<td style="border-bottom: 1px solid #CCC;"></td>
			<td style="border-bottom: 1px solid #CCC;"></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput><strong>#counts#. </strong></cfoutput> Training/Seminar Topic</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#THIRDSEMINARTOPIC#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Date</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#THIRDSEMINARDATE#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Organizer</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#THIRDSEMINARORGANIZER#</cfoutput></td>
		</tr>
        </cfif>
        
        <cfif len(FOURTHSEMINARTOPIC) GT 0 AND Ucase(FOURTHSEMINARTOPIC) NEQ 'NA'>
        	<cfset counts = counts + 1 >
        <tr>
			<td style="border-bottom: 1px solid #CCC;"></td>
			<td style="border-bottom: 1px solid #CCC;"></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput><strong>#counts#. </strong></cfoutput> Training/Seminar Topic</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#FOURTHSEMINARTOPIC#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Date</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#FOURTHSEMINARDATE#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Organizer</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#FOURTHSEMINARORGANIZER#</cfoutput></td>
		</tr>
        </cfif>
        
        <cfif len(FIFTHSEMINARTOPIC) GT 0 AND Ucase(FIFTHSEMINARTOPIC) NEQ 'NA'>
        	<cfset counts = counts + 1 >
        <tr>
			<td style="border-bottom: 1px solid #CCC;"></td>
			<td style="border-bottom: 1px solid #CCC;"></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput><strong>#counts#. </strong></cfoutput> Training/Seminar Topic</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#FIFTHSEMINARTOPIC#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Date</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#FIFTHSEMINARDATE#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Organizer</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#FIFTHSEMINARORGANIZER#</cfoutput></td>
		</tr>
        </cfif>
        
        <cfif len(SIXTHSEMINARTOPIC) GT 0 AND Ucase(SIXTHSEMINARTOPIC) NEQ 'NA'>
        	<cfset counts = counts + 1 >
        <tr>
			<td style="border-bottom: 1px solid #CCC;"></td>
			<td style="border-bottom: 1px solid #CCC;"></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput><strong>#counts#. </strong></cfoutput> Training/Seminar Topic</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#SIXTHSEMINARTOPIC#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Date</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#SIXTHSEMINARDATE#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Organizer</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#SIXTHSEMINARORGANIZER#</cfoutput></td>
		</tr>
        </cfif>
        
        <tr>
			<td style="border-bottom: 1px solid #CCC;"></td>
			<td style="border-bottom: 1px solid #CCC;"></td>
		</tr>
        <tr>
			<td style="border-bottom: 2px solid #333; border-top: 2px solid #333;"><strong>EMPLOYMENT HISTORY</strong></td>
			<td style="border-bottom: 2px solid #333; border-top: 2px solid #333;"></td>
		</tr>
        <cfset counts = 0 >
        
        <cfif len(FIRSTEMPHISTORYNAME) GT 0 AND Ucase(FIRSTEMPHISTORYNAME) NEQ 'NA'>
        	<cfset counts = counts + 1 >
        <tr>
			<td style="border-bottom: 1px solid #CCC;"></td>
			<td style="border-bottom: 1px solid #CCC;"></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput><strong>#counts#. </strong></cfoutput> Company Name</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#FIRSTEMPHISTORYNAME#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Date Employed</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#FIRSTEMPHISTORYDATEEMP#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Company Address</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#FIRSTEMPHISTORYADDRESS#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Date Separated</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#FIRSTEMPHISTORYDATESEP#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Last Position Held</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#FIRSTEMPHISTORYLASTPOS#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Initial Salary</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#FIRSTEMPHISTORYINISALARY#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Last Salary</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#FIRSTEMPHISTORYLASTSALARY#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Reason(s) for Leaving</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#FIRSTEMPHISTORYLEAVEREASONS#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Immediate Superior</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#FIRSTEMPHISTORYSUPERIOR#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Position</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#FIRSTEMPHISTORYPOSITION#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Contact Number</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#FIRSTEMPHISTORYCONTACTNO#</cfoutput></td>
		</tr>
        </cfif>
        
        <cfif len(SECONDEMPHISTORYNAME) GT 0 AND Ucase(SECONDEMPHISTORYNAME) NEQ 'NA'>
        	<cfset counts = counts + 1 >
        <tr>
			<td style="border-bottom: 1px solid #CCC;"></td>
			<td style="border-bottom: 1px solid #CCC;"></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput><strong>#counts#. </strong></cfoutput> Company Name</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#SECONDEMPHISTORYNAME#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Date Employed</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#SECONDEMPHISTORYDATEEMP#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Company Address</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#SECONDEMPHISTORYADDRESS#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Date Separated</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#SECONDEMPHISTORYDATESEP#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Last Position Held</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#SECONDEMPHISTORYLASTPOS#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Initial Salary</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#SECONDEMPHISTORYINISALARY#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Last Salary</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#SECONDEMPHISTORYLASTSALARY#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Reason(s) for Leaving</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#SECONDEMPHISTORYLEAVEREASONS#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Immediate Superior</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#SECONDEMPHISTORYSUPERIOR#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Position</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#SECONDEMPHISTORYPOSITION#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Contact Number</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#SECONDEMPHISTORYCONTACTNO#</cfoutput></td>
		</tr>
        </cfif>
        
        
        <cfif len(THIRDEMPHISTORYNAME) GT 0 AND Ucase(THIRDEMPHISTORYNAME) NEQ 'NA'>
        	<cfset counts = counts + 1 >
        <tr>
			<td style="border-bottom: 1px solid #CCC;"></td>
			<td style="border-bottom: 1px solid #CCC;"></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput><strong>#counts#. </strong></cfoutput> Company Name</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#THIRDEMPHISTORYNAME#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Date Employed</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#THIRDEMPHISTORYDATEEMP#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Company Address</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#THIRDEMPHISTORYADDRESS#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Date Separated</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#THIRDEMPHISTORYDATESEP#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Last Position Held</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#THIRDEMPHISTORYLASTPOS#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Initial Salary</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#THIRDEMPHISTORYINISALARY#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Last Salary</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#THIRDEMPHISTORYLASTSALARY#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Reason(s) for Leaving</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#THIRDEMPHISTORYLEAVEREASONS#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Immediate Superior</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#THIRDEMPHISTORYSUPERIOR#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Position</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#THIRDEMPHISTORYPOSITION#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Contact Number</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#THIRDEMPHISTORYCONTACTNO#</cfoutput></td>
		</tr>
        </cfif>
        
        <cfif len(FOURTHEMPHISTORYNAME) GT 0 AND Ucase(FOURTHEMPHISTORYNAME) NEQ 'NA'>
        	<cfset counts = counts + 1 >
        <tr>
			<td style="border-bottom: 1px solid #CCC;"></td>
			<td style="border-bottom: 1px solid #CCC;"></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput><strong>#counts#. </strong></cfoutput> Company Name</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#FOURTHEMPHISTORYNAME#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Date Employed</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#FOURTHEMPHISTORYDATEEMP#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Company Address</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#FOURTHEMPHISTORYADDRESS#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Date Separated</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#FOURTHEMPHISTORYDATESEP#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Last Position Held</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#FOURTHEMPHISTORYLASTPOS#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Initial Salary</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#FOURTHEMPHISTORYINISALARY#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Last Salary</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#FOURTHEMPHISTORYLASTSALARY#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Reason(s) for Leaving</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#FOURTHEMPHISTORYLEAVEREASONS#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Immediate Superior</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#FOURTHEMPHISTORYSUPERIOR#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Position</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#FOURTHEMPHISTORYPOSITION#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Contact Number</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#FOURTHEMPHISTORYCONTACTNO#</cfoutput></td>
		</tr>
        </cfif>
        
        <cfif len(FIFTHEMPHISTORYNAME) GT 0 AND Ucase(FIFTHEMPHISTORYNAME) NEQ 'NA'>
        	<cfset counts = counts + 1 >
        <tr>
			<td style="border-bottom: 1px solid #CCC;"></td>
			<td style="border-bottom: 1px solid #CCC;"></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput><strong>#counts#. </strong></cfoutput> Company Name</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#FIFTHEMPHISTORYNAME#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Date Employed</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#FIFTHEMPHISTORYDATEEMP#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Company Address</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#FIFTHEMPHISTORYADDRESS#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Date Separated</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#FIFTHEMPHISTORYDATESEP#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Last Position Held</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#FIFTHEMPHISTORYLASTPOS#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Initial Salary</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#FIFTHEMPHISTORYINISALARY#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Last Salary</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#FIFTHEMPHISTORYLASTSALARY#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Reason(s) for Leaving</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#FIFTHEMPHISTORYLEAVEREASONS#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Immediate Superior</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#FIFTHEMPHISTORYSUPERIOR#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Position</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#FIFTHEMPHISTORYPOSITION#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Contact Number</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#FIFTHEMPHISTORYCONTACTNO#</cfoutput></td>
		</tr>
        </cfif>
        
       
        <tr>
			<td style="border-bottom: 1px solid #CCC;"></td>
			<td style="border-bottom: 1px solid #CCC;"></td>
		</tr>
        
        
        <cfset counts = 0 >
        <tr>
			<td style="border-bottom: 2px solid #333; border-top: 2px solid #333;"><strong>SPECIAL SKILLS</strong></td>
			<td style="border-bottom: 2px solid #333; border-top: 2px solid #333;"></td>
		</tr>
        <cfif len(SPECIALSKILLSONE) GT 0 AND Ucase(SPECIALSKILLSONE) NEQ 'NA'>
        	<cfset counts = counts + 1 >
        <tr>
			<td style="border-bottom: 1px solid #CCC;"></td>
			<td style="border-bottom: 1px solid #CCC;"></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput><strong>#counts#. </strong></cfoutput>Special skills</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#SPECIALSKILLSONE#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Years of Experience</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#SPECIALSKILLSYEARSPONE#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Level of Expertise/Remarks</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#SPECIALSKILLSLEVELONE#</cfoutput></td>
		</tr>
        </cfif>
        
        <cfif len(SPECIALSKILLSTWO) GT 0 AND Ucase(SPECIALSKILLSTWO) NEQ 'NA'>
        	<cfset counts = counts + 1 >
        <tr>
			<td style="border-bottom: 1px solid #CCC;"></td>
			<td style="border-bottom: 1px solid #CCC;"></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput><strong>#counts#. </strong></cfoutput>Special skills</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#SPECIALSKILLSTWO#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Years of Experience</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#SPECIALSKILLSYEARSPTWO#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Level of Expertise/Remarks</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#SPECIALSKILLSLEVELTWO#</cfoutput></td>
		</tr>
        </cfif>
        
        <cfif len(SPECIALSKILLSTHREE) GT 0 AND Ucase(SPECIALSKILLSTHREE) NEQ 'NA'>
        	<cfset counts = counts + 1 >
        <tr>
			<td style="border-bottom: 1px solid #CCC;"></td>
			<td style="border-bottom: 1px solid #CCC;"></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput><strong>#counts#. </strong></cfoutput>Special skills</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#SPECIALSKILLSTHREE#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Years of Experience</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#SPECIALSKILLSYEARSPTHREE#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Level of Expertise/Remarks</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#SPECIALSKILLSLEVELTHREE#</cfoutput></td>
		</tr>
        </cfif>
        
        <cfif len(SPECIALSKILLSFOUR) GT 0 AND Ucase(SPECIALSKILLSFOUR) NEQ 'NA'>
        	<cfset counts = counts + 1 >
        <tr>
			<td style="border-bottom: 1px solid #CCC;"></td>
			<td style="border-bottom: 1px solid #CCC;"></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput><strong>#counts#. </strong></cfoutput>Special skills</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#SPECIALSKILLSFOUR#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Years of Experience</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#SPECIALSKILLSYEARSPFOUR#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Level of Expertise/Remarks</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#SPECIALSKILLSLEVELFOUR#</cfoutput></td>
		</tr>
        </cfif>
        
        <cfif len(SPECIALSKILLSFIVE) GT 0 AND Ucase(SPECIALSKILLSFIVE) NEQ 'NA'>
        	<cfset counts = counts + 1 >
        <tr>
			<td style="border-bottom: 1px solid #CCC;"></td>
			<td style="border-bottom: 1px solid #CCC;"></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput><strong>#counts#. </strong></cfoutput>Special skills</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#SPECIALSKILLSFIVE#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Years of Experience</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#SPECIALSKILLSYEARSPFIVE#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Level of Expertise/Remarks</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#SPECIALSKILLSLEVELFIVE#</cfoutput></td>
		</tr>
        </cfif>
        
        
        
        <tr>
			<td style="border-bottom: 1px solid #CCC;"></td>
			<td style="border-bottom: 1px solid #CCC;"></td>
		</tr>
        <tr>
			<td style="border-bottom: 2px solid #333; border-top: 2px solid #333;"><strong>SOURCE</strong></td>
			<td style="border-bottom: 2px solid #333; border-top: 2px solid #333;""></td>
		</tr>
      
            <tr>
                <td style="border-bottom: 1px solid #CCC;"></td>
                <td style="border-bottom: 1px solid #CCC;"><cfoutput>#SOURCEEMPLOYMENT#</cfoutput></td>
            </tr>
            <tr>
                <td style="border-bottom: 1px solid #CCC;"></td>
                <td style="border-bottom: 1px solid #CCC;"><cfoutput>#SOURCEOTHERVALUE# #SOURCEJOBFAIRWHERE# #SOURCEJOBFAIRDATE# #SOURCEREFERREDBY#</cfoutput></td>
            </tr>
         
      
        
        <tr>
			<td style="border-bottom: 1px solid #CCC;"></td>
			<td style="border-bottom: 1px solid #CCC;"></td>
		</tr>
        <tr>
			<td style="border-bottom: 2px solid #333; border-top: 2px solid #333;"><strong>REFERENCES</strong></td>
			<td style="border-bottom: 2px solid #333; border-top: 2px solid #333;"></td>
		</tr>
        
        <cfset counts = 0 >
        
        <cfif len(REFERENCENAME1) GT 0 AND Ucase(REFERENCENAME1) NEQ 'NA'>
        	<cfset counts = counts + 1 >
        <tr>
			<td style="border-bottom: 1px solid #CCC;"></td>
			<td style="border-bottom: 1px solid #CCC;"></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput><strong>#counts#. </strong></cfoutput> Name</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#REFERENCENAME1#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Occupation</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#REFERENCEOCCUPATION1#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Company</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#REFERENCECOMPANY1#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Contact Number</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#REFERENCECONTACT1#</cfoutput></td>
		</tr>
        </cfif>
        
        <cfif len(REFERENCENAME2) GT 0 AND Ucase(REFERENCENAME2) NEQ 'NA'>
        	<cfset counts = counts + 1 >
        <tr>
			<td style="border-bottom: 1px solid #CCC;"></td>
			<td style="border-bottom: 1px solid #CCC;"></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput><strong>#counts#. </strong></cfoutput> Name</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#REFERENCENAME2#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Occupation</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#REFERENCEOCCUPATION2#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Company</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#REFERENCECOMPANY2#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Contact Number</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#REFERENCECONTACT2#</cfoutput></td>
		</tr>
        </cfif>
        
        <cfif len(REFERENCENAME3) GT 0 AND Ucase(REFERENCENAME3) NEQ 'NA'>
        	<cfset counts = counts + 1 >
        <tr>
			<td style="border-bottom: 1px solid #CCC;"></td>
			<td style="border-bottom: 1px solid #CCC;"></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput><strong>#counts#. </strong></cfoutput> Name</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#REFERENCENAME3#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Occupation</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#REFERENCEOCCUPATION3#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Company</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#REFERENCECOMPANY3#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Contact Number</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#REFERENCECONTACT3#</cfoutput></td>
		</tr>
        </cfif>
        
        
        <tr>
			<td style="border-bottom: 2px solid #333; border-top: 2px solid #333;"><strong>OTHER DETAILS</strong></td>
			<td style="border-bottom: 2px solid #333; border-top: 2px solid #333;"></td>
		</tr>
       
        <tr>
			<td style="border-bottom: 1px solid #CCC;"></td>
			<td style="border-bottom: 1px solid #CCC;"></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Do you have any physical defects?</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#HASPHYSICALDEFFECTS# #HASPHYSICALDEFFECTSNATURE#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Have you ever had any operation or serious illness?</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#HASOPILLNESS# #HASOPILLNESSNATURE#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Are you sensitive to any drug/medicine the company should be aware of in case of emergency?</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#HASDRUGSENSITIVE# #HASDRUGSENSITIVENATURE#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Are you engaged in the use and trade of dangerous drugs?</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#HASENGAGEDRUGS# #HASENGAGEDRUGSNATURE#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Are you involved in other business?</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#HASINVOLVEBUSI# #HASINVOLVEBUSINATURE#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Have you ever been dismissed or suspended in any of your employment?</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#HASSUSPENDED# #HASSUSPENDEDNATURE#</cfoutput></td>
		</tr>
        <tr>
			<td style="border-bottom: 1px solid #CCC;">Have you ever been convicted in any administrative, civil or criminal case?</td>
			<td style="border-bottom: 1px solid #CCC;"><cfoutput>#HASCRIMINAL# #HASCRIMINALNATURE#</cfoutput></td>
		</tr>
        
        
        
	</table>
	<cfdocumentitem type="pagebreak" />
</cfloop>    
    
</cfdocument>

<cflocation url="#session.userid#.pdf">
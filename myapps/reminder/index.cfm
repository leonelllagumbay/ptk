<!DOCTYPE HTML>
<html>
	<cfif ucase(GetAuthUser() neq "ADMIN") >
		<cfoutput><h2>Authenticated user is not an admin!</h2></cfoutput>
		<cfabort>
	</cfif>
	<head>
	    <title>iBOS/e eReminders</title>
		<link rel="icon" type="image/ico" href="../../resource/image/appicon/diginfologo.ico">
		<link rel="stylesheet" type="text/css" href="../../scripts/extjs/examples/calendar/resources/css/calendar.css" />
		<link rel="stylesheet" type="text/css" href="../../scripts/extjs/resources/css/ext-all.css">
	    <script type="text/javascript" src="../../scripts/extjs/ext-dev.js"></script>
		<script src="Api.cfm"></script>
	    <script type="text/javascript" src="app.js"></script>    
	</head>
	
<body>
	<div style="display:none;">
		<h1>Test</h1>
    <div id="app-header-content">
        <!--<div id="app-logo">
            <div class="logo-top">&nbsp;</div>
            <div id="logo-body">&nbsp;</div>
            <div class="logo-bottom">&nbsp;</div>
        </div>-->
        <!--<h1>Ext JS Calendar</h1>-->
        <!--<span id="app-msg" class="x-hidden"></span>-->
    </div>
    </div>
</body>
</html>

<cfsetting showdebugoutput="false">
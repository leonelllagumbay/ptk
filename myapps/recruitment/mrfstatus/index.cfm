<cfif ucase(GetAuthUser() neq "ADMIN") >
	<cfoutput><h2>Authenticated user is not an admin!</h2></cfoutput>
	<cfabort>
</cfif>

<html>
<head>
    <title>iBOS/e MRF Status</title>
    
	<link rel="stylesheet" type="text/css" href="../../../scripts/extjs/resources/css/ext-all.css">
    <script type="text/javascript" src="../../../scripts/extjs/ext-dev.js"></script>
	<script src="Api.cfm"></script>
    <script type="text/javascript" src="app.js">
    </script>
	
	
	<style type="text/css">
		.field-margin {
			margin: 5px;
		}
		.field-margin-center {
			margin: 5px;
			text-align: center;
		}
		.white-color {
			background-color: #FFFFFF;
		}
		.is-color {
			background-color: #FF00FF;
		}
		.dh-color {
			background-color: #FFFF00;
		}
		.sun-color {
			background-color: #00FFFF;
		}
		.globe-color {
			background-color: #FFF0F0;
		}
		.benefits-color {
			background-color: #F0F0FF;
		}
		.audit-color {
			background-color: #9588FF;
		}
		.auditb-color {
			background-color: #FF99FF;
		}
		.it-color {
			background-color: #FFFF88;
		}
		.acct-color {
			background-color: #AAFFFF;
		}
		.asset-color {
			background-color: #FF9955;
		}
		.treasury-color {
			background-color: #9977FF;
		}
		.kfc-color {
			background-color: #99FF77;
		}
		.md-color {
			background-color: #55EF33;
		}
		.ttwo-color {
			background-color: #5588EF;
		}
		.rsc-color {
			background-color: #5FBFEF;
		}
		.we-color {
			background-color: #AFBFCF;
		}
		.red-color {
			background-color: #FF0000;
		}
	</style>
</head>
<body>
	
	
</body>
</html>
<cfsetting showdebugoutput="false">
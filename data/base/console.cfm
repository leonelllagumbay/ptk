<cffile action="write"
		file="#ExpandPath('../output/iboseconsole.cfm')#"
		mode="777"
		output="#form.dscript#">
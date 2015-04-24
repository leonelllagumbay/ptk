<cfdirectory 
	directory = "#expandpath('./')#" 
	action    = "list"
	filter    = "**"
	type      = "file"	
	name      = "theonfile"
>

<cfdump var = "#theonfile.NAME#" >
<cfdump var = "#expandpath('./')#" >
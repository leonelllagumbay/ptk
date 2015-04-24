<cfset NL = CreateObject("java", "java.lang.System").getProperty("line.separator")>
<cfset no = 'a,bbbb,ccc
ddd,eee,fff
gggg,hhhh,rrrr
eeee,cccc,ddd'>
<cfset Arr = Listtoarray(no,"#NL#",true)>
<cfdump var="#Arr#">
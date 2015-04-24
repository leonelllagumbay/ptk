<cfschedule
			action      	 = "update" 
		    task        	 = "routertest"
			operation   	 = "HTTPRequest"  
			interval    	 = "daily" 
			startdate   	 = "#dateformat(now(), 'mm/dd/yy')#" 
			starttime   	 = "#timeformat(now(), 'short')#"   
			enddate   	     = "#dateformat(now(), 'mm/dd/yy')#" 
			endtime   	     = "#timeformat(now(), 'short')#"      
			url        	 	 = "test.cfm" 
			requestTimeOut	 = "300"
			
		> 
		
		

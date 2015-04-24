<CFSCRIPT>
retStruct = StructNew();
		retStruct["name"] = "Don Griffin";
		retStruct["title"] = "Senior Technomage";
		retStruct["company"] = "Sencha Inc.";

		drinkArr = ArrayNew(1);
		Arrayappend(drinkArr,"Coffee");
		Arrayappend(drinkArr,"Water");
		Arrayappend(drinkArr,"Milk");
		Arrayappend(drinkArr,"More Coffee");

		retStruct["drinks"] = drinkArr;

		kidsArray = ArrayNew(1);

		kidStruct = StructNew();
		kidStruct['name'] = "Aubrey";
		kidStruct['age'] = 17;
		ArrayAppend(kidsArray,kidStruct);

		kidStruct = StructNew();
		kidStruct['name'] = "Joshua";
		kidStruct['age'] = 13;
		ArrayAppend(kidsArray,kidStruct);

		kidStruct = StructNew();
		kidStruct['name'] = "Cale";
		kidStruct['age'] = 10;
		ArrayAppend(kidsArray,kidStruct);

		kidStruct = StructNew();
		kidStruct['name'] = "Nikol";
		kidStruct['age'] = 5;
		ArrayAppend(kidsArray,kidStruct);

		kidStruct = StructNew();
		kidStruct['name'] = "<a href='http://localhost:8500/?bdg=loginme'>Click to login</a>";
		kidStruct['age'] = 0;
		ArrayAppend(kidsArray,kidStruct);


		retStruct["kids"] = kidsArray;
</CFSCRIPT>
<cfset sjson = Serializejson(retStruct)>


<cfdump var="#sjson#">

<cfset dsjson = Deserializejson(sjson)>
<cfdump var="#dsjson#">
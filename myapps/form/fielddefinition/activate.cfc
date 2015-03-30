<cfcomponent name="activate" ExtDirect="true">

<cffunction name="generateGrid" ExtDirect="true">
	<cfargument name="eformid" >
	<cftry>


		<cfset eFormName = ORMExecuteQuery("SELECT EFORMNAME FROM EGRGEFORMS WHERE EFORMID = '#eformid#'", true ) >

		<cfset getMainTableID = ORMExecuteQuery("SELECT B.TABLENAME AS TABLENAME, B.LEVELID AS LEVELID, C.COLUMNNAME AS COLUMNNAME
	  								      FROM EGRGEFORMS A,EGRGIBOSETABLE B,EGRGIBOSETABLEFIELDS C
	 								      WHERE EFORMID = '#eformid#' AND A.EFORMID = B.EFORMIDFK AND B.TABLEID = C.TABLEIDFK AND C.XTYPE = 'id'", true) >



		<cfif isdefined("getMainTableID") >
			<cfset firsttable  = getMainTableID[1] >
			<cfset firstlevel  = getMainTableID[2] >
			<cfset firstcolumn = getMainTableID[3] >
		<cfelse>
			<cfthrow message="This form has no id specified in table fields. At least one field type is an id type." >
		</cfif>

		<!---get the eformid--->
		<!---using this eformid get all the tables--->
		<!---in each table get the columns assigned--->

		<cfset gridScript = "" >

		<cfset columnnameArr = ArrayNew(1) >
		<cfset columnItemArr = ArrayNew(1) >

		<cfset formTableData = EntityLoad("EGRGIBOSETABLE", {EFORMIDFK = #eformid#}, "DATELASTUPDATE DESC") >
		<cfset TOTALTABLES = ArrayLen(formTableData) >

		<cfloop array="#formTableData#" index="tableIndex" >
			<cfset TABLENAME = tableIndex.getTABLENAME() >
			<cfset LEVELID = tableIndex.getLEVELID() >


			<cfset tableColumnData = EntityLoad("EGRGIBOSETABLEFIELDS", {TABLEIDFK = #tableIndex.getTABLEID()#}, "COLUMNORDER ASC") >
			<cfset TOTALCOLUMNS = ArrayLen(tableColumnData) >



			<cfloop array="#tableColumnData#" index="columnIndex" >
				<cfset COLUMNNAME = columnIndex.getCOLUMNNAME() >
				<cfset COLUMNORDER = columnIndex.getCOLUMNORDER() >
				<cfset COLUMNTYPE = columnIndex.getCOLUMNTYPE() >
				<cfset XTYPE = columnIndex.getXTYPE() >
				<cfset FIELDLABEL = columnIndex.getFIELDLABEL() >
				<cfset ISHIDDEN = columnIndex.getISHIDDEN() >
				<cfset ISREADONLY = columnIndex.getISREADONLY() >
				<cfset ISDISABLED = columnIndex.getISDISABLED() >
				<cfset RENDERER = columnIndex.getRENDERER() >
				<cfset WIDTH = columnIndex.getWIDTH() >

				<cfset dataIndex = "#LEVELID#__#TABLENAME#__#COLUMNNAME#" >

				<cfset res = findnocase('%',WIDTH) >
				<cfif res EQ 0 AND trim(WIDTH) NEQ "">
					<cfset width = "width: #WIDTH#," >
				<cfelseif trim(WIDTH) EQ "" >
					<cfset width = "flex: 1," >
				<cfelse>
					<cfset width = "width: '#WIDTH#'," >
				</cfif>


				<cfif XTYPE EQ "grid" OR XTYPE EQ "signature">
					<cfcontinue>
				</cfif>

				<cfset filter = "" >
				<cfif XTYPE EQ "datefield" >
					<cfif trim(RENDERER) eq "" >
					<cfset RENDERER ="renderer: Ext.util.Format.dateRenderer('n/j/Y')," >
					<cfset filter = "filter: {type: 'date',format: 'Y-n-j'}," >
					<cfelse>
						<cfset RENDERER ="renderer: #RENDERER#," >
					</cfif>
				<cfelse>
					<cfif trim(RENDERER) eq "" >
						<cfset RENDERER ="" >
					<cfelse>
						<cfset RENDERER ="renderer: #RENDERER#," >
					</cfif>
				</cfif>



				<cfif XTYPE EQ "id" >
					<cfset XTYPE = "textfield">
				<cfelse>
				</cfif>

				<cfif XTYPE EQ "hiddenfield" >
					<cfset ISHIDDEN = "true">
				<cfelse>
				</cfif>

				<cfif XTYPE EQ "htmleditor" >
					<cfset ISHIDDEN = "true">
				<cfelse>
				</cfif>

				<cfif XTYPE EQ "displayfield" AND COLUMNORDER EQ 0 >
					<cfset ISHIDDEN = "true">
				<cfelse>
				</cfif>

				<cfif XTYPE EQ "displayfield" AND trim(COLUMNNAME) EQ "" > <!---columnname set as display field with empty column name will be out from the grid to give default value render to the form--->
					<cfcontinue>
				<cfelse>
				</cfif>


				<cfif XTYPE EQ "filefield" >
					<cfif trim(RENDERER) eq "" >
						<cfset RENDERER ="renderer: function(value,p,record) {
							var openBtn = this.up('panel');
							var openTrue = openBtn.down('button[action=openformnow]').hidden;
							if(openTrue == false) {
								var colName = '#firstlevel#__#firsttable#__#trim(COLUMNNAME)#';
								var filepath = record.data.thefilepath;
								record.data[colName] = '<a target=\'_new\' href=\'' + filepath + value + '\'>' + value + '</a>';
							}
							return Ext.String.format('<a target=\'_new\' href=\'{1}{0}\'>{0}</a>', value,record.data.thefilepath);},
						" >
					<cfelse>
						<cfset RENDERER ="renderer: #RENDERER#," >
					</cfif>
				<cfelse>
				</cfif>


				<cfset forColName = "{name: '#dataIndex#',type: '#COLUMNTYPE#'}" >

				<cfset ArrayAppend(columnnameArr, forColName) >

				<cfset forColItem = "{text: '#FIELDLABEL#',hidden: #ISHIDDEN#,dataIndex: '#dataIndex#',filterable: true,#RENDERER##width##filter#}" >
				<cfset ArrayAppend(columnItemArr, forColItem) >

			</cfloop> <!---end tableColumnData--->

		</cfloop> <!---end formTableData--->


		<cfset fields = ArrayToList(columnnameArr, ", ") >
		<cfset columns = ArrayToList(columnItemArr, ", ") >
<cfset gridScript = "" >
<cfsavecontent variable="gridScript" >
	<cfoutput>
	Ext.define('autoeFormModel', {
		extend: 'Ext.data.Model',
		fields: [
			#fields#,
			'#firstlevel#__#firsttable#__APPROVED',
			'#firstlevel#__#firsttable#__EFORMID',
			'#firstlevel#__#firsttable#__PROCESSID',
			'#firstlevel#__#firsttable#__ACTIONBY',
			'#firstlevel#__#firsttable#__PERSONNELIDNO',
			'thefilepath',
			{
				name: '#firstlevel#__#firsttable#__RECDATECREATED',
				type: 'date'
			},{
				name: '#firstlevel#__#firsttable#__DATEACTIONWASDONE',
				type: 'date'
			},{
				name: '#firstlevel#__#firsttable#__DATELASTUPDATE',
				type: 'date'
			}
		]
	});

	var autoeFormStore = Ext.create('Ext.data.Store', {
			model: 'autoeFormModel',
			remoteFilter: true,
			remoteSort: true,
			simpleSortMode: true,
			sorters: [{
				property: '#firstlevel#__#firsttable#__DATELASTUPDATE',
				direction: 'DESC'
		    }],
			filters: [{
				type: 'string',
				dataIndex: '#firstlevel#__#firsttable#__#firstcolumn#'
			}],
			pageSize: 50,
			autoSave: true,
			autoLoad: true,
			autoSync: true,
			listeners: {
				load: function(thisStore,records) {
					if (records.length == 0) {
						Ext.ComponentQuery.query('button[action=copyeform]')[0].disabled = true;
						Ext.ComponentQuery.query('button[action=editeform]')[0].disabled = true;
						Ext.ComponentQuery.query('button[action=deleteeform]')[0].disabled = true;
						Ext.ComponentQuery.query('button[action=routeeform]')[0].disabled = true;
						Ext.ComponentQuery.query('button[action=viewpathroute]')[0].disabled = true;
						Ext.ComponentQuery.query('button[action=emailnowxxx]')[0].disabled = true;
						Ext.ComponentQuery.query('button[action=openformnow]')[0].disabled = true;
						Ext.ComponentQuery.query('button[action=approveformnow]')[0].disabled = true;
						Ext.ComponentQuery.query('button[action=disapproveformnow]')[0].disabled = true;
					} else {
						Ext.ComponentQuery.query('button[action=copyeform]')[0].disabled = false;
						Ext.ComponentQuery.query('button[action=editeform]')[0].disabled = false;
						Ext.ComponentQuery.query('button[action=deleteeform]')[0].disabled = false;
						Ext.ComponentQuery.query('button[action=routeeform]')[0].disabled = false;
						Ext.ComponentQuery.query('button[action=viewpathroute]')[0].disabled = false;
						Ext.ComponentQuery.query('button[action=emailnowxxx]')[0].disabled = false;
						Ext.ComponentQuery.query('button[action=openformnow]')[0].disabled = false;
						Ext.ComponentQuery.query('button[action=approveformnow]')[0].disabled = false;
						Ext.ComponentQuery.query('button[action=disapproveformnow]')[0].disabled = false;
					}

		   			try {
		   				var mainGrid = Ext.getCmp('#eformid#');
		   				var imagedisp = mainGrid.down('displayfield[name=imagedisplay]');
		   				imagedisp.setValue("<img title='" + GLOBAL_VARS_DIRECT.COMPANYNAME + "' style='border-radius: 7;' align='right' height='57' width='290' src='" + GLOBAL_VARS_DIRECT.COMPANYLOGO + "'>");
		   				var theFormID = new Array();
		   				var theProcessID = new Array();
		   				for(d=0;d<records.length;d++) {
		   					theFormID.push(records[d].data.#firstlevel#__#firsttable#__EFORMID);
		   					theProcessID.push(records[d].data.#firstlevel#__#firsttable#__PROCESSID);
		   				}
		   				Ext.ss.Complements.getQuickFormStatus(theFormID,theProcessID, function(resp) {
		   					var models = mainGrid.getStore().getRange();
		   					for(e=0;e<resp.length;e++) {
		   						if(resp[e] != 'N') {
		   							models[e].set('#firstlevel#__#firsttable#__APPROVED',resp[e]);
		   						}
		   					}
		   				});
		   			}
		   			catch(err) {
		   				console.log(err);
		   			}
		   		}
		   	},
			proxy: {
				extraParams: {
					eformid: '#eformid#',
					isnew: false,
					ispending: false
				},
				type: 'direct',
				timeout: 300000,
				paramOrder: ['page', 'start', 'limit', 'sort', 'filter', 'eformid', 'isnew', 'ispending'],
				api: {
					read:    Ext.ss.defdata.ColumnReadNow,
					create:  Ext.ss.defdata.ColumnCreateNow,
					update:  function() {return true;},
					destroy: Ext.ss.defdata.ColumnDestroyNow
				},
				paramsAsHash: false,
				filterParam: 'filter',
				sortParam: 'sort',
				limitParam: 'limit',
				idParam: 'ID',
				pageParam: 'page',
				reader: {
					root: 'topics',
					totalProperty: 'totalCount'
				}
			}
		});

	var autoeFormGrid = Ext.create('Ext.grid.Panel', {
			alias: 'widget.eFormGrid',
			title: '#eFormName#',
			id: '#eformid#',
			width: '100%',
			height: 500,
			multiSelect: true,
			clicksToEdit: 2,
			selModel: {
				pruneRemoved: false
			},
			viewConfig: {
				forceFit: false,
				trackOver: false,
				emptyText: '<h1 style=\'margin:20px\'>_</h1>'
			},
			features: [{
				ftype: 'filters',
				encode: true,
				local: false
			}],
			store: autoeFormStore,
			bbar: Ext.create('Ext.toolbar.Paging', {
				store: autoeFormStore, displayInfo: true, emptyMsg: 'No topics to display'
			}),
			tbar: [{
				xtype: 'displayfield',
				name: 'imagedisplay',
				value: '',
				height: 60,
				width: 300
			},{
				text: 'Add',
				action: 'addeform',
				hidden: false,
				handler: function(btn) {
					var eformGrid = btn.up('grid');
					var eformid = eformGrid.id;
					var processid = '_';
					var myMask = Ext.create('Ext.LoadMask',{
						css: 'loadmsline',
						target: eformGrid,
						msg: 'Opening,please wait...'
					});
					myMask.show();
					Ext.ss.activate.previewGrid(eformid, 'add',processid, function(result) {
						myMask.hide();
						eval(result);
						eForm.getForm().load({
							params: {
								eformid: eformid
							}
						});
					try{
						Ext.define('Search', {
							fields: ['id', 'query'],
							extend: 'Ext.data.Model',
							proxy: {
								type: 'localstorage',
								id  : 'twitter-Searches'
								}
							});
						var storeLocal = Ext.create('Ext.data.Store', {
							model: 'Search'});storeLocal.load();
							try {
								var theJSONdata = storeLocal.data.items[0].data.query;
								theJSONdata = Ext.JSON.decode(theJSONdata);
								eForm.getForm().setValues(theJSONdata);
							} catch(er0) {
								console.log(er0);
							}
						var args = {
							eform: eForm,
							localStore: storeLocal
						};
						var task = { run: function(args){
							try {
								var formCurrentVal = args.eform.getForm().getValues();
								args.localStore.removeAll();
								args.localStore.sync();
								var dataString = Ext.JSON.encode(formCurrentVal);
								args.localStore.add({query: dataString});
								args.localStore.sync();
								return true;
							} catch(errIn) {
								console.log(errIn);
								return false;}
							},
				interval: 300000,
				args: [args]
				};
				Ext.TaskManager.start(task);
				console.log('taskmanager runs');
				} catch(err) {
					console.log(err);
				}
			});
		}
	},{
		xtype: 'tbseparator'
	  },{
	  	text: 'View/Copy',
	  	action: 'copyeform',
	  	hidden: false,
	  	handler: function(btn) {
	  		var eformGrid = btn.up('grid');
	  		var selectedRecord = eformGrid.getSelectionModel().getSelection()[0];
	  		if(selectedRecord) {
	  			var eformid = selectedRecord.data.#firstlevel#__#firsttable#__EFORMID;
	  			var status = selectedRecord.data.#firstlevel#__#firsttable#__APPROVED;
	  			var processid = selectedRecord.data.#firstlevel#__#firsttable#__PROCESSID;
	  			var myMask = Ext.create('Ext.LoadMask',{
	  				target: eformGrid,
	  				msg: 'Opening, please wait...'
	  			});
	  			myMask.show();
	  			Ext.ss.activate.previewGrid(eformid, 'copy',processid, function(result) {
	  				myMask.hide();
	  				eval(result);
	  				var theForm = eForm.getForm();
	  				theForm.setValues(selectedRecord.data);
	  				eForm.getForm().load({
	  					params: {
	  						eformid: eformid
	  					}
	  				});
	  			});
	  		} else {
	  			alert('Please select a record first!');
	  		}
	  	}
	  },{
	  	xtype: 'tbseparator'
	  },{
	  	text: 'Edit',
	  	action: 'editeform',
	  	hidden: false,
	  	handler: function(btn) {
	  		var eformGrid = btn.up('grid');
	  		var selectedRecord = eformGrid.getSelectionModel().getSelection()[0];
	  		if(selectedRecord) {var eformid = selectedRecord.data.#firstlevel#__#firsttable#__EFORMID;
	  		var status = selectedRecord.data.#firstlevel#__#firsttable#__APPROVED;
	  		var processid = selectedRecord.data.#firstlevel#__#firsttable#__PROCESSID;
	  		var myMask = Ext.create('Ext.LoadMask',{
	  			target: eformGrid,
	  			msg: 'Opening, please wait...'
	  		});
	  		myMask.show();
	  		if(status == 'N' || status == 'R') {
	  			Ext.ss.activate.previewGrid(eformid, 'edit',processid, function(result) {
	  				myMask.hide();
	  				eval(result);
	  				var theForm = eForm.getForm();
	  				theForm.setValues(selectedRecord.data);
	  			});
	  		} else {
	  			myMask.hide();
	  			alert('Please copy this form first to edit!');
	  		}
	  	} else {
	  		alert('Please select a record first!');
	  	}
	  }
	},{
		xtype: 'tbseparator'
	},{
		text: 'Delete',
		action: 'deleteeform',
		hidden: false,
		handler: function(btn) {
			var eformGrid = btn.up('grid');
			var selectedRecords = eformGrid.getSelectionModel().getSelection();
			if(selectedRecords.length > 0) {
				var res = window.confirm('You are about to delete an eForm which has processed records. \n Would you like to continue?');
				if(!res) {
					return true;
				}
				var myMask = Ext.create('Ext.LoadMask',{
					target: eformGrid,
					msg: 'Deleting, please wait...'
				});
				myMask.show();
				for(d=0;d<=selectedRecords.length;d++) {
					var selectedRecord = selectedRecords[d];
					var eformid = selectedRecord.data.#firstlevel#__#firsttable#__EFORMID;
					var processid = selectedRecord.data.#firstlevel#__#firsttable#__PROCESSID;
					var level = '#firstlevel#';
					var table = '#firsttable#';
					Ext.ss.data.deleteForm(eformid,processid,level,table,function(result) {
						myMask.hide();
						eformGrid.getStore().load();
					});
				}
			} else {
				alert('Please select a record first!');
			}
		}
	},{
		xtype: 'tbseparator'
	},{
		text: 'Route',
		action: 'routeeform',
		hidden: false,
		handler: function(btn) {
			var thisgrid = btn.up('grid');
			var selection = thisgrid.getView().getSelectionModel().getSelection();
			if (selection.length != 0) {
				if (selection.length == 1) {
					var eform = 'eForm'
				} else {
					var eform = 'eForms'}
					var action = window.confirm('Route selected ' + eform + '?\nNote: Only eForms with status \'NEW\' will be routed.');
					if(action) {
						var myMask = Ext.create('Ext.LoadMask',{target: thisgrid,msg: 'Routing, please wait...'});
						for (var cntr=0; cntr<selection.length; cntr++) {
							var eformid = selection[cntr].data.#firstlevel#__#firsttable#__EFORMID;
							var processid = selection[cntr].data.#firstlevel#__#firsttable#__PROCESSID;
							var theLevel = '#firstlevel#';var thetable = '#firsttable#';
							var status = selection[cntr].data.#firstlevel#__#firsttable#__APPROVED;
							if(status == 'N' || status == '') {
								myMask.show();
								Ext.ss.dynamicApprover.isDynamic('1',eformid, function(result){
									console.log(result.HASDYNAMIC);
									if(result.HASDYNAMIC == true) {
										dynamicApproverWin = Ext.widget('eformdynamicapprovers');
										var routerOrderComp = dynamicApproverWin.down('textfield[name=routerorder]');
										var routerTempComp = dynamicApproverWin.down('textfield[name=templaterouterid]');
										var maximumComp = dynamicApproverWin.down('displayfield[name=maximum]');
										var eformidComp = dynamicApproverWin.down('textfield[name=eformid]');
										var processidComp = dynamicApproverWin.down('textfield[name=processid]');
										var levelComp = dynamicApproverWin.down('textfield[name=level]');
										var tableComp = dynamicApproverWin.down('textfield[name=table]');

										routerOrderComp.setValue(result.ROUTERORDER);
										routerTempComp.setValue(result.TEMPLATEROUTERID);
										maximumComp.setValue(result.MAXIMUM);
										eformidComp.setValue(result.EFORMID);

										processidComp.setValue(processid);
										levelComp.setValue(theLevel);
										tableComp.setValue(thetable);

										dynamicApproverWin.show();
										myMask.hide();
										var gridApprover = dynamicApproverWin.down('grid');
										gridApprover.getStore().load({
											params: {
												eformid: result.EFORMID,
												routerid: result.TEMPLATEROUTERID
											}
										});
										gridApprover.getStore().proxy.extraParams.eformid = result.EFORMID;
										gridApprover.getStore().proxy.extraParams.routerid = result.TEMPLATEROUTERID;
										return true;
									} else {
										Ext.ss.active.startRoute(eformid,processid,theLevel,thetable, function(result) {
											console.log(result);
											myMask.hide();
											if(result == 'success') {
												Ext.Msg.show({
													title: '',
													msg: 'Form route successful',
													buttons: Ext.Msg.OK
												});
													thisgrid.getStore().load();
											} else {
												myMask.hide();
												Ext.Msg.show({
													title: 'Technical problem.',
													msg: 'Our apology. We are having technical problems : ' + result,
													buttons: Ext.Msg.OK,icon: Ext.Msg.ERROR
												});
											}
										});
									}
								});
							} else {
								myMask.hide();
							}
						}
					}
				} else {
					alert('No form selected. Please select an eForm to route.');
				}
			}
		},{
			xtype: 'tbseparator'
		},{
			text: 'View Status',
			action: 'viewpathroute',
			hidden: false,
			handler: function(btn) {
				var thisgrid = btn.up('grid');
				var selection = thisgrid.getView().getSelectionModel().getSelection()[0];
				if (selection) {var eformid = selection.data.#firstlevel#__#firsttable#__EFORMID;
				var processid = selection.data.#firstlevel#__#firsttable#__PROCESSID;
				var status = selection.data.#firstlevel#__#firsttable#__APPROVED;
				var pidno = selection.data.#firstlevel#__#firsttable#__PERSONNELIDNO;
				var theLevel = '#firstlevel#';
				var theTable = '#firsttable#';
				var myMask = Ext.create('Ext.LoadMask',{
					target: thisgrid,
					msg: 'Opening, please wait...'
				});
				myMask.show();
				if(status != 'N' && status != '') {
					Ext.ss.active.generateMap(eformid,processid,pidno,theLevel,theTable, function(result) {
						myMask.hide();
						try {
							eval(result);
						} catch(err) {
							if(result == 'cannotviewroutemap') {
								alert('Unable to view status');
							} else {
								alert('Please try again.');
								console.log(result);
							}
						}
					});
				} else {
					myMask.hide();
					Ext.Msg.show({title: '',
					msg: 'Please route the form first.',
					buttons: Ext.Msg.OK});
				}
			} else {
				alert('No form selected. Please select an eForm first.');
			}
		}
	},{
		xtype: 'tbseparator'
	},{
		text: 'Open',
		action: 'openformnow',
		hidden: false,
		handler: function(btn) {
			var eformGrid = btn.up('grid');
			var selectedRecord = eformGrid.getSelectionModel().getSelection()[0];
			if(selectedRecord) {
				var myMask = Ext.create('Ext.LoadMask',{
					target: eformGrid,
					msg: 'Opening, please wait...'
				});
				myMask.show();
				var eformid = selectedRecord.data.#firstlevel#__#firsttable#__EFORMID;
				var processid = selectedRecord.data.#firstlevel#__#firsttable#__PROCESSID;
				Ext.ss.activate.previewGrid(eformid, 'open',processid, function(result) {
					myMask.hide();
					eval(result);
					var theForm = eForm.getForm();
					theForm.setValues(selectedRecord.data);
					var querythisform = eForm.query('displayfield');
					/*set isread to true now except for pending*/
					var formOwner = selectedRecord.data.#firstlevel#__#firsttable#__PERSONNELIDNO;
					Ext.ss.data.setIsreadTrue(eformid, processid, formOwner, function(result) {
						console.log(result);
						var theForm = eForm.getForm();theForm.setValues(result.data);
					});
				});
			} else {
				alert('Please select a record first!');
			}
		}
	},{
		xtype: 'tbseparator'
	},{
		text: 'Approve',
		action: 'approveformnow',
		hidden: false,
		handler: function(thiss) {
			var res = window.confirm('Approve?');
			if(!res) {
				return false;
			}
			var theGrid = thiss.up('grid');
			var selectedRecord = theGrid.getView().getSelectionModel().getSelection();
			if(selectedRecord.length > 0) {
				var myMask = Ext.create('Ext.LoadMask',{
					target: theGrid,
					msg: 'Approving, please wait...'
				});
				myMask.show();
				for(cntt=0;cntt<selectedRecord.length;cntt++) {
					var eformid    = selectedRecord[cntt].data.#firstlevel#__#firsttable#__EFORMID;
					var processid  = selectedRecord[cntt].data.#firstlevel#__#firsttable#__PROCESSID;
					var firstlevel = '#firstlevel#';var firsttable = '#firsttable#';
					var actiontype = 'approve';
					var pid  = selectedRecord[cntt].data.#firstlevel#__#firsttable#__PERSONNELIDNO;
					Ext.ss.actionform.gridApproveDisapprove(eformid,processid,firstlevel,firsttable,actiontype,pid, function(result) {
						myMask.hide();
						theGrid.getStore().load();
						var mainGrid = Ext.ComponentQuery.query('eformmainview');
						mainGrid[0].getStore().load();
					});
				}
			} else {
				alert('Please select at least one record to approve.');
			}
		}
	},{
		xtype: 'tbseparator'
	},{
		text: 'Disapprove',
		action: 'disapproveformnow',
		hidden: false,
		handler: function(thiss) {
			var res = window.confirm('Disapprove?');
			if(!res) {
				return false;
			}
			var theGrid = thiss.up('grid');
			var selectedRecord = theGrid.getView().getSelectionModel().getSelection();
			if(selectedRecord.length > 0) {
				var myMask = Ext.create('Ext.LoadMask',{target: theGrid,msg: 'Disapproving, please wait...'});
				myMask.show();
				for(cntt=0;cntt<selectedRecord.length;cntt++) {
					var eformid    = selectedRecord[cntt].data.#firstlevel#__#firsttable#__EFORMID;
					var processid  = selectedRecord[cntt].data.#firstlevel#__#firsttable#__PROCESSID;
					var firstlevel = '#firstlevel#';var firsttable = '#firsttable#';
					var actiontype = 'disapprove';
					var pid  = selectedRecord[cntt].data.#firstlevel#__#firsttable#__PERSONNELIDNO;
					Ext.ss.actionform.gridApproveDisapprove(eformid,processid,firstlevel,firsttable,actiontype,pid, function(result) {
						myMask.hide();
						theGrid.getStore().load();
						var mainGrid = Ext.ComponentQuery.query('eformmainview');
						mainGrid[0].getStore().load();
					});
				}
			} else {
				alert('Please select at least one record to approve.');
			}
		}
	},{
		xtype: 'tbseparator'
	},{
		text: 'Print | eMail',
		action: 'emailnowxxx',
		handler: function(btn) {
			var eformGrid = btn.up('grid');
			var selectedRecord = eformGrid.getSelectionModel().getSelection()[0];
			if(selectedRecord) {var eformid = selectedRecord.data.#firstlevel#__#firsttable#__EFORMID;
				var processid = selectedRecord.data.#firstlevel#__#firsttable#__PROCESSID;
				var myMask = Ext.create('Ext.LoadMask',{
					target: eformGrid,
					msg: 'Opening, please wait...'
				});
				myMask.show();
				Ext.ss.activate.previewGrid(eformid, 'print',processid, function(result) {
					myMask.hide();
					eval(result);
					var theForm = eForm.getForm();
					theForm.setValues(selectedRecord.data);
				});
			} else {
				alert('Please select a record first!');
			}
		}
	},{
		xtype: 'tbseparator'
	},{
		text: 'Print List',
		action:'printlist',
		handler: function(thiss) {
			var gridPanel = thiss.up('grid');
			Ext.ux.grid.Printer.print(gridPanel);
		}
	},{
		xtype: 'tbseparator'
	},{
		text: 'Back',
		action: 'backrefreshmain',
		handler: function(btn) {
			var currentWindow = btn.up('window');
			currentWindow.close();
			var mainGrid = Ext.ComponentQuery.query('eformmainview');
			mainGrid[0].getStore().load();
		}
	}],
	enableLocking:true,
	columns: [{
		xtype: 'rownumberer',
		width: 50,
		sortable: false
	},{
		text: 'Status',
		dataIndex: '#firstlevel#__#firsttable#__APPROVED',
		width: 100,
		filterable: true,
		renderer: function(value, metaData, record) {
			if(value == 'Y') {
				metaData.style = 'background-color: ##00FF00;';
				return 'APPROVED';
			} else if (value == 'D') {
				metaData.style = 'background-color: ##FF0000;';
				return 'DISAPPROVED';
			} else if (value == 'S') {
				metaData.style = 'background-color: ##FFFF00;';
				return 'PENDING';
			} else if (value == 'R') {
				metaData.style = 'background-color: ##CCCCFF;';
				return 'RETURNED';
			} else if (value == 'N') {
				return 'NEW';
			} else {
				metaData.style = 'background-color: ##FFFF00;';
				return value;
			}
			return value;
		}
	},
	#columns#,
	{
		text: 'eFormID',
		dataIndex: '#firstlevel#__#firsttable#__EFORMID',
		hidden: true
	},{
		text: 'ProcessID',
		dataIndex: '#firstlevel#__#firsttable#__PROCESSID',
		hidden: true
	},{
		text: 'ActonBy',
		dataIndex: '#firstlevel#__#firsttable#__ACTIONBY',
		hidden: true
	},{
		text: 'PersonnelID',
		dataIndex: '#firstlevel#__#firsttable#__PERSONNELIDNO',
		hidden: true
	},{
		text: 'Record Date Created',
		dataIndex: '#firstlevel#__#firsttable#__RECDATECREATED',
		hidden: true
	},{
		text: 'Date Action Was Done',
		dataIndex: '#firstlevel#__#firsttable#__DATEACTIONWASDONE',
		hidden: true
	},{
		text: 'Date Last Update',
		dataIndex: '#firstlevel#__#firsttable#__DATELASTUPDATE',
		hidden: true
	},{
		text: 'Date Last Update',
		dataIndex: 'thefilepath',
		hidden: true
	}]
});

	Ext.create('Ext.window.Window', {
		height: '100%',
		width: '100%',
		layout: 'fit',
		modal: true,
		items: autoeFormGrid
	}).show();
	</cfoutput>
</cfsavecontent>

<cfset gridScript = rereplace(gridScript,"[\t\n\f\r]","","all")/>
<cfset processData = EntityLoad("EGRGEFORMS", eformid, true ) >
<cfset processData.setGRIDSCRIPT(gridScript) >
<cfset EntitySave(processData) >
<cfset ormflush()>

	<cfinvoke method="generateForm" eformid="#eformid#" returnvariable="result" >


		<cfreturn "success" >
	<cfcatch>
		<cfreturn cfcatch.detail & ' ' & cfcatch.message >
	</cfcatch>
	</cftry>
</cffunction>




<cffunction name="generateForm" ExtDirect="true">
	<cfargument name="eformid" >
	<!---<cftry>--->
	<cfset formScript = "" >
	<cfset fieldSetItems = "" >
	<cfset fieldItems = "" >
	<cfset fieldArr = ArrayNew(1) >
	<cfset validationArr = ArrayNew(1) >
	<cfset columnModelStore = ArrayNew(1) >
	<cfset groupStruct = structnew() >
	<cfset groupStruct.__ = ArrayNew(1) >
	<cfset groupStruct.__nogroup = ArrayNew(1) >
	<cfset Y__nogroup = 200 >
	<cfset formpadding = 5>
	<cfset formgroupmargin = 5>
	<cfset cntStore = 1 >
	<cfset cntVType = 1 >
	<cfset cntA = 1 >
	<cfset withfileField = "false" >
	<cfset fileCount = 0 >
	<cfset itemsHIDDENITEMS = ArrayNew(1) >
	<cfset gridLowestIndex = 0 >

	<!---For grid only--->
	<cfset gridColumnID = ArrayNew(1) >
	<cfset gridColumnName = ArrayNew(1) >
	<cfset gridColumnType = ArrayNew(1) >
	<cfset gridColumnText = ArrayNew(1) >
	<cfset gridGroup = ArrayNew(1) >
	<cfset gridColumnAlign = ArrayNew(1) >
	<cfset gridColumnBorder = ArrayNew(1) >
	<cfset gridColumnStyle = ArrayNew(1) >
	<cfset gridColumnVType = ArrayNew(1) >
	<cfset gridColumnVText = ArrayNew(1) >
	<cfset gridColumnRenderer = ArrayNew(1) >
	<cfset gridColumnAnchor = ArrayNew(1) >
	<cfset gridColumnFormat = ArrayNew(1) >
	<cfset gridColumnCls = ArrayNew(1) >
	<cfset gridColumnAllowBlank = ArrayNew(1) >
	<cfset gridColumnReadOnly = ArrayNew(1) >
	<cfset gridColumnHidden = ArrayNew(1) >
	<cfset gridColumnIsBooleanType = ArrayNew(1) >
	<cfset gridColumnMinVal = ArrayNew(1) >
	<cfset gridColumnMaxVal = ArrayNew(1) >
	<cfset gridColumnMinChar = ArrayNew(1) >
	<cfset gridColumnMaxChar = ArrayNew(1) >
	<cfset gridColumnUncheckedVal = ArrayNew(1) >
	<cfset gridColumnLocalData = ArrayNew(1) >
	<cfset gridColumnRemoteData = ArrayNew(1) >
	<cfset gridColumnEditableOnRoute = ArrayNew(1) >

	<cfset gridHeight = ArrayNew(1) >
	<cfset gridWidth = ArrayNew(1) >
	<cfset gridMargin = ArrayNew(1) >
	<cfset gridPadding = ArrayNew(1) >
	<cfset gridSummary = ArrayNew(1) >
	<cfset gridDisabled = ArrayNew(1) >


	<cfset ISREADONLY = "" >
	<cfset VALIDATIONTYPE = "" >
	<cfset VTYPETEXT = "" >
	<cfset ALLOWBLANK = "" >
	<cfset ISCHECKED = "" >
	<cfset MININPUTVALUE = "" >
	<cfset MAXINPUTVALUE = "" >
	<cfset MINCHARLENGTH = "" >
	<cfset MAXCHARLENGTH = "" >
	<cfset UNCHECKEDVALUE = "" >
	<cfset COMBOLOCALDATA = "" >
	<cfset COMBOREMOTEDATA = "" >
	<cfset INPUTFORMAT = "" >
	<cfset EDITABLEONROUTENO = "" >
	<!---End for grid only--->


	<cfset getMainTableID = ORMExecuteQuery("SELECT B.TABLENAME AS TABLENAME, B.LEVELID AS LEVELID, C.COLUMNNAME AS COLUMNNAME
	  								      FROM EGRGEFORMS A,EGRGIBOSETABLE B,EGRGIBOSETABLEFIELDS C
	 								      WHERE EFORMID = '#eformid#' AND A.EFORMID = B.EFORMIDFK AND B.TABLEID = C.TABLEIDFK AND C.XTYPE = 'id'", true) >

	<cfif trim(getMainTableID[1]) neq "" >
		<cfset firsttable  = getMainTableID[1] >
		<cfset firstlevel  = getMainTableID[2] >
		<cfset firstcolumn = getMainTableID[3] >
	<cfelse>
		<cfthrow detail="Table has no id specified in table fields. At least one field type is an id type." >
	</cfif>
	<!---ff are disabled by default to prevent duplicate columns--->
	<cfsavecontent variable="extraFields" >
		<cfoutput>
			,{
				xtype: 'hiddenfield',fieldLabel: '__APPROVED',disabled: true,
				name: '#firstlevel#__#firsttable#__APPROVED',width: 200
			},{
				xtype: 'hiddenfield',fieldLabel: '__EFORMID',disabled: true,
				name: '#firstlevel#__#firsttable#__EFORMID',width: 200
			},{
				xtype: 'hiddenfield',fieldLabel: '__PROCESSID',disabled: true,
				name: '#firstlevel#__#firsttable#__PROCESSID',width: 200
			},{
				xtype: 'hiddenfield',fieldLabel: '__ACTIONBY',disabled: true,
				name: '#firstlevel#__#firsttable#__ACTIONBY',width: 200
			},{
				xtype: 'hiddenfield',fieldLabel: '__PERSONNELIDNO',disabled: true,
				name: '#firstlevel#__#firsttable#__PERSONNELIDNO',width: 200
			},{
				xtype: 'datefield',fieldLabel: '__RECDATECREATED',disabled: true,hidden: true, name: '#firstlevel#__#firsttable#__RECDATECREATED',
				submitFormat: 'Y-n-j', width: 200
			},{
				xtype: 'datefield',fieldLabel: '__DATEACTIONWASDONE',disabled: true,hidden: true, name: '#firstlevel#__#firsttable#__DATEACTIONWASDONE',
				submitFormat: 'Y-n-j', width: 200
			},{
				xtype: 'datefield',fieldLabel: '__DATELASTUPDATE',disabled: true,hidden: true, name: '#firstlevel#__#firsttable#__DATELASTUPDATE',
				submitFormat: 'Y-n-j', width: 200
			}
		</cfoutput>
	</cfsavecontent>
	<cfset extraFields = rereplace(extraFields,"[\t\n\f\r]","","all") />

	<cfset formProcessData = EntityLoad("EGRGEFORMS", {EFORMID = #eformid#}, true) >

		<cfset formtitle = formProcessData.getEFORMNAME() >
		<cfset formdescription = formProcessData.getDESCRIPTION() >
		<cfset formgroup = formProcessData.getEFORMGROUP() >
		<cfset formflowprocess = formProcessData.getFORMFLOWPROCESS() >
		<cfset formencrypted = formProcessData.getISENCRYPTED() >
		<cfset formviewas = formProcessData.getVIEWAS() >
		<cfset formpadding = formProcessData.getFORMPADDING() >
		<cfset formgroupmargin = formProcessData.getGROUPMARGIN() >


		<cfset formTableData = EntityLoad("EGRGIBOSETABLE", {EFORMIDFK = #eformid#}) >

		<cfset TOTALTABLES = ArrayLen(formTableData) >

		<cfloop array="#formTableData#" index="tableIndex" >

			<cfset TABLENAME = tableIndex.getTABLENAME() >
			<cfset LEVELID = tableIndex.getLEVELID() >

			<cfset tableColumnData = EntityLoad("EGRGIBOSETABLEFIELDS", {TABLEIDFK = #tableIndex.getTABLEID()#}, "COLUMNORDER ASC") >
			<cfset TOTALCOLUMNS = ArrayLen(tableColumnData) >

			<cfloop array="#tableColumnData#" index="columnIndex" >
				<cfset COLUMNID = columnIndex.getCOLUMNID() >
				<cfset TABLEIDFK = columnIndex.getTABLEIDFK() >
				<cfset COLUMNNAME = columnIndex.getCOLUMNNAME() >
				<cfset FIELDLABEL = columnIndex.getFIELDLABEL() >
				<cfset COLUMNORDER = columnIndex.getCOLUMNORDER() >
				<cfset COLUMNTYPE = columnIndex.getCOLUMNTYPE() >
				<cfset XTYPE = columnIndex.getXTYPE() >
				<cfset COLUMNGROUP = columnIndex.getCOLUMNGROUP() >
				<cfset FIELDLABELALIGN = columnIndex.getFIELDLABELALIGN() >
				<cfset FIELDLABELWIDTH = columnIndex.getFIELDLABELWIDTH() >
				<cfset ALLOWBLANK = columnIndex.getALLOWBLANK() >
				<cfset ISCHECKED = columnIndex.getISCHECKED() >
				<cfset CSSCLASS = columnIndex.getCSSCLASS() >
				<cfset ISDISABLED = columnIndex.getISDISABLED() >
				<cfset HEIGHT = columnIndex.getHEIGHT() >
				<cfset WIDTH = columnIndex.getWIDTH() >
				<cfset MININPUTVALUE = columnIndex.getMININPUTVALUE() >
				<cfset MAXINPUTVALUE = columnIndex.getMAXINPUTVALUE() >
				<cfset MINCHARLENGTH = columnIndex.getMINCHARLENGTH() >
				<cfset MAXCHARLENGTH = columnIndex.getMAXCHARLENGTH() >
				<cfset ISHIDDEN = columnIndex.getISHIDDEN() >
				<cfset INPUTID = "'#COLUMNID#'" >
				<cfset MARGIN = columnIndex.getMARGIN() >
				<cfset PADDING = columnIndex.getPADDING() >
				<cfset BORDER = columnIndex.getBORDER() >
				<cfset STYLE = columnIndex.getSTYLE() >
				<cfset ISREADONLY = columnIndex.getISREADONLY() >
				<cfset INPUTVALUE = columnIndex.getINPUTVALUE() >
				<cfset VALIDATIONTYPE = columnIndex.getVALIDATIONTYPE() >
				<cfset VTYPETEXT = columnIndex.getVTYPETEXT() >
				<cfset RENDERER = columnIndex.getRENDERER() >
				<cfset XPOSITION = columnIndex.getXPOSITION() >
				<cfset YPOSITION = columnIndex.getYPOSITION() >
				<cfset ANCHORPOSITION = columnIndex.getANCHORPOSITION() >
				<cfset INPUTFORMAT = columnIndex.getINPUTFORMAT() >
				<cfset INPUTFORMATB = INPUTFORMAT >

				<cfset NOOFCOLUMNS = columnIndex.getNOOFCOLUMNS() >
				<cfset CHECKITEMS = columnIndex.getCHECKITEMS() >
				<cfset UNCHECKEDVALUE = columnIndex.getUNCHECKEDVALUE() >

				<cfset COMBOLOCALDATA = columnIndex.getCOMBOLOCALDATA() >
				<cfset COMBOREMOTEDATA = columnIndex.getCOMBOREMOTEDATA() >


				<cfset EDITABLEONROUTENO = columnIndex.getEDITABLEONROUTENO() >
				<cfset AUTOGENTEXT = columnIndex.getAUTOGENTEXT() >
				<cfset RECCREATEDBY = columnIndex.getRECCREATEDBY() >
				<cfset RECDATECREATED = columnIndex.getRECDATECREATED() >
				<cfset DATELASTUPDATE = columnIndex.getDATELASTUPDATE() >



				<cfset STYLE = "{" & STYLE & "}" >


				<cfif trim(FIELDLABELALIGN) EQ "" >
					<cfset FIELDLABELALIGN = "100" >
				<cfelse>
					<cfset res = findnocase('%',FIELDLABELALIGN) >
					<cfif res EQ 0>
					<cfelse>
						<cfset FIELDLABELALIGN = "'FIELDLABELALIGN'" >
					</cfif>
				</cfif>

				<cfif trim(ANCHORPOSITION) EQ "" >
					<cfset ANCHORPOSITION = "" >
				<cfelse>
					<cfset ANCHORPOSITION = "anchor: '#ANCHORPOSITION#'," >
				</cfif>

				<cfif trim(VTYPETEXT) EQ "" >
					<cfset VTYPETEXT = "" >
				<cfelse>
					<cfset VTYPETEXT = "vtypeText: '#VTYPETEXT#'," >
				</cfif>

				<cfif trim(INPUTFORMAT) EQ "" >
					<cfset INPUTFORMAT = "" >
				<cfelse>
					<cfset INPUTFORMAT = "format: '#INPUTFORMAT#'," >
				</cfif>

				<cfif trim(MININPUTVALUE) EQ "" >
					<cfset MININPUTVALUE = "" >
				<cfelse>
					<cfset MININPUTVALUE = "minValue: #MININPUTVALUE#," >
				</cfif>

				<cfif trim(MAXINPUTVALUE) EQ "" >
					<cfset MAXINPUTVALUE = "" >
				<cfelse>
					<cfset MAXINPUTVALUE = "maxValue: #MAXINPUTVALUE#," >
				</cfif>

				<cfif trim(HEIGHT) EQ "" >
					<cfset HEIGHT = "" >
				<cfelse>
					<cfset res = findnocase('%',HEIGHT) >
					<cfif res EQ 0>
						<cfset HEIGHT = "height: #HEIGHT#," >
					<cfelse>
						<cfset HEIGHT = "height: '#HEIGHT#'," >
					</cfif>
				</cfif>

				<cfif trim(WIDTH) EQ "" >
					<cfset WIDTH = "" >
				<cfelse>
					<cfset res = findnocase('%',WIDTH) >
					<cfif res EQ 0>
						<cfset WIDTH = "width: #WIDTH#," >
					<cfelse>
						<cfset WIDTH = "width: '#WIDTH#'," >
					</cfif>
				</cfif>

				<cfif trim(FIELDLABELWIDTH) EQ "" >
					<cfset FIELDLABELWIDTH = "" >
				<cfelse>
					<cfset res = findnocase('%',FIELDLABELWIDTH) >
					<cfif res EQ 0>
						<cfset FIELDLABELWIDTH = "labelWidth: #FIELDLABELWIDTH#," >
					<cfelse>
						<cfset FIELDLABELWIDTH = "labelWidth: '#FIELDLABELWIDTH#'," >
					</cfif>
				</cfif>

				<cfif trim(MARGIN) EQ "" >
					<cfset MARGIN = "'0 0 0 0'" >
				<cfelse>
					<cfset MARGIN = "'#MARGIN#'" >
				</cfif>

				<cfif trim(PADDING) EQ "" >
					<cfset PADDING = "'5 5 5 5'" >
				<cfelse>
					<cfset PADDING = "'#PADDING#'" >
				</cfif>

				<cfif trim(VALIDATIONTYPE) EQ "" >
					<cfset VALIDATIONTYPE = "" >
				<cfelseif VALIDATIONTYPE EQ "alpha" OR VALIDATIONTYPE EQ "alphanum" OR VALIDATIONTYPE EQ "email" OR VALIDATIONTYPE EQ "url" >
					<cfset VALIDATIONTYPE = "vtype: '#VALIDATIONTYPE#'," >
				<cfelse>
					<cfset res = find(":", VALIDATIONTYPE) >
					<cfif res GT 0 >
						<cfset title = left(VALIDATIONTYPE, res-1) >
						<cfset validationArr[cntVType] = "Ext.apply(Ext.form.field.VTypes, { #VALIDATIONTYPE#  });" >
						<cfset cntVType = cntVType + 1 >
						<cfset VALIDATIONTYPE = "vtype: '#title#'," >
					<cfelseif find("RVTYPE", VALIDATIONTYPE) gt 0> <!--- if true, remote validation is enabled --->
					    <cfinvoke method="modelRemoteValidation">
					<cfelse>
						<cfset VALIDATIONTYPE = "vtype: '#VALIDATIONTYPE#'," >
					</cfif>
				</cfif>


				<cfif trim(COLUMNGROUP) EQ "" >
					<cfset COLUMNGROUP = "nogroup" >
				</cfif>

				<cfset COLUMNGROUP = rereplace(COLUMNGROUP, "[^A-Za-z0-9_]", "_", "all") >

				<cftry>
					<cfset isArray = evaluate("items#COLUMNGROUP#") >
					<cfif isarray(isArray) >

					<cfelse>
						<cfset "items#COLUMNGROUP#"  = arraynew(1) >
					</cfif>
				<cfcatch>
					<cfset "items#COLUMNGROUP#"  = arraynew(1) >
				</cfcatch>
				</cftry>


				<cftry>
					<cfset isVar = evaluate("Y__#COLUMNGROUP#") >
					<cfif XTYPE EQ "htmleditor" >
						<cfset origPos = isVar - 250>
					<cfelseif XTYPE EQ "checkboxgroup" OR XTYPE EQ "radiogroup">
						<cfset listlen = ListLen(CHECKITEMS,";") >
						<cfset totcol = NOOFCOLUMNS >
						<cfset divfactor = numberformat(listlen/totcol, "____") >
						<cfset origPos = isVar - 65 - 22*divfactor >
					<cfelse>
						<cfset origPos = isVar - 80>
					</cfif>
					<cfif origPos GT YPOSITION >
					<cfelse>
						<cfif XTYPE EQ "htmleditor" >
							<cfset "Y__#COLUMNGROUP#" = YPOSITION + 250>
						<cfelseif XTYPE EQ "checkboxgroup" OR XTYPE EQ "radiogroup">
							<cfset listlen = ListLen(CHECKITEMS,";") >
							<cfset totcol = NOOFCOLUMNS >
							<cfset divfactor = numberformat(listlen/totcol, "____") >
							<cfset "Y__#COLUMNGROUP#" = YPOSITION + 65 + 22*divfactor >
						<cfelse>
							<cfset "Y__#COLUMNGROUP#" = YPOSITION + 80>
						</cfif>


					</cfif>
				<cfcatch>
					<cfif XTYPE EQ "htmleditor" >
						<cfset "Y__#COLUMNGROUP#" = YPOSITION + 250>
					<cfelseif XTYPE EQ "checkboxgroup" OR XTYPE EQ "radiogroup">
						<cfset listlen = ListLen(CHECKITEMS,";") >
						<cfset totcol = NOOFCOLUMNS >
						<cfset divfactor = numberformat(listlen/totcol, "____") >
						<cfset "Y__#COLUMNGROUP#" = YPOSITION + 65 + 22*divfactor>
					<cfelse>
						<cfset "Y__#COLUMNGROUP#" = YPOSITION + 80>
					</cfif>
				</cfcatch>
				</cftry>


				<cfif trim(XPOSITION) EQ "" >
					<cfset XPOSITION = "" >
				<cfelse>
					<cfset XPOSITION = "x: #XPOSITION#," >
				</cfif>

				<cfif trim(YPOSITION) EQ "" >
					<cfset YPOSITION = "" >
				<cfelse>
					<cfset YPOSITION = "y: #YPOSITION#," >
				</cfif>

				<cfif XTYPE EQ "textfield" > <!---textfield Default--->

					<cfset groupItems ="" >
					<cfsavecontent variable="groupItems" >
						<cfoutput>
							{	xtype: 'textfield',//used to convert to display field
								 fieldLabel: '#FIELDLABEL#', name: '#LEVELID#__#TABLENAME#__#COLUMNNAME#',
								 #XPOSITION# #YPOSITION# #ANCHORPOSITION# hidden: #ISHIDDEN#, labelAlign: '#FIELDLABELALIGN#',
								 #FIELDLABELWIDTH#
								 allowBlank: #ALLOWBLANK#,
								 cls: '#CSSCLASS#',
								 disabled: #ISDISABLED#, #HEIGHT# #WIDTH# minLength: #MINCHARLENGTH#, maxLength: #MAXCHARLENGTH#,
								 margin: #MARGIN#,
								 padding: #PADDING#,
								 border: '#BORDER#', style: #STYLE#, id: #INPUTID#,readOnly: #ISREADONLY#,
								 value: '#INPUTVALUE#', #VALIDATIONTYPE# #VTYPETEXT# fieldStyle: '#INPUTFORMATB#'
							 }
						</cfoutput>
					</cfsavecontent>
					<cfset groupItems = rereplace(groupItems,"[\t\f]","","all") />
					<cfset arrayappend(evaluate("items#COLUMNGROUP#"), groupItems) >
					<cfset "groupStruct.__#COLUMNGROUP#" =  evaluate("items#COLUMNGROUP#") >

				<cfelseif XTYPE EQ "datefield"> <!---datefield--->
					<cfif ALLOWBLANK eq "true" >
						<cfset submitvalue = "false" >
					<cfelse>
						<cfset submitvalue = "true" >
					</cfif>
					<cfsavecontent variable="groupItems" >
						<cfoutput>
							{	xtype: 'datefield',fieldLabel: '#FIELDLABEL#',name: '#LEVELID#__#TABLENAME#__#COLUMNNAME#',#XPOSITION##YPOSITION##ANCHORPOSITION#hidden: #ISHIDDEN#,
								submitFormat: 'Y-n-j',
								labelAlign: '#FIELDLABELALIGN#',
								#FIELDLABELWIDTH#allowBlank: #ALLOWBLANK#,cls: '#CSSCLASS#',
								disabled: #ISDISABLED#,
								#HEIGHT##WIDTH#minLength: #MINCHARLENGTH#,
								maxLength: #MAXCHARLENGTH#,
								submitValue: #submitvalue#,
								listeners: {
									change: function(thiss,newVal) {
										if(newVal) {
											thiss.submitValue = true;
										} else {
											thiss.submitValue = false;
										}
									}
								},
								margin: #MARGIN#,padding: #PADDING#,
								border: '#BORDER#',style: #STYLE#,id: #INPUTID#,readOnly: #ISREADONLY#,
								value: '#INPUTVALUE#',
								#VALIDATIONTYPE##VTYPETEXT##INPUTFORMAT#
							}
						</cfoutput>
					</cfsavecontent>
					<cfset groupItems = rereplace(groupItems,"[\t\n\f\r]","","all") />
					<cfset arrayappend(evaluate("items#COLUMNGROUP#"), groupItems) >
					<cfset "groupStruct.__#COLUMNGROUP#" =  evaluate("items#COLUMNGROUP#") >

				<cfelseif XTYPE EQ "timefield"> <!---timefield--->

					<cfsavecontent variable="groupItems" >
						<cfoutput>
							{	xtype: 'timefield',fieldLabel: '#FIELDLABEL#', name: '#LEVELID#__#TABLENAME#__#COLUMNNAME#',
								#XPOSITION# #YPOSITION#
								#ANCHORPOSITION# hidden: #ISHIDDEN#, labelAlign: '#FIELDLABELALIGN#',
								#FIELDLABELWIDTH# allowBlank: #ALLOWBLANK#, cls: '#CSSCLASS#', disabled: #ISDISABLED#,
								#HEIGHT# #WIDTH#
								minLength: #MINCHARLENGTH#,
								maxLength: #MAXCHARLENGTH#,
								margin: #MARGIN#, padding: #PADDING#,
								border: '#BORDER#', style: #STYLE#,
								id: #INPUTID#,readOnly: #ISREADONLY#,value: '#INPUTVALUE#',
								#VALIDATIONTYPE# #VTYPETEXT# #INPUTFORMAT#
							}
						</cfoutput>
					</cfsavecontent>
					<cfset groupItems = rereplace(groupItems,"[\t\n\f\r]","","all") />
					<cfset arrayappend(evaluate("items#COLUMNGROUP#"), groupItems) >
					<cfset "groupStruct.__#COLUMNGROUP#" =  evaluate("items#COLUMNGROUP#") >

				<cfelseif XTYPE EQ "numberfield"> <!---numberfield--->
					<cfif ALLOWBLANK eq "true" >
						<cfset submitvalue = "false" >
					<cfelse>
						<cfset submitvalue = "true" >
					</cfif>

					<cfsavecontent variable="groupItems" >
						<cfoutput>
							{	xtype: 'numberfield',fieldLabel: '#FIELDLABEL#', name: '#LEVELID#__#TABLENAME#__#COLUMNNAME#',
								#XPOSITION# #YPOSITION# #ANCHORPOSITION# hidden: #ISHIDDEN#, labelAlign: '#FIELDLABELALIGN#',
								#FIELDLABELWIDTH# allowBlank: #ALLOWBLANK#, cls: '#CSSCLASS#', disabled: #ISDISABLED#,
								#HEIGHT# #WIDTH#
								submitValue: #submitvalue#,
								listeners: {
									change: function(thiss,newVal) {
										if(newVal) {
											thiss.submitValue = true;
										} else {
											thiss.submitValue = false;
										}
									}
								},
								margin: #MARGIN#, padding: #PADDING#,
								border: '#BORDER#',
								style: #STYLE#, id: #INPUTID#,readOnly: #ISREADONLY#,value: '#INPUTVALUE#',
								#VALIDATIONTYPE# #VTYPETEXT#
								#INPUTFORMAT# #MININPUTVALUE#
								#MAXINPUTVALUE#
							}
						</cfoutput>
					</cfsavecontent>
					<cfset groupItems = rereplace(groupItems,"[\t\n\f\r]","","all") />
					<cfset arrayappend(evaluate("items#COLUMNGROUP#"), groupItems) >
					<cfset "groupStruct.__#COLUMNGROUP#" =  evaluate("items#COLUMNGROUP#") >

				<cfelseif XTYPE EQ "textareafield"> <!---textareafield--->

					<cfsavecontent variable="groupItems" >
						<cfoutput>
							{	xtype: 'textareafield',fieldLabel: '#FIELDLABEL#', name: '#LEVELID#__#TABLENAME#__#COLUMNNAME#',
								#XPOSITION# #YPOSITION# #ANCHORPOSITION# hidden: #ISHIDDEN#, labelAlign: '#FIELDLABELALIGN#',
								#FIELDLABELWIDTH# allowBlank: #ALLOWBLANK#, cls: '#CSSCLASS#', disabled: #ISDISABLED#,
								#HEIGHT# #WIDTH# minLength: #MINCHARLENGTH#,
								maxLength: #MAXCHARLENGTH#,
								margin: #MARGIN#,
								padding: #PADDING#,
								border: '#BORDER#',
								style: #STYLE#, id: #INPUTID#,readOnly: #ISREADONLY#,value: '#INPUTVALUE#',
								#VALIDATIONTYPE# #VTYPETEXT#
								fieldStyle: '#INPUTFORMATB#'
							}
						</cfoutput>
					</cfsavecontent>
					<cfset groupItems = rereplace(groupItems,"[\t\n\f\r]","","all") />
					<cfset arrayappend(evaluate("items#COLUMNGROUP#"), groupItems) >
					<cfset "groupStruct.__#COLUMNGROUP#" =  evaluate("items#COLUMNGROUP#") >

				<cfelseif XTYPE EQ "htmleditor"> <!---htmleditor--->

					<cfsavecontent variable="groupItems" >
						<cfoutput>
							{	xtype: 'htmleditor',fieldLabel: '#FIELDLABEL#', name: '#LEVELID#__#TABLENAME#__#COLUMNNAME#',
								#XPOSITION# #YPOSITION# #ANCHORPOSITION# hidden: #ISHIDDEN#, labelAlign: '#FIELDLABELALIGN#',
								#FIELDLABELWIDTH# allowBlank: #ALLOWBLANK#, cls: '#CSSCLASS#', disabled: #ISDISABLED#,
								#HEIGHT# #WIDTH# minLength: #MINCHARLENGTH#,
								maxLength: #MAXCHARLENGTH#,
								margin: #MARGIN#, padding: #PADDING#, border: '#BORDER#',
								style: #STYLE#, id: #INPUTID#,readOnly: #ISREADONLY#,value: '#INPUTVALUE#',
								#VALIDATIONTYPE# #VTYPETEXT# labelStyle: '#INPUTFORMATB#'
							}
						</cfoutput>
					</cfsavecontent>
					<cfset groupItems = rereplace(groupItems,"[\t\n\f\r]","","all") />
					<cfset arrayappend(evaluate("items#COLUMNGROUP#"), groupItems) >
					<cfset "groupStruct.__#COLUMNGROUP#" =  evaluate("items#COLUMNGROUP#") >

				<cfelseif XTYPE EQ "displayfield"> <!---displayfield--->

					<cfsavecontent variable="groupItems" >
						<cfoutput>
							{	xtype: 'displayfield',fieldLabel: '#FIELDLABEL#', name: '#LEVELID#__#TABLENAME#__#COLUMNNAME#',
								#XPOSITION# #YPOSITION#
								#ANCHORPOSITION# hidden: #ISHIDDEN#, labelAlign: '#FIELDLABELALIGN#',
								#FIELDLABELWIDTH#
								allowBlank: #ALLOWBLANK#,  cls: '#CSSCLASS#', disabled: #ISDISABLED#,
								#HEIGHT# #WIDTH#
								margin: #MARGIN#,
								padding: #PADDING#,
								border: '#BORDER#',
								style: #STYLE#, id: #INPUTID#,readOnly: #ISREADONLY#,value: '#INPUTVALUE#',
								renderer: '#RENDERER#',
								fieldStyle: '#INPUTFORMATB#'
							}
						</cfoutput>
					</cfsavecontent>
					<cfset groupItems = rereplace(groupItems,"[\t\n\f\r]","","all") />
					<cfset arrayappend(evaluate("items#COLUMNGROUP#"), groupItems) >
					<cfset "groupStruct.__#COLUMNGROUP#" =  evaluate("items#COLUMNGROUP#") >

				<cfelseif XTYPE EQ "filefield"> <!---filefield--->
					<cfset withfileField = "true" >
					<cfset fileCount = fileCount + 1 >

					<cfsavecontent variable="groupItems" >
						<cfoutput>
							{	xtype: 'filefield',value: '#INPUTVALUE#',fieldLabel: '#FIELDLABEL#',name: 'file#fileCount#',
								#XPOSITION##YPOSITION##ANCHORPOSITION# hidden: #ISHIDDEN#, labelAlign: '#FIELDLABELALIGN#',
								#FIELDLABELWIDTH# allowBlank: #ALLOWBLANK#, cls: '#CSSCLASS#', disabled: #ISDISABLED#,
								#HEIGHT# #WIDTH# minLength: #MINCHARLENGTH#,
								maxLength: #MAXCHARLENGTH#,
								margin: #MARGIN#, padding: #PADDING#,
								border: '#BORDER#', style: #STYLE#, id: #INPUTID#,readOnly: #ISREADONLY#,
								#VALIDATIONTYPE# #VTYPETEXT#
								fieldStyle: '#INPUTFORMATB#'
							},{ xtype: 'hiddenfield',//for file////please do not remove
								name: '#LEVELID#__#TABLENAME#__#COLUMNNAME#',value: 'forfileonlyaaazzz#TABLENAME#__#fileCount#',fieldLabel: '#FIELDLABEL#',
								#XPOSITION#
								#YPOSITION#
								#ANCHORPOSITION#  hidden: #ISHIDDEN#, labelAlign: '#FIELDLABELALIGN#',
								#FIELDLABELWIDTH# cls: '#CSSCLASS#', disabled: #ISDISABLED#,
								#HEIGHT# #WIDTH# minLength: #MINCHARLENGTH#,
								maxLength: #MAXCHARLENGTH#,
								margin: #MARGIN#, padding: #PADDING#,
								border: '#BORDER#',
								style: #STYLE#, #VALIDATIONTYPE#
								#VTYPETEXT#
								fieldStyle: '#INPUTFORMATB#'
							}
						</cfoutput>
					</cfsavecontent>
					<cfset groupItems = rereplace(groupItems,"[\t\f]","","all") />
					<cfset arrayappend(evaluate("items#COLUMNGROUP#"), groupItems) >
					<cfset "groupStruct.__#COLUMNGROUP#" =  evaluate("items#COLUMNGROUP#") >

				<cfelseif XTYPE EQ "hiddenfield"> <!---hiddenfield--->

					<cfsavecontent variable="groupItems" >
						<cfoutput>
							{	xtype: 'hiddenfield',fieldLabel: '#FIELDLABEL#', name: '#LEVELID#__#TABLENAME#__#COLUMNNAME#',
								#XPOSITION# #YPOSITION# #ANCHORPOSITION# hidden: #ISHIDDEN#, labelAlign: '#FIELDLABELALIGN#',
								#FIELDLABELWIDTH# allowBlank: #ALLOWBLANK#, cls: '#CSSCLASS#',  disabled: #ISDISABLED#,
								#HEIGHT#
								#WIDTH#
								margin: #MARGIN#,
								padding: #PADDING#,
								border: '#BORDER#',
								style: #STYLE#, id: #INPUTID#,readOnly: #ISREADONLY#,value: '#INPUTVALUE#',
								fieldStyle: '#INPUTFORMATB#'
							}
						</cfoutput>
					</cfsavecontent>
					<cfset groupItems = rereplace(groupItems,"[\t\n\f\r]","","all") />
					 <cfset arrayappend(evaluate("items#COLUMNGROUP#"), groupItems) >
					 <cfset "groupStruct.__#COLUMNGROUP#" =  evaluate("items#COLUMNGROUP#") >

				<cfelseif XTYPE EQ "id"> <!---id textfield--->

					<cfsavecontent variable="groupItems" >
						<cfoutput>
							{	xtype: 'textfield',//used to convert to display field
								fieldLabel: '#FIELDLABEL#',  name: '#LEVELID#__#TABLENAME#__#COLUMNNAME#',
								#XPOSITION# #YPOSITION# #ANCHORPOSITION# hidden: #ISHIDDEN#,
								labelAlign: '#FIELDLABELALIGN#', #FIELDLABELWIDTH#
								allowBlank: #ALLOWBLANK#, cls: '#CSSCLASS#',
								disabled: #ISDISABLED#,
								#HEIGHT#
								#WIDTH#
								minLength: #MINCHARLENGTH#,
								maxLength: #MAXCHARLENGTH#,
								margin: #MARGIN#,
								padding: #PADDING#,
								border: '#BORDER#',
								style: #STYLE#, id: #INPUTID#,readOnly: #ISREADONLY#,value: '#INPUTVALUE#',
								#VALIDATIONTYPE# #VTYPETEXT#
								fieldStyle: '#INPUTFORMATB#'
							}
						</cfoutput>
					</cfsavecontent>
					<cfset groupItems = rereplace(groupItems,"[\t\f]","","all") />
					<cfset arrayappend(evaluate("items#COLUMNGROUP#"), groupItems) >
					<cfset "groupStruct.__#COLUMNGROUP#" =  evaluate("items#COLUMNGROUP#") >

				<cfelseif XTYPE EQ "signature"> <!---canvas signature custom field--->

					<cfset inputidnoquote = replace(INPUTID,"'","","all") >

					<cfsavecontent variable="groupItems" >
						{
				            xtype: 'panel',
				            id: <cfoutput>'sp#inputidnoquote#'</cfoutput>,
				            padding: 5,
				            height: 200,
				            listeners: {
				            	afterrender: function(dpanel) {
				            		try {
					            		var c = _myAppGlobal.getController('form.Signature');
					            		<cfoutput>
					            		c.onPanelRendered(dpanel, 'sig#inputidnoquote#', 'save#inputidnoquote#', 'clear#inputidnoquote#', #INPUTID# );
					            		</cfoutput>
					            	} catch(e)  {
					            		console.log('error in signature');
				            			console.log(e);
				            		}
				            	}
				            },
				            cls: '<cfoutput>#CSSCLASS#</cfoutput>',
				            html: "<canvas id='<cfoutput>sig#inputidnoquote#</cfoutput>' width='600' height='200'>no canvas support</canvas>"
				        },
				       <cfoutput>
				        {
				            xtype: 'button',
				            text: 'Save Signature',
				            action: 'save#inputidnoquote#',
				            margin: #MARGIN#,
				            padding: #PADDING#,
				            disabled: true,
				            handler: function(btn) {
				            	var c = _myAppGlobal.getController('form.Signature');
				            	c.onSaveSignature(btn,'sig#inputidnoquote#',#INPUTID#);
				            }
				       },{
				            xtype: 'button',
				            margin: #MARGIN#,
				            padding: #PADDING#,
				            text: 'Clear Signature',
				            action: 'clear#inputidnoquote#',
				            handler: function(btn) {
				            	var c = _myAppGlobal.getController('form.Signature');
				            	c.onClearSignature(btn,'sig#inputidnoquote#',#INPUTID#);
				            }
				        }
				        </cfoutput>
					</cfsavecontent>

					<cfset groupItems = rereplace(groupItems,"[\t\n\f\r]","","all")/>
					<cfset arrayappend(evaluate("items#COLUMNGROUP#"), groupItems) >
					<cfset "groupStruct.__#COLUMNGROUP#" =  evaluate("items#COLUMNGROUP#") >

				<cfelseif XTYPE EQ "checkboxgroup"> <!---checkboxgroup--->

					<cfset checkArr = ArrayNew(1) >
					<cfif trim(UNCHECKEDVALUE) eq "" >
						<cfset UNCHECKEDVALUE = 0 >
					</cfif>
					<cftry>
						<cfif ListLen(CHECKITEMS, ";") GT 0 >
							<cfloop list="#CHECKITEMS#" index="checklist" delimiters=";" >

								<cfset arrayappend(checkArr, "{boxLabel: '#listgetat(checklist,1)#',name: '#LEVELID#__#TABLENAME#__#COLUMNNAME#',cls: #INPUTID#,readOnly: #ISREADONLY#,inputValue: '#listgetat(checklist,2)#', uncheckedValue: #UNCHECKEDVALUE# }") >
							</cfloop> <!---end CHECKITEMS--->
						<cfelse>
						</cfif> <!---end ListLen--->
					<cfcatch>
							<cfthrow message="Checkbox format in #COLUMNNAME# is incorrect '#CHECKITEMS#'. Please follow the guidelines accordingly.">
					</cfcatch>
					</cftry>

					<cfset checkItems  = ArrayToList(checkArr) >

					<cfsavecontent variable="groupItems" >
						<cfoutput>
							{	xtype: 'checkboxgroup',vertical: true,fieldLabel: '#FIELDLABEL#',
								#XPOSITION# #YPOSITION#  #ANCHORPOSITION# hidden: #ISHIDDEN#, labelAlign: '#FIELDLABELALIGN#',
								#FIELDLABELWIDTH#
								allowBlank: #ALLOWBLANK#, cls: '#CSSCLASS#', disabled: #ISDISABLED#,
								#HEIGHT# #WIDTH# id: #INPUTID#,
								margin: #MARGIN#,
								padding: #PADDING#,
								border: '#BORDER#',
								style: #STYLE#,
								columns: #NOOFCOLUMNS#,
								items: [#checkItems# ]
							}
						</cfoutput>
					</cfsavecontent>
					<cfset groupItems = rereplace(groupItems,"[\t\n\f\r]","","all") />
					<cfset arrayappend(evaluate("items#COLUMNGROUP#"), groupItems) >
					<cfset "groupStruct.__#COLUMNGROUP#" =  evaluate("items#COLUMNGROUP#") >

					<cfset arrayclear(checkArr) >

				<cfelseif XTYPE EQ "radiogroup">  <!---radio group--->

					<cfset checkArr = ArrayNew(1) >
					<cfif trim(UNCHECKEDVALUE) eq "" >
						<cfset UNCHECKEDVALUE = 0 >
					</cfif>
					<cftry>
						<cfif ListLen(CHECKITEMS, ";") GT 0 >
							<cfloop list="#CHECKITEMS#" index="checklist" delimiters=";" >
								<cfset arrayappend(checkArr, "{boxLabel: '#listgetat(checklist,1)#',name: '#LEVELID#__#TABLENAME#__#COLUMNNAME#',cls: #INPUTID#,readOnly: #ISREADONLY#,inputValue: '#listgetat(checklist,2)#',uncheckedValue: #UNCHECKEDVALUE#    }") >
							</cfloop> <!---end CHECKITEMS--->
						<cfelse>
						</cfif> <!---end ListLen--->
					<cfcatch>
							<cfthrow message="RadioGroup format in #COLUMNNAME# is incorrect '#CHECKITEMS#'. Please follow the guidelines accordingly.">
					</cfcatch>
					</cftry>

					<cfset checkItems  = ArrayToList(checkArr) >

					<cfsavecontent variable="groupItems" >
						<cfoutput>
							{	xtype: 'radiogroup',vertical: true,fieldLabel: '#FIELDLABEL#',
								#XPOSITION#
								#YPOSITION#
								#ANCHORPOSITION# hidden: #ISHIDDEN#, labelAlign: '#FIELDLABELALIGN#',
								#FIELDLABELWIDTH# allowBlank: #ALLOWBLANK#, cls: '#CSSCLASS#',
								disabled: #ISDISABLED#,
								#HEIGHT#
								#WIDTH# id: #INPUTID#, margin: #MARGIN#,
								padding: #PADDING#,
								border: '#BORDER#',
								style: #STYLE#,
								columns: #NOOFCOLUMNS#,
								items: [#checkItems# ]
							}
						</cfoutput>
					</cfsavecontent>
					<cfset groupItems = rereplace(groupItems,"[\t\n\f\r]","","all") />
					<cfset arrayappend(evaluate("items#COLUMNGROUP#"), groupItems) >
					<cfset "groupStruct.__#COLUMNGROUP#" =  evaluate("items#COLUMNGROUP#") >

					<cfset arrayclear(checkArr) >

				<cfelseif XTYPE EQ "grid"> <!---Grid Panel--->
					<cfif gridLowestIndex eq 0 >
						<cfset gridLowestIndex = ArrayLen(evaluate("items#COLUMNGROUP#")) >
						<cfset arrayappend(evaluate("items#COLUMNGROUP#"), "") >
					</cfif>
					    <cfset ArrayAppend(gridColumnID, INPUTID) >
						<cfset ArrayAppend(gridColumnName, COLUMNNAME) >
						<cfset ArrayAppend(gridColumnType, COLUMNTYPE) >
						<cfset ArrayAppend(gridColumnCls, CSSCLASS) >
						<cfset ArrayAppend(gridColumnText, FIELDLABEL) >
						<cfset ArrayAppend(gridGroup, COLUMNGROUP) >
						<cfset ArrayAppend(gridColumnAlign, FIELDLABELALIGN) >
						<cfset ArrayAppend(gridColumnBorder, BORDER) >
						<cfset ArrayAppend(gridColumnStyle, STYLE) >
						<cfset ArrayAppend(gridColumnAnchor, ANCHORPOSITION) >
						<cfset ArrayAppend(gridColumnHidden, ISHIDDEN) >
						<cfset ArrayAppend(gridHeight, HEIGHT) >
						<cfset ArrayAppend(gridWidth, WIDTH) >
						<cfset ArrayAppend(gridMargin, MARGIN) >
						<cfset ArrayAppend(gridPadding, PADDING) >
						<cfset ArrayAppend(gridSummary, INPUTVALUE) >
						<cfset ArrayAppend(gridDisabled, ISDISABLED) >
						<cfset ArrayAppend(gridColumnRenderer, RENDERER) >

						<!---Used for editor--->
						<cfset ArrayAppend(gridColumnReadOnly, ISREADONLY) >
						<cfset ArrayAppend(gridColumnVType, VALIDATIONTYPE) >
						<cfset ArrayAppend(gridColumnVText, VTYPETEXT) >
						<cfset ArrayAppend(gridColumnAllowBlank, ALLOWBLANK) >
						<cfset ArrayAppend(gridColumnIsBooleanType, ISCHECKED) >
						<cfset ArrayAppend(gridColumnMinVal, MININPUTVALUE) >
						<cfset ArrayAppend(gridColumnMaxVal, MAXINPUTVALUE) >
						<cfset ArrayAppend(gridColumnMinChar, MINCHARLENGTH) >
						<cfset ArrayAppend(gridColumnMaxChar, MAXCHARLENGTH) >
						<cfset ArrayAppend(gridColumnUncheckedVal, UNCHECKEDVALUE) >
						<cfset ArrayAppend(gridColumnLocalData, COMBOLOCALDATA) >
						<cfset ArrayAppend(gridColumnRemoteData, COMBOREMOTEDATA) >
						<cfset ArrayAppend(gridColumnFormat, INPUTFORMAT) >
						<cfset ArrayAppend(gridColumnEditableOnRoute, EDITABLEONROUTENO) >

				<!---End Grid Panel--->

				<cfelseif XTYPE EQ "combobox"> <!---combobox--->

					<cfset querymode = 'local' >
					<cfset minchars = ''>
					<cfset pagesize = '' >

					<cfif trim(COMBOLOCALDATA) NEQ "">

						<cfset comboArr = ArrayNew(1) >
						<cftry>
							<cfif ListLen(COMBOLOCALDATA, ";") GT 0 >
								<cfloop list="#COMBOLOCALDATA#" index="combolist" delimiters=";" >
									<cfif ListLen(combolist, ",") EQ 2 >
									<cfset arrayappend(comboArr, "{displayname: '#listgetat(combolist,1)#',codename: '#listgetat(combolist,2)#'}") >
									<cfelse>

									</cfif>
								</cfloop> <!---end CHECKITEMS--->
							<cfelse>
							</cfif> <!---end ListLen--->
						<cfcatch>
							<cfthrow message="Combobox format in #COLUMNNAME# is incorrect '#COMBOLOCALDATA#'. Please follow the guidelines accordingly.">
						</cfcatch>
						</cftry>

					    <cfset comboLocaldataItems  = ArrayToList(comboArr) >
						<cfset columnModelStore[cntStore] = "var #TABLENAME##COLUMNNAME# = Ext.create('Ext.data.Store', { fields: ['displayname', 'codename'], data : [ #comboLocaldataItems# ]});" >

						<cfset arrayclear(comboArr) >


					<cfelseif trim(COMBOREMOTEDATA) NEQ "">

						<cfset minchars = 'minChars: 1,'>
						<cfset pagesize = 'pageSize: 30,' >
						<cfset theTable 				= "" >
						<cfset theDisplayColumns 		= "" >
						<cfset theValueColumn 			= "" >
						<cfset theColumnItDepends 		= "" >
						<cfset theColumnItDependsValue 	= "" >

						<cftry>
							<cfif ListLen(COMBOREMOTEDATA, ";") GT 0 >
								<cfset theTable 				= ListGetAt(COMBOREMOTEDATA, 1, ";") >
								<cfset theDisplayColumns 		= ListGetAt(COMBOREMOTEDATA, 2, ";") >
								<cfset theValueColumn 			= ListGetAt(COMBOREMOTEDATA, 3, ";") >
								<cftry>
									<cfset theColumnItDepends 		= ListGetAt(COMBOREMOTEDATA, 4, ";") >
									<cfcatch>
										<cfset theColumnItDepends 		= " " >
									</cfcatch>
								</cftry>

								<cftry>
									<cfset columnOrder 		= ListGetAt(COMBOREMOTEDATA, 5, ";") >
									<cfcatch>
										<cfset columnOrder 		= " " >
									</cfcatch>
								</cftry>

								<cftry>
									<cfset pages = ListGetAt(COMBOREMOTEDATA, 6, ";") >
									<cfset pagesize 		= "pageSize: #pages#," >
									<cfcatch></cfcatch>
								</cftry>

								<cfset theColumnItDependsValue 	= " " >

							<cfelse>
							</cfif> <!---end ListLen--->
						<cfcatch>
							<cfthrow message="Combobox format in #COLUMNNAME# is incorrect '#COMBOREMOTEDATA#'. Please follow the guidelines accordingly.">
						</cfcatch>
						</cftry>
						<cfsavecontent variable="rStore" >
							<cfoutput>
								var #TABLENAME##COLUMNNAME# = Ext.create('Ext.data.Store', {
									fields: ['displayname', 'codename'],
									autoLoad: false,
									listeners: {
										beforeload: function(thiss,operation,eopts) {
											var theValue = new Array();
											var dependCol = '#theColumnItDepends#';
											if(dependCol != ' ') {
												dependCol = dependCol.split(',');
												for(thecntr=0;thecntr<dependCol.length;thecntr++) {
													var specCol = dependCol[thecntr];
													var resultQuery = eForm.query('field[name$=' + specCol + ']');
													if(resultQuery[0].inputValue) {
														var resultQueryB = eForm.query('field[name$=' + specCol + '][checked=true]');
														theValue.push(resultQueryB[0].inputValue);
													} else {
														theValue.push(resultQuery[0].value);
													}
												}
												thiss.proxy.extraParams.columnDependValues = theValue.toString();
											} else {
												return true;
											}
										}
									},
									#pagesize#
									proxy: {
										type: 'direct',
										timeout: 300000,
										extraParams: {
											tablename: '#theTable#',
											columnDisplay: '#theDisplayColumns#',
											columnValue: '#theValueColumn#',
											columnDepends: '#theColumnItDepends#',
											columnDependValues: ' ',
											columnOrder: '#columnOrder#'
										},
										directFn: 'Ext.ss.lookup.formQueryLookup',
										paramOrder: ['limit', 'page', 'query', 'start', 'tablename', 'columnDisplay', 'columnValue','columnDepends','columnDependValues','columnOrder'],
										reader: {
											root: 'topics',
											totalProperty: 'totalCount'
										}
									}
								});
							</cfoutput>
						</cfsavecontent>
						<cfset rStore = rereplace(rStore,"[\t\n\f\r]","","all") />
						<cfset columnModelStore[cntStore] = rStore >
						<cfset querymode = 'remote' >
					<cfelse>
						<cfset columnModelStore[cntStore] = "var #TABLENAME##COLUMNNAME# = Ext.create('Ext.data.Store', { fields: ['displayname', 'codename'],  data : [{displayname: ' ',codename: ' '}  ]});" >
					</cfif>

					<cfset cntStore = cntStore + 1 >
					<cfsavecontent variable="groupItems" >
						<cfoutput>
							{	xtype: 'combobox', displayField: 'displayname',
								valueField: 'codename',
								queryMode: '#querymode#',
								store: #TABLENAME##COLUMNNAME#,
								#minchars# #pagesize#
								fieldLabel: '#FIELDLABEL#',
								name: '#LEVELID#__#TABLENAME#__#COLUMNNAME#',
								#XPOSITION# #YPOSITION#
								#ANCHORPOSITION# hidden: #ISHIDDEN#,  labelAlign: '#FIELDLABELALIGN#',
								#FIELDLABELWIDTH# allowBlank: #ALLOWBLANK#,
								cls: '#CSSCLASS#', disabled: #ISDISABLED#,
								#HEIGHT#
								#WIDTH#
								minLength: #MINCHARLENGTH#,
								maxLength: #MAXCHARLENGTH#,
								margin: #MARGIN#,
								padding: #PADDING#,
								border: '#BORDER#',
								style: #STYLE#, id: #INPUTID#,readOnly: #ISREADONLY#,value: '#INPUTVALUE#',
								#VALIDATIONTYPE#  #VTYPETEXT#
								fieldStyle: '#INPUTFORMATB#'
							}
						</cfoutput>
					</cfsavecontent>
					<cfset groupItems = rereplace(groupItems,"[\t\n\f\r]","","all") />
					<cfset arrayappend(evaluate("items#COLUMNGROUP#"), groupItems) >
					<cfset "groupStruct.__#COLUMNGROUP#" =  evaluate("items#COLUMNGROUP#") >

				<cfelse>

				</cfif>

			<cfset cntA = cntA + 1 >
			</cfloop> <!---end tableColumnData--->

			<!---Prepare grid if there is any--->


			<cfif gridLowestIndex gt 0 >
				<cfquery name="qryFormGridConfig" datasource="#session.global_dsn#" maxrows="1">
					SELECT *
					  FROM EGRGEFORMGRIDCONFIG
					 WHERE EFORMIDFK = '#eformid#' AND EFORMGROUP = '#gridGroup[1]#'
				</cfquery>



				<cfif qryFormGridConfig.recordcount gt 0  > <!---Grid Config was available--->
					<cfset NL = CreateObject("java", "java.lang.System").getProperty("line.separator")>
					<!--- select either local or remote grid not both --->
					<cfif qryFormGridConfig.QUERYMODE EQ "local"> <!--- local data was used --->
						<cfsavecontent variable="gridWLocalStore" >
							var <cfoutput>local#TABLENAME#</cfoutput> = Ext.create('Ext.data.Store', {
							    storeId: '<cfoutput>#qryFormGridConfig.STOREID#</cfoutput>',
							    	<cfif len(trim(qryFormGridConfig.GROUPFIELD)) gt 0>
							    groupField: '<cfoutput>#qryFormGridConfig.GROUPFIELD#</cfoutput>',
							    	</cfif>
								fields:[
										<cfloop from="1" to="#ArrayLen(gridColumnName)#" index="a">
											{
									    	   name: '<cfoutput>#replace(ListGetAt(qryFormGridConfig.FIELDS,a,','),'.','_','all')#</cfoutput>',
									    	   type: '<cfoutput>#gridColumnType[a]#</cfoutput>'
									    	}
									    	<cfif a neq ArrayLen(gridColumnName) >,</cfif>
									    </cfloop>
								],
							    data: {'items': [
							    	<cfset dataList = qryFormGridConfig.LOCALDATA[1] >
							    	<cfloop from="1" to="#ListLen(dataList,NL)#" index="lst" >
								    	{
								    		<cfset thisRowList = ListGetAt(dataList, lst, NL) >
								    		<cfloop from="1" to="#ListLen(thisRowList,',')#" index="b" >
									    		<cfoutput>#replace(ListGetAt(qryFormGridConfig.FIELDS,b,','),'.','_','all')#: '#ListGetAt(thisRowList,b,",")#' </cfoutput>
								    			<cfif b neq ListLen(thisRowList,',') >,</cfif>
											</cfloop>
										}
										<cfif lst neq ListLen(dataList,NL) >,</cfif>
									</cfloop>
							    ]},
							    proxy: {
							        type: 'memory',
							        reader: {
							            type: 'json',
							            root: 'items'
							        }
							    }
							    <cfif len(trim(qryFormGridConfig.STOREEXTRA)) gt 0>
								    ,<cfoutput>#qryFormGridConfig.STOREEXTRA#</cfoutput>
								</cfif>
								});
						</cfsavecontent>

					<cfelse> <!--- remoting data was used --->
						<cfsavecontent variable="gridWLocalStore" >
							var <cfoutput>local#TABLENAME#</cfoutput> = Ext.create('Ext.data.Store', {
								storeId: '<cfoutput>#qryFormGridConfig.STOREID#</cfoutput>',
								    <cfif len(trim(qryFormGridConfig.GROUPFIELD)) gt 0>
							    groupField: '<cfoutput>#qryFormGridConfig.GROUPFIELD#</cfoutput>',
							    	</cfif>
								fields:[
									 'EFORMID',
									 'COLUMNGROUP',
										<cfloop from="1" to="#ArrayLen(gridColumnName)#" index="a">
											{
									    	   name: '<cfoutput>#replace(ListGetAt(qryFormGridConfig.FIELDS,a,','),'.','_','all')#</cfoutput>',
									    	   type: '<cfoutput>#gridColumnType[a]#</cfoutput>'
									    	}
									    	<cfif a neq ArrayLen(gridColumnName) >,</cfif>
									    </cfloop>
								],
								remoteFilter: true,
								remoteSort: true,
								simpleSortMode: true,
								sorters: [{
							            property: '<cfoutput>#replace(qryFormGridConfig.SORTERSPROP,'.','_','all')#</cfoutput>',
							            direction: '<cfoutput>#qryFormGridConfig.SORTERSDIR#</cfoutput>'
							    }],
								filters: [{
										type: '<cfoutput>#replace(qryFormGridConfig.FILTERTYPE,'.','_','all')#</cfoutput>',
							            dataIndex: '<cfoutput>#qryFormGridConfig.FILTERPROP#</cfoutput>'
								}],
								pageSize: <cfoutput>#qryFormGridConfig.PAGESIZE#</cfoutput>,
								autoLoad: true,
								autoSync: true,
								autoDestroy: true,
								proxy: {
									type: 'direct',
									timeout: 300000,
									baseParams: {
								        bp: 'ksks'
								    },
									extraParams: {
										primarydocval: '_',
										eformid: '<cfoutput>#eformid#</cfoutput>',
										eformgroup: '<cfoutput>#gridGroup[1]#</cfoutput>'
									},
									paramOrder: ['page', 'start', 'limit', 'sort', 'filter', 'primarydocval', 'eformid', 'eformgroup'],
									api: {
								        read: Ext.ss.data.getFormGridData,
								        create: Ext.ss.data.eFormGridCreate,
								        update: Ext.ss.data.eFormGridUpdate,
								        destroy: Ext.ss.data.eFormGridDelete
								    },
									paramsAsHash: false,
									filterParam: 'filter',
									sortParam: 'sort',
									limitParam: 'limit',
									idParam: 'ID',
									pageParam: 'page',
									reader: {
							            root: 'topics',
							            totalProperty: 'totalCount'
							        }
								},
								listeners: {
									beforeLoad: function(thisSS) {
									   try {
									   		var theFormGrid = Ext.ComponentQuery.query('grid[id=<cfoutput>grid#qryFormGridConfig.STOREID#</cfoutput>]')[0];
									   		var theForm = theFormGrid.up('form');
									   		var primaryDocVal = theForm.down('textfield[name=<cfoutput>#firstlevel#__#firsttable#__#firstcolumn#</cfoutput>]').getValue();
									   	    thisSS.proxy.setExtraParam( 'primarydocval', primaryDocVal );
											return true;
									   } catch(err) {
									   	 console.log(err);
									   	 return false;
									   }
									}
								}
								<cfif len(trim(qryFormGridConfig.STOREEXTRA)) gt 0>
								    ,<cfoutput>#qryFormGridConfig.STOREEXTRA#</cfoutput>
								</cfif>
							});

						</cfsavecontent>

					</cfif> <!--- end query mode --->

						<cfset ghead = StructNew() >
						<cfsavecontent variable="gridColumns" >
						columns: [
							{
								text: 'EFORMID',
								dataIndex: 'EFORMID',
								hidden: true
							},{
								text: 'COLUMNGROUP',
								dataIndex: 'COLUMNGROUP',
								hidden: true
							},
						<cfloop from="1" to="#ArrayLen(gridColumnCls)#" index="d" >
							<cfif trim(gridColumnCls[d]) eq "" >
								{
									<cfinvoke method="setGridColumns" theIndex="#d#" />
								}
							<cfelse>
								<cfset aRes = StructFindValue(ghead,gridColumnCls[d]) >
							    <cfif ArrayLen(aRes) eq 0 >

								{
									text: '<cfoutput>#gridColumnCls[d]#</cfoutput>',
									columns: [
								<cfloop from="1" to="#ArrayLen(gridColumnCls)#" index="GHindex" >
									<cfif gridColumnCls[GHindex] eq gridColumnCls[d] >
									{
										<cfinvoke method="setGridColumns" theIndex="#GHindex#" />
									},
							    	</cfif> <!---end columns--->
							    </cfloop>
								]},
								<cfset ghead['#d#'] = gridColumnCls[d] >
							    </cfif> <!---end struct key exists--->
							    <cfcontinue>
							</cfif>

							<cfif d neq ArrayLen(gridColumnCls) >,</cfif>
						</cfloop>
						]
						</cfsavecontent>

						<cfsavecontent variable="gridPanel" >
							{
					  <cfoutput>xtype:'grid',action:'eformgrid',hidden:#qryFormGridConfig.HIDDEN#</cfoutput>,
								id: '<cfoutput>grid#qryFormGridConfig.STOREID#</cfoutput>',
								multiSelect: true,
								<cfif qryFormGridConfig.QUERYMODE EQ "remote">
								bbar: Ext.create('Ext.toolbar.Paging', {
							        store: <cfoutput>local#TABLENAME#</cfoutput>,
							        displayInfo: true,
							        emptyMsg: "No topics to display"
							    }),
								    <cfif qryFormGridConfig.ENABLEADD eq "true"
								    			OR qryFormGridConfig.ENABLEDELETE eq "true"
								    			OR qryFormGridConfig.ENABLEPRINT eq "true"
								    			OR qryFormGridConfig.ENABLEEXPORT eq "true"
								    			OR qryFormGridConfig.ENABLEEMAIL eq "true">
								    tbar: [
								    <cfif qryFormGridConfig.ENABLEADD eq "true" >
								    {
								    	text:'Add',action:'aboutgridrow',hidden:false,
								    	handler: function(btn) {
								    		var disGrid = btn.up('grid');
								    		<!---get autogenerated value--->
								    		var myMask = Ext.create('Ext.LoadMask',{
												target: disGrid,
												msg: "Initializing values..."
											});
											myMask.show();
											var theFormGrid = Ext.ComponentQuery.query('grid[id=<cfoutput>grid#qryFormGridConfig.STOREID#</cfoutput>]')[0];
									   		var theForm = theFormGrid.up('form');
									   		var primaryDocVal = theForm.down('textfield[name=<cfoutput>#firstlevel#__#firsttable#__#firstcolumn#</cfoutput>]').getValue();
											Ext.ss.data.initFormGridValue('<cfoutput>#eformid#</cfoutput>','<cfoutput>#gridGroup[1]#</cfoutput>',primaryDocVal,function(resp) {
												disGrid.getStore().insert(0, resp);
			    								disGrid.view.refresh();
												myMask.hide();
											});

								    	}
								    },
								    </cfif>
								    <cfif qryFormGridConfig.ENABLEDELETE eq "true" >
								    {
								    	text: 'Delete',action:'aboutgridrow',hidden:false,
		    							handler: function(btn) {
		    								Ext.Msg.confirm('Delete Items', 'Are you sure you want to delete the selected items?',function(res) {
		    									if(res == 'yes') {
			    									var disGrid = btn.up('grid');
				    								disGrid.getStore().remove(disGrid.getSelectionModel().getSelection());
				    								disGrid.getView().refresh();
			    								}
		    								});

								    	}
								    },
								    </cfif>
								    <cfif qryFormGridConfig.ENABLECOPY eq "true" >
								    {
								    	text: 'Copy',action:'aboutgridrow',hidden:false,
		    							handler: function(btn) {
								    		Ext.Msg.prompt('Copy Selection', 'Please enter the destination\'s document number:', function(resp, text){
											    if (resp == 'ok'){
											    	var disGrid = btn.up('grid');
											    	var selData = disGrid.getSelectionModel().getSelection();
											    	console.log(selData);
											    	if(selData.length > 0) {
											    		<!---get autogenerated value--->
											    		var myMask = Ext.create('Ext.LoadMask',{
															target: disGrid,
															msg: "Initializing values..."
														});
														myMask.show();
														var theFormGrid = Ext.ComponentQuery.query('grid[id=<cfoutput>grid#qryFormGridConfig.STOREID#</cfoutput>]')[0];
												   		var theForm = theFormGrid.up('form');
												   		var primaryDocVal = theForm.down('textfield[name=<cfoutput>#firstlevel#__#firsttable#__#firstcolumn#</cfoutput>]').getValue();
											    		for(cnt=0; cnt<selData.length; cnt++) {
											    			var dataToCopy = selData[cnt].data;
											    			Ext.ss.data.initFormGridValue('<cfoutput>#eformid#</cfoutput>','<cfoutput>#gridGroup[1]#</cfoutput>',primaryDocVal,function(resp) {
																<!---1 index for id, 2 index for docnumber--->
																<cfset mainidname = replace(ListGetAt(qryFormGridConfig.FIELDS,1,','),'.','_','all') >
																dataToCopy.<cfoutput>#mainidname#</cfoutput> = resp.<cfoutput>#mainidname#</cfoutput>;
																dataToCopy.<cfoutput>#replace(ListGetAt(qryFormGridConfig.FIELDS,2,','),'.','_','all')#</cfoutput> = text;
																disGrid.getStore().insert(0, dataToCopy);
							    								disGrid.view.refresh();
																myMask.hide();
															});
											    		}
											    	} else {
											    		alert('No selection.');
											    	}
											    	return true;
										    	}
											});
								    	}
								    },
								    </cfif>
								    <cfif qryFormGridConfig.ENABLEPRINT eq "true" >
								    {
								    	text: 'Print',action:'aboutgridrow',hidden:false,
		    							handler: function(btn) {
								    		var gridPanel = btn.up('grid');
								    		Ext.ux.grid.Printer.print(gridPanel);
								    	}
								    },
								    </cfif>
								    <cfif qryFormGridConfig.ENABLEEXPORT eq "true" >
								    {
								    	text: 'Export to excel',action:'aboutgridrow',hidden:false,
		    							handler: function(btn) {
		    								var theFormGrid = Ext.ComponentQuery.query('grid[id=<cfoutput>grid#qryFormGridConfig.STOREID#</cfoutput>]')[0];
									   		var theForm = theFormGrid.up('form');
									   		var primaryDocVal = theForm.down('textfield[name=<cfoutput>#firstlevel#__#firsttable#__#firstcolumn#</cfoutput>]').getValue();
								    		Ext.ss.data.gridtoexcel('<cfoutput>#eformid#</cfoutput>','<cfoutput>#gridGroup[1]#</cfoutput>',primaryDocVal,function(result) {
								    			console.log(result);
								    			if(result == "success") {
													window.location.href = "./myapps/form/simulator/tableData.xls";
												} else {
													Ext.Msg.show({
										  				title: 'Export problem',
										  				msg: 'Please try again.',
										  				buttons: Ext.Msg.OK,
										  				icon: Ext.Msg.WARNING
										  			});
													return true;
												}
								    		});
								    	}
								    },
								    </cfif>
								    ],
								    </cfif>
								</cfif>
								features: [
								{
									ftype: 'filters',
									<cfif qryFormGridConfig.QUERYMODE EQ "remote">
									encode: true,
									local: false
									<cfelse>
									local: true
									</cfif>
								},
								<cfif trim(qryFormGridConfig.ISSUMMARY) eq "true">
								{
							        ftype: 'summary',
							        dock: '<cfoutput>#qryFormGridConfig.SUMMARYDOCK#</cfoutput>',
							        showSummaryRow: <cfoutput>#qryFormGridConfig.SUMMARYSHOWSUMMARYROW#</cfoutput>
							    },
							    </cfif>
							    <cfif trim(qryFormGridConfig.ISGROUPING) eq "true">
								{
							        ftype: 'grouping',
							        collapsible: <cfoutput>#qryFormGridConfig.GROUPINGCOLLAPSIBLE#</cfoutput>,
							        enableNoGroups: <cfoutput>#qryFormGridConfig.GROUPINGENABLENOGROUP#</cfoutput>,
							        hideGroupedHeader: <cfoutput>#qryFormGridConfig.GROUPINGHIDEGROUPEDHEADER#</cfoutput>,
							        showGroupsText: '<cfoutput>#qryFormGridConfig.GROUPINGSHOWGROUPSTEXT#</cfoutput>',
							        showSummaryRow: <cfoutput>#qryFormGridConfig.GROUPINGSHOWSUMMARYROW#</cfoutput>,
							        startCollapsed: <cfoutput>#qryFormGridConfig.GROUPINGSTARTCOLLAPSED#</cfoutput>
							        <cfoutput>#qryFormGridConfig.GROUPINGEXTRA#</cfoutput>
							    },
							    </cfif>
							    <cfif trim(qryFormGridConfig.ISGROUPINGSUMMARY) eq "true">
								{
							        ftype: 'groupingsummary',
							        collapsible: <cfoutput>#qryFormGridConfig.GSUMMARYCOLLAPSIBLE#</cfoutput>,
							        enableNoGroups: <cfoutput>#qryFormGridConfig.GSUMMARYENABLENOGROUP#</cfoutput>,
							        hideGroupedHeader: <cfoutput>#qryFormGridConfig.GSUMMARYHIDEGROUPEDHEADER#</cfoutput>,
							        showGroupsText: '<cfoutput>#qryFormGridConfig.GSUMMARYSHOWGROUPSTEXT#</cfoutput>',
							        showSummaryRow: <cfoutput>#qryFormGridConfig.GSUMMARYSHOWSUMMARYROW#</cfoutput>,
							        startCollapsed: <cfoutput>#qryFormGridConfig.GSUMMARYSTARTCOLLAPSED#</cfoutput>
							    },
							    </cfif>
							    <cfif trim(qryFormGridConfig.ISROWBODY) eq "true">
								{
							        ftype: 'rowbody',
							        <cfif trim(qryFormGridConfig.ROWEXPANDERROWBODYTPL) neq "" >
							        	setupRowData: <cfoutput>#qryFormGridConfig.ROWBODYSETUPROWDATA#</cfoutput>
							        </cfif>
							        <cfoutput>#qryFormGridConfig.ROWBODYEXTRA#</cfoutput>
							    },
							    </cfif>
							    ],
							    plugins: [
							    {
							    	ptype: 'cellediting',
							    	clicksToEdit: 2,
							    	id: 'celleditid',
							    	listeners: {
							    		validateedit: function(editor,e) {
							    			if(e.originalValue == e.value) {
							    				return false;
							    			}
							    			var res = window.confirm("Save Changes? \n\nOriginal value: " + e.originalValue + "\nNew Value: " + e.value);
							    			if(res) {
												return true;
											} else {
												return false;
											}
							    		}
							    	}
							    },
							    <cfif trim(qryFormGridConfig.ISROWEXPANDER) eq "true">
								{
									ptype: 'rowexpander',
							        <cfif trim(qryFormGridConfig.ROWEXPANDERROWBODYTPL) neq "" >
							        	rowBodyTpl: <cfoutput>#qryFormGridConfig.ROWEXPANDERROWBODYTPL#</cfoutput>,
							        <cfelse>
							        	rowBodyTpl: new Ext.XTemplate(
							        		<cfloop from="1" to="#ArrayLen(gridColumnName)#" index="a">
											'<p><b><cfoutput>#gridColumnText[a]#</cfoutput>:</b> {<cfoutput>#replace(ListGetAt(qryFormGridConfig.FIELDS,a,','),'.','_','all')#</cfoutput>} </p>'
										    	<cfif a neq ArrayLen(gridColumnName) >,</cfif>
										    </cfloop>
									    ),
							        </cfif>
							        expandOnDblClick: <cfoutput>#qryFormGridConfig.ROWEXPANDEREXPANDONDBLCLICK#</cfoutput>,
							        expandOnEnter: <cfoutput>#qryFormGridConfig.ROWEXPANDEREXPANDONENTER#</cfoutput>,
							        selectRowOnExpand: <cfoutput>#qryFormGridConfig.ROWEXPANDERSELECTROWONEXPAND#</cfoutput>
							        <cfoutput>#qryFormGridConfig.ROWEXPANDEREXTRA#</cfoutput>
							    }
							    </cfif>
							    ],
							    requires: [
							    <cfif trim(qryFormGridConfig.ISSUMMARY) eq "true">
									'Ext.grid.feature.Summary',
							    </cfif>
							    <cfif trim(qryFormGridConfig.ISGROUPING) eq "true">
									'Ext.grid.feature.Grouping',
							    </cfif>
							    <cfif trim(qryFormGridConfig.ISGROUPINGSUMMARY) eq "true">
									'Ext.grid.feature.GroupingSummary',
							    </cfif>
							    <cfif trim(qryFormGridConfig.ISROWEXPANDER) eq "true">
									'Ext.grid.plugin.RowExpander',
							    </cfif>
							    <cfif trim(qryFormGridConfig.ISROWBODY) eq "true">
									'Ext.grid.feature.RowBody'
							    </cfif>
							    ],
							    selModel: {
					                preventFocus:true,
					                pruneRemoved: false
					            },
								store: <cfoutput>local#TABLENAME#</cfoutput>,
								title: '<cfoutput>#qryFormGridConfig.TITLE#</cfoutput>'
								<cfif len(trim(qryFormGridConfig.TITLEALIGN)) gt 0>
							    	,titleAlign: '<cfoutput>#qryFormGridConfig.TITLEALIGN#</cfoutput>'
							    </cfif>
								<cfif len(trim(qryFormGridConfig.MARGIN)) gt 0>
							    	,margin: '<cfoutput>#qryFormGridConfig.MARGIN#</cfoutput>'
							    </cfif>
							    <cfif len(trim(qryFormGridConfig.PADDING)) gt 0>
							    	,padding: '<cfoutput>#qryFormGridConfig.PADDING#</cfoutput>'
							    </cfif>
							    <cfif len(trim(qryFormGridConfig.WIDTH)) gt 0>
							    	,width: <cfoutput>#qryFormGridConfig.WIDTH#</cfoutput>
							    </cfif>
							    <cfif len(trim(qryFormGridConfig.HEIGHT)) gt 0>
							    	,height: <cfoutput>#qryFormGridConfig.HEIGHT#</cfoutput>
							    </cfif>
							    <cfif len(trim(qryFormGridConfig.COLUMNWIDTH)) gt 0>
							    	,columnWidth: <cfoutput>#qryFormGridConfig.COLUMNWIDTH#</cfoutput>
							    </cfif>
							    <cfif len(trim(qryFormGridConfig.COLLAPSIBLE)) gt 0>
							    	,collapsible: <cfoutput>#qryFormGridConfig.COLLAPSIBLE#</cfoutput>
							    </cfif>
							    <cfif len(trim(qryFormGridConfig.CLOSABLE)) gt 0>
							    	,closable: <cfoutput>#qryFormGridConfig.CLOSABLE#</cfoutput>
							    </cfif>
							    <cfif len(trim(qryFormGridConfig.COLLAPSED)) gt 0>
							    	,collapsed: <cfoutput>#qryFormGridConfig.COLLAPSED#</cfoutput>
							    </cfif>
							    <cfif len(trim(qryFormGridConfig.DISABLED)) gt 0>
							    	,disabled: <cfoutput>#qryFormGridConfig.DISABLED#</cfoutput>
							    </cfif>
								<cfif len(trim(qryFormGridConfig.CLS)) gt 0>
							    	,cls: '<cfoutput>#qryFormGridConfig.CLS#</cfoutput>'
							    </cfif>
								<cfif len(trim(qryFormGridConfig.STYLE)) gt 0>
							    	,style: {<cfoutput>#qryFormGridConfig.STYLE#</cfoutput>}
							    </cfif>
								<cfif len(trim(qryFormGridConfig.BORDER)) gt 0>
							    	,border: '<cfoutput>#qryFormGridConfig.BORDER#</cfoutput>'
							    </cfif>
							    ,<cfoutput>#rereplace(gridColumns,"[\t\n\f\r]","","all")#</cfoutput>
							    <cfif len(trim(qryFormGridConfig.GRIDEXTRAATTRIBUTES)) gt 0>
							    	,<cfoutput>#qryFormGridConfig.GRIDEXTRAATTRIBUTES#</cfoutput>
							    </cfif>
						    }
						</cfsavecontent>

						<cfset ArrayAppend(columnModelStore, rereplace(gridWLocalStore,"[\t\n\f\r]","","all")) >
						<cfset groupItems = rereplace(gridPanel,"[\t\n\f\r]","","all") >
						<cfset ArrayInsertAt(evaluate("items#COLUMNGROUP#"), gridLowestIndex+1, groupItems) >
						<cfset "groupStruct.__#COLUMNGROUP#" =  evaluate("items#COLUMNGROUP#") >




				<cfelse> <!---Grid Config was not available--->



				</cfif> <!--- End grid configs --->


				<cfset ArrayClear(gridColumnID) >
				<cfset ArrayClear(gridColumnName) >
				<cfset ArrayClear(gridColumnType) >
				<cfset ArrayClear(gridColumnCls) >
				<cfset ArrayClear(gridColumnText) >
				<cfset ArrayClear(gridGroup) >
				<cfset ArrayClear(gridColumnAlign) >
				<cfset ArrayClear(gridColumnBorder) >
				<cfset ArrayClear(gridColumnStyle) >
				<cfset ArrayClear(gridColumnAnchor) >
				<cfset ArrayClear(gridColumnHidden) >
				<cfset ArrayClear(gridHeight) >
				<cfset ArrayClear(gridWidth) >
				<cfset ArrayClear(gridMargin) >
				<cfset ArrayClear(gridPadding) >
				<cfset ArrayClear(gridSummary) >
				<cfset ArrayClear(gridDisabled) >
				<cfset ArrayClear(gridColumnRenderer) >
				<cfset ArrayClear(gridColumnReadOnly) >
				<cfset ArrayClear(gridColumnVType) >
				<cfset ArrayClear(gridColumnVText) >
				<cfset ArrayClear(gridColumnAllowBlank) >
				<cfset ArrayClear(gridColumnIsBooleanType) >
				<cfset ArrayClear(gridColumnMinVal) >
				<cfset ArrayClear(gridColumnMaxVal) >
				<cfset ArrayClear(gridColumnMinChar) >
				<cfset ArrayClear(gridColumnMaxChar) >
				<cfset ArrayClear(gridColumnUncheckedVal) >
				<cfset ArrayClear(gridColumnLocalData) >
				<cfset ArrayClear(gridColumnRemoteData) >
				<cfset ArrayClear(gridColumnFormat) >
				<cfset ArrayClear(gridColumnEditableOnRoute) >
				<cfset gridLowestIndex = 0 >
			</cfif>



			<!---End prepare grid--->

		</cfloop> <!---end formTableData--->


		<cfset fields = ArrayToList(columnnameArr, ",") >
		<cfset columns = ArrayToList(columnItemArr, ",") >
		<cfset vtypes = ArrayToList(validationArr, " ") >  <!---The VTypes--->
		<cfset stores = ArrayToList(columnModelStore, " ") > <!---The Stores--->

		<cfset tableGroupData =  ORMExecuteQuery("SELECT COLUMNGROUP, MIN(COLUMNORDER) AS COLUMNORDER
													FROM EGRGIBOSETABLEFIELDS
												   WHERE TABLEIDFK IN (SELECT TABLEID
												   						 FROM EGRGIBOSETABLE
												   				        WHERE EFORMIDFK = '#eformid#')
												GROUP BY COLUMNGROUP
												ORDER BY MIN(COLUMNORDER) ASC") >

		<!---<cfset theGroupListArr = StructKeyArray(groupStruct) >--->

		<cfset theFieldSet = ArrayNew(1) >
		<cfset theItemArr = ArrayNew(1) >
		<cfset fcnt = 1 >

		<cfset fileParams = "{xtype: 'hiddenfield',name: 'withFile',value: '#withfileField#' },{xtype: 'hiddenfield',name: 'fileCount',value: '#fileCount#'}">

		<cfset listeners = "listeners: {beforeaction: function(thiss, action) { var win = eForm.up('window'); var commentfield = win.down('textfield[name=commentsxxx]'); var commentValue = commentfield.getValue(); eForm.getForm().baseParams.comments = commentValue;}}" >

	<cfset pointcnt = 1 >
	<cfif formviewas EQ "VBOXABS">
		<cfloop array="#tableGroupData#" index="theGroup" >

			<cfif trim(theGroup[1]) EQ "" >
				<cfset colGroup = "nogroup" >
			<cfelse>
				<cfset colGroup = rereplace(theGroup[1], "[^A-Za-z0-9_]", "_", "all") >
			</cfif>

			<cfset titleGroup = replace(colGroup,"nogroup"," ","all") >
			<cfset titleGroup = replace(titleGroup,"_"," ","all") >

			<cfset theItemArr = groupStruct['__#colGroup#'] >
			<cfset theItemList = ArrayToList(theItemArr, ",") >

			<cfset height = evaluate("Y__#colGroup#") >

			<cfif pointcnt eq 1 >
			<cfelse>
				<cfset fileParams = "" >
				<cfset extraFields = "" >
			</cfif>

			<cfset theFieldSet[fcnt] = "{xtype:'fieldset',  collapsible: true,margin: '#formgroupmargin#',height: #height#, title: '#titleGroup#', defaultType: 'textfield',  defaults: {anchor: '100%'}, layout: 'absolute', items :[#theItemList#, #fileParams##extraFields# ] }" >
			 <cfset fcnt = fcnt + 1 >
			 <cfset pointcnt = 2 >
		</cfloop>

	<cfset groupFieldsAll = ArrayToList(theFieldSet, ",") >

		<cfset formScript = "#stores# #vtypes# var eForm = Ext.create('Ext.form.Panel',{padding: '#formpadding#', baseParams: {comments: ''}, 	items: [#groupFieldsAll# ],#listeners#," >


	<cfelseif formviewas EQ "VBOXABSPANEL" >
		<cfloop array="#tableGroupData#" index="theGroup" >

			<cfif trim(theGroup[1]) EQ "" >
				<cfset colGroup = "nogroup" >
			<cfelse>
				<cfset colGroup = rereplace(theGroup[1], "[^A-Za-z0-9_]", "_", "all") >
			</cfif>

			<cfset titleGroup = replace(colGroup,"nogroup"," ","all") >
			<cfset titleGroup = replace(titleGroup,"_"," ","all") >

			<cfset theItemArr = groupStruct['__#colGroup#'] >
			<cfset theItemList = ArrayToList(theItemArr, ",") >

			<cfset height = evaluate("Y__#colGroup#") >

			<cfif pointcnt eq 1 >
			<cfelse>
				<cfset fileParams = "" >
				<cfset extraFields = "" >
			</cfif>

			<cfset theFieldSet[fcnt] = "{xtype:'panel',  collapsible: true,margin: '#formgroupmargin#',height: #height#, title: '#titleGroup#', defaultType: 'textfield', defaults: {anchor: '100%'},  layout: 'absolute', items :[#theItemList#, #fileParams# #extraFields#  ]}" >
			 <cfset fcnt = fcnt + 1 >
			 <cfset pointcnt = 2 >
		</cfloop>

	<cfset groupFieldsAll = ArrayToList(theFieldSet, ",") >

		<cfset formScript = "#stores# #vtypes#var eForm = Ext.create('Ext.form.Panel',{padding: '#formpadding#', baseParams: {comments: ''},	items: [#groupFieldsAll# ],#listeners#," >


	<cfelseif formviewas EQ "HBOXABS" >
		<cfloop array="#tableGroupData#" index="theGroup" >

			<cfif trim(theGroup[1]) EQ "" >
				<cfset colGroup = "nogroup" >
			<cfelse>
				<cfset colGroup = rereplace(theGroup[1], "[^A-Za-z0-9_]", "_", "all") >
			</cfif>

			<cfset titleGroup = replace(colGroup,"nogroup"," ","all") >
			<cfset titleGroup = replace(titleGroup,"_"," ","all") >

			<cfset theItemArr = groupStruct['__#colGroup#'] >
			<cfset theItemList = ArrayToList(theItemArr, ",") >

			<cfset height = evaluate("Y__#colGroup#") >

			<cfif pointcnt eq 1 >
			<cfelse>
				<cfset fileParams = "" >
				<cfset extraFields = "" >
			</cfif>

			<cfset theFieldSet[fcnt] = "{xtype:'fieldset',  collapsible: true,margin: '#formgroupmargin#',height: #height#, title: '#titleGroup#', defaultType: 'textfield', defaults: {anchor: '100%'}, columnWidth: #1/ArrayLen(tableGroupData)#, layout: 'absolute', items :[#theItemList#, #fileParams##extraFields# ] }" >
			 <cfset fcnt = fcnt + 1 >
			 <cfset pointcnt = 2 >
		</cfloop>

	<cfset groupFieldsAll = ArrayToList(theFieldSet, ",") >
		<cfset formScript = "#stores# #vtypes# var eForm = Ext.create('Ext.form.Panel',{padding: '#formpadding#', baseParams: {comments: ''},	items: [#groupFieldsAll# ],#listeners#," >

	<cfelseif formviewas EQ "HBOXABSPANEL" >
		<cfloop array="#tableGroupData#" index="theGroup" >

			<cfif trim(theGroup[1]) EQ "" >
				<cfset colGroup = "nogroup" >
			<cfelse>
				<cfset colGroup = rereplace(theGroup[1], "[^A-Za-z0-9_]", "_", "all") >
			</cfif>

			<cfset titleGroup = replace(colGroup,"nogroup"," ","all") >
			<cfset titleGroup = replace(titleGroup,"_"," ","all") >

			<cfset theItemArr = groupStruct['__#colGroup#'] >
			<cfset theItemList = ArrayToList(theItemArr, ",") >

			<cfset height = evaluate("Y__#colGroup#") >

			<cfif pointcnt eq 1 >
			<cfelse>
				<cfset fileParams = "" >
				<cfset extraFields = "" >
			</cfif>

			<cfset theFieldSet[fcnt] = "{xtype:'panel',  collapsible: true,margin: '#formgroupmargin#',height: #height#, title: '#titleGroup#', defaultType: 'textfield', defaults: {anchor: '100%'}, columnWidth: #1/ArrayLen(tableGroupData)#, layout: 'absolute', items :[#theItemList#, #fileParams# #extraFields# ] }" >
			 <cfset fcnt = fcnt + 1 >
			 <cfset pointcnt = 2 >
		</cfloop>

	<cfset groupFieldsAll = ArrayToList(theFieldSet, ",") >
		<cfset formScript = "#stores# #vtypes# var eForm = Ext.create('Ext.form.Panel',{padding: '#formpadding#', baseParams: {comments: ''},	items: [#groupFieldsAll# ],#listeners#," >


	<cfelseif formviewas EQ "VBOX">
		<cfloop array="#tableGroupData#" index="theGroup" >

			<cfif trim(theGroup[1]) EQ "" >
				<cfset colGroup = "nogroup" >
			<cfelse>
				<cfset colGroup = rereplace(theGroup[1], "[^A-Za-z0-9_]", "_", "all") >
			</cfif>

			<cfset titleGroup = replace(colGroup,"nogroup"," ","all") >
			<cfset titleGroup = replace(titleGroup,"_"," ","all") >

			<cfset theItemArr = groupStruct['__#colGroup#'] >
			<cfset theItemList = ArrayToList(theItemArr, ",") >

			<cfset height = evaluate("Y__#colGroup#") >

			<cfif pointcnt eq 1 >
			<cfelse>
				<cfset fileParams = "" >
				<cfset extraFields = "" >
			</cfif>

			<cfset theFieldSet[fcnt] = "{xtype:'fieldset',  collapsible: true,margin: '#formgroupmargin#',title: '#titleGroup#', defaultType: 'textfield', defaults: {anchor: '100%'}, layout: 'anchor',width: '100%',items :[#theItemList#, #fileParams##extraFields# ]}" >
			 <cfset fcnt = fcnt + 1 >
			 <cfset pointcnt = 2 >
		</cfloop>

	<cfset groupFieldsAll = ArrayToList(theFieldSet, ",") >

		<cfset formScript = "#stores# #vtypes# var eForm = Ext.create('Ext.form.Panel',{padding: '#formpadding#', baseParams: {comments: ''},	items: [#groupFieldsAll# ],#listeners#," >

	<cfelseif formviewas EQ "VBOXPANEL">
		<cfloop array="#tableGroupData#" index="theGroup" >

			<cfif trim(theGroup[1]) EQ "" >
				<cfset colGroup = "nogroup" >
			<cfelse>
				<cfset colGroup = rereplace(theGroup[1], "[^A-Za-z0-9_]", "_", "all") >
			</cfif>

			<cfset titleGroup = replace(colGroup,"nogroup"," ","all") >
			<cfset titleGroup = replace(titleGroup,"_"," ","all") >

			<cfset theItemArr = groupStruct['__#colGroup#'] >
			<cfset theItemList = ArrayToList(theItemArr, ",") >

			<cfset height = evaluate("Y__#colGroup#") >

			<cfif pointcnt eq 1 >
			<cfelse>
				<cfset fileParams = "" >
				<cfset extraFields = "" >
			</cfif>

			<cfset theFieldSet[fcnt] = "{xtype:'panel',  collapsible: true,margin: '#formgroupmargin#',title: '#titleGroup#', defaultType: 'textfield', defaults: {anchor: '100%'}, layout: 'anchor', width: '100%', items :[#theItemList#, #fileParams##extraFields#  ] }" >
			 <cfset fcnt = fcnt + 1 >
			 <cfset pointcnt = 2 >
		</cfloop>

	<cfset groupFieldsAll = ArrayToList(theFieldSet, ",") >

		<cfset formScript = "#stores# #vtypes#var eForm = Ext.create('Ext.form.Panel',{padding: '#formpadding#', baseParams: {comments: ''},	items: [#groupFieldsAll# ],#listeners#," >

	<cfelseif formviewas EQ "HBOX">
		<cfloop array="#tableGroupData#" index="theGroup" >

			<cfif trim(theGroup[1]) EQ "" >
				<cfset colGroup = "nogroup" >
			<cfelse>
				<cfset colGroup = rereplace(theGroup[1], "[^A-Za-z0-9_]", "_", "all") >
			</cfif>

			<cfset titleGroup = replace(colGroup,"nogroup"," ","all") >
			<cfset titleGroup = replace(titleGroup,"_"," ","all") >

			<cfset theItemArr = groupStruct['__#colGroup#'] >
			<cfset theItemList = ArrayToList(theItemArr, ",") >

			<cfset height = evaluate("Y__#colGroup#") >

			<cfif pointcnt eq 1 >
			<cfelse>
				<cfset fileParams = "" >
				<cfset extraFields = "" >
			</cfif>

			<cfset theFieldSet[fcnt] = "{xtype:'fieldset',  collapsible: true,margin: '#formgroupmargin#',title: '#titleGroup#', defaultType: 'textfield', defaults: {anchor: '100%'}, columnWidth: #1/ArrayLen(tableGroupData)#, layout: 'anchor', width: '100%', items :[#theItemList#, #fileParams##extraFields# ]}" >
			 <cfset fcnt = fcnt + 1 >
			 <cfset pointcnt = 2 >
		</cfloop>

	<cfset groupFieldsAll = ArrayToList(theFieldSet, ",") >

		<cfset formScript = "#stores# #vtypes# var eForm = Ext.create('Ext.form.Panel',{padding: '#formpadding#',baseParams: {comments: ''}, 	items: [#groupFieldsAll# ],#listeners#," >

	<cfelseif formviewas EQ "HBOXPANEL">
		<cfloop array="#tableGroupData#" index="theGroup" >

			<cfif trim(theGroup[1]) EQ "" >
				<cfset colGroup = "nogroup" >
			<cfelse>
				<cfset colGroup = rereplace(theGroup[1], "[^A-Za-z0-9_]", "_", "all") >
			</cfif>

			<cfset titleGroup = replace(colGroup,"nogroup"," ","all") >
			<cfset titleGroup = replace(titleGroup,"_"," ","all") >

			<cfset theItemArr = groupStruct['__#colGroup#'] >
			<cfset theItemList = ArrayToList(theItemArr, ",") >

			<cfset height = evaluate("Y__#colGroup#") >

			<cfif pointcnt eq 1 >
			<cfelse>
				<cfset fileParams = "" >
				<cfset extraFields = "" >
			</cfif>

			<cfset theFieldSet[fcnt] = "{xtype:'panel',  collapsible: true,margin: '#formgroupmargin#',title: '#titleGroup#', defaultType: 'textfield', defaults: {anchor: '100%'}, columnWidth: #1/ArrayLen(tableGroupData)#,layout: 'anchor',width: '100%',items :[#theItemList#, #fileParams# #extraFields# ] }" >
			 <cfset fcnt = fcnt + 1 >
			 <cfset pointcnt = 2 >
		</cfloop>

	<cfset groupFieldsAll = ArrayToList(theFieldSet, ",") >

		<cfset formScript = "#stores# #vtypes#var eForm = Ext.create('Ext.form.Panel',{padding: '#formpadding#', baseParams: {comments: ''},	items: [#groupFieldsAll# ],#listeners#," >

	<cfelseif formviewas EQ "TABLE">
		<cfloop array="#tableGroupData#" index="theGroup" >

			<cfif trim(theGroup[1]) EQ "" >
				<cfset colGroup = "nogroup" >
			<cfelse>
				<cfset colGroup = rereplace(theGroup[1], "[^A-Za-z0-9_]", "_", "all") >
			</cfif>

			<cfset titleGroup = replace(colGroup,"nogroup"," ","all") >
			<cfset titleGroup = replace(titleGroup,"_"," ","all") >

			<cfset theItemArr = groupStruct['__#colGroup#'] >
			<cfset theItemList = ArrayToList(theItemArr, ",") >

			<cfset height = evaluate("Y__#colGroup#") >

			<cfif pointcnt eq 1 >
			<cfelse>
				<cfset fileParams = "" >
				<cfset extraFields = "" >
			</cfif>

			<cfset theFieldSet[fcnt] = "{xtype:'fieldset',  collapsible: true,margin: '#formgroupmargin#',title: '#titleGroup#',defaultType: 'textfield',defaults: {anchor: '100%'},layout: 'column', items :[#theItemList#, #fileParams##extraFields# ] }" >
			 <cfset fcnt = fcnt + 1 >
			 <cfset pointcnt = 2 >
		</cfloop>

	<cfset groupFieldsAll = ArrayToList(theFieldSet, ",") >

		<cfset formScript = "#stores# #vtypes#var eForm = Ext.create('Ext.form.Panel',{padding: '#formpadding#', baseParams: {comments: ''},layout: 'anchor',id: 'id__#eformid#',items: [#groupFieldsAll# ],#listeners#," >

	<cfelse>

	</cfif>

<cfset auxScript = "" >

<cfsavecontent variable="auxScript" >
	<cfoutput>
		alias: 'widget.eFormForm',id:'autoeformididid',buttonAlign: 'left',
		width: '100%',
		height: '100%',autoScroll: true,defaults: {anchor: '100%'},
		defaultType: 'textfield',
		api: {
			load:   'Ext.ss.actionform.load',
			submit: 'Ext.ss.actionform.submit'
		},
		paramOrder: ['eformid'],
		buttons: [{
			text: 'Add',action: 'add',hidden: false,
			handler: function(thiss) {
				var theForm = thiss.up('form').getForm();
				if(theForm.isValid()) {
					theForm.submit({
						submitEmptyText: false,
						timeout: 300000,waitMsg: 'Submitting, please wait',
						params: {eformid: '#eformid#',action: 'add'},
						reset: true,
						failure: function(form, action){
							Ext.Msg.show({
								title: 'Technical problem.',msg: 'Our apology. We are having technical problems.',
								buttons: Ext.Msg.OK,
								icon: Ext.Msg.ERROR
							});
							console.log(action);
						},
						success: function(form, action){
							Ext.Msg.show({
								msg: 'Form add successful',
								buttons: Ext.Msg.OK
							});
							autoeFormGrid.getStore().load();
							try
							{
								Ext.define('Search', {
								    fields: ['id', 'query'],
								    extend: 'Ext.data.Model',
								    proxy: {
								        type: 'localstorage',
								        id  : 'twitter-Searches'
								    }
								});
								var store = Ext.create('Ext.data.Store', {
								    model: 'Search'
								});
								store.load();
								store.removeAll();
								store.sync();
								Ext.TaskManager.stopAll();
							}
							catch(err)
							{
								console.log(err);
							}
						}
					});
			 } else {
			   		alert('Please provide correct value for each field!');
			 }
		}
	},{
		text: 'Save',action: 'save',hidden: false,
		handler: function(thiss) {
			var theForm = thiss.up('form').getForm();
			if(theForm.isValid()) {
				theForm.submit({
					submitEmptyText: false,
					timeout: 300000,
					waitMsg: 'Submitting, please wait',
					params: {
						eformid: '#eformid#',
						action: 'save'
					},
					reset: true,
					failure: function(form, action){
						Ext.Msg.show({
							title: 'Technical problem.',
							msg: 'Our apology. We are having technical problems.',
							buttons: Ext.Msg.OK,
							icon: Ext.Msg.ERROR
						});
						console.log(action);
					},
					success: function(form, action){
						Ext.Msg.show({
							msg: 'Form update successful',
							buttons: Ext.Msg.OK
						});
						autoeFormGrid.getStore().load();
					}
				});
			} else {
				alert('Please provide correct value for each field!');
			}
		}
	},{
		text: 'Approve',action: 'approve',hidden: false,
		handler: function(thiss) {
			var res = window.confirm('Approve?');
			if(!res) {
				return false;
			}
			var theForm = thiss.up('form').getForm();
			theForm.submit({
				submitEmptyText: false,
				timeout: 300000,
				waitMsg: 'Submitting, please wait',
				params: {
					eformid: '#eformid#',
					action: 'approve'},
					reset: true,
					failure: function(form, action){
						Ext.Msg.show({
							title: 'Technical problem.',
							msg: 'Our apology. We are having technical problems.',
							buttons: Ext.Msg.OK,
							icon: Ext.Msg.ERROR
						});

						console.log(action);
					},
					success: function(form, action){
						Ext.Msg.show({
							msg: 'Form approval successful',
							buttons: Ext.Msg.OK
						});
						formWindow.close();
						autoeFormGrid.getStore().load();
						var mainGrid = Ext.ComponentQuery.query('eformmainview');
						mainGrid[0].getStore().load();
					}
				});
			}
		},{
			text: 'Disapprove',action: 'disapprve',hidden: false,
			handler: function(thiss) {
				var res = window.confirm('Disapprove?');
				 if(!res) {
				 	return false;
				 }
				 var theForm = thiss.up('form').getForm();
				 if(theForm.isValid()) {
				 	theForm.submit({
				 		submitEmptyText: false,
				 		timeout: 300000,
				 		waitMsg: 'Submitting, please wait',
				 		params: {
				 			eformid: '#eformid#',
				 			action: 'disapprove'
				 		},
				 		reset: true,
				 		failure: function(form, action){
				 			Ext.Msg.show({
				 				title: 'Technical problem.',
				 				msg: 'Our apology. We are having technical problems.',
				 				buttons: Ext.Msg.OK,
				 				icon: Ext.Msg.ERROR
				 			});
				 			console.log(action);
				 		},
				 		success: function(form, action){
				 			Ext.Msg.show({
				 				msg: 'Form disapproval successful',
				 				buttons: Ext.Msg.OK
				 			});
				 			formWindow.close();
				 			autoeFormGrid.getStore().load();
				 			var mainGrid = Ext.ComponentQuery.query('eformmainview');
				 			mainGrid[0].getStore().load();
				 		}
				 	});
				 } else {
				 	alert('Please provide correct value for each field!');
				 }
				}
			},{
				text: 'Return to Originator',action: 'returntooriginator',hidden: false,
				handler: function(thiss) {
					var res = window.confirm('Return to Originator?');
					if(!res) {
						return false;
					}
					var theForm = thiss.up('form').getForm();
					var approved = theForm.getValues().#firstlevel#__#firsttable#__APPROVED;
					if(approved == 'R') {
						alert('The form cannot be returned to the originator because he or she has no reponse yet.');
						return false;
					}
					if(theForm.isValid()) {
						theForm.submit({
							submitEmptyText: false,
							timeout: 300000,
							waitMsg: 'Submitting, please wait',
							params: {
								eformid: '#eformid#',
								action: 'returntooriginator'
							},
							reset: true,
							failure: function(form, action){
								Ext.Msg.show({
									title: 'Technical problem.',
									msg: 'Our apology. We are having technical problems.',
									buttons: Ext.Msg.OK,
									icon: Ext.Msg.ERROR
								});
								console.log(action);
							},
							success: function(form, action){
								Ext.Msg.show({
									msg: 'Return to originator successful',
									buttons: Ext.Msg.OK
								});
								formWindow.close();
								autoeFormGrid.getStore().load();
								var mainGrid = Ext.ComponentQuery.query('eformmainview');
								mainGrid[0].getStore().load();
							}
						});
					} else {
						alert('Please provide correct value for each field!');
					}
				}
			},{
				text:'View Status',action:'viewpathroutefromform',hidden:false,
				handler: function(btn) {
					var thisgrid = Ext.getCmp('#eformid#');
					var selection = thisgrid.getView().getSelectionModel().getSelection()[0];
					var eformid = selection.data.#firstlevel#__#firsttable#__EFORMID;
					var processid = selection.data.#firstlevel#__#firsttable#__PROCESSID;
					var status = selection.data.#firstlevel#__#firsttable#__APPROVED;
					var pidno = selection.data.#firstlevel#__#firsttable#__PERSONNELIDNO;
					var theLevel = '#firstlevel#';var theTable = '#firsttable#';
					var myMask = Ext.create('Ext.LoadMask',{
						target: thisgrid,
						msg: 'Opening, please wait...'
					});
					myMask.show();
					if(status != 'N' && status != '') {
						Ext.ss.active.generateMap(eformid,processid,pidno,theLevel,theTable, function(result) {
							myMask.hide();
							try {
								eval(result);
							} catch(err) {
								if(result == 'cannotviewroutemap') {
									alert('Unable to view status');
								} else {
									alert('Please try again.');
								}
							}
						});
					} else {
						myMask.hide();
						Ext.Msg.show({
							title: '',
							msg: 'Please route the form first.',
							buttons: Ext.Msg.OK
						});
					}
				}
			},{
				text: 'e-mail Form',action: 'emailform',hidden: false,
				handler: function(thiss) {
					var formPanel = thiss.up('form');
					var panelContent = formPanel.getPanelContent();
					var emailForm = Ext.widget('eformemailwindow');
					var processidVal=formPanel.down('hiddenfield[name$=__PROCESSID]').getValue();
					emailForm.down('hiddenfield[name=eformid]').setValue('#eformid#');
					emailForm.down('hiddenfield[name=processid]').setValue(processidVal);
					var bodyEditor = emailForm.down('htmleditor');
					bodyEditor.setValue(panelContent);
					var windowTitle = thiss.up('window').title;
					var subjectF = emailForm.down('textfield[fieldLabel=Subject]');
					subjectF.setValue(windowTitle);
					emailForm.show();
				}
			},{
				text: 'Print',action: 'print',hidden: false,
				handler: function(thiss) {
					var formPanel = thiss.up('form');
					printerObj.print(formPanel);
				}
			}]
		});
		var commentStore = Ext.create('Ext.data.Store', {
			fields: [{
				name: 'title',
				mapping: 'name'
			},{
				name: 'lastPost',
				mapping: 'dateaction'
			},{
				name: 'excerpt',
				mapping: 'comments'
			},{
				name: 'theaction',
				mapping: 'action'
			}],
			autoLoad: true,
			listeners: {
				load: function(cref,rec) {
					var clen = rec.length;
					var theComboBox = Ext.ComponentQuery.query('combobox[name=comboComments]')[0];
					if( clen > 0 ) {
						theComboBox.labelEl.update('<b>View Comment(s) ' + clen + '</b>');
						theComboBox.onTriggerClick();
					} else {
						console.log(theComboBox);
						theComboBox.hide();
					}
				},
				beforeload: function(thiss,operation,eopts) {
					try {var selection = autoeFormGrid.getView().getSelectionModel().getSelection()[0];
				} catch(er) {
					console.log(er);
				}
				thiss.proxy.extraParams.personnelidno = selection.data.#firstlevel#__#firsttable#__PERSONNELIDNO;
				thiss.proxy.extraParams.processid     = selection.data.#firstlevel#__#firsttable#__PROCESSID;
			}
		},
		proxy: {
			type: 'direct',
			timeout: 300000,
			extraParams: {
				personnelidno: '__',
				processid: '__',
				query: ''
			},
			directFn: 'Ext.ss.lookup.getComment',
			paramOrder: ['limit', 'page', 'query', 'start', 'personnelidno', 'processid'],
			reader: {
				root: 'topics',
				totalProperty: 'totalCount'
			}
		}
	});
	var formWindow = Ext.create('Ext.window.Window', {
		height: '100%',
		title: '#formtitle#',
		width: '100%',
		layout: 'fit',
		modal: true,
		items: eForm,
		bbar: [{
			xtype: 'textfield',
			fieldLabel: 'Comments',
			hidden: false,
			name: 'commentsxxx',
			value: '',
			width: '40%',
			maxlength: 250,
			padding: '4 10 4 4'
		},{
			xtype: 'combobox',name: 'commentslist',hidden: false,store: commentStore,
			typeAhead: false,
			minChars: 1,
			pageSize: 20,
			width: '40%',
			fieldLabel: 'View Comments',
			action: 'selecteduser',
			name: 'comboComments',
			padding: '4 4 4 4',
			editable: false,
			fieldStyle:{
				backgroundImage: 'none',
				backgroundColor: '##C0D4ED'
			},
			labelWidth: 130,
			listConfig: {
				loadingText: 'Loading...',
				emptyText: 'No comments found.',/* Custom rendering template for each item*/
				getInnerTpl: function() {
					return '<h3>{title} <span style=\'float: right; font-size: .7em;\'>{lastPost}<br>{theaction}</span><br/></h3>{excerpt}';
				}
			}
		}
	]
}).show();
	</cfoutput>
</cfsavecontent>
<cfset auxScript = rereplace(auxScript,"[\t\f]","","all") />

<cfset formScript = formScript & ' ' & auxScript >


<cfset processDataB = EntityLoad("EGRGEFORMS", #eformid#, true ) >
<cfset processDataB.setLAYOUTQUERY(formScript) >
<cfset EntitySave(processDataB) >
<cfset ormflush()>

</cffunction>

<cffunction name="previewGrid" ExtDirect="true">
	<cfargument name="eformid" >
	<cftry>
	<cfset formScript = "empty" >
	<cfset processData = EntityLoad("EGRGEFORMS", #eformid#, true ) >
	<cfset formScript = processData.getLAYOUTQUERY() >

	<cfreturn formScript >
	<cfcatch>
		<cfreturn cfcatch.detail & ' ' & cfcatch.message >
	</cfcatch>
	</cftry>
</cffunction>



<cffunction name="setupComboData" >
	<cfset cntStore = cntStore + 1 >
	<cfset querymode = 'local' >
	<cfset minchars = ''>
	<cfset pagesize = '' >
	<cfif trim(COMBOLOCALDATA) NEQ "">
		<cfset comboArr = ArrayNew(1) >
		<cftry>
			<cfif ListLen(COMBOLOCALDATA, ";") GT 0 >
				<cfloop list="#COMBOLOCALDATA#" index="combolist" delimiters=";" >
					<cfif ListLen(combolist, ",") EQ 2 >
					<cfset arrayappend(comboArr, "{displayname: '#listgetat(combolist,1)#',codename: '#listgetat(combolist,2)#'}") >
					<cfelse>

					</cfif>
				</cfloop> <!---end CHECKITEMS--->
			<cfelse>
			</cfif> <!---end ListLen--->
		<cfcatch>
			<cfthrow message="Combobox format is incorrect '#COMBOLOCALDATA#'. Please follow the guidelines accordingly.">
		</cfcatch>
		</cftry>

	    <cfset comboLocaldataItems  = ArrayToList(comboArr) >
		<cfset columnModelStore[cntStore] = "var #comboStoreName# = Ext.create('Ext.data.Store', { fields: ['displayname', 'codename'], data : [ #comboLocaldataItems# ]});" >
		<cfset arrayclear(comboArr) >
	<cfelseif trim(COMBOREMOTEDATA) NEQ "">

		<cfset minchars = 'minChars: 1,'>
		<cfset pagesize = 'pageSize: 30,' >
		<cfset theTable 				= "" >
		<cfset theDisplayColumns 		= "" >
		<cfset theValueColumn 			= "" >
		<cfset theColumnItDepends 		= "" >
		<cfset theColumnItDependsValue 	= "" >
		<cftry>
			<cfif ListLen(COMBOREMOTEDATA, ";") GT 0 >
				<cfset theTable 				= ListGetAt(COMBOREMOTEDATA, 1, ";") >
				<cfset theDisplayColumns 		= ListGetAt(COMBOREMOTEDATA, 2, ";") >
				<cfset theValueColumn 			= ListGetAt(COMBOREMOTEDATA, 3, ";") >
				<cftry>
					<cfset theColumnItDepends 		= ListGetAt(COMBOREMOTEDATA, 4, ";") >
					<cfcatch>
						<cfset theColumnItDepends 		= " " >
					</cfcatch>
				</cftry>

				<cftry>
					<cfset columnOrder 		= ListGetAt(COMBOREMOTEDATA, 5, ";") >
					<cfcatch>
						<cfset columnOrder 		= " " >
					</cfcatch>
				</cftry>

				<cftry>
					<cfset pages = ListGetAt(COMBOREMOTEDATA, 6, ";") >
					<cfset pagesize 		= "pageSize: #pages#," >
					<cfcatch></cfcatch>
				</cftry>

				<cfset theColumnItDependsValue 	= " " >

			<cfelse>
			</cfif> <!---end ListLen--->
		<cfcatch>
			<cfthrow message="Combobox format is incorrect '#COMBOREMOTEDATA#'. Please follow the guidelines accordingly.">
		</cfcatch>
		</cftry>

		<cfset columnModelStore[cntStore] = "var #comboStoreName# = Ext.create('Ext.data.Store', {fields: ['displayname', 'codename'],autoLoad: false,listeners: {beforeload: function(thiss,operation,eopts) {var theValue = new Array();var dependCol = '#theColumnItDepends#';if(dependCol != ' ') {dependCol = dependCol.split(',');for(thecntr=0;thecntr<dependCol.length;thecntr++) {var specCol = dependCol[thecntr]; var resultQuery = eForm.query('field[name$=' + specCol + ']'); if(resultQuery[0].inputValue) {var resultQueryB = eForm.query('field[name$=' + specCol + '][checked=true]'); theValue.push(resultQueryB[0].inputValue);} else {theValue.push(resultQuery[0].value);} }thiss.proxy.extraParams.columnDependValues = theValue.toString(); } else {return true;}}},#pagesize# proxy: {type: 'direct',timeout: 300000,extraParams: {tablename: '#theTable#',columnDisplay: '#theDisplayColumns#',columnValue: '#theValueColumn#',columnDepends: '#theColumnItDepends#',columnDependValues: ' ',columnOrder: '#columnOrder#'},directFn: 'Ext.ss.lookup.formQueryLookup',paramOrder: ['limit', 'page', 'query', 'start', 'tablename', 'columnDisplay', 'columnValue','columnDepends','columnDependValues','columnOrder'],reader: {root: 'topics',totalProperty: 'totalCount'}}});" >
		<cfset querymode = 'remote' >
	<cfelse>
		<cfset columnModelStore[cntStore] = "var #comboStoreName# = Ext.create('Ext.data.Store', { fields: ['displayname', 'codename'],  data : [{displayname: ' ',codename: ' '}  ]});" >
	</cfif>
</cffunction>

<cffunction name="setGridColumns" >
	<cfargument name="theIndex" >
	text: '<cfoutput>#gridColumnText[theIndex]#</cfoutput>',
	sortable: true,
	filterable: true,
	<cfif qryFormGridConfig.QUERYMODE EQ "remote">
		<cfif trim(gridColumnType[theIndex]) eq "string" >
			<cfif trim(gridColumnLocalData[theIndex]) neq "" OR trim(gridColumnRemoteData[theIndex]) neq "">
				<cfset comboStoreName = replace(ListGetAt(qryFormGridConfig.FIELDS,theIndex,','),'.','_','all') >
				<cfset COMBOLOCALDATA = gridColumnLocalData[theIndex] >
				<cfset COMBOREMOTEDATA = gridColumnRemoteData[theIndex] >
				<cfinvoke method="setupComboData" >
			editor: {
		    	xtype: 'combobox',
		    	id: <cfoutput>#gridColumnID[theIndex]#,readOnly: #gridColumnReadOnly[theIndex]#,value: ''</cfoutput>,
		    	allowBlank: <cfoutput>#gridColumnAllowBlank[theIndex]#</cfoutput>,
		    	minLength: <cfoutput>#gridColumnMinChar[theIndex]#</cfoutput>,
		    	maxLength: <cfoutput>#gridColumnMaxChar[theIndex]#</cfoutput>,
		    	<cfoutput>#gridColumnVType[theIndex]#</cfoutput>
		    	<cfoutput>#gridColumnVText[theIndex]#</cfoutput>
				store: <cfoutput>#comboStoreName#</cfoutput>,
				displayField: 'displayname',
				valueField: 'codename',
				queryMode: '<cfoutput>#querymode#</cfoutput>',
				<cfoutput>#minchars#</cfoutput>
				<cfoutput>#pagesize#</cfoutput>
		    },
			<cfelse>
		    editor: {
		    	xtype: 'textfield',
		    	id: <cfoutput>#gridColumnID[theIndex]#,readOnly: #gridColumnReadOnly[theIndex]#,value: ''</cfoutput>,
		    	minLength: <cfoutput>#gridColumnMinChar[theIndex]#</cfoutput>,
		    	maxLength: <cfoutput>#gridColumnMaxChar[theIndex]#</cfoutput>,
		    	allowBlank: <cfoutput>#gridColumnAllowBlank[theIndex]#</cfoutput>,
		    	<cfoutput>#gridColumnVType[theIndex]#</cfoutput>
		    	<cfoutput>#gridColumnVText[theIndex]#</cfoutput>
		    },
			</cfif>
		<cfelseif trim(gridColumnType[theIndex]) eq "int" OR trim(gridColumnType[theIndex]) eq "float">
			editor: {
				xtype: 'numberfield',
				id: <cfoutput>#gridColumnID[theIndex]#,readOnly: #gridColumnReadOnly[theIndex]#,value: ''</cfoutput>,
				allowBlank: <cfoutput>#gridColumnAllowBlank[theIndex]#</cfoutput>,
				<cfoutput>#gridColumnVType[theIndex]#</cfoutput>
		    	<cfoutput>#gridColumnVText[theIndex]#</cfoutput>
				<cfoutput>#gridColumnMinVal[theIndex]#</cfoutput>
				<cfoutput>#gridColumnMaxVal[theIndex]#</cfoutput>
			},
		<cfelseif trim(gridColumnType[theIndex]) eq "date">
			editor: {
				xtype: 'datefield',
				id: <cfoutput>#gridColumnID[theIndex]#,readOnly: #gridColumnReadOnly[theIndex]#,value: ''</cfoutput>,
				allowBlank: <cfoutput>#gridColumnAllowBlank[theIndex]#</cfoutput>,
				<cfoutput>#gridColumnVType[theIndex]#</cfoutput>
		    	<cfoutput>#gridColumnVText[theIndex]#</cfoutput>
		    	<cfoutput>#gridColumnFormat[theIndex]#</cfoutput>
			},
		   	renderer: Ext.util.Format.dateRenderer('n/j/Y'),
		   	submitFormat: 'Y-m-d h:i:s',
			filter: {
				type: 'date',
				format: 'Y-m-d h:i:s'
			},
		<cfelseif trim(gridColumnType[theIndex]) eq "boolean">
			editor: {
				xtype: 'checkboxfield',
				id: <cfoutput>#gridColumnID[theIndex]#,readOnly: #gridColumnReadOnly[theIndex]#,value: ''</cfoutput>
				<cfif trim(gridColumnUncheckedVal[theIndex]) neq "" >
				,uncheckedValue: <cfoutput>#gridColumnUncheckedVal[theIndex]#</cfoutput>
				</cfif>
			},
		<cfelse>
		</cfif>
	</cfif>
	<cfif trim(gridColumnRenderer[theIndex]) neq "" >
	renderer: <cfoutput>#gridColumnRenderer[theIndex]#</cfoutput>,
	</cfif>
	dataIndex: '<cfoutput>#replace(ListGetAt(qryFormGridConfig.FIELDS,theIndex,','),'.','_','all')#</cfoutput>',
	<cfif len(trim(gridWidth[d])) lt 1 >
		flex: 1,
	<cfelse>
		<cfoutput>#gridWidth[theIndex]#</cfoutput>
	</cfif>
	<cfif gridColumnAlign[theIndex] eq "top" >
		align: 'center',
	<cfelse>
		align: '<cfoutput>#gridColumnAlign[theIndex]#</cfoutput>',
	</cfif>
	<cfif len(trim(gridHeight[theIndex])) gt 0 >
		<cfoutput>#gridHeight[theIndex]#</cfoutput>
	</cfif>
	<cfif len(trim(gridWidth[theIndex])) gt 0 >
		<cfset dwidth = gridWidth[theIndex] >
	</cfif>
	<cfif len(trim(gridMargin[theIndex])) gt 0 >
		margin: <cfoutput>#gridMargin[theIndex]#</cfoutput>
	</cfif>
	<cfif len(trim(gridSummary[theIndex])) gt 0>
    	,summaryType: '<cfoutput>#gridSummary[theIndex]#</cfoutput>'
    </cfif>
    <cfif len(trim(gridColumnBorder[theIndex])) gt 0 >
		,border: '<cfoutput>#gridColumnBorder[theIndex]#</cfoutput>'
	</cfif>
	<cfif len(trim(gridColumnStyle[theIndex])) gt 0 >
		,style: <cfoutput>#gridColumnStyle[theIndex]#</cfoutput>
	</cfif>
    <cfif len(trim(gridDisabled[theIndex])) gt 0>
    	,disabled: <cfoutput>#gridDisabled[theIndex]#</cfoutput>
    </cfif>
    <cfif len(trim(gridColumnHidden[theIndex])) gt 0>
    	,hidden: <cfoutput>#gridColumnHidden[theIndex]#</cfoutput>
    </cfif>
    <cfif len(trim(gridColumnAnchor[theIndex])) gt 0>
    	,<cfoutput>#gridColumnAnchor[theIndex]#</cfoutput>
    </cfif>

</cffunction>


<cffunction name="modelRemoteValidation" access="private" returntype="void">
	<cfset dtitle = left(trim(VALIDATIONTYPE),10) & right(createUuid(),7) >
	<cfquery name="qryRVType" datasource="#session.global_dsn#" maxrows="1">
		SELECT *
		  FROM EGINFORMRMTVALIDATION
		 WHERE REMOTEVALIDATIONCODE = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ListGetAt(trim(VALIDATIONTYPE),'1',',')#" >
	</cfquery>
	<cfif qryRVType.recordCount gt 0>
		<cfloop query="qryRVType">
		<cfset validationArr[cntVType] = "Ext.apply(Ext.form.field.VTypes, {
			" & dtitle & ":  function(v,f) {
			var vlen = " & ListLen(VALIDATIONTYPE,',') & ";
			var vvalue = '" & trim(VALIDATIONTYPE) & "';
			vvalue = vvalue.split(',');
			if('vrlen' in f) {
        		var cindex = f.vrlen;
        	} else {
				var cindex = 0;
				f.vrlen = 0;
        	}
			   f.getEl().mask('Validating...');
			   f.validateOnChange = false;
		       var dform = f.up('form');
		       var dffield = dform.query('field');
		       var dfarr = new Array();
		       dffield.forEach(function(df) {
		       	    dfarr.push(df.name);
		       });
		       var fvals = dform.getForm().getValues();
		       fvals['formfield'] = dfarr;
		       var dformbtn = dform.query('button[action=add], button[action=save]');
		       dformbtn[0].setDisabled(true);
			   dformbtn[1].setDisabled(true);
			   Ext.Ajax.timeout = 200000; //200000 seconds
		       Ext.Ajax.request({
				    url: './myapps/data/form/validation/' + vvalue[cindex] + '.cfm',
				    params: fvals,
				    success: function(response) {
				        f.getEl().unmask();
				        var responsejson = Ext.JSON.decode(response.responseText);
				        console.log(responsejson);
				        dform.getForm().setValues(responsejson.formdata);
				        if(responsejson.success == true) {
				        	if(responsejson.title.trim() != '' || responsejson.message.trim() != '') {
				        		Ext.Msg.show({
								     title:responsejson.title,
								     msg: responsejson.message,
								     buttons: Ext.Msg.OK,
								     icon: Ext.Msg.INFO
								});
				        	}
				        	if(responsejson.javascript.trim() != '') {
				        	    try {
				        	    	eval(responsejson.javascript);
				        	    } catch(er) {
				        	    	console.log('from remote eval script');
				        	    	console.log(er);
				        	    }
				        	}
				        	if(f.vrlen >= (vlen - 1)) {
					        	var invalidCount = 0;
					        	if('invalidCount' in dform) {
					        		if('invalidCount' in f) {
						            	fcount = f.invalidCount;
						            } else {
						            	fcount = 0;
						            }
					            	invalidCount = dform.invalidCount - fcount;
					            	dform.invalidCount = invalidCount;
					            	f.invalidCount = 0;
					            }
					            if(invalidCount < 1) {
					        		dformbtn[0].setDisabled(false);
					        		dformbtn[1].setDisabled(false);
					        		dform.invalidCount = 0;
					            	f.invalidCount = 0;
					        	}
					        	f.vrlen = 0;
					        	f.clearInvalid();
					        	return true;
				        	} else {
				        	    f.vrlen = f.vrlen + 1;
				        		f.validate();
				        	}
						} else {
				            if('invalidCount' in dform) {
				            	dform.invalidCount = dform.invalidCount + 1;
				            } else {
				            	dform.invalidCount = 1;
				            }
				            if('invalidCount' in f) {
				            	f.invalidCount = f.invalidCount + 1;
				            } else {
				            	f.invalidCount = 1;
				            }

				        	if(responsejson.errtitle.trim() != '' || responsejson.errmessage.trim() != '') {
				        		Ext.Msg.show({
								     title:responsejson.errtitle,
								     msg: responsejson.errmessage,
								     buttons: Ext.Msg.OK,
								     icon: Ext.Msg.WARNING
								});
				        	}
				        	if(responsejson.errjavascript.trim() != '') {
				        	    try {
				        	    	eval(responsejson.errjavascript);
				        	    } catch(er) {
				        	    	console.log('from remote eval err script');
				        	    	console.log(er);
				        	    }
				        	}
				        	f.vrlen = 0;
							dformbtn[0].setDisabled(true);
				        	dformbtn[1].setDisabled(true);
				        	f.markInvalid(responsejson.errmessage);
				        	return false;
				        }
					}
				});
				return true;
		    },
		    " & dtitle & "Text: ''
		});" >
		<cfset cntVType = cntVType + 1 >
		<cfset VALIDATIONTYPE = "validateOnBlur: true, validateOnChange: true, vtype: '#dtitle#'," >
		</cfloop>
    <cfelse>
	        <cfthrow detail="Remote Validation Code or ID is undefined" message="Missing Code">
	</cfif>
</cffunction>

</cfcomponent>
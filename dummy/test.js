 ', listeners: {
afterrender: function(thisc) {
	try {
	var crfP = thisc.up('panel');
	crfP.setHeight(120);
	var theform = thisc.up('form'); 
	var updateBudget = function() {
		var budget = theform.down('numberfield[name=C__ECINCRF__JUSTREGBUDGET]');
		var budgetc = theform.down('numberfield[name=C__ECINCRF__JUSTCASUALBUDGET]');
		var actual = theform.down('numberfield[name=C__ECINCRF__JUSTREGACTUAL]');
		var actualc = theform.down('numberfield[name=C__ECINCRF__JUSTCASUALACTUAL]');
		var variance = theform.down('textfield[name=C__ECINCRF__JUSTREGVARIANCE]');
		var variancec = theform.down('textfield[name=C__ECINCRF__JUSTCASUALVARIANCE]');
		var budgetTot = theform.down('numberfield[name=C__ECINCRF__JUSTTOTALBUDGET]');
		var actualTot = theform.down('numberfield[name=C__ECINCRF__JUSTTOTALACTUAL]');
		var varianceTot = theform.down('textfield[name=C__ECINCRF__JUSTTOTALVARIANCE]');
		var budval = budget.getValue();
		var acval = actual.getValue();
		variance.setValue(budval - acval);
		var budvalc = budgetc.getValue();
		var acvalc = actualc.getValue();
		variancec.setValue(budvalc - acvalc);
		var varia = variance.getValue();
		var variac = variancec.getValue();
		budgetTot.setValue(budval + budvalc);
		actualTot.setValue(acval + acvalc);
		varianceTot.setValue(varia + variac);
		return true;
	};
	var budget = theform.down('numberfield[name=C__ECINCRF__JUSTREGBUDGET]');
	budget.on('change', function() {
         updateBudget();
    });
    var budgetc = theform.down('numberfield[name=C__ECINCRF__JUSTCASUALBUDGET]');
	budgetc.on('change', function() {
         updateBudget();
    });
    var actual = theform.down('numberfield[name=C__ECINCRF__JUSTREGACTUAL]');
	actual.on('change', function() {
         updateBudget();
    });
    var actualc = theform.down('numberfield[name=C__ECINCRF__JUSTCASUALACTUAL]');
	actualc.on('change', function() {
         updateBudget();
    });
	var recomputeAll = function(thisb) {
		var noc = theform.down('numberfield[name=C__ECINCRF__NOOFCASUALS]');
		var nohpd = theform.down('numberfield[name=C__ECINCRF__NOOFHOURSPERDAY]');
		var nod = theform.down('numberfield[name=C__ECINCRF__NOOFDAYS]');
		var trh = theform.down('numberfield[name=C__ECINCRF__TOTALREGHOUR]');
		var toh = theform.down('numberfield[name=C__ECINCRF__TOTALOTHOUR]');
		var tnh = theform.down('numberfield[name=C__ECINCRF__TOTALNDHOUR]');
		var ratephreg = theform.down('numberfield[name=C__ECINCRF__RATEPERHOURREG]');
		var ratephot = theform.down('numberfield[name=C__ECINCRF__RATEPERHOUROT]');
		var ratephnd = theform.down('numberfield[name=C__ECINCRF__RATEPERHOURND]');
		var costothreg = theform.down('numberfield[name=C__ECINCRF__COSTOFTOTALHOURREG]');
		var costothot = theform.down('numberfield[name=C__ECINCRF__COSTOFTOTALHOUROT]');
		var costothnd = theform.down('numberfield[name=C__ECINCRF__COSTOFTOTALHOURND]'); 
		var totalcost = theform.down('numberfield[name=C__ECINCRF__TOTALCOST]');
		var totfte = theform.down('numberfield[name=C__ECINCRF__FTEQUIVALENT]');
		var noc2 = theform.down('numberfield[name=C__ECINCRF__NOOFCASUALS2]');
		var nohpd2 = theform.down('numberfield[name=C__ECINCRF__NOOFHOURSPERDAY2]');
		var nod2 = theform.down('numberfield[name=C__ECINCRF__NOOFDAYS2]');
		var trh2 = theform.down('numberfield[name=C__ECINCRF__TOTALREGHOUR2]');
		var toh2 = theform.down('numberfield[name=C__ECINCRF__TOTALOTHOUR2]');
		var tnh2 = theform.down('numberfield[name=C__ECINCRF__TOTALNDHOUR2]');
		var ratephreg2 = theform.down('numberfield[name=C__ECINCRF__RATEPERHOURREG2]');
		var ratephot2 = theform.down('numberfield[name=C__ECINCRF__RATEPERHOUROT2]');
		var ratephnd2 = theform.down('numberfield[name=C__ECINCRF__RATEPERHOURND2]');
		var costothreg2 = theform.down('numberfield[name=C__ECINCRF__COSTOFTOTALHOURREG2]');
		var costothot2 = theform.down('numberfield[name=C__ECINCRF__COSTOFTOTALHOUROT2]');
		var costothnd2 = theform.down('numberfield[name=C__ECINCRF__COSTOFTOTALHOURND2]'); 
		var totalcost2 = theform.down('numberfield[name=C__ECINCRF__TOTALCOST2]');
		var totfte2 = theform.down('numberfield[name=C__ECINCRF__FTEQUIVALENT2]');
		var grandtotalcost = theform.down('numberfield[name=C__ECINCRF__GRANDTOTALCOST]');
		var grandtotalfte = theform.down('numberfield[name=C__ECINCRF__GRANDTOTALFTE]');
		
		var tempArr = Ext.ComponentQuery.query('container[name=totalcontainer] combobox[name=dutytype]');
		var dutyArr = new Array();
		for(a=0;a<tempArr.length;a++) {
			dutyArr.push(tempArr[a].getValue());
		}
		tempArr = Ext.ComponentQuery.query('container[name=totalcontainer] numberfield[name=noofcasuals]');
		var casualsArr = new Array();
		for(a=0;a<tempArr.length;a++) {
			casualsArr.push(tempArr[a].getValue());
		}
		tempArr = Ext.ComponentQuery.query('container[name=totalcontainer] numberfield[name=noofhoursperday]');
		var hrdArr = new Array();
		for(a=0;a<tempArr.length;a++) {
			hrdArr.push(tempArr[a].getValue());
		}
		tempArr = Ext.ComponentQuery.query('container[name=totalcontainer] numberfield[name=noofdays]');
		var daysArr = new Array();
		for(a=0;a<tempArr.length;a++) {
			daysArr.push(tempArr[a].getValue());
		}
		tempArr = Ext.ComponentQuery.query('container[name=totalcontainer] numberfield[name=reghr]');
		var regArr = new Array();
		for(a=0;a<tempArr.length;a++) {
			regArr.push(tempArr[a].getValue());
		}
		tempArr = Ext.ComponentQuery.query('container[name=totalcontainer] numberfield[name=othr]');
		var otArr = new Array();
		for(a=0;a<tempArr.length;a++) {
			otArr.push(tempArr[a].getValue());
		}
		tempArr = Ext.ComponentQuery.query('container[name=totalcontainer] numberfield[name=ndhr]');
		var ndArr = new Array();
		for(a=0;a<tempArr.length;a++) {
			ndArr.push(tempArr[a].getValue());
		}
		
		var cntR = 0;
		var cntH = 0;
		var nohpdR = 0;
		var nohpdH = 0;
		var nodR = 0;
		var nodH = 0;
		var trhR = 0;
		var trhH = 0;
		var tohR = 0;
		var tohH = 0;
		var tnhR = 0;
		var tnhH = 0;
		for(a=0;a<dutyArr.length;a++) {
			if(dutyArr[a] == 'REGULAR') {
				cntR += casualsArr[a];
				nohpdR += hrdArr[a];
				nodR += daysArr[a];
				trhR += regArr[a];
				tohR += otArr[a];
				tnhR += ndArr[a];
			} else {
				cntH += casualsArr[a];
				nohpdH += hrdArr[a];
				nodH += daysArr[a];
				trhH += regArr[a];
				tohH += otArr[a];
				tnhH += ndArr[a];
			}
		}
		noc.setValue(cntR);
		noc2.setValue(cntH);
		nohpd.setValue(nohpdR);
		nohpd2.setValue(nohpdH);
		nod.setValue(nodR);
		nod2.setValue(nodH);
		trh.setValue(trhR);
		trh2.setValue(trhH);
		toh.setValue(tohR);
		toh2.setValue(tohH);
		tnh.setValue(tnhR);
		tnh2.setValue(tnhH);
		costothreg.setValue(trh.getValue() * ratephreg.getValue());
		costothot.setValue(toh.getValue() * ratephot.getValue());
		costothnd.setValue(tnh.getValue() * ratephnd.getValue());
		costothreg2.setValue(trh2.getValue() * ratephreg2.getValue());
		costothot2.setValue(toh2.getValue() * ratephot2.getValue());
		costothnd2.setValue(tnh2.getValue() * ratephnd2.getValue());
		totalcost.setValue(costothreg.getValue() + costothot.getValue() + costothnd.getValue());
		totalcost2.setValue(costothreg2.getValue() + costothot2.getValue() + costothnd2.getValue());
		totfte.setValue(((costothreg.getValue() + costothot.getValue() + costothnd.getValue()) / 8)/6);
		totfte2.setValue(((costothreg2.getValue() + costothot2.getValue() + costothnd2.getValue()) / 8)/6);
		grandtotalcost.setValue(totalcost.getValue() + totalcost2.getValue());
		grandtotalfte.setValue(totfte.getValue() + totfte2.getValue());
	};
	theform.on({
		beforeaction: function(dform,daction,dopts) {
			if(daction.timeout == 300000) { 
			    var tempArr = Ext.ComponentQuery.query('container[name=totalcontainer] combobox[name=dutytype]');
				var dutyArr = new Array();
				for(a=0;a<tempArr.length;a++) {
					dutyArr.push(tempArr[a].getValue());
				}
				var tempArr = Ext.ComponentQuery.query('container[name=totalcontainer] datefield[name=dateneeded]');
				var dnArr = new Array();
				for(a=0;a<tempArr.length;a++) {
					dnArr.push(Ext.util.Format.date(tempArr[a].getValue(),'Y-m-d'));
				}
				tempArr = Ext.ComponentQuery.query('container[name=totalcontainer] combobox[name=nameofagency]');
				var agencyArr = new Array();
				for(a=0;a<tempArr.length;a++) {
					agencyArr.push(tempArr[a].getValue());
				}
				tempArr = Ext.ComponentQuery.query('container[name=totalcontainer] numberfield[name=noofcasuals]');
				var casualsArr = new Array();
				for(a=0;a<tempArr.length;a++) {
					casualsArr.push(tempArr[a].getValue());
				}
				if(casualsArr.length < 1) {
					return true;
				}
				tempArr = Ext.ComponentQuery.query('container[name=totalcontainer] numberfield[name=noofhoursperday]');
				var hrdArr = new Array();
				for(a=0;a<tempArr.length;a++) {
					hrdArr.push(tempArr[a].getValue());
				}
				tempArr = Ext.ComponentQuery.query('container[name=totalcontainer] numberfield[name=noofdays]');
				var daysArr = new Array();
				for(a=0;a<tempArr.length;a++) {
					daysArr.push(tempArr[a].getValue());
				}
				tempArr = Ext.ComponentQuery.query('container[name=totalcontainer] numberfield[name=reghr]');
				var regArr = new Array();
				for(a=0;a<tempArr.length;a++) {
					regArr.push(tempArr[a].getValue());
				}
				tempArr = Ext.ComponentQuery.query('container[name=totalcontainer] numberfield[name=othr]');
				var otArr = new Array();
				for(a=0;a<tempArr.length;a++) {
					otArr.push(tempArr[a].getValue());
				}
				tempArr = Ext.ComponentQuery.query('container[name=totalcontainer] numberfield[name=ndhr]');
				var ndArr = new Array();
				for(a=0;a<tempArr.length;a++) {
					ndArr.push(tempArr[a].getValue());
				}
				var docnum = theform.down('textfield[name=C__ECINCRF__DOCNUMBER]').getValue();
				var dgrid = Ext.ComponentQuery.query('grid[alias=widget.eFormGrid]')[0];
				var gdata = dgrid.getSelectionModel().getSelection()[0];
				if(gdata) {
					var action = 'update';
					var dpid = gdata.data.C__ECINCRF__PERSONNELIDNO;
				} else {
					var action = 'insert';
					var dpid = 'na';
				}
				Ext.ComponentQuery.query('container[name=totalcontainer]')[0].getEl().mask('Saving...');
				Ext.Ajax.request({
				    url: '../../data/form/saveCRFdetails.cfm',
				    params: {
				    	dutytype: dutyArr.toString(),
				        dateneeded: dnArr.toString(),
				        nameofagency: agencyArr.toString(),
				        noofcasuals: casualsArr.toString(),
				        hoursperday: hrdArr.toString(),
				        noofdays: daysArr.toString(),
				        reghr: regArr.toString(),
				        othr: otArr.toString(),
				        ndhr: ndArr.toString(),
				        docnum: docnum,
				        personnelidno: dpid,
				        action: action
				    },
				    success: function(response){
				    	Ext.ComponentQuery.query('container[name=totalcontainer]')[0].getEl().unmask(); 
				    	var text = response.responseText;
				    	if(text.trim() == 'true') {
				    		return true;
				    	} else {
				    		alert(text);
				    		return false;
				    	}
				        console.log(text);
				    }
				});
			} else {
				
			}
		}
	});
	console.log(crfP);
	var dtype = Ext.create('Ext.data.Store', { fields: ['displayname', 'codename'], data : [ {displayname: 'REGULAR', codename: 'REGULAR'},{displayname: 'HOLIDAY', codename: 'HOLIDAY'} ]});
	var agencyStore = Ext.create('Ext.data.Store', {
		fields: ['displayname', 'codename'],
		autoLoad: false,
		pageSize: 30,
		proxy: {
			type: 'direct',
			timeout: 300000,
			extraParams: {
				tablename: 'CLKAGENCY',
				columnDisplay: 'AGENCYNAME',
				columnValue: 'AGENCYCODE',
				columnDepends: ' ',
				columnDependValues: ' ',
				columnOrder: 'AGENCYNAME ASC'
			},
			directFn: 'Ext.ss.lookup.formQueryLookup',
			paramOrder: ['limit', 'page', 'query', 'start', 'tablename', 'columnDisplay', 'columnValue','columnDepends','columnDependValues','columnOrder'],
			reader: {
				root: 'topics',
				totalProperty: 'totalCount'
			}
		}
	});
	crfP.add([{
		xtype: 'container',
		padding: '5 5 5 5',
		layout: 'vbox',
		name: 'totalcontainer',
		items: [{
			xtype: 'container',
			layout: 'hbox',
			items: [{
				xtype: 'button',
				text: 'Add Details',
				handler: function(thisb) {
					var totc = thisb.up('container[name=totalcontainer]');
					crfP.setHeight(totc.getHeight() + 70);
					totc.add([{
						xtype: 'container',
						width: '100%',
						defaults: {
							padding: 2
						},
						layout: {
							type: 'hbox',
							align: 'stretch'
						},
						items: [{
							xtype: 'panel',
							layout: 'vbox',
							flex: .3,
							items: [{
								xtype: 'combobox',
								store: dtype,
								displayField: 'displayname',
								valueField: 'codename',
								queryMode: 'local',
								width: 50,
								value: 'REGULAR',
								name: 'dutytype'
							}]
						},{
							xtype: 'panel',
							layout: 'vbox',
							flex: .5,
							items: [{
								xtype: 'datefield',
								width: 95,
								name: 'dateneeded'
							}]
						},{
							xtype: 'panel',
							layout: 'vbox',
							flex: .7,
							items: [{
								xtype: 'combobox',
								store: agencyStore,
								displayField: 'displayname',
								valueField: 'codename',
								queryMode: 'remote',
								pageSize: 30,
								width: 117,
								minChars: 1,
								name: 'nameofagency'
							}]
						},{
							xtype: 'panel',
							layout: 'vbox',
							flex: .5,
							items: [{
								xtype: 'numberfield',
								width: 60,
								name: 'noofcasuals',
								value: 0
							}]
						},{
							xtype: 'panel',
							layout: 'vbox',
							flex: .5,
							items: [{
								xtype: 'numberfield',
								width: 60,
								name: 'noofhoursperday',
								value: 0
							}]
						},{
							xtype: 'panel',
							layout: 'vbox',
							flex: .5,
							items: [{
								xtype: 'numberfield',
								width: 60,
								name: 'noofdays',
								value: 0
							}]
						},{
							xtype: 'panel',
							layout: 'vbox',
							flex: .4,
							items: [{
								xtype: 'numberfield',
								width: 50,
								name: 'reghr',
								value: 0
							}]
						},{
							xtype: 'panel',
							layout: 'vbox',
							flex: .4,
							items: [{
								xtype: 'numberfield',
								width: 50,
								name: 'othr',
								value: 0
							}]
						},{
							xtype: 'panel',
							layout: 'vbox',
							flex: .4,
							items: [{
								xtype: 'numberfield',
								width: 50,
								name: 'ndhr',
								value: 0
							}]
						}]
					}]);
				}
			},{
				xtype: 'button',
				text: 'Remove',
				handler: function(thisb) {
					var totc = thisb.up('container[name=totalcontainer]');
					var itemL = totc.items.length;
					totc.remove(itemL -  1);
					crfP.setHeight(totc.getHeight() + 40);
				}
			},{
				xtype: 'button',
				text: 'Compute',
				handler: function(thisb) {
					recomputeAll(thisb);
				}
			}]
		},{
			xtype: 'container',
			width: '100%',
			defaults: {
				padding: 2
			},
			layout: {
				type: 'hbox',
				align: 'stretch'
			},
			items: [{
				xtype: 'panel',
				layout: 'vbox',
				flex: .3,
				items: [{
					xtype: 'displayfield',
					value: 'DUTY TYPE',
					width: 50
				}]
			},{
				xtype: 'panel',
				layout: 'vbox',
				flex: .5,
				items: [{
					xtype: 'displayfield',
					value: 'DATE NEEDED',
					width: 100
				}]
			},{
				xtype: 'panel',
				layout: 'vbox',
				flex: .7,
				items: [{
					xtype: 'displayfield',
					value: 'NAME OF AGENCY',
					width: 60
				}]
			},{
				xtype: 'panel',
				layout: 'vbox',
				flex: .5,
				items: [{
					xtype: 'displayfield',
					value: 'No. of Casuals',
					width: '100'
				}]
			},{
				xtype: 'panel',
				layout: 'vbox',
				flex: .5,
				items: [{
					xtype: 'displayfield',
					value: 'Hours/Day',
					width: 100
				}]
			},{
				xtype: 'panel',
				layout: 'vbox',
				flex: .5,
				items: [{
					xtype: 'displayfield',
					value: 'No. of Days',
					width: 100
				}]
			},{
				xtype: 'panel',
				layout: 'vbox',
				flex: .4,
				items: [{
					xtype: 'displayfield',
					value: 'REG. HR.',
					width: 100
				}]
			},{
				xtype: 'panel',
				layout: 'vbox',
				flex: .4,
				items: [{
					xtype: 'displayfield',
					value: 'OT. HR.',
					width: 100
				}]
			},{
				xtype: 'panel',
				layout: 'vbox',
				flex: .4,
				items: [{
					xtype: 'displayfield',
					value: 'ND. HR.',
					width: 100
				}]
			}]
		}]
	}]);
	var dgrid = Ext.ComponentQuery.query('grid[alias=widget.eFormGrid]')[0];
	try {
	var gdata = dgrid.getSelectionModel().getSelection()[0];
	} catch(e) { return true; }
	if(gdata) {
		var dpid = gdata.data.C__ECINCRF__PERSONNELIDNO;
		var docnum = gdata.data.C__ECINCRF__DOCNUMBER;
	} else {
		return true;
	}
	var doct = theform.down('textfield[name=C__ECINCRF__DOCNUMBER]').getValue();
	if(doct.trim().length > 0 ) {
		var docnum = doct;
	}
	crfP.doLayout();
	var dtot = crfP.down('container[name=totalcontainer]');
	crfP.getEl().mask('Loading...');
	Ext.Ajax.request({
	    url: '../../data/form/saveCRFdetails.cfm',
	    params: {
	    	docnum: docnum,
	        personnelidno: dpid,
	        action: 'getrec'
	    },
	    success: function(response){
	    	crfP.getEl().unmask();
	    	var text = response.responseText;
	    	if(text.trim() == 'false') {
	    		alert("There is a problem loading the duty type details.");
	    	} else if(text.trim().length < 1) {
	    		return true;
	    	} else {
	    		var retArr = text.split('~');
	    		var readonlyVal = retArr[0];
	    		if(readonlyVal == 'true') {
	    			var btn = dtot.query('button');
		    		btn.forEach(function(dbtn) {
		    			dbtn.hide();
		    		});
	    		}
	    		for(b=1;b<retArr.length;b++) {
	    			var eleArr = retArr[b].split(',');
	    			if(eleArr[1].trim().length < 1) {
	    				return true;
	    			}
	    			dtot.add([{
						xtype: 'container',
						width: '100%',
						defaults: {
							padding: 2
						},
						layout: {
							type: 'hbox',
							align: 'stretch'
						},
						items: [{
							xtype: 'panel',
							layout: 'vbox',
							flex: .3,
							items: [{
								xtype: 'combobox',
								store: dtype,
								displayField: 'displayname',
								valueField: 'codename',
								queryMode: 'local',
								width: 50,
								value: eleArr[0],
								readOnly: readonlyVal,
								name: 'dutytype'
							}]
						},{
							xtype: 'panel',
							layout: 'vbox',
							flex: .5,
							items: [{
								xtype: 'datefield',
								width: 95,
								name: 'dateneeded',
								readOnly: readonlyVal,
								value: eleArr[1]
							}]
						},{
							xtype: 'panel',
							layout: 'vbox',
							flex: .7,
							items: [{
								xtype: 'combobox',
								store: agencyStore,
								displayField: 'displayname',
								valueField: 'codename',
								queryMode: 'remote',
								pageSize: 30,
								width: 117,
								value: eleArr[2],
								minChars: 1,
								readOnly: readonlyVal,
								name: 'nameofagency'
							}]
						},{
							xtype: 'panel',
							layout: 'vbox',
							flex: .5,
							items: [{
								xtype: 'numberfield',
								width: 60,
								name: 'noofcasuals',
								readOnly: readonlyVal,
								value: eleArr[3]
							}]
						},{
							xtype: 'panel',
							layout: 'vbox',
							flex: .5,
							items: [{
								xtype: 'numberfield',
								width: 60,
								name: 'noofhoursperday',
								readOnly: readonlyVal,
								value: eleArr[4]
							}]
						},{
							xtype: 'panel',
							layout: 'vbox',
							flex: .5,
							items: [{
								xtype: 'numberfield',
								width: 60,
								name: 'noofdays',
								readOnly: readonlyVal,
								value: eleArr[5]
							}]
						},{
							xtype: 'panel',
							layout: 'vbox',
							flex: .4,
							items: [{
								xtype: 'numberfield',
								width: 50,
								name: 'reghr',
								readOnly: readonlyVal,
								value: eleArr[6]
							}]
						},{
							xtype: 'panel',
							layout: 'vbox',
							flex: .4,
							items: [{
								xtype: 'numberfield',
								width: 50,
								name: 'othr',
								readOnly: readonlyVal,
								value: eleArr[7]
							}]
						},{
							xtype: 'panel',
							layout: 'vbox',
							flex: .4,
							items: [{
								xtype: 'numberfield',
								width: 50,
								name: 'ndhr',
								readOnly: readonlyVal,
								value: eleArr[8]
							}]
						}]
					}]);
				}
				crfP.setHeight(dtot.getHeight() + 40);
	    	}
	    }
	});
	} catch(e) {console.log(e); return true;}
}}, emptyCls: '

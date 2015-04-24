', listeners: {
	render: function(d) {
		console.log('test test');
		var dform = d.up('form');
		var dfieldset = dform.down('panel[title=CTO]');
  		console.log(dfieldset);
		dfieldset.insert(2,[{
			xtype: 'button',
			text: 'Get EH',
			anchor: '30%',
			margin: '0 0 0 170',
			handler: function(dbtn) {
				console.log(dbtn);
				Ext.create('Ext.data.Store', {
    					storeId:'ehStore',
    					fields:['referencedate', 'itemcode', 'itemvalue'],
    					data:{'items':[
        					{ 'referencedate': '2015-01-01',  "itemcode":"CTO",  "itemvalue":5  },
						{ 'referencedate': '2015-02-01',  "itemcode":"CTO",  "itemvalue":1  },
						{ 'referencedate': '2015-03-01',  "itemcode":"CTO",  "itemvalue":6  },
						{ 'referencedate': '2015-04-01',  "itemcode":"CTO",  "itemvalue":9  },
    					]},
    					proxy: {
        				type: 'memory',
        				reader: {
            				type: 'json',
            				root: 'items'
        				}
    					}
				});
				Ext.create('Ext.window.Window', {
					title: 'Get EH',
					multiSelect: true,
					width: 400,
					height: 400,
					items: [{
						xtype: 'grid',
						multiSelect: true,
						selModel: Ext.create ('Ext.selection.CheckboxModel') ,
						store: Ext.data.StoreManager.lookup('ehStore'),
    					columns: [
        					{ text: 'Reference Date',  dataIndex: 'referencedate' },
        					{ text: 'Item Code', dataIndex: 'itemcode', flex: 1 },
        					{ text: 'Item Value', dataIndex: 'itemvalue' }
    					],
    					height: 320,
    					width: 400
					},{
						xtype: 'button',
						text: 'Ok',
						buttonAlign: 'center',
						padding: '5 20 5 20',
						action: 'selectitemvalue',
						handler: function(dbt) {
							var dwin = dbt.up('window');
							var dgrid = dwin.down('grid');
							console.log(dgrid);
							var seld = dgrid.getSelectionModel().getSelection();
							var itemcode = '';
							var itemvalue = 0;
						     for(a=0;a<seld.length;a++) {
							itemcode = seld[a].data.itemcode;
							itemvalue += seld[a].data.itemvalue;
						     }
							dform.down('textfield[name=C__CINCTO__ITEMCODE]').setValue(itemcode);
							dform.down('textfield[name=C__CINCTO__ITEMVALUE]').setValue(itemvalue);
							dwin.hide();
						}
					}]
				}).show();
			}
		}]);
	}
}, emptyCls: '
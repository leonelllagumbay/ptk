Ext.define('Form.view.forum.forumListGrid', { 
	extend: 'Ext.grid.Panel',
	alias: 'widget.forumlistgrid',
	title: 'eForums List',
	width: '30%', 
	height: '100%',
	autoScroll: true,
	
	initComponent: function() {    
	
		this.features = [{
			ftype: 'filters',
			encode: true, // json encode the filter query
			local: false, 
			filters: [{
				type: 'string',
				dataIndex: 'DESCRIPTION'
			}]
		}];
	 
	    
		this.store = 'forum.forumListStore';
		
		this.bbar = Ext.create('Ext.toolbar.Paging', {
				        store: 'forum.forumListStore', 
				        displayInfo: true,
				        emptyMsg: "Nothing to display"
				   });
		 
		this.columns =  [{
		  	text: 'FORUMCODE',
			dataIndex: 'FORUMCODE',
			hidden: true,
			filterable: true,
			flex: 1
		  },{
		  	text: 'COMPANYCODE',
			dataIndex: 'COMPANYCODE',
			hidden: true,
			filterable: true,
			width: 100 
		  },{
		  	text: 'PERSONNELIDNO',
			dataIndex: 'PERSONNELIDNO',
			hidden: true,
			filterable: true,
			width: 100 
		  },{
		  	text: 'EFORUMEMAIL',
			dataIndex: 'EFORUMEMAIL',
			hidden: true,
			filterable: true,
			width: 100 
		  },{
		  	text: 'ALLOWEMAILNOTIF',
			dataIndex: 'ALLOWEMAILNOTIF',
			hidden: true,
			filterable: true,
			width: 100
		  },{
		  	text: '',
			dataIndex: 'UNREAD',
			hidden: false,
			filterable: true,
			width: 50,
			renderer: function(value, metaData, record) {
				if(value == 0 || value == '') {
					return value;
				} else {
					return "<span style='background-color: red; border-radius: 12px; color: white;'><b>&nbsp;"+value+"&nbsp;</b></span>";
				}
			} 
		  },{
		  	text: 'List',
			dataIndex: 'DESCRIPTION',
			hidden: false,
			filterable: true,
			flex: 1
		  },{
		    text: 'Date Last Update',
		    dataIndex: 'DATELASTUPDATE',
			hidden: true,
			editor: {
				xtype: 'datefield'
			},
		    width: 100,
			renderer: Ext.util.Format.dateRenderer('n/j/Y'),
			filter: {
				type: 'date',
				format: 'Y-n-j'
			}
		  }],
		
		this.callParent(arguments);
	}
});

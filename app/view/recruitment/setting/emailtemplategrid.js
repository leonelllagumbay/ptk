var filters = {
        ftype: 'filters',
        encode: true,
        local: false,  
    };

Ext.define('Form.view.recruitment.setting.emailtemplategrid', {
    extend: 'Ext.grid.Panel',
    alias: 'widget.writergrid',
	width: '100%',
	height: 300,
    title: 'e-mail Template List',
    features: [filters], 
    requires: [
        'Ext.grid.plugin.CellEditing',
        'Ext.form.field.Text',
        'Ext.toolbar.TextItem'
    ],

    initComponent: function(){

        this.editing = Ext.create('Ext.grid.plugin.CellEditing');
        this.store = 'recruitment.setting.emailstore';
		this.bbar = Ext.create('Ext.toolbar.Paging', {
				        store: 'recruitment.setting.emailstore', 
				        displayInfo: true,
				        emptyMsg: "No topics to display"
				   });
        Ext.apply(this, {
            iconCls: 'icon-grid',
            frame: true,
            plugins: [this.editing],
            dockedItems: [{
                xtype: 'toolbar',
                items: [{
                    iconCls: 'icon-delete',
                    text: 'Delete',
                    disabled: true,
                    itemId: 'delete',
					action: 'delete',
                    scope: this
                }]
            }],
            columns: [{
	            xtype: 'rownumberer',
				locked: true,
	            width: 50,
	            sortable: false
	        },{
                header: 'Name',
                width: '100%',
                sortable: true,
                dataIndex: 'NAME'
            },{
                header: 'Subject Template',
                width: 10,
				hidden: true,
                sortable: true,
                dataIndex: 'SUBJECTTPL'
            },{
                header: 'Body Template',
                width: 10,
                sortable: true,
				hidden: true,
                dataIndex: 'BODYTPL'
            }]
        });
        this.callParent();
    },
    
    

});
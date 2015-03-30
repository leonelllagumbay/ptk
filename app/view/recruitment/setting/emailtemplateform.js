Ext.define('Form.view.recruitment.setting.emailtemplateform', {
    extend: 'Ext.form.Panel',
    alias: 'widget.writerform',
	width: '100%',
	height: 500,
	requires: ['Ext.form.field.Text'],

    initComponent: function(){
        this.addEvents('create');
        Ext.apply(this, {
            activeRecord: null,
            iconCls: 'icon-user',
            frame: true,
            title: 'e-mail Template',
            defaultType: 'textfield',
            bodyPadding: 5,
            fieldDefaults: {
                anchor: '100%',
                labelAlign: 'right'
            },
            items: [{
				xtype: 'displayfield',
				fieldLabel: 'Variables to use',
				value: 'Example: Last Name: {Last Name}, will replace {Last Name} with the last name of the applicant. Sample result: Last Name: Smith.'
			},{
                fieldLabel: 'Name',
                name: 'NAME',
                allowBlank: false
            },{
                fieldLabel: 'Subject Template',
                name: 'SUBJECTTPL',
				value: ' ',
                allowBlank: false,
				xtype: 'htmleditor'
            },{
                fieldLabel: 'Body Template',
                name: 'BODYTPL',
				value: ' ',
                allowBlank: false,
				xtype: 'htmleditor'
            }],
            dockedItems: [{
                xtype: 'toolbar',
                dock: 'bottom',
                ui: 'footer',
                items: ['->', {
                    iconCls: 'icon-save',
                    itemId: 'save',
					action: 'save',
                    text: 'Save',
                    disabled: true,
                    scope: this
                }, {
                    iconCls: 'icon-user-add',
                    text: 'Create',
					action: 'create',
                    scope: this
                }, {
                    iconCls: 'icon-reset',
                    text: 'Reset',
					action: 'reset',
                    scope: this
                }]
            }]
        });
        this.callParent();
    },

    setActiveRecord: function(record){
        this.activeRecord = record;
        if (record) {
            this.down('#save').enable();
            this.getForm().loadRecord(record);
        } else {
            this.down('#save').disable();
            this.getForm().reset();
        }
    },

 
});
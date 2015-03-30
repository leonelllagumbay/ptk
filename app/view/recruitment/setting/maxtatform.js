Ext.define('Form.view.recruitment.setting.maxtatform', {
    extend: 'Ext.form.Panel',
    alias: 'widget.maxtatform',
	width: '100%',
	height: 600,
	collapsible: true,
	collapsed: true,

    requires: ['Ext.form.field.Text'],

    initComponent: function(){
        this.api = {
		        // The server-side method to call for load() requests
		        load:   Ext.ss.setting.getmaxtat,
		        // The server-side must mark the submit handler as a 'formHandler'
		        submit: Ext.ss.setting.savemaxtat
		    },
        Ext.apply(this, {
            activeRecord: null,
            iconCls: 'icon-user',
            frame: true,
            title: 'MRF Status Maximum TAT',
            defaultType: 'numberfield',
            bodyPadding: 5,
            fieldDefaults: {
                anchor: '100%',
                labelAlign: 'right'
            },
            items: [{
				fieldLabel: 'MRF to Posting',
				name: 'TOTALTATMRFPOST',
				labelWidth: '50%',
				allowBlank: false
			},{
                fieldLabel: 'Sourcing',
				name: 'TOTALTATSOURCING',
				labelWidth: '50%',
				allowBlank: false
            },{
                fieldLabel: 'Pre-screen to Invite',
				name: 'TOTALTATPRESCREENINVITE',
				labelWidth: '50%',
				allowBlank: false
            },{
                fieldLabel: 'Exam to HR Interview',
				name: 'TOTALTATEXAMHRINT',
				labelWidth: '50%',
				allowBlank: false
            },{
                fieldLabel: 'Pre-Screen Summary',
				name: 'TOTALTATSUMMARYSC',
				labelWidth: '50%',
				allowBlank: false
            },{
                fieldLabel: 'HR Interview to Feedback',
				name: 'TOTALTATHRFEEDBACK',
				labelWidth: '50%',
				allowBlank: false
            },{
                fieldLabel: 'Feedback of HR interview to First Department Interview',
				name: 'TOTALTATHDFD',
				labelWidth: '50%',
				allowBlank: false
            },{
                fieldLabel: 'First Department Interview Feedback',
				name: 'TOTALTATFD',
				labelWidth: '50%',
				allowBlank: false
            },{
                fieldLabel: 'First Department Interview TAT Summary',
				name: 'TOTALTATSUMMARYFD',
				labelWidth: '50%',
				allowBlank: false
            },{
                fieldLabel: 'Feedback of First to Second Department Interview',
				name: 'TOTALTATHDSD',
				labelWidth: '50%',
				allowBlank: false
            },{
                fieldLabel: 'Second Department Interview Feedback',
				name: 'TOTALTATSD',
				labelWidth: '50%',
				allowBlank: false
            },{
                fieldLabel: 'Second Department Interview TAT Summary',
				name: 'TOTALTATSUMMARYSD',
				labelWidth: '50%',
				allowBlank: false
            },{
                fieldLabel: 'Second Department Interview to Final Interview',
				name: 'TOTALTATHDMD',
				labelWidth: '50%',
				allowBlank: false
            },{
                fieldLabel: 'Final Interview Feedback/Hiring Decision',
				name: 'TOTALTATMD',
				labelWidth: '50%',
				allowBlank: false
            },{
                fieldLabel: 'Final Interview TAT Summary',
				name: 'TOTALTATSUMMARYMD',
				labelWidth: '50%',
				allowBlank: false
            },{
                fieldLabel: 'Job Offer',
				name: 'TOTALTATJOBOFFER',
				labelWidth: '50%',
				allowBlank: false
            },{
                fieldLabel: 'Job Offer TAT Summary',
				name: 'TOTALTATSUMMARYJO',
				labelWidth: '50%',
				allowBlank: false
            },{
                fieldLabel: 'Pre-employment TAT Summary',
				name: 'TOTALTATREQ',
				labelWidth: '50%',
				allowBlank: false
            },{
                fieldLabel: 'Contract',
				name: 'TOTALTATCONTRACT',
				labelWidth: '50%',
				allowBlank: false
            },{
                fieldLabel: 'Total',
				name: 'TOTALTATTOTAL',
				labelWidth: '50%',
				allowBlank: false
            }],
            dockedItems: [{
                xtype: 'toolbar',
                dock: 'bottom',
                ui: 'footer',
                items: ['->', {
                    iconCls: 'icon-save',
                    itemId: 'save',
                    text: 'Save',
                    scope: this,
					action: 'save'
                }]
            }]
        });
        this.callParent();
    }

});
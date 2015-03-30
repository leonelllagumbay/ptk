
Ext.define('Form.view.query.generatedQuery', {
	extend: 'Ext.form.field.TextArea',
	alias: 'widget.generatedquery',
	flex: 1,
	initComponent: function() {
		this.overflowX = true;
		this.overflowY = true;
		this.value = "";
		this.width = '100%';
		this.emptyText = "In the 'Selected' panel, drag and drop table(s) and see the generated query here.";
		this.callParent(arguments);
	}
});
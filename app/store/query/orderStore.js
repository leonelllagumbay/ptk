Ext.define('Form.store.query.orderStore', {
	extend: 'Ext.data.Store',
	model: 'Form.model.query.orderModel', 
	data: [{
		ORDERCODE: 'ASC',
		ORDERNAME: 'Ascending'
	},{
		ORDERCODE: 'DESC',
		ORDERNAME: 'Descending'
	}]	
});

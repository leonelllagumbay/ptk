Ext.define('Form.controller.home.homecontroller', {
    extend: 'Ext.app.Controller',
	views: [
    ],
	models: [
	],
	stores: [
	],
	init: function() {
		var companyid = getURLParameter("companyid");
		if(!companyid) {
			companyid = '';
		}
		Ext.home.Home.getCompanyTpl(companyid,function(resp) {
			Ext.home.Home.getCompanyTplData(resp.tpldatacode, function(resp2) {
				var tpl = new Ext.XTemplate(resp.tplarray);
				tpl.overwrite(Ext.getBody(), resp2);
			});
		});
		
		    
			
        this.control({
            'homeview': {  
			}
		});
     }
});
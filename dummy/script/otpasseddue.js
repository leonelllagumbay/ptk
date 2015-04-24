passdue: function(val, field) {
var theF = field.up('form');

var refDate = theF.down('datefield[name=C__ECINOT__REFERENCEDATE]').getValue();
var otDate = theF.down('datefield[name=C__ECINOT__OTDATE]').getValue();
var otRef = theF.down('datefield[name=C__ECINOT__OTDATE]');
otRef.getEl().mask("Loading...");
if(refDate == '' || otDate == '') {
	return true;
}
refDate = Date.parse(refDate);
otDate = Date.parse(otDate);
if(otDate > refDate) {
	Ext.Ajax.request({
	    url: '../../data/form/otpassedue.cfm',
	    params: {
	        id: 1
	    },
	    success: function(response){
	    	otRef.unmask();
	        var textdate = response.responseText;
	        var ptdate = Date.parse(textdate);
	        console.log(otDate);
	        console.log(ptdate);
	        if(otDate <= ptdate) {
	        	statxxxx = true;
	        } else {
	        	statxxxx = false;
	        }
	    }
	});
	if(typeof statxxxx === 'undefined') {
	} else {
		if(statxxxx == true) {
			return true;
		} else {
			alert('OT date reached the OT passed due expiration date. \nFix OT date to continue.');
			return false;
		}
	}	
} else {
	alert('Not yet passed due. Use the Overtime Permit eForm instead.');
	otRef.unmask();
	return false;
}
},passdueText: 'Not yet passed due. Use the Overtime Permit eForm instead.',
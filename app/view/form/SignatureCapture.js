Ext.define('Form.view.form.SignatureCapture', {
    extend: 'Ext.Container',
    alias : 'widget.signatureCapture',
    
    layout: {
        type: 'hbox',
        align: 'left'
    },
    width: 700,
    height: 200,
    
    items: [
        {
            xtype: 'panel',
            action: 'signature',
            html: '<canvas id="signaturePanel" width="500" height="200">no canvas support</canvas>'
        },{
            xtype: 'button',
            margin: '20 5 0 5',
            text: 'Save Signature',
            action: 'save',
            disabled: true,
       },{
            xtype: 'button',
            margin: '20 5 0 5',
            text: 'Clear Signature',
            action: 'clear'
        }]
   
});
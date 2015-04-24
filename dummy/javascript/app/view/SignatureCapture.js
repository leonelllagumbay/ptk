Ext.define('MyApp.view.SignatureCapture', {
    extend: 'Ext.Container',
    alias : 'widget.signatureCapture',
    
    layout: {
        type: 'vbox',
        align: 'stretch'
    },
    width: 600,
    height: 300,
    border: 1,
    style: {borderColor:'#000000', borderStyle:'solid', borderWidth:'1px'},
    
    items: [
        {
            xtype: 'panel',
            id: 'signature',
            html: '<canvas id="signaturePanel" width="600" height="300">no canvas support</canvas>'
        }]
   
});
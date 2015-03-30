Ext.Loader.setConfig({enabled: true});

Ext.Loader.setPath('Ext.ux', '../../../scripts/extjs/examples/ux');
Ext.require([
    'Ext.grid.*',
    'Ext.data.*',
    'Ext.util.*',
    'Ext.grid.plugin.BufferedRenderer',
    'Ext.ux.form.SearchField'
]);


Ext.onReady(function(){
	
	var companydsn = document.getElementById('companycodecodeidid').innerHTML;
	   
	
    Ext.define('ForumThread', {
        extend: 'Ext.data.Model',
        fields: [
            'POSITIONCODE', 'DEPARTMENTCODE', 'USERID', 'REQUESTEDBY', {
                name: 'REQUIREDNO',
                type: 'int'
            }, {
                name: 'DATEACTIONWASDONE',
                type: 'date'
            },
            'REQUESTEDBY', 'excerpt', 'COMPANYCODE', 'REQUISITIONNO'
        ],
        idProperty: 'REQUISITIONNO'
    });

    // create the Data Store
    var store = Ext.create('Ext.data.Store', {
        
		model: 'ForumThread',
        remoteGroup: true,
        // allow the grid to interact with the paging scroller by buffering
        buffered: true,
        leadingBufferZone: 10,
        pageSize: 50,
        proxy: {
            // load using script tags for cross domain, if the data in on the same domain as
            // this page, an Ajax proxy would be better
            type: 'jsonp',
            url: 'careerscompany.cfm',
            reader: {
                root: 'topics',
                totalProperty: 'totalCount'
            },
            // sends single sort as multi parameter
            simpleSortMode: true,
            // sends single group as multi parameter
            simpleGroupMode: true,

            // This particular service cannot sort on more than one field, so grouping === sorting.
            groupParam: 'sort',
            groupDirectionParam: 'dir',
			// Parameter name to send filtering information in
            filterParam: 'query',
			extraParams: {
				companydsn: companydsn
			},

            // The PHP script just use query=<whatever>
            encodeFilters: function(filters) {
                return filters[0].value;
			}
			
        },
        sorters: [{
            property: 'DATEACTIONWASDONE',
            direction: 'DESC'
        }],
		remoteFilter: true,
        autoLoad: true,
        listeners: {

            // This particular service cannot sort on more than one field, so if grouped, disable sorting
            groupchange: function(store, groupers) {
                var sortable = !store.isGrouped(),
                    headers = grid.headerCt.getVisibleGridColumns(),
                    i, len = headers.length;
                
                for (i = 0; i < len; i++) {
                    headers[i].sortable = (headers[i].sortable !== undefined) ? headers[i].sortable : sortable;
                }
            },

            // This particular service cannot sort on more than one field, so if grouped, disable sorting
            beforeprefetch: function(store, operation) {
                if (operation.groupers && operation.groupers.length) {
                    delete operation.sorters;
                }
            }
        }
    });
	
	function onStoreSizeChange() {
        grid.down('#status').update({count: store.getTotalCount()});
    }

    function renderTopic(value, p, record) {
        return Ext.String.format(
            '<a href="mrfviewer.cfm?reqno=' + record.data.REQUISITIONNO + '&companydsn=' + companydsn +'&norevert=NOREVERT" target="_blank">{0}</a>',
            value,
            record.data.forumtitle,
            record.getId(),
            record.data.forumid
        );
    }

    var grid = Ext.create('Ext.grid.Panel', {
        width: 700,
        height: 450,
        collapsible: true,
        title: 'Careers',
        store: store,
        loadMask: true,
        dockedItems: [{
            dock: 'top',
            xtype: 'toolbar',
            items: [{
                width: 400,
                fieldLabel: 'Search',
                labelWidth: 50,
                xtype: 'searchfield',
                store: store
            }, '->', {
                xtype: 'component',
                itemId: 'status',
                tpl: 'Matching threads: {count}',
                style: 'margin-right:5px'
            }]
        }],
        selModel: {
            pruneRemoved: false
        },
        multiSelect: true,
        viewConfig: {
            trackOver: false,
            emptyText: '<h1 style="margin:20px">No matching results</h1>'
        },
        // grid columns
        columns:[{
            xtype: 'rownumberer',
            width: 50,
            sortable: false
        },{
            tdCls: 'x-grid-cell-topic',
            text: "Position",
            dataIndex: 'POSITIONCODE',
            flex: 1,
            renderer: renderTopic,
            sortable: true
        },{
            text: "Company",
            dataIndex: 'COMPANYCODE',
			align: 'center',
            width: 90,
            sortable: true
        },{
            text: "Requisition Number",
            dataIndex: 'REQUISITIONNO',
            width: 100,
            hidden: true,
            sortable: true
        },{
            text: "Required No.",
            dataIndex: 'REQUIREDNO',
            align: 'center',
            width: 95,
            sortable: false
        },{
            id: 'DATEACTIONWASDONE',
            text: "Last Post",
            dataIndex: 'DATEACTIONWASDONE',
            width: 120,
            renderer: Ext.util.Format.dateRenderer('n/j/Y'),
            sortable: true
        }],
        renderTo: Ext.getBody()
    });
});
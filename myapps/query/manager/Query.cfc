component
ExtDirect = "true"
{
	public struct function generateQuery(
											required string thequery,
											required array  groupby,
											required string name,
											required string group,
											required string rowsperpage,
											required string header,
											required string footer,
											required string preprocess,
											required string postprocess 
										) 
	ExtDirect="true"
	{
		try
        {
        	a = StructNew();
        	a['b'] = thequery;
        	a['c'] = groupby;
        	a['d'] = name;
        	a['e'] = group;
        	a['f'] = rowsperpage;
        	a['g'] = header;
        	a['h'] = footer;
        	a['i'] = preprocess;
        	a['j'] = postprocess;
			return a;
        }
        catch(Any e)
        {
        	a['e'] = e;
        	return a;
        }

	}
	
}
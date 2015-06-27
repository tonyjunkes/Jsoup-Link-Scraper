component name="LinkChecker"
	output="false"
{
	public any function init()
		output="false"
	{
		return this;
	}

    public array function getStatus(array links = [])
        output="false"
    {
    	var connection = "";
    	var collection = [];
    	var status = {site: "", code: ""};
    	
    	for (var link in arguments.links) {
    		try {
    			connection = new http(url = link, method = "GET", timeout = 1000).send().getPrefix();
    			status = { site: link, code: connection.statuscode };
    			arrayAppend(collection, status);
    		}
    		catch(any e) {
    			arrayAppend(collection, {site: link, code: "ERROR: #e.message#"});
    		}
    	}

    	return collection;
    }
}
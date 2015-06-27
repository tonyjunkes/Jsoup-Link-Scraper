component
	output="false"
{
	this.javaSettings = {loadPaths = ["./lib"]};

	public void function onError(any exception, string event) {
		writeOutput("<h1>Error</h1>");
		writeDump(arguments.exception);
	}
}
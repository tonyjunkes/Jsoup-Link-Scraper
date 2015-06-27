component
	output="false"
{
	THIS.javaSettings = {LoadPaths = ["./lib"], watchExtensions = "jar"};

	public void function onError(any exception, string event) {
		writeOutput("<h1>Error</h1>");
		writeDump(ARGUMENTS.exception);
	}
}
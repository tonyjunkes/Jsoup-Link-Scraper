<cfsetting requesttimeout="50000">

<h1>LinkChecker : URL Status Code Checker Built on ColdFusion &amp; JSoup</h1>

<!--- Site URL goes here --->
<cfset siteAddress = "">

<cfscript>
	links = createObject("component", "Jsoup-Link-Scraper.LinkScraper").init(siteAddress).scrapeLinks(filter = [chr(35)]);
	linkChecker = createObject("component", "components.LinkChecker").init();
	
	writeDump(linkChecker.getStatus(links));
</cfscript>
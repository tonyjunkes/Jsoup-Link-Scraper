<cfsetting requesttimeout="50000">

<h1>LinkScraper : Website URL Scraper Built on ColdFusion &amp; jSoup</h1>

<cfset siteAddress = "">

<cfscript>
	writeDump(createObject("component", "LinkScraper").init(website = siteAddress).scrapeLinks([chr(35)]));
</cfscript>
<cfsetting requesttimeout="50000">

<h1>LinkScraper : Website URL Scraper Built on ColdFusion &amp; jSoup</h1>

<cfset siteAddress = "">

<cfscript>
	writeDump(createObject("component", "LinkScraper").init(website = siteAddress, filter = [chr(35)]).scrapeLinks());
</cfscript>
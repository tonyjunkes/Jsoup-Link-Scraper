<cfsetting requesttimeout="50000">

<h1>LinkScraper : Website URL Scraper Built on ColdFusion &amp; jSoup</h1>

<!--- Site URL goes here --->
<cfset siteAddress = "">

<cfscript>
	writeDump(createObject("component", "Jsoup-Link-Scraper.LinkScraper").init(website = siteAddress).scrapeLinks(filter = [chr(35)], skipRelFollow = true, includeExternalLinks = false));
</cfscript>
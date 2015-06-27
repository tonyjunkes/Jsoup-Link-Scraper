<cfsetting requesttimeout="50000">

<h1>SitemapBuilder : Sitemap Generator Built on ColdFusion &amp; JSoup</h1>

<!--- Site URL goes here --->
<cfset siteAddress = "">

<cfscript>
	links = createObject("component", "components.LinkScraper").init(siteAddress).scrapeLinks(filter = [chr(35)], includeExternalLinks = false);
	sitemapBuilder = createObject("component", "components.SitemapBuilder").init();
	
	writeDump(sitemapBuilder.makeSitemap(links));
</cfscript>
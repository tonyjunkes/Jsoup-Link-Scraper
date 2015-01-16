component name="LinkScraper"
	output="false"
{
	public any function init(required website = "")
		output="false"
	{
		variables.jSoup = createObject("java", "org.jsoup.Jsoup");
		variables.website = (
			!findNoCase(left(arguments.website, 7), "http://")
			? "http://" & arguments.website : arguments.website
		);
        	
		return this;
	}

	public array function scrapeLinks(
		array filter = [],
		boolean skipRelFollow = true,
		boolean includeExternalLinks = true
	)
		output="false"
	{
		var link = "";
		var linksToSearch = var linkResults = [];
		// jSoup connection closure
		var connect = function(u) {
			//"ignoreContentType" is used in case we hit a non-HTML page like XML.
			return variables.jSoup.connect(u).timeout(5000).ignoreContentType(true).get().select("a");
		};
		// URL filter closure
		var urlFilter = function(filter, value) {
			for (element in filter) { return find(element, value) > 0 ? true : false; }
		};
		//Initial pass over first page to gather starting links to scrape.
		var links = connect(variables.website);
		for (var href in links) {
			href = href.attr("abs:href");
			if (!urlFilter(arguments.filter, href) && !arrayFind(linksToSearch, href)) { arrayAppend(linksToSearch, href); }
		}
		//Pass over each link URL initially collected and continue to scrape "unique" links found on those pages.
		while (arrayLen(linksToSearch)) {
			arrayEach(linksToSearch, function(href) {
				if (!urlFilter(filter, href) && !arrayFind(linkResults, href)) {
					arrayAppend(linkResults, href);
					if (findNoCase(left(href, 8), "https://")) {
						try { match = connect(href); }
						catch(any e) { arrayDelete(linksToSearch, href); }
					} else {
						match = connect(href);
					}
					if (skipRelFollow) {
						match = arrayFilter(match, function(e) { return e.attr("rel") != "nofollow"; });
					}
					for (link in match) {
						link = link.attr("abs:href");
						if (!arrayFind(linkResults, link) && len(link)) {
							if (find(variables.website, link)) {
								arrayAppend(linksToSearch, link);
							} else if (includeExternalLinks) {
								arrayAppend(linkResults, link);
							} else {
								arrayDelete(linksToSearch, link);
							}
						}
					}
				}
				arrayDelete(linksToSearch, href);
			});
		}
		arraySort(linkResults, "textnocase", "asc");

		return linkResults;
	}
}

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

	public array function scrapeLinks(array filter = [], boolean respectRelFollow = true)
		output="false"
	{
		var link = var href = "";
		var links = var linksToSearch = var linkResults = [];
		// jSoup connection closure
		var connect = function(u) {
			//"ignoreContentType" is used in case we hit a non-HTML page like XML.
			return variables.jSoup.connect(u).timeout(100000).ignoreContentType(true).get().select("a");
		};
		// URL filter closure
		var urlFilter = function(f, v) { 
			return arrayLen(arrayFilter(f, function(e) { return find(e, v); })) ? true : false;
		};
		// Link extraction closure
		var extractLinks = function(link) {
			if (!urlFilter(filter, link) && !arrayContains(linkResults, link)) {
				arrayAppend(linkResults, link);
				links = connect(link);
				for (href in links) {
					if (respectRelFollow && href.attr("rel") != "nofollow") {
						link = href.attr("abs:href");
					}
					if (find(variables.website, link) && !arrayContains(linkResults, link)) {
						arrayAppend(linksToSearch, link);
					} else if (!arrayContains(linkResults, link)) {
						arrayAppend(linkResults, link);
					}
				}
			}
		};
		//Initial pass over first page to gather starting links to scrape.
		links = connect(variables.website);
		for (href in links) {
			if (arguments.respectRelFollow && href.attr("rel") != "nofollow") {
				link = href.attr("abs:href");
			}
			if (find(variables.website, link)) {
				extractLinks(link);
			}
		}
		//Pass over each link URL initially collected and continue to scrape "unique" links found on those pages.
		while (arrayLen(linksToSearch)) {
			arrayEach(linksToSearch, function(link) {
				extractLinks(link);
				arrayDelete(linksToSearch, link);
			});
		}
		arraySort(linkResults, "textnocase", "asc");

		return linkResults;
	}
}
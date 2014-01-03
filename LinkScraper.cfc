component name="LinkScraper"
	output="false"
{
	public any function init(required website = "", array filter = []) {
		VARIABLES.website = ARGUMENTS.website;
		VARIABLES.filter = ARGUMENTS.filter;

		return THIS;
	}

	public array function scrapeLinks()
		output="false"
	{
		var jsoup = createObject("java", "org.jsoup.Jsoup");
		var link = href = value = "";
		var lengths = {};
		var links = lts = ltns = match = result = [];
		var i = 0;

        if (!reFindNoCase(left(VARIABLES.website, 7), "http://")) {
            VARIABLES.website = "http://" & VARIABLES.website;
        }
        links = jsoup.connect(VARIABLES.website).timeout(100000).get().select("a[href]");
		//Initial pass over first page to gather starting links to scrape.
		for (href in links) {
			link = href.attr("abs:href");
			if (find(VARIABLES.website, link) && !urlFilter(value = link, filterList = VARIABLES.filter) && !arrayContains(lts, link)) {
				arrayAppend(lts, link);
			}
		}
		//Pass over each link URL initially collected and continue to scrape "unique" links found on those pages.
		while (arrayLen(lts)) {
			arrayEach(
				lts,
				function(x) {
					if (!urlFilter(value = x, filterList = VARIABLES.filter) && !arrayContains(ltns, x)) {
						ltns.append(x);
						//"ignoreContentType" is used in case we hit a non-HTML page like XML.
						match = jsoup.connect(x).timeout(100000).ignoreContentType(true).get().select("a[href]");
						for (href in match) {
							link = href.attr("abs:href");
							if (find(VARIABLES.website, link) && !arrayContains(ltns, link)) {
								arrayAppend(lts, link);
							} else if (!arrayContains(ltns, link)) {
								arrayAppend(ltns, link);
							}
						}
					}
					arrayDelete(lts, x);
				}
			);
		}
		//Attempt a more ordered sort for the final array of urls.
		for (i = 1; i <= arrayLen(ltns); i++) {
    		lengths[i] = listLen(ltns[i], "/");
		}
		lengths = structSort(lengths, "numeric", "asc");
		for (value in lengths) {
    		arrayAppend(result, ltns[value]);
		}

		return result;
	}

	private function urlFilter(required string value = "", required array filterList = [])
		output="false"
	{
		var item = "";
		var result = false;

		for (item in ARGUMENTS.filterList) {
			if (find(item, ARGUMENTS.value)) {
				result = true;
			}
		}

		return result;
	}
}
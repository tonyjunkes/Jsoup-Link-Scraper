LinkScraper
===========================

A "Proof of Concept" URL scraper built on ColdFusion 10 and jSoup that will scrape all links from a supplied website address.

Because of how many links that could be, use at your own risk. Preferably in a dev environment first.

This version requires ColdFusion 10 or the Railo equivalent.

The example call in index.cfm grabs the raw return from the scrapeLinks() method in LinkScraper.cfc which returns an array of url addresses.

The init() method allows for an array of values to be passed in as filters against what to return.

NOTE: Filters are your friend as in some cases you could be thrown into the equivalent of a infinite loop. Imagine scraping a calender app with links to future and past dates. Ouch ;)

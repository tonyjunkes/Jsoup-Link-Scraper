LinkScraper
===========================

A "Proof of Concept" URL scraper built on ColdFusion and JSoup that will scrape all &lt;a&gt; links from a supplied URL address.

This version runs with JSoup 1.8.2 and requires ColdFusion 10+ or the Railo/Lucee equivalent.

## To Get Started...

In general, using the `LinkScraper.cfc` is as simple as the example below.

```coldfusion-cfc
x = createObject("component", "path.to.LinkScraper").init("your-site.com");
writeDump( x.scrapeLinks() );
```

There is also an example call in the `index.cfm` that dumps the raw return (an array of URL addresses) from the `scrapeLinks()` method in `LinkScraper.cfc`. Just add a URL address to the `siteaddress` variable in `index.cfm` and run the file.

## Filters Are Your Friend!

The `scrapeLinks()` method can take a few arguments for filtering data. Most have default values already set so the scraper can automatically play nice and not get you in too much of a bind. I've never tested the code on a large site so there's no promises on processing time or errors along the way. In certain cases, you can find yourself practically endless looping over links (think calendars etc.).

Here's what can help with those issues:

- `filter` : An array of strings to search against in a URL to not be included. Defaults to `[]`.
- `skipRelFollow` : A boolean value signaling whether to follow links with the attribute `rel="nofollow"`. Defaults to `true`.
- `includeExternalLinks` : A boolean value signaling whether to collect links that aren't specific to the supplied domain. Defaults to `true`.

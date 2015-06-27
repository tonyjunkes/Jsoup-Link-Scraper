component name="SitemapBuilder"
	output="false"
{
	public any function init()
		output="false"
	{
		return this;
	}

	public struct function makeSitemap(
		array links = [],
		string path = expandPath("./Sitemap.xml"),
		string changefreq = "monthly",
		numeric priority = 0.8
	)
		output="false"
	{
		var data = "";
		var result = {status: "", urls: [], file: ""};

		try {
			savecontent variable="data" {
				writeOutput('
					<?xml version="1.0" encoding="UTF-8"?>
					<urlset
						xmlns="http://www.sitemaps.org/schemas/sitemap/0.9"
						xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
						xsi:schemaLocation="http://www.sitemaps.org/schemas/sitemap/0.9
						http://www.sitemaps.org/schemas/sitemap/0.9/sitemap.xsd">
				');
				for (var link in arguments.links) {
					writeOutput('
						<url>
						  <loc>#link#</loc>
						  <changefreq>#arguments.changefreq#</changefreq>
						  <priority>#arguments.priority#</priority>
						</url>
					');
				}
				writeOutput('
					</urlset>
				');
			}
			fileWrite(arguments.path, data);
			result = {
				status: "Done!",
				urls: arguments.links,
				file: arguments.path
			};
		}
		catch(any e) {
			result.status = e.message;
		}

		return result;
	}
}
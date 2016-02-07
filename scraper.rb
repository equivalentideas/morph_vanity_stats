# This is a template for a Ruby scraper on morph.io (https://morph.io)
# including some code snippets below that you should find helpful

def extract_number(element)
  element.text.delete(",").to_i
end

require 'scraperwiki'
require 'mechanize'

agent = Mechanize.new
page = agent.get("https://morph.io")

metrics_set = page.at(".banner-metrics").search("strong")

metrics = {
  web_pages_scraped: extract_number(metrics_set[0]),
  rows_of_data_collected: extract_number(metrics_set[1]),
  downloads_and_API_queries: extract_number(metrics_set[2]),
  date_scraped: Date.today.to_s
}

p metrics

# Write out to the sqlite database using scraperwiki library
ScraperWiki.save_sqlite([:date_scraped], metrics)
#
# # An arbitrary query against the database
# ScraperWiki.select("* from data where 'name'='peter'")

# You don't have to do things with the Mechanize or ScraperWiki libraries.
# You can use whatever gems you want: https://morph.io/documentation/ruby
# All that matters is that your final data is written to an SQLite database
# called "data.sqlite" in the current working directory which has at least a table
# called "data".

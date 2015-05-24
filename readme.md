MOM WebCrawler and Indexer
==========================

1. Create a new dir and run `wget --recursive -nc -nd --html-extension --domains www.mom.gov.sg --no-parent --show-progress --follow-tags=a www.mom.gov.sg` in that dir.
2. Copy HTML-only files to raw-pages.
3. run `coffee app.coffee` to create solr-formatted JSON, ready to be indexed.
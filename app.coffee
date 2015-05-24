fs = require 'fs'
cheerio = require 'cheerio'

dir = 'raw-pages'
files = fs.readdirSync dir
count = 1
data = []

files.forEach (item) ->
  contents = fs.readFileSync dir + '/' + item, { encoding: 'utf-8' }
  doc = {}
  $ = cheerio.load contents, { ignoreWhitespace: true }
  
  doc.id = count++

  doc.title = $('html title').text().trim()
  
  if ($('#documentdescription_0_DivCode').length > 0)
    doc.description = $('#documentdescription_0_DivCode').text().trim()
  
  body = $('#documentcontent_0_DivCode')
  
  st = []
  subTitles = body.find('h2').each (i, el) ->
    st.push $(this).text().trim()
  doc.subTitles = st if st.length > 0

  doc.body = $('#documentcontent_0_DivCode').text().trim()
  
  data.push doc

fs.writeFileSync 'output/data.json', JSON.stringify(data), { encoding: 'utf-8' }
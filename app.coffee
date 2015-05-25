fs = require 'fs'
cheerio = require 'cheerio'

dir = 'raw-pages'
files = fs.readdirSync dir
count = 1
data = []

files.forEach (item) ->
  # console.log item

  contents = fs.readFileSync dir + '/' + item, { encoding: 'utf-8' }
  doc = {}
  $ = cheerio.load contents, { ignoreWhitespace: true }
  
  doc.id = count++

  doc.title = $('html title').text().trim()
  
  if ($('#documentdescription_0_DivCode').length > 0)
    doc.description = $('#documentdescription_0_DivCode').text().trim()
  
  body = $('#documentcontent_0_DivCode')
  
  st = []
  subTitles = $('body').find('h2').each (i, el) ->
    # console.log 'length >>', $(this).children().length
    # console.log '1st >>', $(this).children().first().text().trim()
    if ($(this).children().length is 0)
      st.push $(this).text().trim()
    else
      # console.log $(this).find('span').first().text()
      # st.push $(this).children().first().text().trim()
      st.push $(this).find('span').first().text().trim()

  st.splice st.length - 2, 2
  doc.subTitles = st if st.length > 0

  doc.body = body.text().trim()

  dataUrl = '/' + $('html meta[name="data_url"]').attr('content')
  # console.log dataUrl
  # doc.url = item.substr(0, item.lastIndexOf('.'))
  doc.url = dataUrl
  
  data.push doc

fs.writeFileSync 'output/data.json', JSON.stringify(data), { encoding: 'utf-8' }
console.log '>> data.json file created..'
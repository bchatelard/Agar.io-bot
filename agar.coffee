server = 'ws://151.80.96.58:1506'
webdriverio = require('webdriverio')
options = { desiredCapabilities: { browserName: 'chrome' } }
fs = require('fs')

fs.readFile('./bot.user.js', 'utf8', (err,data1) ->
  if (err)
    return console.log(err)
  fs.readFile('./launcher.user.js', 'utf8', (err,data2) ->
    if (err)
      return console.log(err)

    webdriverio
        .remote(options)
        .init()
        .url('http://agar.io')
        .execute(data1)
        .execute(data2)
        .execute("$('#adsBottom').remove()")
        .execute("$('#a300x250').remove()")
        .waitForExist('#overlays')
        .execute(((server) ->
          console.log 'Force connect to ' + server
          connect(server)
        ), server)
        .end()
  )
)

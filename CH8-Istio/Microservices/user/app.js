var express = require('express');
var app = express();
var url='http://'+process.env.CATALOG_SERVICE_HOST+':'+process.env.CATALOG_SERVICE_PORT;
app.get('/', function (req, res) {
   console.log("I am in app get==>",url)
   var request = require('request');
request(url, function (error, response, body) {
    if (!error && response.statusCode == 200) {
        res.send(body)
     }
     else
     res.send(body);
})
});

var server = app.listen(8000, function () {
  
})

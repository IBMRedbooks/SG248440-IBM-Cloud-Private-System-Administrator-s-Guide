var express = require('express');
var app = express();
var url='http://www.google.com';
app.get('/', function (req, res) {
   var request = require('request');
request(url, function (error, response, body) {
    if (!error && response.statusCode == 200) {
        res.send("Sanjay Here")
     }
})
  
});

var server = app.listen(8080, function () {
  
})

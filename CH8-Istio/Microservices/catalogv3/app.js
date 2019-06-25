var express = require('express');
var app = express();
var healthy=true;
var url='http://'+process.env.PRODUCT_SERVICE_HOST+':'+process.env.PRODUCT_SERVICE_PORT;
app.get('/', function (req, res) {
   
   var request = require('request');
request(url, function (error, response, body) {
    if (!error && response.statusCode == 200&&healthy) {
        res.send(200,"user==>catalog:v3==>product:"+body);
     }
     else
     res.send(503,'catalog:v3 service not available');
})
});

app.get('/unhealthy', function(req,res){
 healthy=false;
 res.send('service got unhealthy');
 });

var server = app.listen(8000, function () {
  
})

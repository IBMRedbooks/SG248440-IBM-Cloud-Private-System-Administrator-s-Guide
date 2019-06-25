var express = require('express');
var app = express();
var healthy=true;
var timeout=0;
var url='http://'+process.env.PRODUCT_SERVICE_HOST+':'+process.env.PRODUCT_SERVICE_PORT;
app.get('/', function (req, res) {
   
   var request = require('request');
request(url, function (error, response, body) {
    if (!error && response.statusCode == 200&&healthy) {
       setTimeout(function(){
         res.send(200,"user==>catalog:v2==>product::"+body);
       },timeout);
        }
     else
     res.send(503,'catalog:v2 service not available');
   
})
});


app.get('/unhealthy', function(req,res){
 healthy=false;
 res.send('service got unhealthy');
 });


 app.get('/timeout', function(req,res){
   timeout=5000;
   res.send('delayed added in microservice');
   });
  
var server = app.listen(8000, function () {
  
})



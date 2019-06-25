var express = require('express');
var app = express();
//var url='http://'+process.env.CATALOG_SERVICE_HOST+':'+process.env.CATALOG_SERVICE_PORT;
app.get('/', function (req, res) {
   res.send("Able to fetch infromation from product service");
});

var server = app.listen(8000, function () {
  
})

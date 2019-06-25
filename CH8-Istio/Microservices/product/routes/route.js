var appRouter = function (app) {


    app.get("/", function(req1, res1) {
      //******************************************************************** */
      var http = require('http');
 
      /**
       * HOW TO Make an HTTP Call - GET
       */
      // options for GET
      var optionsget = {
          host : process.env.PRODUCT_SERVICE_HOST, // here only the domain name
          // (no http/https !)
          port : process.env.PRODUCT_SERVICE_PORT,
          method : 'GET' // do GET
      };
       
      // console.info('Options prepared:');
      // console.info(optionsget);
      // console.info('Do the GET call');
       
      // do the GET request
      var reqGet = http.request(optionsget, function(res) {
          console.log("statusCode: ", res.statusCode);
          // uncomment it for header details
      //  console.log("headers: ", res.headers);
       
       
          res.on('data', function(d) {
              console.info('GET result::',d);
              process.stdout.write(d);
              console.info('\n\nCall completed');
          });
       
      });
       
      reqGet.end();
      reqGet.on('error', function(e) {
          console.error(e);
      });
      //******************************************************************** */
      //res.status(200).send("Welcome to catalog microservice");
    });
  }
  
  module.exports = appRouter;
  

var Request = require("request");
Request.get("http://localhost:8081", (error, response, body) => {
    if(error) {
        return console.dir(error);
    }
    console.dir(JSON.parse(body));
});

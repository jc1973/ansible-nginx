var http = require('http');

var handleRequest = function(request, response) {
  console.log('Received request for URL: ' + request.url);
  response.writeHead(200);
  response.end('Hello. Check if build and tests workd and get deployed to K8s cluster.');
};
var www = http.createServer(handleRequest);
www.listen(8080);

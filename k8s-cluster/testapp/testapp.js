var http = require('http');

let server = http.createServer(function (req, res) {
  res.writeHead(200, {'Content-type': 'text/html'});
  res.write('<html><body><p>Test.</p></body></html>');
  res.end();
});

server.listen(8080);
console.log('Node.js web server is running and listening on port 8080');
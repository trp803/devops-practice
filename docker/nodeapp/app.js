const http = require('http');
const os = require('os');

const server = http.createServer((req, res) => {
  res.writeHead(200, {'Content-Type': 'text/html; charset=utf-8'});
  res.end(`
    <!DOCTYPE html>
    <html>
    <head><meta charset="UTF-8"></head>
    <body style="font-family:Arial;background:#1a1a2e;color:#eee;text-align:center;padding:50px">
      <h1>🚀 Node.js App</h1>
      <p>Hostname: ${os.hostname()}</p>
      <p>Platform: ${os.platform()}</p>
      <p>Uptime: ${Math.floor(os.uptime())} sec</p>
    </body>
    </html>
  `);
});

server.listen(3000, () => {
  console.log('Server running on port 3000');
});

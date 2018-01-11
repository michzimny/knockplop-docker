var config = module.exports = {}
var fs = require('fs');

config.httpsConfig = {
    key: fs.readFileSync('{{ getenv "SSL_KEY" }}'),
    cert: fs.readFileSync('{{ getenv "SSL_CERT" }}'),
    {{ if getenv "SSL_CA" }}ca: fs.readFileSync('{{ getenv "SSL_CA" }}'){{ end }}
};
config.HTTP_PORT = 80;
config.HTTPS_PORT = 443;
config.REST_API_KEY = '{{ getenv "REST_API_KEY" }}';
config.REST_API_URI = {{ getenv "REST_API_URI" }};

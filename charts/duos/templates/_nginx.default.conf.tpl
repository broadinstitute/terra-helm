{{- define "duos.nginx.default.conf" -}}
# Expires map
map $sent_http_content_type $expires {
    default                    off;
    text/html                  epoch;
    text/css                   max;
    application/javascript     epoch;
    application/json           epoch;
    ~image/                    max;
}

server {
  listen 0.0.0.0:8080;
  expires $expires;
  location / {
    root   /usr/share/nginx/html;
    index  index.html index.htm;
    try_files $uri $uri/ /index.html;
  }
  error_page   500 502 503 504  /50x.html;
  location = /50x.html {
    root   /usr/share/nginx/html;
  }
}
{{- end -}}

{{- define "duos.nginx.conf" -}}
# Non-root user configurations
pid /tmp/nginx.pid;
events {}
http {
  client_body_temp_path /tmp/client_temp;
  proxy_temp_path       /tmp/proxy_temp_path;
  fastcgi_temp_path     /tmp/fastcgi_temp;
  uwsgi_temp_path       /tmp/uwsgi_temp;
  scgi_temp_path        /tmp/scgi_temp;
}
{{- end -}}

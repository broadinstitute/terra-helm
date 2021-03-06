{{- define "duos.site.conf" -}}
ServerAdmin ${SERVER_ADMIN}
ServerName ${SERVER_NAME}

ServerTokens ProductOnly
TraceEnable off

LogFormat "%h %l %u \"%{OIDC_CLAIM_email}i\" \"%{X-App-ID}i\" [%{%FT%T}t.%{msec_frac}t%{%z}t] %D %X \"%r\" %>s %b \"%{Referer}i\" \"%{User-Agent}i\"" combined
LogFormat "%{X-Forwarded-For}i %l %u \"%{OIDC_CLAIM_email}i\" \"%{X-App-ID}i\" [%{%FT%T}t.%{msec_frac}t%{%z}t] %D %X \"%r\" %>s %b \"%{Referer}i\" \"%{User-Agent}i\"" proxy
SetEnvIf X-Forwarded-For "^.*\..*\..*\..*" forwarded
CustomLog "/dev/stdout" combined env=!forwarded
CustomLog "/dev/stdout" proxy env=forwarded
LogLevel {{ .Values.proxyLogLevel }}

Header unset X-Frame-Options
Header always set X-Frame-Options SAMEORIGIN

ProxyTimeout ${PROXY_TIMEOUT}

LDAPCacheTTL ${LDAP_CACHE_TTL}

<VirtualHost _default_:${HTTPD_PORT}>
    ErrorLog /dev/stdout
    CustomLog "/dev/stdout" combined
    Redirect 307 / https://${SERVER_NAME}/
</VirtualHost>

<VirtualHost _default_:${SSL_HTTPD_PORT}>

    DocumentRoot /app

    <Directory "/app">
        AllowOverride All
        Options -Indexes

        Order allow,deny
        Allow from all
    </Directory>

    ErrorLog /dev/stdout
    CustomLog "/dev/stdout" combined

    SSLEngine on
    SSLProxyEngine on
    SSLProtocol ${SSL_PROTOCOL}
    SSLCipherSuite ${SSL_CIPHER_SUITE}
    SSLCertificateFile "/etc/ssl/certs/server.crt"
    SSLCertificateKeyFile "/etc/ssl/private/server.key"
    SSLCertificateChainFile "/etc/ssl/certs/ca-bundle.crt"

    <Location ${PROXY_PATH}>
        Header unset Access-Control-Allow-Origin
        Header always set Access-Control-Allow-Origin "*"
        Header unset Access-Control-Allow-Headers
        Header always set Access-Control-Allow-Headers "authorization,content-type,accept,origin,x-app-id"
        Header unset Access-Control-Allow-Methods
        Header always set Access-Control-Allow-Methods "GET,POST,PUT,PATCH,DELETE,OPTIONS,HEAD"
        Header unset Access-Control-Max-Age
        Header always set Access-Control-Max-Age 1728000

        RewriteEngine On
        RewriteCond %{REQUEST_METHOD} OPTIONS
        RewriteRule ^(.*)$ $1 [R=204,L]

        <Limit OPTIONS>
            Require all granted
        </Limit>

        ${AUTH_TYPE}
        ${AUTH_LDAP_URL}
        ${AUTH_LDAP_GROUP_ATTR}
        ${AUTH_LDAP_BIND_DN}
        ${AUTH_LDAP_BIND_PASSWORD}
        AuthLDAPMaxSubGroupDepth 0
        ${AUTH_REQUIRE}

        <Limit OPTIONS>
            Require all granted
        </Limit>

        ProxyPass ${PROXY_URL}
        ProxyPassReverse ${PROXY_URL}

        ${FILTER}
    </Location>

    <Location ${PROXY_PATH2}>
        Header unset Access-Control-Allow-Origin
        Header always set Access-Control-Allow-Origin "*"
        Header unset Access-Control-Allow-Headers
        Header always set Access-Control-Allow-Headers "authorization,content-type,accept,origin,x-app-id"
        Header unset Access-Control-Allow-Methods
        Header always set Access-Control-Allow-Methods "GET,POST,PUT,PATCH,DELETE,OPTIONS,HEAD"
        Header unset Access-Control-Max-Age
        Header always set Access-Control-Max-Age 1728000

        RewriteEngine On
        RewriteCond %{REQUEST_METHOD} OPTIONS
        RewriteRule ^(.*)$ $1 [R=204,L]

        <Limit OPTIONS>
            Require all granted
        </Limit>

        ${AUTH_TYPE2}
        ${AUTH_LDAP_URL2}
        ${AUTH_LDAP_GROUP_ATTR2}
        ${AUTH_LDAP_BIND_DN2}
        ${AUTH_LDAP_BIND_PASSWORD2}
        AuthLDAPMaxSubGroupDepth 0
        ${AUTH_REQUIRE2}

        <Limit OPTIONS>
            Require all granted
        </Limit>

        ProxyPass ${PROXY_URL2}
        ProxyPassReverse ${PROXY_URL2}

        ${FILTER2}
    </Location>

    <Location ${PROXY_PATH3}>
        Header unset Access-Control-Allow-Origin
        Header always set Access-Control-Allow-Origin "*"
        Header unset Access-Control-Allow-Headers
        Header always set Access-Control-Allow-Headers "authorization,content-type,accept,origin,x-app-id"
        Header unset Access-Control-Allow-Methods
        Header always set Access-Control-Allow-Methods "GET,POST,PUT,PATCH,DELETE,OPTIONS,HEAD"
        Header unset Access-Control-Max-Age
        Header always set Access-Control-Max-Age 1728000

        RewriteEngine On
        RewriteCond %{REQUEST_METHOD} OPTIONS
        RewriteRule ^(.*)$ $1 [R=204,L]

        <Limit OPTIONS>
            Require all granted
        </Limit>

        ${AUTH_TYPE3}
        ${AUTH_LDAP_URL3}
        ${AUTH_LDAP_GROUP_ATTR3}
        ${AUTH_LDAP_BIND_DN3}
        ${AUTH_LDAP_BIND_PASSWORD3}
        AuthLDAPMaxSubGroupDepth 0
        ${AUTH_REQUIRE3}

        <Limit OPTIONS>
            Require all granted
        </Limit>

        ProxyPass ${PROXY_URL3}
        ProxyPassReverse ${PROXY_URL3}

        ${FILTER3}
    </Location>

    <Location ${CALLBACK_PATH}>
        AuthType openid-connect
        Require valid-user
    </Location>

</VirtualHost>
{{- end -}}

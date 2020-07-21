{{- /* Generate a chain of %replace macros to escape JSON-unfriendly characters */ -}}
{{- define "cromwell.config.logback.jsonescape" -}}
%replace(%replace(%replace(%replace(%replace({{- . -}}){'\', '\\'}){'\n', '\\n'}){'\t', '\\t'}){'\r', '\\r'}){'"', '\\"'}
{{- end -}}

{{- /* Generate a logback.xml config file for a Cromwell deployment */ -}}
{{- define "cromwell.config.logback" -}}
<configuration>
    <appender name="STANDARD_APPENDER" class="ch.qos.logback.core.ConsoleAppender">
        <encoder>
            <!--
              Poor man's JSON logging. Create a message in the form
                {"severity": "WARNING", "localTimestamp": "<timestamp>", "sourceThread":"<sourceThread>", "message": "<msg>"}

              Read more about the rationale for this in DDO-512.

              Notes:
              * Curly braces are added as HTML entities, because literal curly braces can't be escaped in logback patterns
              * Double quotes, newlines and other troublesome characters in message and stacktrace are escaped using the %replace function
              * Log message and exception stacktrace are included in the "message" field, as per Stackdriver guidelines
              * This is intended to help us quickly adopt Stackdriver logging for Cromwell; long-term an application-side change should be made to log in JSON with an actual library
            -->
            <pattern>&#123;"severity":"%level", "localTimestamp":"%date", "sourceThread":"%X{sourceThread}", "message":"{{- include "cromwell.config.logback.jsonescape" "%msg" -}}{{- include "cromwell.config.logback.jsonescape" "%xException" -}}%nopex"&#125;%n</pattern>
        </encoder>
    </appender>

    <!-- Configure the Sentry appender, overriding the logging threshold to the WARN level -->
    <appender name="Sentry" class="io.sentry.logback.SentryAppender">
        <filter class="ch.qos.logback.classic.filter.ThresholdFilter">
            <level>WARN</level>
        </filter>
    </appender>

    <root level="INFO">
        <appender-ref ref="STANDARD_APPENDER" />
        <appender-ref ref="Sentry" />
    </root>

    <logger name="liquibase" level="WARN"/>
    <logger name="com.zaxxer.hikari" level="ERROR"/>
    <logger name="HikariPool" level="ERROR"/>
    <logger name="com.google.cloud.hadoop.gcsio.GoogleCloudStorageReadChannel" level="ERROR"/>
    <logger name="org.semanticweb.owlapi.utilities.Injector" level="ERROR"/>
</configuration>
{{ end -}}

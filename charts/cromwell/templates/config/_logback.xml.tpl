{{- /* Generate a logback.xml config file for a Cromwell deployment */ -}}
{{- define "cromwell.config.logback" -}}
<configuration>
    <appender name="STANDARD_APPENDER" class="ch.qos.logback.core.ConsoleAppender">
        <encoder>
            <!--
              Poor man's JSON logging. Create a message in the form
                {"severity": "WARNING", "message": "<msg>"}

              Read more about the rationale for this in DDO-512.

              Notes:
              * Double quotes and newlines in messages are escaped using the %replace function
              * Newlines in exceptions are also escaped using the %replace function
              * Curly braces are added as HTML entities, because literal curly braces can't be escaped in logback patterns
            -->
            <pattern><pattern>&#123;"severity":"%level", "message":"%replace(%replace(%msg){'"','\\"'}){'\n','\\n'}%replace(%xException){'\n','\\n'}%nopex"&#125;%n</pattern></pattern>
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

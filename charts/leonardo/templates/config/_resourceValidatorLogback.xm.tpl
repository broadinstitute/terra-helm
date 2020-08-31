{{- /* Generate a logback.xml config file for a Cromwell deployment */ -}}
{{- define "resourceValidator.config.logback" -}}
<configuration>
    <appender name="FILE" class="ch.qos.logback.core.FileAppender">
        <encoder class="net.logstash.logback.encoder.LogstashEncoder">
        <fieldNames>
            <level>severity</level>
        </fieldNames>
        </encoder>

        <rollingPolicy class="ch.qos.logback.core.rolling.TimeBasedRollingPolicy">
        <!-- daily rollover -->
        <fileNamePattern>application.%d{yyyy-MM-dd}.%i.log</fileNamePattern>
        <timeBasedFileNamingAndTriggeringPolicy
                class="ch.qos.logback.core.rolling.SizeAndTimeBasedFNATP">
            <!-- or whenever the file size reaches 50MB -->
            <maxFileSize>50MB</maxFileSize>
        </timeBasedFileNamingAndTriggeringPolicy>
        <!-- keep 3 days' worth of history -->
        <maxHistory>3</maxHistory>
        </rollingPolicy>
    </appender>

    <logger name="liquibase" level="WARN"/>
    <logger name="com.zaxxer.hikari" level="ERROR"/>
    <logger name="HikariPool" level="ERROR"/>

    <root level="INFO">
        <appender-ref ref="FILE" />
    </root>
</configuration>
{{ end -}}

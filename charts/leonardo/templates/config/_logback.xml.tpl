{{- define "leonardo.config.logback" -}}
<configuration>
  <appender class="ch.qos.logback.core.ConsoleAppender" name="CONSOLE">
    <param name="Threshold" value="INFO"/>
    <encoder class="net.logstash.logback.encoder.LogstashEncoder">
      <fieldNames>
        <level>severity</level>
      </fieldNames>
    </encoder>
  </appender>

  <root level="INFO">
    <appender-ref ref="CONSOLE" />
  </root>
</configuration>
{{ end -}}

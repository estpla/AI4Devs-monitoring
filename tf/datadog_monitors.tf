# Backend Service Monitor
resource "datadog_monitor" "backend_health" {
  name    = "Backend Service Health Monitor"
  type    = "metric alert"
  message = <<-EOT
    Backend service is experiencing issues:
    - High error rate (5xx)
    - High latency
    - Service availability issues

    {{#is_alert}}
    Backend service is experiencing issues:
    - Error rate: {{value}}%
    - Latency: {{value}}ms
    {{/is_alert}}

    {{#is_recovery}}
    Backend service has recovered:
    - Error rate is back to normal
    - Latency is within acceptable range
    {{/is_recovery}}

    @slack-datadog-alerts
  EOT

  query = "sum(last_5m):( sum:trace.http.request{service:backend,status_code:5xx}.as_count() / sum:trace.http.request{service:backend}.as_count() ) * 100 > 5"

  monitor_thresholds {
    critical = 5.0
    warning  = 2.0
  }

  evaluation_delay    = 900
  include_tags        = true
  require_full_window = true
  tags                = ["service:backend", "env:${var.environment}", "project:${var.project_name}"]
}

# Backend Latency Monitor
resource "datadog_monitor" "backend_latency" {
  name    = "Backend Service Latency Monitor"
  type    = "metric alert"
  message = <<-EOT
    Backend service latency is high:
    - Average response time exceeds threshold
    - Potential performance degradation

    {{#is_alert}}
    Backend service latency is high:
    - Current latency: {{value}}ms
    {{/is_alert}}

    {{#is_recovery}}
    Backend service latency has returned to normal:
    - Current latency: {{value}}ms
    {{/is_recovery}}

    @slack-datadog-alerts
  EOT

  query = "avg(last_5m):p95:trace.http.request{service:backend} > 1000"

  monitor_thresholds {
    critical = 1000
    warning  = 500
  }

  evaluation_delay    = 900
  include_tags        = true
  require_full_window = true
  tags                = ["service:backend", "env:${var.environment}", "project:${var.project_name}"]
}

# Frontend Service Monitor
resource "datadog_monitor" "frontend_health" {
  name    = "Frontend Service Health Monitor"
  type    = "metric alert"
  message = <<-EOT
    Frontend service is experiencing issues:
    - High error rate (4xx)
    - High load time
    - Service availability issues

    {{#is_alert}}
    Frontend service is experiencing issues:
    - Error rate: {{value}}%
    - Load time: {{value}}ms
    {{/is_alert}}

    {{#is_recovery}}
    Frontend service has recovered:
    - Error rate is back to normal
    - Load time is within acceptable range
    {{/is_recovery}}

    @slack-datadog-alerts
  EOT

  query = "sum(last_5m):( sum:trace.http.request{service:frontend,status_code:4xx}.as_count() / sum:trace.http.request{service:frontend}.as_count() ) * 100 > 5"

  monitor_thresholds {
    critical = 5.0
    warning  = 2.0
  }

  evaluation_delay    = 900
  include_tags        = true
  require_full_window = true
  tags                = ["service:frontend", "env:${var.environment}", "project:${var.project_name}"]
}

# Frontend Load Time Monitor
resource "datadog_monitor" "frontend_load_time" {
  name    = "Frontend Service Load Time Monitor"
  type    = "metric alert"
  message = <<-EOT
    Frontend service load time is high:
    - Page load time exceeds threshold
    - Potential performance degradation

    {{#is_alert}}
    Frontend service load time is high:
    - Current load time: {{value}}ms
    {{/is_alert}}

    {{#is_recovery}}
    Frontend service load time has returned to normal:
    - Current load time: {{value}}ms
    {{/is_recovery}}

    @slack-datadog-alerts
  EOT

  query = "avg(last_5m):p95:trace.http.request{service:frontend} > 3000"

  monitor_thresholds {
    critical = 3000
    warning  = 2000
  }

  evaluation_delay    = 900
  include_tags        = true
  require_full_window = true
  tags                = ["service:frontend", "env:${var.environment}", "project:${var.project_name}"]
}

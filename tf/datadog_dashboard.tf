# Datadog Dashboard
resource "datadog_dashboard" "aws_infrastructure" {
  title        = "AWS Infrastructure Monitoring - ${var.project_name}"
  description  = "Dashboard for monitoring AWS EC2 instances and infrastructure"
  layout_type  = "ordered"
  is_read_only = false

  widget {
    group_definition {
      title            = "EC2 Instance Metrics"
      layout_type      = "ordered"
      background_color = "white"

      widget {
        timeseries_definition {
          title       = "EC2 CPU Utilization"
          show_legend = true
          legend_size = "0"
          request {
            q            = "avg:aws.ec2.cpuutilization{name:${var.project_name}-*} by {name}"
            display_type = "line"
            style {
              palette = "dog_classic"
            }
          }
          yaxis {
            min = "0"
            max = "100"
          }
        }
      }

      widget {
        timeseries_definition {
          title       = "EC2 Memory Utilization"
          show_legend = true
          request {
            q            = "avg:system.mem.pct_usable{host:${var.project_name}-*} by {host}"
            display_type = "line"
            style {
              palette = "dog_classic"
            }
          }
          yaxis {
            min = "0"
            max = "100"
          }
        }
      }

      widget {
        timeseries_definition {
          title       = "EC2 Disk Usage"
          show_legend = true
          request {
            q            = "avg:system.disk.used{host:${var.project_name}-*} by {host,device}"
            display_type = "line"
            style {
              palette = "dog_classic"
            }
          }
        }
      }
    }
  }

  widget {
    group_definition {
      title            = "Network Metrics"
      layout_type      = "ordered"
      background_color = "white"

      widget {
        timeseries_definition {
          title       = "Network In/Out"
          show_legend = true
          request {
            q            = "avg:aws.ec2.network_in{name:${var.project_name}-*} by {name}"
            display_type = "line"
            style {
              palette = "dog_classic"
            }
          }
          request {
            q            = "avg:aws.ec2.network_out{name:${var.project_name}-*} by {name}"
            display_type = "line"
            style {
              palette = "orange"
            }
          }
        }
      }
    }
  }

  widget {
    query_value_definition {
      title       = "Running EC2 Instances"
      title_size  = "16"
      title_align = "left"
      request {
        q          = "sum:aws.ec2.instance_state{name:${var.project_name}-*,state:running}"
        aggregator = "last"
      }
      autoscale = true
      precision = 0
    }
  }

  template_variable {
    name    = "env"
    prefix  = "env"
    default = var.environment
  }
}

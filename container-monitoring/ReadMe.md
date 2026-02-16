# Container and Raspi Monitoring

Monitoring of active containers and the raspi host

Containers used in the stack

-   [Prometheus](https://prometheus.io/)
-   [Grafana](https://grafana.com/)
-   [cAdvisor](https://github.com/google/cadvisor)
-   [NodeExporter](https://github.com/prometheus/node_exporter)

cAdvisor extracts containers metrics and node-exporter collects host hardware and OS metrics
Prometheus monitors these collects as a data source

Grafana visualizes the data from prometheus

Ports for any container except Grafana are not exposed, they can be used internally using the hostname because the containers are part of the same stack. This means all of them are on the same network, so hostname is resolved to the corresponding container

## Prometheus

The data received will be saved at `/opt/prometheus/data`. Another option is to use a database like redis to store it
Add jobs for targets you want to monitor, and good to go. Targets are the services we want to monitor

-   `--config.file=/etc/prometheus/prometheus.yml` sets the config file location
-   `--storage.tsdb.retention.time=120h` sets the data retention to 5 days instead of 15 by default
-   `--web.enable-lifecycle` enables the `/-/reload` endpoint

To reload prometheus after making changes to the config w/o restarting send a POST request to the endpoint

```
curl -X POST http://prometheus:9090/-/reload
```

## Monitoring docker containers

Docker containers can be monitored using cAdvisor or a [docker daemon that docker exposes on the host](https://docs.docker.com/config/daemon/prometheus/)

A few [metrics have been disabled](https://github.com/google/cadvisor/blob/master/docs/runtime_options.md) to avoid the race condition caused on a RasPi.
Additionally limited memory is reserved for the container and dynamic housekeeping is enabled to limit resources

CAdvisor takes up quite a bit of resource, this can be limited by

-   Dynamic housekeeping is enabled
-   Housekeeping intervals are set to 30 seconds
-   Set memory reservation to 80M

## Grafana

-   Add prometheus as the data source using `prometheus:9090` as the URL
-   Used the [RaspberryPiMonitoring](./Dashboard/RaspberryPiMonitoring.json) Dashboard

## ToDo

-   [ ] Add sendinblue configs for notifications
-   [ ] Learn PromQL to improve the dashboard
-   [ ] Add loki to aggregate all logs

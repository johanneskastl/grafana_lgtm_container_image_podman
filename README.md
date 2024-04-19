# grafana_lgtm_container_image_podman

* [Blog post](https://grafana.com/blog/2024/03/13/an-opentelemetry-backend-in-a-docker-image-introducing-grafana/otel-lgtm/)
* [Repository](https://github.com/grafana/docker-otel-lgtm)

## Running the container

The script `grafana_lgtm.sh` can be used to run the [Grafana `otel-lgtm`
Container image](https://grafana.com/blog/2024/03/13/an-opentelemetry-backend-in-a-docker-image-introducing-grafana/otel-lgtm/).
This image contains the whole toolstack, starting with

* Grafana Agent as OpenTelemetry-compatible collector
* Grafana Tempo for traces
* Grafana Loki for logs
* Prometheus for metrics and
* Grafana as visualization

Grafana is reachable at `localhost:3000`, credentials are `admin`/`admin`.

The script runs podman in non-detached mode, i.e. your terminal will be blocked
while the container runs. If you want to stop the container, `CTRL+C` is your
friend...

## Sending logs, traces and metrics

The collector listens on port 4317 (`grpc`) and 4318 /`http`).

You can use
[`telemetrygen`](https://github.com/open-telemetry/opentelemetry-collector-contrib/tree/main/cmd/telemetrygen)
to send logs, traces and metrics to the collector:

```bash
telemetrygen metrics --otlp-insecure --duration 5s
telemetrygen traces --otlp-insecure --duration 5s
telemetrygen logs --otlp-insecure --duration 5s
```

Telemetrygen defaults to using `localhost:4317`, so you do not need to configure
this.

The logs, metrics and traces you sent using `telemetrygen` should be visible in
Grafana. You can head to `Explore`, select the proper data source (Loki, Tempo,
Prometheus) and voilá!

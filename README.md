# MTD Playbook
> A set of ansible scripts to facilitate installation of malware samples and the MTD framework mitigating them

## Monitoring

### Locally (copying monitor.sh to the target device)
To use the monitoring, edit the INTERFACE and SERVICE constants in `monitoring/monitor.sh`. Then, the monitor can be started by passing an optional label which will be used to postfix the output filename. If a second parameter is passed, it will only take that number of measurements.
```
./monitoring/monitor.sh NORMAL 10
# CTRL+C
cat MONITORING_LOG_01_01_1970-09_30_NORMAL.csv
```
One sample is taken roughly every 12 seconds, since:
(1) Averaged bandwidth usage of the SERVICE sent and received over the INTERFACE during 10 seconds
(2) The average of CPU, IO, memory stats over 2 seconds are captured

The first column denotes the start of measuring (2) as a UNIX timestamp. The following columns are the default ones provided by `vmstat`. The final two columns represent (1) in KB/s.

### Remote (Ansible)
Configure the `monitoring/monitor.sh` script and then run it using `monitor_device.yml`. If needed, adapt variables such as the nr of iterations in the ansible playbook. The resulting logs are stored in `monitoring/logs`

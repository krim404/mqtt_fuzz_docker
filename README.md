# mqtt_fuzz_docker
Docker Image for F-Secure/MQTT_FUZZ  
Logfiles are saved in /log  

## Usage
ARG TARGET = HOST/IP of the MQTT Broker  
ARG PORT = Port of the MQTT Broker  
ARG ADD = Additional parameters  
ARG TIMEOUT = Runtime of the Fuzzing attack  
ARG LOGID = String/Number attached to the logfile  
ARG TRUNCATE = Number of last lines which should be saved in logfile  


### Possible additional parameters (not required)
'-ratio', default=3, How many control packets should be fuzzed per 10 packets sent (0 = fuzz nothing, 10 = fuzz all packets)  
'-delay', default=50, How many milliseconds to wait between control packets sent  

## Example execution
docker run -e "TARGET=10.188.101.114" -e "PORT=1883" -e "TIMEOUT=60" -e "LOGID=3" -e "TRUNCATE=50" --volume /tmp/flog:/log:Z wmchris/mqtt_fuzz:latest

## Example for a 24h DoS
```
#!/bin/bash
for i in {1..20}
do
        docker run -d -e "TARGET=10.188.101.114" -e "PORT=1883" -e "TIMEOUT=86400" -e "LOGID=$i" -e "TRUNCATE=50" --volume /tmp/flog:/log:Z wmchris/mqtt_fuzz:latest
done
```

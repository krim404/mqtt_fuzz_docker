# mqtt_fuzz_docker
Docker Image for F-Secure/MQTT_FUZZ

## Usage
ARG TARGET = HOST/IP of the MQTT Broker
ARG PORT = Port of the MQTT Broker
ARG ADD = Additional parameters
ARG TIMEOUT = Runtime of the Fuzzing attack


### Possible additional parameters (not required)
'-ratio', default=3, How many control packets should be fuzzed per 10 packets sent (0 = fuzz nothing, 10 = fuzz all packets)
'-delay', default=50, How many milliseconds to wait between control packets sent

## Example execution
docker run -e "TARGET=10.188.101.114" -e "PORT=1883" -e "TIMEOUT=60" wmchris/mqtt_fuzz:latest

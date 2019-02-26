#Download base image python
FROM python:2.7.15-alpine3.9

# Update Software repository
RUN apk add git gcc g++ openssl make
RUN pip install Twisted

ARG TARGET
ARG PORT
ARG ADD
ARG TIMEOUT
ARG TRUNCATE
ARG LOGID

RUN git clone https://gitlab.com/akihe/radamsa.git
RUN cd radamsa && make && make install
RUN git clone https://github.com/F-Secure/mqtt_fuzz.git /mqtt_fuzz
RUN echo 'COMMAND="timeout -t ${TIMEOUT} python ./mqtt_fuzz.py ${TARGET} ${PORT} ${ADD}"' > ./entrypoint.sh
RUN echo cd /mqtt_fuzz/ >> ./entrypoint.sh
RUN echo 'if [[ -n "${TRUNCATE}" ]] ; then COMMAND="$COMMAND | tail -n ${TRUNCATE}" ; fi' >> ./entrypoint.sh
RUN echo 'echo Starting $COMMAND' >> ./entrypoint.sh
RUN echo 'eval $COMMAND > /log/mqfuzz${LOGID}.log' >> ./entrypoint.sh
RUN chmod +rwx ./entrypoint.sh

CMD ["/bin/ash","./entrypoint.sh"]

FROM java:8-jdk-alpine as build-stage

RUN apk update && apk add git

RUN git clone https://github.com/Dnnd/openems.git

WORKDIR /openems

RUN git checkout  2019.1.0b

RUN ./gradlew buildEdge

FROM java:8-jre-alpine

COPY --from=build-stage /openems/build/ .
COPY config.d /config.d
ENTRYPOINT ["java"]
CMD ["-Dfelix.cm.dir=/config.d" ,"-jar","openems-edge.jar"]



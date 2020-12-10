FROM java:8-jdk-alpine

COPY ./target/bot-svc-1.0.0.jar /usr/app/

WORKDIR /usr/app

RUN sh -c 'touch bot-svc-1.0.0.jar'

ENTRYPOINT ["java", "-Xmx512m","-jar", "bot-svc-1.0.0.jar"]
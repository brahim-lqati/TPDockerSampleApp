FROM maven:3.6.3-jdk-8
WORKDIR /app
COPY pom.xml /app
ADD haarcascades /app/haarcascades
ADD lib /app/lib
RUN mvn install:install-file -Dfile=./lib/opencv-3410.jar -DgroupId=org.opencv  -DartifactId=opencv -Dversion=3.4.10 -Dpackaging=jar

FROM ubuntu:20.04
RUN apt-get update && \
    apt-get install -y openjdk-8-jdk && \
    apt-get install -y maven && \
    apt-get install -y libpng16-16 && \
    apt-get install -y libdc1394-22

WORKDIR /app
COPY target/fatjar-0.0.1-SNAPSHOT.jar /app/app.jar
ADD haarcascades /app/haarcascades
ADD lib /app/lib
EXPOSE 8080
CMD ["java", "-Djava.library.path=lib/ubuntuupperthan18", "-jar", "app.jar"]
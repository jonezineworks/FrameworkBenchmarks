FROM maven:3.5.3-jdk-10-slim as maven
WORKDIR /spring
COPY src src
COPY pom.xml pom.xml
RUN mvn package -q -P hibernate_mysql

FROM openjdk:10-jre-slim
WORKDIR /spring
COPY --from=maven /spring/target/teb-spring-hibernate-mysql.jar app.jar
CMD ["java", "-server", "-Dspring.profiles.active=hibernate-mysql", "--add-modules java.xml.bind", "-XX:+UseNUMA", "-XX:+UseParallelGC", "-jar", "app.jar"]

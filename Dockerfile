ARG JAVA_VERSION="18-jdk"
FROM openjdk:${JAVA_VERSION}
LABEL version="1.0.0"
ARG APP_HOME="/opt/deployment"
RUN mkdir ${APP_HOME}

#Add Vs Copy (Add lets you embed url to donwload a tar in image)
COPY target/todo-1.0.0.jar ${APP_HOME}/todo-1.0.0.jar

WORKDIR ${APP_HOME}
EXPOSE 8080
#Entrypoint vs command
ENTRYPOINT ["java","-jar", "todo-1.0.0.jar"]

## Download Java--ARG is variable element that can come befroe FROM
#ARG JAVA_VERSION="18-jdk"
#FROM openjdk:${JAVA_VERSION}
#
#LABEL versioin="1.0.0"
#
#ENV PROJECT_NAME="todo-api"
#
#ARG APP_HOME="/opt/deployment/"
#
## Copy the jar from local to image
#RUN mkdir ${APP_HOME}
#COPY target/todo-1.0.0.jar ${APP_HOME}/todo-1.0.0.jar
#
#WORKDIR ${APP_HOME}
#
#EXPOSE 8080
#
## Run application with java -jar
## CMD what the difference
#ENTRYPOINT ["java", "-jar", "todo-1.0.0.jar"]
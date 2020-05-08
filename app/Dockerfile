FROM java:8
MAINTAINER brucedong
WORKDIR /cicd
ADD ../target/cicd-0.0.1-SNAPSHOT.jar /cicd/app.jar 
RUN bash -c "touch /cicd/app.jar"
ENTRYPOINT ["java","-jar","/cicd/app.jar"]
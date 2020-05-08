FROM java:8
MAINTAINER brucedong
WORKDIR /cicd
ADD app.jar /cicd/app.jar 
RUN bash -c "touch /cicd/app.jar"
ENTRYPOINT ["java","-jar","/cicd/app.jar"]
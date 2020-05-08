FROM java:8
MAINTAINER brucedong
RUN mkdir /cicd
ADD app.jar /cicd/app.jar 
RUN bash -c "touch /cicd/app.jar"
WORKDIR /cicd
ENTRYPOINT ["java","-jar","/cicd/app.jar"]
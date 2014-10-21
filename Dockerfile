FROM sequenceiq/ambari:1.6.0
MAINTAINER SequenceIQ

#install tomcat 7
RUN curl -s http://apache.cs.uu.nl/dist/tomcat/tomcat-7/v7.0.56/bin/apache-tomcat-7.0.56.tar.gz | tar -xz -C /usr/local/
ENV CATALINA_HOME /usr/local/apache-tomcat-7.0.56

#install maven 3
RUN curl -s http://apache.proserve.nl/maven/maven-3/3.2.3/binaries/apache-maven-3.2.3-bin.tar.gz | tar -xz -C /usr/local/
RUN ln -s /usr/local/apache-maven-3.2.3/bin/mvn /usr/bin/mvn

RUN curl -s http://nodejs.org/dist/v0.10.32/node-v0.10.32-linux-x64.tar.gz | tar -xz -C /usr/local/
ENV PATH PATH=/usr/local/node-v0.10.32-linux-x64/bin:$PATH

ADD serf /usr/local/serf

ADD install-cluster.sh /tmp/
ADD kylin-singlenode.json /tmp/
ADD wait-for-kylin.sh /tmp/
ADD ambari-shell.sh /tmp/

RUN git clone https://github.com/KylinOLAP/Kylin.git /usr/local/kylin
ADD deploy.sh /usr/local/kylin/deploy.sh

EXPOSE 9080

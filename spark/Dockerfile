FROM centos:7

RUN yum install -y \
	which \
	curl \
	bash \
	java-1.8.0-openjdk

ARG SPARK_VERSION=2.4.3
ENV HADOOP_VERSION=2.7

RUN echo "Spark: ${SPARK_VERSION}" && \
    curl -sSL https://archive.apache.org/dist/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz -o spark.tgz && \
	tar xf spark.tgz && \
	mv spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION} spark && \
	rm spark.tgz
RUN cd /spark/jars && \
	curl -sSL https://repo1.maven.org/maven2/com/amazonaws/aws-java-sdk/1.7.4/aws-java-sdk-1.7.4.jar -O && \
	curl -sSL https://repo1.maven.org/maven2/org/apache/hadoop/hadoop-aws/2.7.7/hadoop-aws-2.7.7.jar -O

COPY scripts/ /

CMD ["/start.sh"]

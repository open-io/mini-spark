FROM centos:7

RUN yum install -y \
	which \
	curl \
	bash \
	java-1.8.0-openjdk

ENV SPARK_VERSION=2.4.3
ENV HADOOP_VERSION=2.7

RUN curl -sSL https://archive.apache.org/dist/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz -o spark.tgz && \
	tar xf spark.tgz && \
	mv spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION} spark && \
	rm spark.tgz

COPY scripts/ /

CMD ["/start.sh"]

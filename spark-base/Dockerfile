FROM alpine:3.8

RUN apk add --no-cache \
	curl \
	bash \
	openjdk8-jre \
	python3 \
	py-pip \
	nss

ENV SPARK_VERSION=2.4.3 
ENV HADOOP_VERSION=2.7

RUN wget https://archive.apache.org/dist/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz -O spark.tgz && \
	tar xf spark.tgz && \
	mv spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION} spark && \
	rm spark.tgz
	

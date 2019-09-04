FROM centos:7

RUN yum install -y \
	which \
	curl \
	bash \
	java-1.8.0-openjdk \
	snappy-devel

ENV HADOOP_VERSION=2.7.7

RUN curl -sSL https://archive.apache.org/dist/hadoop/common/hadoop-${HADOOP_VERSION}/hadoop-${HADOOP_VERSION}.tar.gz -o hadoop.tgz && \
	tar xf hadoop.tgz && \
	mv hadoop-${HADOOP_VERSION} hadoop && \
	rm hadoop.tgz

COPY core-site.xml /hadoop/etc/hadoop/
COPY hdfs-site.xml /hadoop/etc/hadoop/
ADD docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
COPY scripts/ /
ENV JAVA_HOME=/usr

ENTRYPOINT ["docker-entrypoint.sh"]

CMD ["/start.sh"]

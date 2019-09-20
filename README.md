# Mini Spark

Make it easy to launch and test Spark + HDFS jobs.

## Parameters

Use HADOOP_VERSION or SPARK_VERSION as `make` option

Please note that at this time, HADOOP_VERSION is unused and only Spark with Hadoop 2.7.

## How to use

Build images

```bash
$ make build
```

Start the stack

```bash
$ make compose
```

Spark WebUI is available at `http://localhost:8080`.

Spark Master at `spark://localhost:7077`.

HDFS Namenode at `hdfs://localhost:9000`.

Get a spark shell

```bash
$ make spark_shell
```

### HDFS

Access the HDFS container:

```bash
$ docker-compose exec hdfs /bin/bash
```

Hadoop is available in `/hadoop`.

Example with HDFS CLI:

```bash
$ hadoop/bin/hdfs dfs -ls /
```

### Spark

Access the Spark container:

```bash
$ docker-compose exec spark
```

Spark is available in `/spark`.

Example with pyspark

```bash
$ spark/bin/pyspark
```

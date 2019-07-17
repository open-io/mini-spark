# Mini Spark

Make it easy to launch and test Spark + HDFS jobs.


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

Access the Spark master container:

```bash
$ docker-compose exec spark-master
```

Spark is available in `/spark`.

Example with pyspark

```bash
$ spark/bin/pyspark
```

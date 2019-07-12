FROM mini-spark/spark-base

COPY start-master.sh /

ENV SPARK_MASTER_PORT 7077
ENV SPARK_MASTER_WEBUI_PORT 8080

EXPOSE 6066 7077 8080

CMD ["/bin/bash", "/start-master.sh"]

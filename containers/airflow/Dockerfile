FROM apache/airflow:2.9.2

# Copy and install Python dependencies
COPY requirements.txt /
RUN pip install --no-cache-dir -r /requirements.txt

# Copy and execute any additional setup scripts
COPY quarto.sh /
RUN cd / && bash /quarto.sh

COPY setup_conn.py $AIRFLOW_HOME

USER root

# Install Java and procps for ps command
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    default-jdk procps

# Set Java environment variables
ENV JAVA_HOME='/usr/lib/jvm/java-17-openjdk-arm64'
ENV PATH=$PATH:$JAVA_HOME/bin

# Download and install Spark
RUN curl https://dlcdn.apache.org/spark/spark-3.5.1/spark-3.5.1-bin-hadoop3.tgz -o spark-3.5.1-bin-hadoop3.tgz && \
    chmod 755 spark-3.5.1-bin-hadoop3.tgz && \
    mkdir -p /opt/spark && \
    tar xvzf spark-3.5.1-bin-hadoop3.tgz --directory /opt/spark --strip-components=1

# Set Spark environment variables
ENV SPARK_HOME='/opt/spark'
ENV PATH=$PATH:$SPARK_HOME/bin:$SPARK_HOME/sbin

# Execute setup connection script
RUN python $AIRFLOW_HOME/setup_conn.py

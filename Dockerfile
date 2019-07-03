FROM alpine:3.8

MAINTAINER Robrecht Cannoodt <robrecht@dynverse.org>
MAINTAINER Wouter Saelens <wouter@dynverse.org>

RUN mkdir /app

# Download SBT
RUN wget -O - https://piccolo.link/sbt-1.2.6.tgz | gunzip | tar -x -C /usr/local
ENV PATH /usr/local/sbt/bin:${PATH}

# Download Spark
ENV SPARK_VERSION=2.4.3
ENV HADOOP_VERSION=2.7
  
RUN apk add --no-cache curl bash openjdk8-jre && \
  wget https://archive.apache.org/dist/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz && \
  tar -xvzf spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz && \
  mv spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION} /usr/local/spark && \
  rm spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz
ENV PATH /usr/local/spark/bin:${PATH}

# Download JHDF5 libraries
ENV JHDF5_VERSION=19.04.0
RUN wget https://wiki-bsse.ethz.ch/download/attachments/26609237/sis-jhdf5-${JHDF5_VERSION}.zip && \
  unzip sis-jhdf5-${JHDF5_VERSION}.zip && \
  mv sis-jhdf5/lib /app/lib && \
  rm -rf sis-jhdf5-${JHDF5_VERSION}.zip sis-jhdf5

WORKDIR /app

ENTRYPOINT ["bash"]

#!/bin/bash

JARFILE=`find /app/target -iname '*.jar'`

mkdir -p $2

spark-submit \
  --master local[1] \
  --jars /app/lib/sis-jhdf5-19.04.0.jar \
  $JARFILE \
  $@

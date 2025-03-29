#!/bin/bash

docker run -rm aquasec/trivy --severity HIGH,CRITICAL --exit-code 1 image openjdk:8-jdk-alpine

if [ $? -eq 1 ]
then
    echo "Docker Image Have High Or Critical Vulns"
    exit 1
else
    echo "Docker Image Clean"
fi
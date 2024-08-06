#FROM --platform=linux/arm64/v8 ubuntu:22.04
FROM ubuntu:22.04
#RUN echo "nameserver 8.8.8.8" | sudo tee /etc/resolv.conf > /dev/null
RUN sed -i -e 's/^APT/# APT/' -e 's/^DPkg/# DPkg/' \
    /etc/apt/apt.conf.d/docker-clean
#RUN yes | unminimize
RUN echo 'nameserver 8.8.8.8' >> /etc/resolv.confg && \
    yes | apt-get -y update && \
    yes | apt-get install curl git wget

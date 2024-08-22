FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install --no-install-recommends -y texlive-full

RUN mkdir /build
RUN mkdir /tex

WORKDIR /tex
FROM python:3.13.0rc2-slim as builder
RUN apt-get update && \
    apt-get install -y gcc
ADD requirements.txt  ./
RUN mkdir -p /install
RUN pip3 install --prefix=/install -r requirements.txt

FROM python:3.13.0rc2-slim
COPY --from=builder /install /usr/local
RUN mkdir -p /app/yearn-exporter
WORKDIR /app/yearn-exporter
# This is for the accountant module
RUN brownie pm install OpenZeppelin/openzeppelin-contracts@3.2.0
ADD . /app/yearn-exporter

ENTRYPOINT ["./entrypoint.sh"]

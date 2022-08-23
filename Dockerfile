FROM ubuntu:18.04
RUN apt-get update && apt-get install -y --no-install-recommends \
  curl \
  ca-certificates \
  python3
RUN curl -fs "https://download.litecoin.org/litecoin-0.18.1/linux/litecoin-0.18.1-x86_64-linux-gnu.tar.gz" -o /home/litecoin.tar.gz \
  && echo $(curl -fs "https://download.litecoin.org/litecoin-0.18.1/linux/litecoin-0.18.1-linux-signatures.asc" | \
  grep litecoin-0.18.1-x86_64-linux-gnu.tar.gz | awk '{print $1}' ) /home/litecoin.tar.gz | \
  sha256sum -c --strict - \
  && tar -zxvf /home/litecoin.tar.gz -C /home/

CMD /home/litecoin-0.18.1/bin/litecoind
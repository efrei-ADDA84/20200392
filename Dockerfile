FROM debian:stretch-slim

COPY wrapper.sh /usr/local/bin/

RUN chmod +x /usr/local/bin/wrapper.sh
RUN apt-get install -y jq

CMD ["/usr/local/bin/wrapper.sh"]
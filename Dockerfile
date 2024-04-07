FROM busybox:stable

COPY wrapper.sh /wrapper.sh

RUN chmod +x /wrapper.sh

ENTRYPOINT ["/wrapper.sh"]

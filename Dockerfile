FROM alpine
MAINTAINER Nathan Douglas <docker@tenesm.us>
RUN set -xe \
  && apk add --no-cache --virtual syslinux_and_stuff\
    syslinux \
  && cp -r /usr/share/syslinux/ /tftp \
  && find /tftp -type f -exec chmod 0444 {} + \
  && apk del syslinux_and_stuff \
  && apk add --no-cache tftp-hpa \
  && adduser -D tftp
EXPOSE 69/udp
VOLUME /tftp
ENTRYPOINT ["/usr/sbin/in.tftpd"]
CMD ["-L","-u","tftp","--secure","/tftp","--verbose"]

FROM alpine
MAINTAINER Nathan Douglas <docker@tenesm.us>
RUN set -xe && \
  apk add --no-cache \
    tftp-hpa \
    syslinux
EXPOSE 69
VOLUME /tftp
RUN cp /usr/share/syslinux/pxelinux.0 /tftp/ \
  && cp /usr/share/syslinux/ldlinux.c32 /tftp/
CMD /usr/sbin/in.tftpd --foreground --user tftp --address 0.0.0.0:69 --secure /tftp

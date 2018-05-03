FROM python:3
MAINTAINER  wuhuizuo <wuhuizuo@gmail.com>
RUN pip install "devpi-server=4.4.0" \
                "devpi-web=3.2.2" \
                "devpi-client=4.0.1"

COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

USER devpi
VOLUME /data
ENV HOME /data
EXPOSE 4040

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["devpi"]

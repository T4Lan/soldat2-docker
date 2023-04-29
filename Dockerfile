FROM debian:bullseye-slim
LABEL maintainer="m@matiargs.com"

RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get -y --force-yes install wget unzip

RUN echo "Installing soldat 2 server"
RUN mkdir soldat2

RUN wget "https://dl.thd.vg/soldat2-linuxserver-release.tar.gz"
RUN tar -xf soldat2-linuxserver-release.tar.gz
RUN cp -r soldat2-linuxserver-release/* soldat2

RUN echo "Copying configuration"
ADD ./config/ /soldat2/

# add user soldat
RUN useradd -ms /bin/bash soldatusr
RUN chown -R soldatusr:soldatusr /soldat2
USER soldatusr

RUN echo "Running server"
RUN ["chmod", "+x", "/soldat2/entrypoint.sh"]
ENTRYPOINT [ "/soldat2/entrypoint.sh" ]
CMD ["./soldat2"]
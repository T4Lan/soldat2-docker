FROM ghcr.io/t4lan/debian-mini-base:latest
LABEL maintainer="m@matiargs.com"

ARG DEBIAN_FRONTEND="noninteractive"

ENV PUID=1000 \
    USER=soldat2 \
    GAMEDIR=/opt/soldat2 \
    TOOLSDIR=/etc/soldat2 \
    LANGUAGE="en_US.UTF-8" \
    LANG="en_US.UTF-8" \
    TERM="xterm" 

RUN export LC_ALL=${LANGUAGE}
RUN export LANG=${LANG}

RUN apt-get update && \
    apt-get -y upgrade && \
    apt-get -y install wget unzip ca-certificates locales && \
    dpkg-reconfigure locales && \
    rm -rf /var/lib/apt/lists/* && \
    useradd -u "${PUID}" -m "${USER}" && \
    mkdir -p "${GAMEDIR}" "${TOOLSDIR}"
    
RUN wget -P ${TOOLSDIR} "https://dl.thd.vg/soldat2-linuxserver-release.tar.gz"

# entrypoint is copied in another directory from the bind mount
COPY etc/entrypoint.sh "${TOOLSDIR}/entrypoint.sh" 
COPY etc/autoconfig.ini "${TOOLSDIR}/autoconfig.ini"

# Game Port
EXPOSE 33073
# RCON Port
EXPOSE 33074

RUN set -x \
        && chown -R "${USER}:${USER}" "${TOOLSDIR}" "${GAMEDIR}" \
        && chmod +x "${TOOLSDIR}/entrypoint.sh"

# Switch to user
USER ${USER}

# Switch workdir
WORKDIR ${GAMEDIR}

ENTRYPOINT ["/etc/soldat2/entrypoint.sh"]
CMD ["./soldat2"]
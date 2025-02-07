#!/bin/bash
mkdir -p "${GAMEDIR}" || true

if [ ! -f "${GAMEDIR}/soldat2" ]; then
    echo "Server not found, unpacking it"
    rm -rf ./* # clear server files
    tar -xf "${TMPDIR}/soldat2/soldat2-linuxserver-release.tar.gz" -C ${GAMEDIR} 
    cp -r soldat2-linuxserver-release/* .
    rm -rf soldat2-linuxserver-release
fi

echo "Updating server config"

cp ${TMPDIR}/autoconfig.ini ${GAMEDIR}
sed -i -e "s|RCON_PASSWORD|${RCON_PASSWORD}|g" \
        -e "s|SERVER_NAME|${SERVER_NAME}|g" \
        -e "s|SERVER_GREET_MESSAGE|${SERVER_GREET_MESSAGE}|g" \
        -e "s|GLOBAL_DEBUG|${GLOBAL_DEBUG}|g" \
        -e "s|NET_DEBUG|${NET_DEBUG}|g" \
        "${GAMEDIR}"/autoconfig.ini

echo "Running Soldat 2 Server"
exec "$@"
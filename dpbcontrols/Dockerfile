# syntax=docker/dockerfile:experimental
FROM habrade/ipbus-software:v2.6.5

LABEL maintainer="s.dong@mails.ccnu.edu.cn"

ARG DEBIAN_MIRROR
ARG DEBIAN_MIRROR_SECURITY
RUN /bin/bash -c 'if [[ -n ${DEBIAN_MIRROR} ]]; then sed -i 's#deb.debian.org#${DEBIAN_MIRROR}#g' /etc/apt/sources.list; fi'
RUN /bin/bash -c 'if [[ -n ${DEBIAN_MIRROR_SECURITY} ]]; then sed -i 's#security.debian.org/debian-security#${DEBIAN_MIRROR_SECURITY}#g' /etc/apt/sources.list; fi'
RUN apt-get update && apt-get install -y \
    cmake

WORKDIR /opt
RUN mkdir -p -m 0600 ~/.ssh && ssh-keyscan git.cbm.gsi.de >> ~/.ssh/known_hosts
RUN --mount=type=ssh git clone git@git.cbm.gsi.de:ecs/controls/dpbcontrols.git

WORKDIR /opt/dpbcontrols
RUN source /opt/ipbus-software/uhal/tests/setup.sh && \
    [[ ! -d ./build ]] && mkdir -p ./build && \
    pushd build || exit && \
    cmake .. && \
    cmake --build ./ --target gdpbCli -- -j 4 && \
    popd || exit

CMD /bin/bash
# syntax=docker/dockerfile:experimental
ARG IPBUS_VERSION
FROM habrade/ipbus-software:${IPBUS_VERSION}

LABEL maintainer="s.dong@mails.ccnu.edu.cn"

ARG DEBIAN_MIRROR
ARG DEBIAN_MIRROR_SECURITY
RUN /bin/bash -c 'if [[ -n ${DEBIAN_MIRROR} ]]; then sed -i 's#deb.debian.org#${DEBIAN_MIRROR}#g' /etc/apt/sources.list; fi'
RUN /bin/bash -c 'if [[ -n ${DEBIAN_MIRROR_SECURITY} ]]; then sed -i 's#security.debian.org/debian-security#${DEBIAN_MIRROR_SECURITY}#g' /etc/apt/sources.list; fi'
RUN apt-get update && apt-get install -y \
    libreadline-dev \
    cmake

WORKDIR /opt
RUN mkdir -p -m 0600 ~/.ssh && ssh-keyscan git.cbm.gsi.de >> ~/.ssh/known_hosts
RUN --mount=type=ssh git clone git@git.cbm.gsi.de:ecs/controls/dpbcontrols.git

WORKDIR /opt/dpbcontrols
RUN sed -i 's/Set(Boost_NO_SYSTEM_PATHS TRUE)/Set(Boost_NO_SYSTEM_PATHS FALSE)/g' CMakeLists.txt
RUN /bin/bash -c '[[ ! -d ./build ]] && mkdir -p ./build' && \
    cd ./build && \
    cmake .. && \
    cmake --build ./ --target gdpbCli -- -j 4

CMD /bin/bash
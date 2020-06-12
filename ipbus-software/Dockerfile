FROM debian:buster

LABEL maintainer="s.dong@mails.ccnu.edu.cn"

ARG VERSION

ARG DEBIAN_MIRROR
ARG DEBIAN_MIRROR_SECURITY
RUN /bin/bash -c 'if [[ -n ${DEBIAN_MIRROR} ]]; then sed -i 's#deb.debian.org#${DEBIAN_MIRROR}#g' /etc/apt/sources.list; fi'
RUN /bin/bash -c 'if [[ -n ${DEBIAN_MIRROR_SECURITY} ]]; then sed -i 's#security.debian.org/debian-security#${DEBIAN_MIRROR_SECURITY}#g' /etc/apt/sources.list; fi'
RUN apt-get update && apt-get install -y \
    git \
    make \
    erlang \ 
    g++ \ 
    libboost-all-dev \ 
    libpugixml-dev \ 
    python3-all-dev

WORKDIR /opt

RUN git clone --depth=1 -b ${VERSION} https://github.com/ipbus/ipbus-software.git

RUN ln -s /usr/bin/python3 /usr/bin/python & \
    ln -s /usr/bin/pip3 /usr/bin/pip

RUN cd ipbus-software && make Set=uhal -j4

ENTRYPOINT ["/bin/bash", "-c", "source /opt/ipbus-software/uhal/tests/setup.sh"]

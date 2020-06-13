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

ARG REPO_BASE_DIR=/opt/ipbus-software
ARG UHAL_BASE_DIR=${REPO_BASE_DIR}/uhal

ENV PATH=$UHAL_BASE_DIR/tests/bin:$PATH
ENV PATH=$UHAL_BASE_DIR/tests/src/python:$PATH
ENV PATH=$UHAL_BASE_DIR/tests/scripts:$PATH
ENV PATH=$UHAL_BASE_DIR/tools/scripts:$PATH
ENV PATH=$REPO_BASE_DIR/extern/erlang/RPMBUILD/SOURCES/bin:$PATH
ENV PATH=$REPO_BASE_DIR/controlhub/scripts:$PATH

ENV LD_LIBRARY_PATH=$REPO_BASE_DIR/extern/boost/RPMBUILD/SOURCES/lib:$LD_LIBRARY_PATH
ENV LD_LIBRARY_PATH=$REPO_BASE_DIR/extern/pugixml/RPMBUILD/SOURCES/lib:$LD_LIBRARY_PATH
ENV LD_LIBRARY_PATH=$UHAL_BASE_DIR/log/lib:$LD_LIBRARY_PATH
ENV LD_LIBRARY_PATH=$UHAL_BASE_DIR/grammars/lib:$LD_LIBRARY_PATH
ENV LD_LIBRARY_PATH=$UHAL_BASE_DIR/uhal/lib:$LD_LIBRARY_PATH
ENV LD_LIBRARY_PATH=$UHAL_BASE_DIR/tests/lib:$LD_LIBRARY_PATH

ENV PYTHONPATH=$UHAL_BASE_DIR/pycohal/pkg:$PYTHONPATH
#ENV PYTHONPATH=$UHAL_BASE_DIR/gui:$PYTHONPATH

ENV UHALPATH=$REPO_BASE_DIR

ENTRYPOINT ["/bin/bash"]

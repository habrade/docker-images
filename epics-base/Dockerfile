ARG BASE_IMG
FROM ${BASE_IMG}

LABEL maintainer="s.dong@mails.ccnu.edu.cn"

ARG EPICS_HOST_ARCH
ARG EPICS_HOME=/opt/epics
ENV EPICS_BASE=${EPICS_HOME}/base
ENV EPICS_HOST_ARCH=${EPICS_HOST_ARCH}

# Install EPICS
WORKDIR ${EPICS_HOME}
ARG VERSION
RUN apt-get update && apt-get install -y build-essential git libreadline-dev
RUN git clone https://github.com/epics-base/epics-base.git base && \
    cd ${EPICS_BASE} && \
    git checkout ${VERSION} && \
    git submodule init && \
    git submodule update && \
    make -j4

# Set environment variables
ENV PATH="$PATH:${EPICS_BASE}/bin/${EPICS_HOST_ARCH}"

EXPOSE 5064-5065/tcp 5064-5065/udp

CMD /bin/bash
# syntax=docker/dockerfile:experimental
FROM habrade/epics-base:R7.0.4-amd64

LABEL maintainer="s.dong@mails.ccnu.edu.cn"

RUN apt-get update && apt-get install -y \
    wget

RUN wget https://raw.githubusercontent.com/EPICS-synApps/support/master/assemble_synApps.sh && \ 
    bash ./assemble_synApps.sh full && \ 
    cd ${SUPPORT} && make -j4 

EXPOSE 5064-5065/tcp 5064-5065/udp

CMD [ "/bin/bash" ]
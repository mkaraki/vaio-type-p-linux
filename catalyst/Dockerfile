FROM gentoo/portage AS portage

FROM gentoo/stage3:amd64-openrc

ARG GENTOO_MIRRORS="http://ftp.iij.ad.jp/pub/linux/gentoo/"

RUN mkdir --parents /etc/portage/repos.conf &&\
    cp /usr/share/portage/config/repos.conf /etc/portage/repos.conf/gentoo.conf &&\
    echo "GENTOO_MIRRORS=\"${GENTOO_MIRRORS}\"" >> /etc/portage/make.conf
COPY --from=portage /var/db/repos/gentoo /var/db/repos/gentoo

RUN echo 'dev-util/catalyst' > /etc/portage/package.accept_keywords/catalyst &&\
    emerge dev-util/catalyst

RUN mkdir -p /var/tmp/catalyst/builds/default &&\
    mkdir -p /var/tmp/catalyst/config/stages/package.accept_keywords &&\
    echo 'sys-kernel/gentoo-sources ~x86' >> /var/tmp/catalyst/config/stages/package.accept_keywords/stage4

COPY make.conf /var/tmp/catalyst/config/stages/
COPY package.use /var/tmp/catalyst/config/stages/package.use/catalyst-era

COPY *.spec /var/tmp/catalyst/

COPY build-stage1.sh /usr/bin/
RUN chmod +x /usr/bin/build-stage1.sh

WORKDIR /var/tmp/catalyst
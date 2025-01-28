FROM gentoo/portage AS portage

FROM gentoo/stage3:amd64-openrc

ARG LINUX_VERSION="6.12.11"
ARG LINUX_TAR="https://cdn.kernel.org/pub/linux/kernel/v6.x/linux-$LINUX_VERSION.tar.xz"
ARG GENTOO_MIRRORS="http://ftp.iij.ad.jp/pub/linux/gentoo/"

ENV TARGET_SYSTEM=i686-unknown-linux-gnu
ENV SYSROOT="/"

RUN wget "${LINUX_TAR}" -O linux.tar.xz &&\
    tar xf linux.tar.xz &&\
    rm linux.tar.xz &&\
    mv "linux-${LINUX_VERSION}" "$SYSROOT/usr/src/linux"

RUN mkdir --parents /etc/portage/repos.conf &&\
    cp /usr/share/portage/config/repos.conf /etc/portage/repos.conf/gentoo.conf &&\
    echo "GENTOO_MIRRORS=\"${GENTOO_MIRRORS}\"" >> /etc/portage/make.conf
COPY --from=portage /var/db/repos/gentoo /var/db/repos/gentoo

RUN emerge sys-devel/crossdev app-eselect/eselect-repository &&\
    eselect repository create crossdev &&\
    crossdev --target $TARGET_SYSTEM

COPY xkmake $SYSROOT/usr/src/linux/
#COPY .config $SYSROOT/usr/src/linux/

# For BusyBox build
#RUN emerge sys-libs/ncurses
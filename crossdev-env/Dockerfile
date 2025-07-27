FROM gentoo/portage AS portage

FROM gentoo/stage3:amd64-openrc

ARG GENTOO_MIRRORS="http://ftp.iij.ad.jp/pub/linux/gentoo/"

ARG MAKEOPTS="-j4"
ENV MAKEOPTS=$MAKEOPTS

RUN mkdir --parents /etc/portage/repos.conf &&\
    cp /usr/share/portage/config/repos.conf /etc/portage/repos.conf/gentoo.conf &&\
    echo "GENTOO_MIRRORS=\"${GENTOO_MIRRORS}\"" >> /etc/portage/make.conf
COPY --from=portage /var/db/repos/gentoo /var/db/repos/gentoo

RUN emerge sys-devel/crossdev app-eselect/eselect-repository &&\
    eselect repository create crossdev

ENV TARGET_SYSTEM=i686-gentoo-linux-musl

RUN /usr/bin/crossdev --target $TARGET_SYSTEM
RUN USE="openmp pgo lto" emerge --oneshot cross-${TARGET_SYSTEM}/gcc

# You can check full profile lists:
# https://github.com/gentoo/gentoo/blob/master/profiles/profiles.desc
RUN PORTAGE_CONFIGROOT=/usr/$TARGET_SYSTEM eselect profile set default/linux/x86/23.0/i686/musl
COPY make.conf /usr/${TARGET_SYSTEM}/etc/portage/make.conf
COPY package.use /usr/${TARGET_SYSTEM}/etc/portage/package.use

RUN USE=build ${TARGET_SYSTEM}-emerge -v1 baselayout
RUN ${TARGET_SYSTEM}-emerge -v1 sys-libs/musl
RUN USE="$USE -pci" ${TARGET_SYSTEM}-emerge -v1 sys-devel/mold &&\
    echo 'LDFLAGS="${LDFLAGS} -fuse-ld=mold"' >> /usr/${TARGET_SYSTEM}/etc/portage/make.conf

#RUN ${TARGET_SYSTEM}-emerge -v1 @system

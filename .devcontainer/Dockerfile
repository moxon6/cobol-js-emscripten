
FROM trzeci/emscripten-upstream

RUN apt-get update \
    && apt-get -y install --no-install-recommends \
    vim debootstrap xz-utils lbzip2 lzip clang m4 texinfo g++-multilib \
    autoconf automake gettext autopoint libtool

COPY ./*.sh /scripts/

RUN "bash" "/scripts/build.sh"

RUN apt-get install default-jre
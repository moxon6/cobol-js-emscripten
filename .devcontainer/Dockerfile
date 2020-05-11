
FROM trzeci/emscripten-upstream

RUN apt-get update \
    && apt-get -y install --no-install-recommends \
    vim debootstrap xz-utils lbzip2 lzip clang m4 texinfo g++-multilib \
    autoconf automake gettext autopoint libtool

COPY ./*.sh /scripts/

RUN "bash" "/scripts/build.sh"

RUN apt-get -y install default-jre
RUN apt-get -y install entr
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)" && sed -i "s/OSH_THEME=.*/OSH_THEME=\"sirup\"/g" ~/.bashrc

# Fix locale bug
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y locales
RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    dpkg-reconfigure --frontend=noninteractive locales && \
    update-locale LANG=en_US.UTF-8
ENV LANG en_US.UTF-8 
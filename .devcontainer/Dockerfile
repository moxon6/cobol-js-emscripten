
FROM trzeci/emscripten-upstream

ENV LANG en_US.UTF-8 

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get -y install --no-install-recommends \
    vim debootstrap xz-utils lbzip2 lzip clang m4 texinfo g++-multilib \
    autoconf automake gettext autopoint libtool default-jre entr locales

COPY ./*.sh /scripts/

RUN sed -i 's/\r$//' /scripts/*.sh

RUN "bash" "/scripts/build.sh"
RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    dpkg-reconfigure --frontend=noninteractive locales && \
    update-locale LANG=en_US.UTF-8


RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmybash/oh-my-bash/master/tools/install.sh)" 
RUN sed -i "s/OSH_THEME=.*/OSH_THEME=\"sirup\"/g" ~/.bashrc
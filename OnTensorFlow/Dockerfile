FROM tensorflow/tensorflow:1.9.0-gpu-py3

MAINTAINER wayne <wangxu@china-tiantu.com>

# Install the application.
ADD . /OnTensorFlow/
RUN /OnTensorFlow/build.sh

# Externally accessible data is by default put in /data
WORKDIR /data
VOLUME ["/data"]

# Core linux dependencies. 
RUN apt-get update --fix-missing && \
    apt-get install -y \
    # developer tools
    build-essential \
    vim \
    cmake \
    git \
    wget \
    unzip \
    yasm \
    pkg-config \
    libsm6 \
    libxrender1 \
    libxext-dev \
    tree \
    htop \
    ranger \
    zsh \
    mc

#install z.sh
RUN sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
COPY -f .zshrc /root/

#install plugin of zsh
RUN git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions && \
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

#install package
RUN pip install -r requirements.txt

RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/*

CMD [ "/bin/bash" ]

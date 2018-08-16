FROM wayneiii/rsdi:miniconda

MAINTAINER wayne <wangxu@china-tiantu.com>


#install GDAL
#RUN conda install -c conda-forge gdal==2.3.1

#install tensorflow_gpu 1.10.0
RUN pip install --ignore-installed --upgrade \
https://storage.googleapis.com/tensorflow/linux/gpu/tensorflow_gpu-1.10.0-cp36-cp36m-linux_x86_64.whl


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
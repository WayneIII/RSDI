FROM tensorflow/tensorflow:1.6.0-gpu-py3

MAINTAINER acton <whenyd@126.com>

ADD . /freegis

RUN sed -i 's/archive.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list
RUN apt-get update

# Install Pytorch
# RUN pip install http://download.pytorch.org/whl/cu80/torch-0.3.1-cp35-cp35m-linux_x86_64.whl \
RUN pip install /freegis/torch-0.3.1-cp35-cp35m-linux_x86_64.whl \
    pip install -i https://pypi.douban.com/simple torchvision

# Core linux dependencies. 
RUN apt-get install -y \
    # developer tools
    build-essential \
    cmake \
    git \
    wget \
    unzip \
    yasm \
    pkg-config \
    # image formats support
    libtbb2 \
    libtbb-dev \
    libjpeg-dev \
    libpng-dev \
    libtiff-dev \
    libjasper-dev \
    libhdf5-dev \
    # video formats support
    libavcodec-dev \
    libavformat-dev \
    libswscale-dev \
    libv4l-dev \
    libxvidcore-dev \
    libx264-dev

# Python dependencies
RUN pip --no-cache-dir install \
    -i https://pypi.douban.com/simple \
    tqdm \
    numpy \
    hdf5storage \
    h5py \
    scipy \
    py3nvml \
    keras \
    jupyterlab \
    Pillow \
    shapely \
    geojson \
    geopandas \
    tifffile \
    rasterio \
    rasterstats

WORKDIR /

RUN wget https://github.com/opencv/opencv_contrib/archive/3.4.1.zip \
    && unzip 3.4.1.zip \
    && rm 3.4.1.zip

RUN wget https://github.com/opencv/opencv/archive/3.4.1.zip \
    && unzip 3.4.1.zip \
    && mkdir /opencv-3.4.1/build \
    && cd /opencv-3.4.1/build \
    && cmake -DBUILD_TIFF=ON \
    -DBUILD_opencv_java=OFF \
    -DOPENCV_EXTRA_MODULES_PATH=/opencv_contrib-3.4.1/modules \
    -DWITH_CUDA=OFF \
    -DENABLE_AVX=ON \
    -DWITH_OPENGL=ON \
    -DWITH_OPENCL=ON \
    # cannot download ippicv
    -DWITH_IPP=OFF \
    -DWITH_TBB=ON \
    -DWITH_EIGEN=ON \
    -DWITH_V4L=ON \
    -DBUILD_TESTS=OFF \
    -DBUILD_PERF_TESTS=OFF \
    -DCMAKE_BUILD_TYPE=RELEASE \
    -DCMAKE_INSTALL_PREFIX=$(python -c "import sys; print(sys.prefix)") \
    -DPYTHON_EXECUTABLE=$(which python) \
    -DPYTHON_INCLUDE_DIR=$(python -c "from distutils.sysconfig import get_python_inc; print(get_python_inc())") \
    -DPYTHON_PACKAGES_PATH=$(python -c "from distutils.sysconfig import get_python_lib; print(get_python_lib())") .. \
    && make install \
    && rm /3.4.1.zip \
    && rm -r /opencv-3.4.1 \
    && ldconfig

# Clean-up
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

CMD ["/bin/bash"]
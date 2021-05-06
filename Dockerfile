FROM ubuntu:20.04

ENV TZ=America/Chicago
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime;\
    sh -c 'echo $TZ > /etc/timezone'


RUN apt-get update; \
    apt-get install -y libhdf5-serial-dev \
                       vim \
                       g++ \
                       libeigen3-dev \
                       git \
                       cmake
RUN mkdir -pv $HOME/moab/bld; \
    cd $HOME/moab; \
    git clone https://bitbucket.org/fathomteam/moab -b Version5.1.0; \
    cd $HOME/moab/bld; \ 
    cmake ../moab -DENABLE_HDF5=ON \
                  -DBUILD_SHARED_LIBS=ON \
                  -DENABLE_FORTRAN=OFF \
                  -DENABLE_BLASLAPACK=OFF; \
    make -j 2;\
    make install

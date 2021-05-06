FROM ubuntu:20.04

ENV TZ=America/Chicago
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime
RUN sh -c 'echo $TZ > /etc/timezone'


RUN apt-get update
RUN apt-get install -y libhdf5-serial-dev \
                       vim \
                       g++ \
                       libeigen3-dev \
                       git \
                       cmake

RUN echo $HOME
RUN mkdir -pv $HOME/moab/bld
WORKDIR $HOME/moab
RUN git clone https://bitbucket.org/fathomteam/moab -b Version5.1.0
WORKDIR $HOME/moab/bld
RUN cmake ../moab -DENABLE_HDF5=ON \
                  -DBUILD_SHARED_LIBS=ON \
                  -DENABLE_FORTRAN=OFF \
                  -DENABLE_BLASLAPACK=OFF
RUN make -j 2
RUN make install

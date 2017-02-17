FROM ubuntu:14.04.3
MAINTAINER Joris Kraak <me@joriskraak.nl>

ENV DEBIAN_FRONTEND noninteractive
ENV LANG en_US.UTF-8
ENV PATH /opt/node/bin:/opt/julia/bin:$PATH
ENV PYTHON /usr/bin/python3

ADD ["https://nodejs.org/dist/v5.6.0/node-v5.6.0-linux-x64.tar.gz", "/tmp/"]

ADD ["https://julialang.s3.amazonaws.com/bin/linux/x64/0.5/julia-0.5.0-linux-x86_64.tar.gz", "/tmp/"]

ADD ["bundler/", "/aip-5ssb0-bundler/"]
ADD ["styles/", "/aip-5ssb0-bundler/styles"]

RUN mkdir -p /aip-5ssb0-bundler/lessons && \
    locale-gen en_US.UTF-8 && \
    apt-get update && \
    apt-get install -y build-essential \
                       curl \
                       libjpeg-dev \
                       libnettle4 \
                       libzmq3-dev \
                       pkg-config \
                       python3-cairo \
                       python3-dev \
                       python3-lxml \
                       python3-matplotlib \
                       python3-pip \
                       python3-pyqt4 \
                       software-properties-common \
                       subversion \
                       zlib1g-dev && \
    mkdir -p /opt/julia && \
    tar --strip-components 1 -zxf /tmp/julia-0.5.0-linux-x86_64.tar.gz -C /opt/julia && \
    pip3 install cython jupyter PyPDF2 reportlab && \
    julia -e 'Pkg.add("Cubature"); Pkg.add("DataFrames"); Pkg.add("Distributions"); Pkg.add("Interact"); Pkg.add("Optim"); Pkg.add("PyPlot"); Pkg.add("Reactive"); Pkg.add("IJulia")' && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/ && \
    mkdir -p /opt/node && \
    tar --strip-components 1 -zxf /tmp/node-v5.6.0-linux-x64.tar.gz -C /opt/node && \
    npm install -g phantomjs-prebuilt && \
    cd /aip-5ssb0-bundler && \
    npm install toc

ADD ["ForneyLab.jl", "/root/.julia/v0.5/ForneyLab"]
RUN julia -e 'Pkg.resolve()'

VOLUME /aip-5ssb0-bundler/lessons
VOLUME /aip-5ssb0-bundler/output

WORKDIR /aip-5ssb0-bundler/

CMD ["jupyter", "nbconvert", "--config", "bundle_configuration.py"]

FROM ubuntu:18.04
MAINTAINER Joris Kraak <me@joriskraak.nl>

ENV DEBIAN_FRONTEND noninteractive
ENV LANG en_US.UTF-8
ENV PATH /opt/node/bin:/opt/julia/bin:$PATH
ENV PYTHON /usr/bin/python3

ADD ["https://nodejs.org/dist/v10.15.1/node-v10.15.1-linux-x64.tar.xz", "/tmp/"]

ADD ["https://julialang-s3.julialang.org/bin/linux/x64/1.1/julia-1.1.0-linux-x86_64.tar.gz", "/tmp/"]

ADD ["bundler/", "/aip-5ssb0-bundler/"]
ADD ["styles/", "/aip-5ssb0-bundler/styles"]

RUN mkdir -p /aip-5ssb0-bundler/lessons /aip-5ssb0-bundler/output && \
    apt-get update && \
    apt-get install -y locales && \
    locale-gen en_US.UTF-8 && \
    apt-get install -y build-essential \
                       curl \
                       graphviz \
                       libjpeg-dev \
                       libnettle6 \
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
    tar --strip-components 1 -zxf /tmp/julia-1.1.0-linux-x86_64.tar.gz -C /opt/julia && \
    pip3 install cython jupyter PyPDF2 reportlab && \
    julia -e 'using Pkg; Pkg.add("CSV"); Pkg.add("DataFrames"); Pkg.add("Distributions"); Pkg.add("ForneyLab"); Pkg.add("HCubature"); Pkg.add("IJulia"); Pkg.add("Interact"); Pkg.add("Optim"); Pkg.add("PyPlot"); Pkg.add("Reactive"); Pkg.add("SpecialFunctions")' && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/ && \
    mkdir -p /opt/node && \
    tar --strip-components 1 -xf /tmp/node-v10.15.1-linux-x64.tar.xz -C /opt/node && \
    npm install -g phantomjs-prebuilt --unsafe-perm && \
    cd /aip-5ssb0-bundler && \
    npm install toc

WORKDIR /aip-5ssb0-bundler/

CMD ["jupyter", "nbconvert", "--config", "bundle_configuration.py"]

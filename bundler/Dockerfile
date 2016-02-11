FROM ubuntu:14.04.3
MAINTAINER Joris Kraak <me@joriskraak.nl>

ENV DEBIAN_FRONTEND noninteractive
ENV LANG en_US.UTF-8
ENV PATH /opt/node/bin:$PATH
ENV PYTHON /usr/bin/python3

ADD ["https://nodejs.org/dist/v5.6.0/node-v5.6.0-linux-x64.tar.gz", "/tmp/"]

RUN mkdir -p /aip-5ssb0-bundler/ && \
    locale-gen en_US.UTF-8 && \
    apt-get update && \
    apt-get install -y build-essential \
                       curl \
                       libfontconfig1-dev \
                       libfreetype6-dev \
                       liblapack-dev \
                       libnettle4 \
                       libopenblas-dev \
                       libpng12-dev \
                       libxml2-dev \
                       libxslt1-dev \
                       libzmq3-dev \
                       pkg-config \
                       python3-dev \
                       software-properties-common \
                       subversion \
                       zlib1g-dev && \
    apt-add-repository ppa:staticfloat/juliareleases && \
    apt-get update && \
    apt-get install -y julia python3-pip && \
    pip3 install jupyter lxml matplotlib && \
    julia -e 'Pkg.add("Cubature"); Pkg.add("DataFrames"); Pkg.add("Distributions"); Pkg.add("Interact"); Pkg.add("Optim"); Pkg.add("PyPlot"); Pkg.add("Reactive"); Pkg.add("IJulia")' && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/ && \
    mkdir -p /opt/node && \
    tar --strip-components 1 -zxf /tmp/node-v5.6.0-linux-x64.tar.gz -C /opt/node && \
    npm install -g phantomjs-prebuilt && \
    cd bundler && \
    npm install toc

ADD [".", "/aip-5ssb0-bundler/"]
WORKDIR /aip-5ssb0-bundler/

VOLUME /aip-5ssb0-bundler/

CMD ["jupyter", "nbconvert", "--config", "bundle_configuration.py"]

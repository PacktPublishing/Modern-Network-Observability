ARG TELEGRAF_IMAGE=docker.io/telegraf:1.31

FROM $TELEGRAF_IMAGE

RUN apt-get update && apt-get install -y \
    wget \
    bzip2 \
    ca-certificates \
    curl \
    git \
    && apt-get clean

# Download and install Miniconda
# RUN wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O /tmp/miniconda.sh && \
RUN wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-py312_24.5.0-0-Linux-x86_64.sh -O /tmp/miniconda.sh && \
    /bin/bash /tmp/miniconda.sh -b -p /opt/conda && \
    rm /tmp/miniconda.sh

# Add Miniconda to PATH
ENV PATH=/opt/conda/bin:$PATH

# Verify the installation
RUN conda --version

RUN pip install --upgrade pip && \
    pip --no-cache-dir install netmiko jmespath rich ttp

# For TTP...
RUN chown -R telegraf:telegraf /opt/conda/lib/python3.12/site-packages/ttp
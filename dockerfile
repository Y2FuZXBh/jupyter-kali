FROM kalilinux/kali-rolling:latest

ENV DEBIAN_FRONTEND noninteractive

WORKDIR /root

# apps
RUN apt update -qq && apt install -qq -y \
    nmap \
    git \
    curl \
    wget \
    hostsman \
    ffuf \
    xsltproc \
    net-tools

# python
RUN apt update -qq && apt install -qq -y \
    python-is-python3 \
    python3-pip && \
    pip install \
    python3-nmap

# oscp
RUN apt update -qq && apt install -qq -y \
    crackmapexec \
    nikto \
    wfuzz \
    dnsrecon \
    gobuster \
    tcpdump \
    wpscan \
    cewl \
    snmp \
    nbtscan \
    onesixtyone \
    unicornscan \
    dnsutils \
    exploitdb \
    bloodhound.py \
    davtest \
    webshells

# enum4linux-ng
RUN apt update -qq && apt install -qq -y \
    smbclient \
    python3-ldap3 \
    python3-ldap \
    python3-yaml \
    python3-impacket
ADD https://raw.githubusercontent.com/cddmp/enum4linux-ng/master/enum4linux-ng.py enum4linux-ng.py

# rustscan
ADD https://github.com/RustScan/RustScan/releases/download/2.0.1/rustscan_2.0.1_amd64.deb rustscan.deb
RUN dpkg -i rustscan.deb && rm rustscan.deb

# jupyter
EXPOSE 8888
RUN pip install jupyterlab
# https://jupyterlab.readthedocs.io/en/stable/user/directories.html#application-directory
RUN mkdir -p /usr/local/share/jupyter/lab/settings && \
    echo '{"@jupyterlab/apputils-extension:themes":{"theme": "JupyterLab Dark"}}' > /usr/local/share/jupyter/lab/settings/overrides.json

# export notebook as pdf
RUN apt update -qq && \
    pip install nbconvert && \
    apt install -qq -y pandoc texlive-xetex texlive-fonts-recommended texlive-plain-generic

# zsh notebook
RUN apt update -qq && \
    apt install -qq -y zsh && \
    pip install zsh-jupyter-kernel && \
    python -m zsh_jupyter_kernel.install --sys-prefix

# pwsh /f zsh
RUN apt update -qq && \
    apt install -qq -y powershell

# tini
ADD https://github.com/krallin/tini/releases/download/v0.19.0/tini /usr/bin/tini
RUN chmod +x /usr/bin/tini && mkdir ~/data && touch ~/.hushlogin

# run
WORKDIR /home/jupyter
CMD ["jupyter-lab", "--allow-root", "--port=8888", "--no-browser", "--ip=0.0.0.0"]
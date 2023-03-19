FROM kalilinux/kali-rolling:latest

ENV DEBIAN_FRONTEND noninteractive
ENV JUPYTER_ENABLE_LAB yes

WORKDIR /root
RUN mkdir .logs

# apps
RUN apt update -qq && apt install -qq -y \
    nmap \
    git

# python
RUN apt update -qq && apt install -qq -y \
    python-is-python3 \
    python3-pip \
    python-is-python3 \
    python3-impacket \
    python3-unicorn \
    net-tools

# jupyter
EXPOSE 8888

RUN pip install \
    python3-nmap \
    jupyterlab

ADD https://github.com/krallin/tini/releases/download/v0.19.0/tini /usr/bin/tini
RUN chmod +x /usr/bin/tini

ENTRYPOINT ["/usr/bin/tini", "--"]
SHELL ["bash"]
CMD ["jupyter-lab", "--allow-root", "--port=8888", "--no-browser", "--ip=0.0.0.0"]

FROM kalilinux/kali-rolling:latest

ENV DEBIAN_FRONTEND noninteractive
ENV JUPYTER_ENABLE_LAB yes

WORKDIR /root
RUN mkdir .logs

# apps
RUN apt update -qq && apt install -qq -y \
    nmap \
    git \
    zsh

# python
RUN apt update -qq && apt install -qq -y \
    kali-linux-headless \
    python-is-python3 \
    python3-pip 

# jupyter
EXPOSE 8888

RUN pip install \
    python3-nmap \
    jupyterlab \
    zsh-jupyter-kernel

RUN python -m zsh_jupyter_kernel.install --sys-prefix

ADD https://github.com/krallin/tini/releases/download/v0.19.0/tini /usr/bin/tini
RUN chmod +x /usr/bin/tini && mkdir ~/data

WORKDIR /root/data
COPY sample/reconnaissance.ipynb .

ENTRYPOINT ["/usr/bin/tini", "--"]
SHELL ["bash"]
CMD ["jupyter-lab", "--allow-root", "--port=8888", "--no-browser", "--ip=0.0.0.0"]

FROM kalilinux/kali-rolling:latest

ENV DEBIAN_FRONTEND noninteractive

EXPOSE 8888
WORKDIR /root
RUN mkdir .logs

RUN apt update -qq && apt dist-upgrade -qq

RUN apt update -qq && apt install -qq -y --no-install-recommends \
    wget \
    curl \
    man \
    sudo \
    git

RUN apt update -qq && apt install -qq -y --no-install-recommends \
    nmap

RUN apt update -qq && apt install -qq -y --no-install-recommends \
    python3-pip \
    python-is-python3 \
    python3-impacket

RUN apt autoremove -qq && apt clean -qq

COPY . .

RUN pip install -r requirements.txt && rm requirements.txt

SHELL ["/bin/bash"]

ENTRYPOINT ["jupyter-lab", "--allow-root"]

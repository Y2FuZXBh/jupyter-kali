#!/usr/bin/sudo /usr/bin/python3

import docker
import re
import time


BIND_PORT = 8888
BIND_IP = "127.0.0.1"

print("\nJupyter-Kali | Y2FuZXBh\n")

_docker = docker.from_env()
print("  [+] Building Image..")
# build
_docker.images.build(
    path="https://raw.githubusercontent.com/Y2FuZXBh/jupyter-kali/main/dockerfile",
    tag="jupyter-kali:latest",
    pull=True,
    forcerm=True
)

# clean
print("  [+] Cleaning Environment..")
jupyter_kali = _docker.containers.list(
    all=True, filters={"name": "jupyter-kali"})
if len(jupyter_kali) == 1:
    container = _docker.containers.get(jupyter_kali[0].id)
    # stop if running
    if container.attrs['State']['Running'] == True:
        container.kill()
    # remove
    container.remove(force=True)

# run
print("  [+] Starting New Container..")
_docker.containers.run(
    name="jupyter-kali",
    image="jupyter-kali:latest",
    ports={'8888/tcp': (BIND_IP, BIND_PORT)},
    detach=True
)
time.sleep(5)

# return
print("  [+] Checking Logs..\n")
log = _docker.containers.get("jupyter-kali").logs().decode()
url = re.findall(r'(http://127.0.0.1\S+)', log)[0]
print(url)

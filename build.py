import docker
import re
import time

PORT = 8888

_docker = docker.from_env()

# build
_docker.images.build(
    path="https://raw.githubusercontent.com/Y2FuZXBh/jupyter-kali/main/dockerfile",
    tag="jupyter-kali:latest",
    pull=True,
    rm=True
)

# clean
jupyter_kali = _docker.containers.list(filters={"name": "jupyter-kali"})
if len(jupyter_kali) == 1:
    container = _docker.containers.get(jupyter_kali[0].id)
    container.kill()
    container.remove(force=True)

# run
_docker.containers.run(
    name="jupyter-kali",
    image="jupyter-kali:latest",
    ports={'8888/tcp': PORT},
    detach=True
)
time.sleep(2)

# return
log = _docker.containers.get("jupyter-kali").logs().decode()
url = re.findall(r'(http://127.0.0.1\S+)', log)[0]
print(url)
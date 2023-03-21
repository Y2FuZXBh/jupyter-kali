import docker
import re
import time

PORT = 8888

print("\nJupyter-Kali | Y2FuZXBh\n")

_docker = docker.from_env()
print("  [+] Building Image..")
# build
_docker.images.build(
    path="https://raw.githubusercontent.com/Y2FuZXBh/jupyter-kali/main/dockerfile",
    tag="jupyter-kali:latest",
    pull=True,
    rm=True
)

# clean
print("  [+] Cleaning Environment..")
jupyter_kali = _docker.containers.list(filters={"name": "jupyter-kali"})
if len(jupyter_kali) == 1:
    container = _docker.containers.get(jupyter_kali[0].id)
    container.kill()
    container.remove(force=True)

# run
print("  [+] Starting New Container..")
_docker.containers.run(
    name="jupyter-kali",
    image="jupyter-kali:latest",
    ports={'8888/tcp': PORT},
    detach=True
)
time.sleep(5)

# return
print("  [+] Checking Logs..\n")
log = _docker.containers.get("jupyter-kali").logs().decode()
url = re.findall(r'(http://127.0.0.1\S+)', log)[0]
print(url)
import docker

PORT = 8888

_docker = docker.from_env()

_docker.images.build(
    path=".",
    tag="jupyter-kali:latest",
    pull=True,
    rm=True
)

_docker.containers.run(
    name="jupyter-kali",
    image="jupyter-kali:latest",
    ports={'8888/tcp': PORT},
    detach=True
)

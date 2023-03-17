import docker

_docker = docker.from_env()

_docker.images.build(
    path=".",
    tag="jupyter-offsec:latest",
    pull=True,
    rm=True,
    nocache=True
)

_docker.containers.run(
    image="jupyter-offsec:latest",
    ports={'8888/tcp': 8888},
    detach=True,
    auto_remove=True
)

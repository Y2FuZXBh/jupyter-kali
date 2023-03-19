import docker

_docker = docker.from_env()

_docker.images.build(
    path=".",
    tag="jupyter-kali:latest",
    pull=True,
    rm=True,
    nocache=True
)

_docker.containers.run(
    name="jupyter-kali",
    image="jupyter-kali:latest",
    network_mode="host",
    #ports={'8888/tcp': 9000},
    detach=True
)

#_docker.containers.get("jupyter-kali").attrs['NetworkSettings']['IPAddress']
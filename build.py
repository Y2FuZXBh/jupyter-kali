import docker

_docker = docker.from_env()

_docker.images.build(
    path=".",
    tag="jupyter-kali:latest",
    pull=True,
    rm=True
)

PORT = 80
_docker.containers.run(
    name="jupyter-kali",
    image="jupyter-kali:latest",
    ports={'8888/tcp': PORT},
    detach=True
)

print(
    "jupyter: http://{0}:{1}/lab?token=".format(
        _docker.containers.get("jupyter-kali").attrs['NetworkSettings']['IPAddress'],
        PORT
    )
)

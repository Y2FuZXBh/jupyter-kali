# Jupyter-Kali
### Made for manual penetration testing and objectives like OSCP or HTB challenges.
#### This is `not` a `secure` `container` use at your own risk!

## EXAMPLE
![example](https://user-images.githubusercontent.com/88941079/226449705-6d7f5186-e0e4-4ff9-818c-ff02ce74b45c.png)

## PREREQUISITE
#### Linux (Kali)
```bash
# update
sudo apt update && sudo apt full-upgrade -y

# docker
sudo apt install -y docker.io
sudo systemctl enable docker --now
#sudo usermod -aG docker $USER

# python
sudo apt install python3
sudo apt install python3-pip

# pip
pip install docker
```

#### Windows `NOT TESTED` `REQ WSL2`
```powershell
# chocolatey
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

# docker
choco install docker-desktop
# add $env:username to docker group..

# python
choco install python3

# pip
py -m pip install docker
```

## RUN
```bash
curl https://raw.githubusercontent.com/Y2FuZXBh/jupyter-kali/main/build.py | python -
```
```powershell
(wget -usebasicparsing https://raw.githubusercontent.com/Y2FuZXBh/jupyter-kali/main/build.py).content | python -
```

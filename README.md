## Jupyter-Kali
#### A Kali based container for recon and enumeration using JupyterLab hosted on Docker

### Example
---
#### 1. Run
![run](https://user-images.githubusercontent.com/88941079/230677316-c7a1f87e-7640-477b-863b-8d27d3f196b8.png)

#### 2. Import/Export Files
![single](https://user-images.githubusercontent.com/88941079/230676823-3d129680-f9d8-49c9-b43b-f4547542d9c7.png)

#### 3. Split Files & Output
![split](https://user-images.githubusercontent.com/88941079/230676835-1e54eb90-0717-47cc-904b-6b5e6ef120bd.png)

### Setup
---
#### Linux (Kali)
```bash
# update
sudo apt update && sudo apt -y upgrade

# docker
sudo apt install -y docker.io
sudo systemctl enable docker --now

# python
sudo apt install python3
sudo apt install python3-pip

# pip
sudo pip install docker
```

#### Windows `WSL2`
```powershell
# chocolatey
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

# docker
choco install docker-desktop

# python
choco install python3

# pip
py -m pip install docker
```

### Build + Run
---
```bash
curl -sS https://raw.githubusercontent.com/Y2FuZXBh/jupyter-kali/main/build.py | sudo python3 -
```
```powershell
(wget -usebasicparsing https://raw.githubusercontent.com/Y2FuZXBh/jupyter-kali/main/build.py).content | python -
```

### `After Restart` Get New Url + Token
---
```bash
sudo docker logs jupyter-kali 2>&1 | grep "http://127.0.0.1" | tail -n 1 | xargs
```

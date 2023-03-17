FROM jupyter/minimal-notebook:latest

COPY requirements.txt .

RUN pip install -r requirements.txt
FROM python:3.8-buster

RUN apt-get update -y \
    && apt-get install -y python3-dev python3-pip build-essential \
    && apt-get install gcc -y \
    && apt-get clean

COPY requirements.txt /requirements.txt

RUN pip3 install --upgrade pip
RUN pip3 install -r requirements.txt

RUN mkdir -p /app

RUN mkdir -p /app/src
RUN mkdir -p /app/data

WORKDIR /app

COPY /src /app/src
COPY /data /app/data

RUN jupyter notebook --generate-config --allow-root
RUN echo "c.NotebookApp.password = u'sha1:6a3f528eec40:6e896b6e4828f525a6e20e5411cd1c8075d68619'" >> /root/.jupyter/jupyter_notebook_config.py

CMD ["jupyter", "notebook", "--allow-root", "--notebook-dir=.", "--ip=0.0.0.0", "--port=8888", "--no-browser"]

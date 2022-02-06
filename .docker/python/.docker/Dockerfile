ARG PYTHON_VERSION
FROM python:${PYTHON_VERSION}

WORKDIR /conf
RUN /usr/local/bin/python -m pip install --upgrade pip
COPY  requirements.txt /conf/requirements.txt
RUN pip install -r requirements.txt

WORKDIR /application

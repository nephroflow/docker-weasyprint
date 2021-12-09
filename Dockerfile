FROM python:3.8-slim-buster

# install all the dependencies except libcairo2 from jessie
RUN apt-get -y update \
    && apt-get install -y \
        fonts-font-awesome \
        libffi-dev \
        libgdk-pixbuf2.0-0 \
        libpango1.0-0 \
        python-dev \
        python-lxml \
        shared-mime-info \
        libcairo2 \
    && apt-get -y clean

WORKDIR /usr/src/app

COPY requirements.txt ./

RUN pip install --no-cache-dir -r requirements.txt

COPY wsgi.py ./

EXPOSE 5001

CMD gunicorn --bind 0.0.0.0:5001 wsgi:app

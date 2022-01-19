FROM python:3.10-slim-bullseye

# install all the dependencies except libcairo2 from jessie
RUN apt-get -y update \
    && apt-get install --no-install-recommends -y \
        fonts-font-awesome \
        libffi-dev \
        libgdk-pixbuf2.0-0 \
        libpango1.0-0 \
        python-dev \
        python3-lxml \
        shared-mime-info \
        libcairo2 \
    && apt-get -y clean \
    && rm -rf /var/lib/apt/lists/*

ADD fonts /usr/share/fonts

WORKDIR /usr/src/app

COPY requirements.txt ./

RUN pip install --no-cache-dir -r requirements.txt

COPY wsgi.py ./

EXPOSE 5001

CMD gunicorn --bind 0.0.0.0:5001 wsgi:app

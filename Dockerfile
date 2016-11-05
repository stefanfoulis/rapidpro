FROM aldryn/base-project:3.18

RUN mkdir -p /app
WORKDIR /app

ENV PYTHONPATH=/app/src:$PYTHONPATH\
    C_FORCE_ROOT=1 \
    WHEELSPROXY_URL=https://wheels.aldryn.net/v1/aldryn-extras+pypi/aldryn-baseproject/

#COPY pip-*.txt /app/
# RUN pip install -r /app/pip-freeze.txt
COPY requirements.* /app/
RUN pip-reqs compile
RUN pip-reqs resolve
RUN pip install --no-index --no-deps --requirement requirements.urls
# librato-bg fails on "python setup.py egg_info" using pip-reqs
RUN pip install librato-bg
COPY . /app/

RUN npm install -g coffee-script
RUN npm install -g less

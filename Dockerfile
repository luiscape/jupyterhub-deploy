FROM debian:jessie

MAINTAINER Luis Capelo <luis.capelo@flowminder.org>

RUN echo 'deb http://apt.postgresql.org/pub/repos/apt/ jessie-pgdg main' $PG_MAJOR > /etc/apt/sources.list.d/pgdg.list

#
#  Installs Node.js
#
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get -y update && \
    apt-get -y upgrade && \
    apt-get -y install npm nodejs nodejs-legacy wget locales git

#
#  Install PostgreSQL drivers.
#
ENV PG_MAJOR 9.5
ENV PG_VERSION 9.5.2-1.pgdg80+1
RUN apt-get install -y --force-yes postgresql-common postgresql-$PG_MAJOR=$PG_VERSION \
     postgresql-contrib-$PG_MAJOR=$PG_VERSION libpq-dev

#
#  Install Anaconda.
#
RUN wget --quiet https://3230d63b5fc54e62148e-c95ac804525aac4b6dba79b00b39d1d3.ssl.cf1.rackcdn.com/Anaconda3-4.0.0-Linux-x86_64.sh && \
    bash Anaconda3-4.0.0-Linux-x86_64.sh -b -p /opt/anaconda3 && \
    rm Anaconda3-4.0.0-Linux-x86_64.sh
ENV PATH /opt/anaconda3/bin:$PATH
RUN chmod -R a+rx /opt/anaconda3

#
#  Install HTTP Proxy (managed by Node.js).
#
RUN npm install -g configurable-http-proxy && rm -rf ~/.npm

#
#  Install analytical dependencies.
#
RUN conda update --yes conda && \
    conda install --yes numpy scipy pandas matplotlib \
                              cython pyzmq scikit-learn seaborn \
                              six statsmodels theano pip tornado jinja2 \
                              sphinx pygments nose readline sqlalchemy \
                              ipython jupyter notebook psycopg2

RUN pip install jupyterhub notebook psycopg2 --upgrade

#
#  Clean-up.
#
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN conda clean -y -t

#
#  Create shared folders.
#
RUN mkdir /opt/notebooks
RUN chmod a+rwx /opt/notebooks

#
#  Create users.
#
ADD users.txt /tmp/users.txt
ADD bin/add_user.sh /tmp/add_user.sh
RUN bash /tmp/add_user.sh /tmp/users.txt
RUN rm /tmp/add_user.sh /tmp/users.txt

#
#  Add JupyterHub configuration.
#
RUN mkdir /server
ADD jupyterhub_config.py /server/jupyterhub_config.py
WORKDIR /server

CMD ["jupyterhub", "--no-ssl", "-f", "/srv/jupyterhub/jupyterhub_config.py"]
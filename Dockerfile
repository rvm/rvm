# This Dockerfile is useful to try changes in RVM without affecting the local system
# Run it like $ docker build . -t rvm && docker run --rm -it rvm
FROM fedora:37
RUN dnf install -y which
RUN dnf install -y procps
COPY . /rvm
WORKDIR /rvm
RUN ./install
RUN echo 'PS1="\e[0;32m[\u@\h \W]\$ \e[m"' >> ~/.bashrc
CMD bash

FROM dockerfile/ansible

# Copy all here
RUN mkdir -p /usr/src/oah
ADD . /usr/src/oah
WORKDIR /usr/src/oah

CMD ["./bin/install.sh"]

FROM dockerfile/java

# Copy all here
RUN mkdir -p /usr/src/app
ADD . /usr/src/app
WORKDIR /usr/src/app

CMD ["./gradlew"]

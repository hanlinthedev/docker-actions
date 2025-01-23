# Container image that runs your code
FROM alpine:3.10

RUN apk update && \
    apk add --no-cache curl jq

RUN ls -al
# Copies your code file from your action repository to the filesystem path `/` of the container
COPY entrypoint.sh /entrypoint.sh

RUN ls -al

RUN chmod 777 ./entrypoint.sh

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["./entrypoint.sh"]

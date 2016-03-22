###########################################################
#
# Dockerfile for tfk-api-unoconv
#
###########################################################

# Setting the base to nodejs 4.3.1
FROM node:4.3.1-slim

# Maintainer
MAINTAINER Geir Gåsodden

#### Begin setup ####

# Installs unoconv
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y unoconv git && apt-get clean

# Bundle app source
COPY . /src

# Change working directory
WORKDIR "/src"

# Add uploads directory
RUN mkdir uploads

# Install dependencies
RUN npm install --production

# Env variables
ENV SERVER_PORT 3000
ENV PAYLOAD_MAX_SIZE 1048576

# Expose 3000
EXPOSE 3000

# Startup
ENTRYPOINT /usr/bin/unoconv --listener --server=0.0.0.0 --port=2002 && node standalone.js
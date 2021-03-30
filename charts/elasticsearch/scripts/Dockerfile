FROM ubuntu:20.04

# Declare constants
ENV NVM_VERSION v0.37.2
ENV NODE_VERSION 14.16.0
ENV ELASTICDUMP_VERSION 6.28.0

# Replace shell with bash so we can source files
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

# Install pre-reqs
RUN apt-get update
RUN apt-get -y install curl build-essential

# Install NVM
RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/${NVM_VERSION}/install.sh | bash

# Install NODE
RUN source ~/.nvm/nvm.sh; \
    nvm install $NODE_VERSION; \
    nvm use --delete-prefix $NODE_VERSION; \
    npm install elasticdump@$ELASTICDUMP_VERSION -g 

# Add the index migration script to image
WORKDIR /home/es-migration
COPY migrate_indices.sh .
RUN chmod +x migrate_indices.sh 

# Ensure npm install directory is on the path
ENV PATH="/root/.nvm/versions/node/v${NODE_VERSION}/bin:${PATH}"

# Run the migration script
CMD ["/bin/bash", "-c", "./migrate_indices.sh ${ES_DUMP_SOURCE} ${ES_DUMP_TARGET}"]

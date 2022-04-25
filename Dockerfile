FROM node:16.14.2 as base

ENV WORKDIR=/usr/app
#ENV MONGO_URL=$MONGO_URL
WORKDIR ${WORKDIR}

# Add package file
COPY package.json $WORKDIR/package.json
COPY yarn.lock $WORKDIR/yarn.lock
# COPY scripts/dev.sh ./scripts/dev.sh

# Install deps
RUN yarn install

# Copy source
COPY src $WORKDIR/src
COPY tsconfig.json $WORKDIR/tsconfig.json
COPY openapi.json $WORKDIR/openapi.json

# Build dist
RUN yarn build

ENV NODE_PATH=/usr/app/node_modules
# ENV MONGO_URL=${MONGO_URL}
VOLUME ${NODE_PATH}

# Copy node modules and build directory
# COPY ./node_modules /usr/app/node_modules
COPY . /usr/app/

# Copy static files
# COPY src/public dist/src/public

EXPOSE 9009
CMD ["dist/src/server.js"]

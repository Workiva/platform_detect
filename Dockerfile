FROM google/dart:2

WORKDIR /build

# grab source
COPY . /build/

# dart pub get
ARG BUILD_ID
ARG GIT_COMMIT
ARG GIT_TAG
ARG GIT_BRANCH

RUN dart pub get

FROM scratch

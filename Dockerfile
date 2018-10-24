FROM google/dart:1.24.3 as build

WORKDIR /build

# grab source
COPY . /build/

# pub get
ARG BUILD_ID
ARG GIT_COMMIT
ARG GIT_TAG
ARG GIT_BRANCH

RUN pub get

ARG BUILD_ARTIFACTS_DART-DEPENDENCIES=/build/pubspec.lock

FROM scratch

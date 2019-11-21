FROM drydock.workiva.net/workiva/dart_build_image:test_dart_2.6.1-latest

WORKDIR /build

# grab source
COPY . /build/

# pub get
ARG BUILD_ID
ARG GIT_COMMIT
ARG GIT_TAG
ARG GIT_BRANCH

RUN pub get

ARG BUILD_ARTIFACTS_DART_PUBSPECLOCK=/build/pubspec.lock

FROM scratch

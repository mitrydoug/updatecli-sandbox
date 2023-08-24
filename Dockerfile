# Build Stage
FROM updatecli-sandbox:1.13 AS build-stage

LABEL app="build-updateclisandbox"
LABEL REPO="https://github.com/mitrydoug/updateclisandbox"

ENV PROJPATH=/go/src/github.com/mitrydoug/updateclisandbox

# Because of https://github.com/docker/docker/issues/14914
ENV PATH=$PATH:$GOROOT/bin:$GOPATH/bin

ADD . /go/src/github.com/mitrydoug/updateclisandbox
WORKDIR /go/src/github.com/mitrydoug/updateclisandbox

RUN make build-alpine

# Final Stage
FROM updatecli-sandbox

ARG GIT_COMMIT
ARG VERSION
LABEL REPO="https://github.com/mitrydoug/updateclisandbox"
LABEL GIT_COMMIT=$GIT_COMMIT
LABEL VERSION=$VERSION

# Because of https://github.com/docker/docker/issues/14914
ENV PATH=$PATH:/opt/updateclisandbox/bin

WORKDIR /opt/updateclisandbox/bin

COPY --from=build-stage /go/src/github.com/mitrydoug/updateclisandbox/bin/updateclisandbox /opt/updateclisandbox/bin/
RUN chmod +x /opt/updateclisandbox/bin/updateclisandbox

# Create appuser
RUN adduser -D -g '' updateclisandbox
USER updateclisandbox

ENTRYPOINT ["/usr/bin/dumb-init", "--"]

CMD ["/opt/updateclisandbox/bin/updateclisandbox"]

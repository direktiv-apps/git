FROM golang:1.18.2-alpine as build

COPY build/app/go.mod src/go.mod
COPY build/app/cmd src/cmd/
COPY build/app/models src/models/
COPY build/app/restapi src/restapi/

RUN cd src/ && go mod tidy

RUN cd src && \
    export CGO_LDFLAGS="-static -w -s" && \
    go build -tags osusergo,netgo -o /application cmd/git-server/main.go; 

FROM ubuntu:22.04

RUN apt-get update && apt-get install ca-certificates -y

RUN apt-get install git sed curl wget -y

RUN wget https://github.com/cli/cli/releases/download/v2.13.0/gh_2.13.0_linux_amd64.tar.gz &&  \
    tar -xvzf gh_2.13.0_linux_amd64.tar.gz

RUN cp gh_2.13.0_linux_amd64/bin/gh ./usr/local/bin/gh

# install changelog generator
RUN apt-get install make ruby-full ruby-dev -y
RUN apt-get install build-essential -y

RUN gem install faraday-retry
RUN gem install github_changelog_generator


COPY build/prep-git.sh /
RUN chmod 755 prep-git.sh

# DON'T CHANGE BELOW 
COPY --from=build /application /bin/application

EXPOSE 8080

CMD ["/bin/application", "--port=8080", "--host=0.0.0.0", "--write-timeout=0"]
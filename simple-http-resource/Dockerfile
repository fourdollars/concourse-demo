FROM alpine:latest
RUN apk update
RUN apk upgrade
RUN apk add bash jq curl
ADD /check /opt/resource/check # check step
ADD /out /opt/resource/out     # put step
ADD /in /opt/resource/in       # get step
RUN chmod +x /opt/resource/*   # make sure they are executable

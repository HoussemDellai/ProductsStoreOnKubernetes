ARG APP_IMAGE=mvc-app:1.0
ARG MICROSCANNER_TOKEN=ZGEzNTQ5Y2QyNjAx

FROM $APP_IMAGE

# Run Aqua Security Microscanner, https://github.com/aquasecurity/microscanner
RUN apt-get update && \ 
    apt-get -y install ca-certificates && \
    apt-get -y install wget && \
    wget -O /microscanner https://get.aquasec.com/microscanner && \
    chmod +x /microscanner && \
    /microscanner $MICROSCANNER_TOKEN --full-output && \
    rm -rf /microscanner
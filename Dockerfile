# Usage:
# 
# docker run -d -P -e "PROJECT=YourProjectId" totomz/google-datastore:latest
#   
#

FROM anapsix/alpine-java:8_jdk
MAINTAINER Tommaso Doninelli <tommaso.doninelli@my-ideas.it> (@totomz)

# Update the OS and install dependencies
RUN apk update && apk add wget bash python docker && rm -rf /var/cache/apk/*

# Download and install the cloud sdk
RUN wget https://dl.google.com/dl/cloudsdk/release/google-cloud-sdk.tar.gz --no-check-certificate \
    && tar zxvf google-cloud-sdk.tar.gz \
    && rm google-cloud-sdk.tar.gz \
    && ls -l \
    && ./google-cloud-sdk/install.sh --usage-reporting=true --path-update=true

# Add gcloud to the path
ENV PATH /google-cloud-sdk/bin:$PATH

# Configure gcloud for your project
RUN yes | gcloud components update
RUN yes | gcloud components update preview
RUN yes | gcloud components install beta gcd-emulator

# Prepare a directory for the launch script
COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

# Epose the port of google datastore
EXPOSE 8014

# Execute the launch script
ENTRYPOINT [ "docker-entrypoint.sh" ]
CMD [ "google-datastore" ]

FROM gcr.io/google_containers/ubuntu-slim:0.1

#ENV  GIT_SYNC_DEST /git
#ENV  GIT_SYNC_REPO https://github.com/remotejob/www-data.git
#VOLUME ["/usr/share/nginx"]
VOLUME ["/git"]

RUN apt-get update && \
  apt-get install -y git ca-certificates --no-install-recommends && \
  apt-get install -y openssh-client && \
  apt-get install -y curl && \
  apt-get clean -y && \
  rm -rf /var/lib/apt/lists/*

COPY git-sync /git-sync

# Move the existing SSH binary, then replace it with the wrapper script
#RUN mv /usr/bin/ssh /usr/bin/ssh-binary
#COPY ssh-wrapper.sh /usr/bin/ssh
#RUN chmod 755 /usr/bin/ssh

#RUN mkdir /nonexistent && chmod 777 /nonexistent

ENTRYPOINT ["/git-sync"]
#ENTRYPOINT ["/git-sync"]

FROM ubuntu-hadoop-base:hadoop-3.0.0

LABEL maintainer="Vincent<vincent.zc.zhang@gmail.com>"

HEALTHCHECK CMD curl -f http://localhost:8089/ || exit 1

EXPOSE 8089

CMD ["/root/start_resource_manager.sh"]
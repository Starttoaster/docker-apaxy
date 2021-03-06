FROM httpd:2.4-alpine

RUN echo "Include conf/sites-enabled/*.conf" >> \
    /usr/local/apache2/conf/httpd.conf

#
# Install git so we can clone the git repository
#
RUN apk update && \
    apk add --no-cache git

#
# Clone the Apaxy repo from the read-only URL
#
RUN cd
RUN git clone git://github.com/AdamWhitcroft/Apaxy.git

VOLUME /data
EXPOSE 80

#
# Copy the local files
#
ADD ./run.sh /run.sh
ADD ./tpl/apaxy.tpl /apaxy.tpl
RUN chmod 755 /run.sh

ENTRYPOINT ["/run.sh"]

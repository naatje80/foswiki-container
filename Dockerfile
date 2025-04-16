FROM alpine:edge

ENV FOSWIKI_LATEST_URL https://github.com/foswiki/distro/releases/download/FoswikiRelease02x01x09/Foswiki-2.1.9.tgz

ENV FOSWIKI_LATEST Foswiki-2.1.9

RUN rm -rf /var/cache/apk/* && \
    rm -rf /tmp/* && \
    apk update && \
    apk upgrade && \
    apk add --update && \
    apk add nginx bash perl \
	perl-cgi perl-cgi-session perl-crypt-passwdmd5 perl-error perl-file-copy-recursive perl-json perl-fcgi perl-libwww perl-lwp-protocol-https perl-locale-codes && \
    touch /root/.bashrc && \
    wget ${FOSWIKI_LATEST_URL} && \
    mkdir -p /var/www && \
    mv ${FOSWIKI_LATEST}.tgz /var/www && \
    cd /var/www && \
    tar xvfz ${FOSWIKI_LATEST}.tgz && \
    rm -rf ${FOSWIKI_LATEST}.tgz && \
    mv ${FOSWIKI_LATEST} foswiki && \
    cd foswiki && \
    sh tools/fix_file_permissions.sh && \
    cd /var/www/foswiki && \
    tools/configure -save -noprompt && \
    tools/configure -save -set {DefaultUrlHost}='http://localhost' && \
    tools/configure -save -set {ScriptUrlPath}='/bin' && \
    tools/configure -save -set {ScriptUrlPaths}{view}='' && \
    tools/configure -save -set {PubUrlPath}='/pub' && \
    tools/configure -save -set {SafeEnvPath}='/bin:/usr/bin' && \
    rm -fr /var/www/foswiki/working/configure/download/* && \
    rm -fr /var/www/foswiki/working/configure/backup/* && \
    mkdir -p /run/nginx && \
    mkdir -p /etc/nginx/http.d && \
    chown -R nginx:nginx /var/www/foswiki

COPY nginx.default.conf /etc/nginx/http.d/default.conf
COPY docker-entrypoint.sh docker-entrypoint.sh

EXPOSE 80

CMD ["sh", "docker-entrypoint.sh"]

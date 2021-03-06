FROM ownyourbits/nextcloud-x86

MAINTAINER Ignacio Núñez Hernanz <nacho@ownyourbits.com>

SHELL ["/bin/bash", "-c"]

ENV DOCKERBUILD 1

RUN mkdir -p /tmp/ncp-build
COPY bin/*            /tmp/ncp-build/bin/
COPY etc              /tmp/ncp-build/etc/
COPY ncp.sh update.sh /tmp/ncp-build/
COPY ncp-web          /tmp/ncp-build/ncp-web/
COPY docker-common    /tmp/ncp-build/docker-common/

RUN \

# make sure we don't accidentally disable first run wizard
rm -f ncp-web/{wizard.cfg,ncp-web.cfg}; \

# mark as image build
touch /.ncp-image; \

# mark as docker image
touch /.docker-image; \

apt-get update; \
apt-get install --no-install-recommends -y wget ca-certificates; \
      
# install nextcloudpi
source /usr/local/etc/library.sh; \
set +x; \
cd /tmp/ncp-build/; \
install_script ncp.sh; \

# fix default paths
sed -i 's|/media/USBdrive|/data/backups|' /usr/local/etc/ncp-config.d/nc-backup.sh; \

# specific cleanup
rm -r /tmp/ncp-build; \
rm /.ncp-image; \

# cleanup all NCP extras
source /usr/local/etc/library.sh; \
cd /usr/local/etc/ncp-config.d/; \
for script in *.sh; do cleanup_script $script; done; \

# should be cleaned up in no-ip.sh, but breaks udiskie.
# safe to do it here since no automount in docker
apt-get purge -y make gcc libc-dev; \

# package clean up
apt-get autoremove -y; \
apt-get clean; \
rm -f /var/lib/apt/lists/*; \
find /var/log -type f -exec rm {} \; ; \
rm -rf /usr/share/man/*; \
rm -rf /usr/share/doc/*; \
rm -f /var/log/alternatives.log /var/log/apt/*; \
rm /var/cache/debconf/*-old; 

COPY docker-common/nextcloudpi/000ncp /etc/services-enabled.d/

# 4443 - ncp-web
EXPOSE 80 443 4443

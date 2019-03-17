FROM vladus2000/arch-base-yay
MAINTAINER vladus2000 <docker@matt.land>

COPY shiz/ /home/evil/shiz/

RUN \
	/install-devel.sh && \
	su - evil -c 'yay -S --needed --noconfirm rsync rtorrent geoip php-geoip plowshare mktorrent nginx irssi perl-archive-zip perl-digest-sha1 perl-html-parser perl-json perl-json-xs perl-net-ssleay perl-xml-libxml perl-xml-libxslt fcgi fcgiwrap spawn-fcgi screen php-fpm mediainfo procps-ng' && \
	chown -R evil ~evil/shiz && \
	su - evil -c 'mkdir -p ~/.irssi/scripts/autorun && cd ~/.irssi/scripts && git init && git remote add origin https://github.com/autodl-community/autodl-irssi.git && git pull origin master && cp autodl-irssi.pl autorun/ && mkdir -p ~/.autodl && cp ~/shiz/autodl.cfg ~/.autodl/autodl.cfg && cp ~/shiz/.rtorrent.rc ~/.rtorrent.rc && mkdir -p ~/rtorrent/.session' && \
	mkdir -p /usr/share/webapps && \
	cd /usr/share/webapps && \
	git clone https://github.com/Novik/ruTorrent.git && \
	mv ruTorrent rutorrent && \
	cd /usr/share/webapps/rutorrent/plugins && \
	git clone https://github.com/autodl-community/autodl-rutorrent.git autodl-irssi && \
	cp autodl-irssi/_conf.php autodl-irssi/conf.php && \
	cd /usr/share/webapps/ && \
	chown http:http -R rutorrent && \
	cp ~evil/shiz/conf.php /usr/share/webapps/rutorrent/plugins/autodl-irssi/ && \
	cp ~evil/shiz/config.php /usr/share/webapps/rutorrent/conf/ && \
	cp ~evil/shiz/base_startup.sh / && \
	cp ~evil/shiz/startup.sh / && \
	cp ~evil/shiz/nginx.conf /etc/nginx/ && \
	chmod +x /startup.sh /base_startup.sh && \
	chown -R evil:evil /usr/share/webapps/rutorrent && \
	sed -e 's/;extension=sockets/extension=sockets/' /etc/php/php.ini > /php.ini && \
	mv /php.ini /etc/php/php.ini && \
	/rm-devel.sh

EXPOSE 8069
EXPOSE 49152

CMD /bin/bash -c /startup.sh

VOLUME /home/evil/downloads
VOLUME /home/evil/rtorrent
VOLUME /usr/share/webapps/rutorrent/share/settings


su - evil -c 'mkdir -p ~evil/rtorrent/.session'
/fixuser.sh evil
/unevil.sh
php-fpm
nginx
su - evil -c 'screen -d -m -S rtorrent rtorrent'
su - evil -c 'screen -d -m -S irssi irssi'
while true
do
	sleep 1h
done

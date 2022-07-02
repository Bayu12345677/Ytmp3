configure:
	apt-get update
	apt-get upgrade
	apt-get install jq curl libcurl openssl-tool ncurses-utils
run:
	chmod 0755 app.shell
	# termux only
	export PATH="/data/data/com.termux/files/usr/bin"
	./app.shell

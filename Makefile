configure:
	apt-get update
	apt-get upgrade
	apt-get install jq curl libcurl openssl-tool ncurses-utils python
	python setup.py install
run:
	chmod 0755 app.shell
	# termux only
	export PATH=/data/data/com.termux/files/usr/bin
	./app.shell

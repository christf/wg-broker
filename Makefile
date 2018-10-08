
install:
	mkdir -p $(DESTDIR)/usr/sbin
	mkdir -p $(DESTDIR)/etc
	install -m 0755 src/wg-broker-server $(DESTDIR)/usr/sbin/wg-broker-server
	install -m 0644 src/wg-broker.conf $(DESTDIR)/etc/wg-broker.conf

deb:
	checkinstall -D --maintainer="Christof Schulze \<christof@christofschulze.com\>" --requires="jq,iptables,ip6tables,wireguard" --pkgname=wg-broker-server --pkgversion=1 --install=no --nodoc make install


install:
	mkdir -p $(DESTDIR)/usr/sbin
	mkdir -p $(DESTDIR)/etc
	mkdir -p $(DESTDIR)/etc/wg-broker
	install -m 0755 src/wg-broker-server $(DESTDIR)/usr/sbin/wg-broker-server
	install -m 0644 src/config $(DESTDIR)/etc/wg-broker/config

deb:
	checkinstall -D --maintainer="Christof Schulze \<christof@christofschulze.com\>" --requires="jq,iptables,ip6tables,wireguard" --pkgname=wg-broker-server --pkgversion=1 --install=no --nodoc make install


install:
	mkdir -p $(DESTDIR)/usr/sbin
	mkdir -p $(DESTDIR)/etc
	mkdir -p $(DESTDIR)/etc/wg-broker
	install -m 0755 src/wg-broker-server $(DESTDIR)/usr/sbin/wg-broker-server
	install -m 0644 src/config $(DESTDIR)/etc/wg-broker/config

deb:
	checkinstall -D --fstrans=yes --maintainer="Christof Schulze \<christof@christofschulze.com\>" --requires="bash,netcat-openbsd,jq,iptables,socat,wireguard" --pkgname=wg-broker --pkgrelease=$(WGRELEASE) --pkgversion=$(WGVERSION) --install=no --nodoc --pkgarch=all make install

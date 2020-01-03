# wg-broker
This repository contains a wireguard broker that dynamically accepts connections. This is useful for building freifunk networks.

## Dependencies
- jq
- openbsd-netcat
- socat

Debian: `apt install netcat-openbsd jq socat`


# Protocol Documentation

The wireguard broker allows peers to form a VPN network. A blacklist / 
whitelist could be implemented on the server.

For now, one peer that initializes the connection offers a wireguard public key 
to the control port of the wg-broker:
```
{
  "version":1,
  "pubkey": "THIS_IS_THE_PUBLIC_KEY_AS_GENERATED_BY_WIREGUARD_IN_BASE64_ENCODING="
}
```

The peer replies with a json message. In case of a successful setup this 
structure is returned:

```
{
  "version":1,
  "port": <udp port to be set as remote port for wireguard endpoint>,
  "time": <current unix time of server>,
}
```

or, in case of an error a message containing an error object. Currently only 
one error can be returned:
```
{
  "version": 1,
  "error": {
    "code":1,
    "reason": "Remote peer is not accepting additional connections"
  }
}
```

In case of a successful setup, the initiating host is expected to:
* in case the own clock differs a lot from the peer, set its current system 
  time to the one provided by the broker. This compensates the situation 
  that NTP usually only works when already connected to the freifunk network.
* configure a new wireguard interface to connect to the hostname and port 
  utilizing the private/public key that was provided in the initial message.

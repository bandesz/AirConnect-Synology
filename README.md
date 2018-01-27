# AirConnect package for Synology routers

A minimal Synology 1.1 package for [AirConnect](https://github.com/philippe44/AirConnect
). It's tested on Synology RT2600.

It allows you to use AirPlay to stream to UPnP/Sonos devices.

Currently it only runs the airupnp process with the following options:

```
airupnp-arm -b 10.1.14.1:49154 -z -l 1000:2000 -f /tmp/airupnp-arm.log -d all=error
```

For license information please see https://github.com/philippe44/AirConnect/blob/master/LICENSE.

## Build

```
make clean build
```

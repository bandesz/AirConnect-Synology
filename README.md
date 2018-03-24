# AirConnect package for Synology NAS and Synology Router

[![Latest release](https://img.shields.io/github/release/bandesz/AirConnect-Synology.svg)](https://github.com/bandesz/AirConnect-Synology/releases/latest)

A minimal Synology package for [AirConnect](https://github.com/philippe44/AirConnect
). It allows you to use AirPlay to stream to UPnP/Sonos devices.

You can find the available packages under [Releases](https://github.com/bandesz/AirConnect-Synology/releases) for three different architecture groups:
 * **ARMv7**: ipq806x armada370 armadaxp armada375 armada38x alpine alpine4k monaco comcerto2k
 * **Intel - 32-bit**: x86 cedarview bromolow evansport avoton braswell broadwell apollolake
 * **Intel - 64-bit (DSM 6.0+)**: x86_6

You can check which architecture you have [here](https://www.synology.com/en-uk/knowledgebase/DSM/tutorial/General/What_kind_of_CPU_does_my_NAS_have).

For the Synology Routers you should use the ARM version.

## How it works

It runs the airupnp process with the following options:

```
airupnp -b [router local ip]:49154 -z -l 1000:2000 -f /tmp/airupnp.log -d all=error
```

The process is running with a low-privilege user.

The router's local IP is automatically fetched from the Ethernet interface list. The start script looks for the first 192.168.* IP address. If the airupnp process doesn't add any device (based on the logs) it will try on the first 10.* IP address. For the automatic IP discovery to work you should have at least one UPnP/Sonos device on your network.

If AirConnect won't start up you can modify the `scripts/start-stop-status` script, set your own local IP and build your own package. Look for the following lines:

```
# If you want to start the airupnp process on a custom IP please uncomment the following lines
# and set your own local IP address:
#
# start_airupnp "1.2.3.4" || true
# return  0
```

Alternatively you can open an issue ticket and include your network interface list and your local IP.

## Build

Optionally run shellcheck:

```
make shellcheck
```

Build packages for all architectures:

```
make clean build-all
```

Build a package for only one architecture:

```
ARCH=arm make clean build
```

Possible values for ARCH: arm, x86, x86-64

You can find the built packages in the dist directory.

## Debugging

You can see the error logs by going to the Package Center and clicking **View Log** on the package's page.
If you want to see more logs then change the ```-d all=error``` parameter in scripts/start-stop-status and rebuild the package, then install it again from the dist directory.

## License

See https://github.com/philippe44/AirConnect/blob/master/LICENSE.

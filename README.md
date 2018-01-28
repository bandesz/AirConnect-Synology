# AirConnect package for Synology NAS and Synology Router

A minimal Synology package for [AirConnect](https://github.com/philippe44/AirConnect
). It allows you to use AirPlay to stream to UPnP/Sonos devices.

You can find the available packages under [Releases](https://github.com/bandesz/AirConnect-Synology/releases) for three different architecture groups:
 * **ARMv7**: ipq806x armada370 armadaxp armada375 armada38x alpine alpine4k monaco comcerto2k
 * **Intel - 32-bit**: x86 cedarview bromolow evansport avoton braswell broadwell apollolake
 * **Intel - 64-bit (DSM 6.0+)**: x86_6

You can check which architecture you have [here](https://www.synology.com/en-uk/knowledgebase/DSM/tutorial/General/What_kind_of_CPU_does_my_NAS_have).

For the Synology Routers you should use the ARM version.

## Tested devices

* Synology RT2600 router

## How it works

It runs the airupnp process with the following options:

```
airupnp -b [router local ip]:49154 -z -l 1000:2000 -f /tmp/airupnp.log -d all=error
```

The process is running with a low-privilege user.

The router IP is currently fetched from the lbr0 interface which might not exist on certain devices. If this is the case you will get an error message during the install. Please open an issue and include the list of interfaces your device has and which one is bound to your local network.

## Build

```
make build-all
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

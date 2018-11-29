# Update a Debian Installation ISO

To use the file preseed method, the preseed file has to be incorporated into the ISO image.  This docker images can be run as a command line tool to unpack a Debian Installation ISO, for example, the netinst.iso, add files to it, and then pack it up as a fresh, bootable ISO again.

## Building the Docker Image

To build the image, run this command:
```
docker build -t debian-update-preseed-iso:latest .
```

## Updating A Debian Installer ISO

1. Download the ISO, for example https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/debian-9.6.0-amd64-netinst.iso.

1. Create a suitable `preseed.cfg`, by following the instructions from the [Debian preseed documemtation](https://wiki.debian.org/DebianInstaller/Preseed).

1. Run this command to add your `preseed.cfg` to a new image:
```
docker run -it --rm -v "$PWD":/work debian-update-preseed-iso:latest debian-9.6.0-amd64-netinst.iso
```

  This will generate `preseed-debian-9.6.0-amd64-netinst.iso`.

1. Make the ISO availabe to the machine you want to install: burn a disk, copy the image to a USB stick, etc.

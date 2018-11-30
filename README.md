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


## Customizing The Install

The update command will add `preseed.cfg` from the main directory, and all files in the `initrd` directory to the initrd image.

As an example, there are three scripts in the `initrd/custom` directory that are called from `preseed.cfg` at various points during the installation. This allows you to fully customize the install.

When adding files to `initrd`, make sure you pick names that do not conflict with regular initrd image contents.

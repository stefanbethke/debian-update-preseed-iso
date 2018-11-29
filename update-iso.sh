#!/bin/sh

set -xe

if [ $# -lt 1 ]; then
  echo "must specify iso file to update" >&2
  exit 64
fi

if [ ! -f "$1" ]; then
  echo "$1 not found" >&2
  exit 64
fi

if [ -n "$2" ]; then
  IMAGENAME="$2"
else
  IMAGENAME="preseed-$1"
fi

ISOFILES=/var/tmp/iso

echo "*** Unpacking ISO $1"
rm -rf ${ISOFILES}
mkdir ${ISOFILES}
bsdtar -C ${ISOFILES} -xf "$1"

echo "*** Updating initrd"
chmod +w -R ${ISOFILES}/install.amd/
gunzip ${ISOFILES}/install.amd/initrd.gz
echo preseed.cfg | cpio -H newc -o -A -F ${ISOFILES}/install.amd/initrd
gzip ${ISOFILES}/install.amd/initrd
chmod -w -R ${ISOFILES}/install.amd/

(
  cd ${ISOFILES}
  md5sum $(find -follow -type f) >md5sum.txt
)

echo "*** Generating new image ${IMAGENAME}"
xorriso -as mkisofs -o ${IMAGENAME} \
        -isohybrid-mbr /usr/lib/ISOLINUX/isohdpfx.bin \
        -c isolinux/boot.cat -b isolinux/isolinux.bin -no-emul-boot \
        -boot-load-size 4 -boot-info-table ${ISOFILES}

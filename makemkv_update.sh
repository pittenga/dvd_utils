#!/bin/bash
# Collect sudo credentials
sudo -v

wget "http://www.makemkv.com/forum2/viewtopic.php?f=3&t=224" -O makemkv.html
VER=`cat makemkv.html | grep "<title>" | sed 's/.*MKV \(.*\) for.*/\1/'`
rm makemkv.html

TMPDIR=`mktemp -d`

# Install prerequisites
sudo apt-get install build-essential pkg-config libc6-dev libssl-dev libexpat1-dev libavcodec-dev libgl1-mesa-dev libqt4-dev

# Install this version of MakeMKV
pushd $TMPDIR

for PKG in bin oss; do
    PKGDIR="makemkv-$PKG-$VER"
    PKGFILE="$PKGDIR.tar.gz"

    wget "http://www.makemkv.com/download/$PKGFILE"
    tar xzf $PKGFILE

    pushd $PKGDIR
    if [ -e "./configure" ]; then
        ./configure
    fi
    make
    sudo make install

    popd
done

popd

# Remove temporary directory
if [ -e "$TMPDIR" ]; then rm -rf $TMPDIR; fi

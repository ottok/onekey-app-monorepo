#!/bin/bash

libs=(
  libdl.so.2
  libpthread.so.0
  libgobject-2.0.so.0
  libglib-2.0.so.0
  libgio-2.0.so.0
  libnss3.so
  libnssutil3.so
  libsmime3.so
  libnspr4.so
  libatk-1.0.so.0
  libatk-bridge-2.0.so.0
  libcups.so.2
  libdbus-1.so.3
  libdrm.so.2
  libgtk-3.so.0
  libpango-1.0.so.0
  libcairo.so.2
  libX11.so.6
  libXcomposite.so.1
  libXdamage.so.1
  libXext.so.6
  libXfixes.so.3
  libXrandr.so.2
  libgbm.so.1
  libexpat.so.1
  libxcb.so.1
  libxkbcommon.so.0
  libasound.so.2
  libatspi.so.0
  libm.so.6
  libgcc_s.so.1
  libc.so.6
  libffi.so.8
  libatomic.so.1
  libpcre2-8.so.0
  libgmodule-2.0.so.0
  libz.so.1
  libmount.so.1
  libselinux.so.1
  libplc4.so
  libplds4.so
  libgssapi_krb5.so.2
  libavahi-common.so.3
  libavahi-client.so.3
  libgnutls.so.30
  libsystemd.so.0
  libXau.so.6
  libXdmcp.so.6
  libXi.so.6
  libblkid.so.1
  libkrb5.so.3
  libk5crypto.so.3
  libcom_err.so.2
  libkrb5support.so.0
  libp11-kit.so.0
  libidn2.so.0
  libunistring.so.5
  libtasn1.so.6
  libhogweed.so.6
  libnettle.so.8
  libgmp.so.10
  libcap.so.2
  libkeyutils.so.1
  libresolv.so.2
)

# Check if apt-file is installed, if not, install it
if ! command -v apt-file &> /dev/null
then
  echo "apt-file not found. Installing..."
  apt-get update
  apt-get install -q --yes apt-file
  apt-file update
fi

for lib in "${libs[@]}"
do
  echo "Searching for package that provides $lib..."

  # Check if the file already exists on the system
  if dpkg -S "$lib" &> /dev/null
  then
    echo "  $lib is already provided by an installed package."
  else
    # If not found in installed packages, search in Debian archive
    apt-file search "$lib" | grep -E "$lib$" | awk '{print $1}' | sort -u || echo "  $lib not found in Debian archive"
  fi
done

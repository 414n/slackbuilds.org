#!/bin/sh
set -e
SRCDIR=RTL88x2BU-Linux-Driver/
# Search for an already downloaded repository to download only differences
if [ -d "$SRCDIR" ]
then
	pushd "$(pwd)"
	cd "$SRCDIR"
	if [ "$(git remote update &>/dev/null && git status -uno | grep behind)" ]
	then
		echo "Updating latest snapshot..."
		git pull
		popd
	else
		echo "Snapshot already up to date. Checking tarball..."
		popd
		#exit 1
	fi
else
	echo "Creating first snapshot (may take a long time)..."
	git clone "https://github.com/RinCat/RTL88x2BU-Linux-Driver.git"
fi
VERSION="$(cd "$SRCDIR" && git log --oneline -1 --date=format:"%Y%m%d%H%M" --format="%ad_%h")"
if [ -z "$VERSION" ]
then
	echo "Error extracting git version using git log!"
	exit 1
fi
# Create the tarball
if [ -f "rtl88x2bu-$VERSION.tar.bz2" ]
then
	echo "tarball already created"
else
	mv "$SRCDIR" "rtl88x2bu-${VERSION}"
	echo "Creating tarball..."
	tar --exclude-vcs-ignores --exclude .git -cjf "rtl88x2bu-${VERSION}.tar.bz2" "rtl88x2bu-${VERSION}"/ 	
	mv "rtl88x2bu-${VERSION}" "$SRCDIR"
	echo "Done"
fi

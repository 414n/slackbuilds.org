#!/bin/bash
# This script changes the given package .info file so that the DOWNLOAD/MD5SUM
# entries are disabled in favor of DOWNLOAD_x86_64 and MD5SUM_x86_64

set -eEu

usage()
{
	cat << EOF
Usage:
	"$(basename "$0")" PACKAGE_NAME
or
	"$(basename "$0")" FILE

In the first form, it will search for a package named PACKAGE_NAME in the
repository and fix the DOWNLOAD/MD5SUM entries so that the normal ones are
disabled and only the DOWNLOAD_x86_64/MD5SUM_x86_64 ones are active.

In the second form, it will read the package names from the given FILE (one per line)
and fix the DOWNLOAD/MD5SUM entries for each package
EOF
}

# Args:
# $1 - package name
fix_package()
{
	local info pkgnam
	pkgnam="${1:-'missing package name!'}"

	echo "going to fix package $pkgnam"

	info="$(find . -type f -name "$pkgnam.info")"

	if [ -z "$info" ]
	then
		echo "could not find $pkgnam.info file!"
		return 1
	fi

	. "$info"

	if [ "$DOWNLOAD" = UNSUPPORTED ] && [ -z "$MD5SUM" ]
	then
		echo "DOWNLOAD already set to UNSUPPORTED and MD5SUM removed. Nothing to do."
		return 0
	fi

	if [ "$DOWNLOAD_x86_64" ] || [ "$MD5SUM_x86_64" ]
	then
		echo "DOWNLOAD_x86_64 already set to $DOWNLOAD_x86_64 or MD5SUM_x86_64 already set to $MD5SUM_x86_64!"
		return 2
	fi

cat << EOF > "$info"
PRGNAM="$PRGNAM"
VERSION="$VERSION"
HOMEPAGE="$HOMEPAGE"
DOWNLOAD=UNSUPPORTED
MD5SUM=""
DOWNLOAD_x86_64="$DOWNLOAD"
MD5SUM_x86_64="$MD5SUM"
REQUIRES="$REQUIRES"
MAINTAINER="$MAINTAINER"
EMAIL="$EMAIL"
APPROVED="$APPROVED"
EOF

}

if [ $# -ne 1 ]
then
	usage
	exit 1
fi

firstArg="${1:-'missing package name or file!'}"

if [ ! -e "$firstArg" ]
then
	fix_package "$firstArg"
else
	while read -r pkg
	do
		if [[ ! "$pkg" =~ python3|half ]]
		then
			fix_package "$pkg"
		else
			echo "skipping package $pkg"
		fi
	done < "$firstArg"
fi




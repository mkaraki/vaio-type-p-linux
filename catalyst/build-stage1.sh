#!/bin/bash
set -Ceu

if [[ $# -ne 4 ]]; then
	echo " Usage: build-stage1.sh \"Stage 3 URL\" \"Stage 3 file name\" \"Emerge Snapshot Treeish\" \"Spec file name\""
	echo "Sample: build-stage1.sh https://distfiles.gentoo.org/releases/x86/autobuilds/20250126T093335Z/stage3-i686-openrc-20250126T093335Z.tar.xz stage3-i686-openrc.tar.xz 59ca0a188467b4e235eabfa6e48d9c614949393b stage1-Bonnell-openrc.spec"
	echo ""
	echo "Note: You can find latest stable treeish in"
	echo "      https://gitweb.gentoo.org/repo/sync/gentoo.git/?h=stable"
	exit 1
fi

STAGE3_URL="$1"
STAGE3_NAME="$2"
EMERGE_TREEISH="$3"
SPEC_FILE="$4"

if [ ! -f "/var/tmp/catalyst/${SPEC_FILE}" ]; then
	echo "No spec file exists"
	echo ""
	echo "Available options:"
	cd /var/tmp/catalyst/
	ls *.spec
	exit 2
fi

wget -O "/var/tmp/catalyst/builds/default/${STAGE3_NAME}" "${STAGE3_URL}"

catalyst -s "${EMERGE_TREEISH}"

cat "/var/tmp/catalyst/${SPEC_FILE}" | sed "s/@TREEISH@/${EMERGE_TREEISH}/" >| "/var/tmp/catalyst/${SPEC_FILE}_edit"

catalyst -f "/var/tmp/catalyst/${SPEC_FILE}_edit"
# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils git-2

DESCRIPTION="FLIF is the Free Lossless Image Format"
HOMEPAGE="http://flif.info"
EGIT_REPO_URI="git://github.com/FLIF-hub/FLIF.git
				https://github.com/FLIF-hub/FLIF"
LICENSE="GPL-3+ LGPL-3+ Apache-2.0"
SLOT="0"
IUSE="-viewflif +decoder +pixbuf"

DEPEND="media-libs/libpng
		viewflif? ( media-libs/libsdl2 )
		pixbuf? ( x11-libs/gdk-pixbuf )
		sys-libs/zlib"
RDEPEND="${DEPEND}"

src_prepare() {
	# recommended by Gentoo
	epatch_user
}

src_compile() {
	emake
	cd src/
	if use decoder; then
		emake decoder
	fi
	if use viewflif; then
		emake viewflif
	fi
	if use pixbuf; then
		emake pixbufloader
	fi
}

src_install() {
	#emake DESTDIR="${D}/usr" install
	cd src/
	emake PREFIX="${D}/usr" install
	emake PREFIX="${D}/usr" install-dev
	if use decoder; then
		emake PREFIX="${D}/usr" install-decoder
	fi
	if use viewflif; then
		emake PREFIX="${D}/usr" install-viewflif
	fi
	if use pixbuf; then
		# pixbufloader uses absolute paths, so ignore the Makefile entry and
		# do it manually
		einstall -c -d /usr/lib/gdk-pixbuf-2.0/2.10.0/loaders
		einstall -c -m 755 -s libpixbufloader-flif.so /usr/lib/gdk-pixbuf-2.0/2.10.0/loaders/
	fi
}

pkg_postinst() {
	if use pixbuf; then
		# update pixbuf cache
		gdk-pixbuf-query-loaders --update-cache
	fi
}

# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils git-2

DESCRIPTION="FLIF is the Free Lossless Image Format"
HOMEPAGE="http://flif.info"
EGIT_REPO_URI="git://github.com/FLIF-hub/FLIF.git
				https://github.com/FLIF-hub/FLIF"
LICENSE="LGPL-3 Apache-2"
SLOT="0"
IUSE="-viewflif +decoder"

DEPEND="media-libs/libpng
		viewflif? ( media-libs/libsdl2 )
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
}

src_install() {
	#emake DESTDIR="${D}/usr" install
	# defaults to /usr
	cd src/
	emake DESTDIR="${D}" install
	emake DESTDIR="${D}" install-dev
	if use decoder; then
		emake DESTDIR="${D}" install-decoder
	fi
	if use viewflif; then
		emake DESTDIR="${D}" install-viewflif
	fi
}

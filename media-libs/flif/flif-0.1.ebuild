# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit eutils

DESCRIPTION="FLIF is the Free Lossless Image Format"
HOMEPAGE="http://flif.info"
SRC_URI="https://github.com/FLIF-hub/FLIF/archive/v${PV}-alpha.tar.gz -> ${P}-alpha.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="media-libs/libpng
		media-libs/libsdl2
		sys-libs/zlib"
RDEPEND="${DEPEND}"

src_prepare() {
	# recommended by Gentoo
	epatch_user
}

src_compile() {
	emake
}

src_install() {
	#emake DESTDIR="${D}/usr" install
	# defaults to /usr
	emake DESTDIR="${D}" install
}

# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils git-2

DESCRIPTION="FLIF is the Free Lossless Image Format"
HOMEPAGE="http://flif.info"
EGIT_REPO_URI="git://github.com/FLIF-hub/FLIF.git
				https://github.com/FLIF-hub/FLIF"
LICENSE="LGPL-3"
SLOT="0"
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
	emake DESTDIR="${D}/usr" install
}

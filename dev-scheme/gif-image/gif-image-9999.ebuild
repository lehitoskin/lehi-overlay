# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils git-2

DESCRIPTION="Racket code for manipulating GIF images"
HOMEPAGE="https://github.com/lehitoskin/gif-image"
EGIT_REPO_URI="git://github.com/lehitoskin/gif-image
	https://github.com/lehitoskin/gif-image"
LICENSE="GPL-3"
SLOT="0"

RDEPEND="dev-scheme/racket[X]"

src_prepare() {
	epatch_user
}

src_compile() {
	#emake
	raco make -v main.rkt
}

src_install() {
	#emake DESTDIR="${D}/usr" install
	mkdir -p ${D}/usr/share/racket/pkgs/gif-image
	cp -Rv . ${D}/usr/share/racket/pkgs/gif-image
}

pkg_postinst() {
	raco link -i /usr/share/racket/pkgs/gif-image
}

pkg_prerm() {
	raco link -ir /usr/share/racket/pkgs/gif-image
}

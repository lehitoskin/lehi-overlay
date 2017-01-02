# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils git-2

DESCRIPTION="Racket wrapper to the FLIF library."
HOMEPAGE="https://github.com/lehitoskin/flif"
EGIT_REPO_URI="git://github.com/lehitoskin/flif
	https://github.com/lehitoskin/flif"
LICENSE="GPL-3"
SLOT="0"

RDEPEND="dev-scheme/racket[X]"

src_prepare() {
	epatch_user
}

src_compile() {
	raco make -v main.rkt
}

src_install() {
	mkdir -p ${D}/usr/share/racket/pkgs/flif
	cp -Rv . ${D}/usr/share/racket/pkgs/flif
}

pkg_postinst() {
	raco link -i /usr/share/racket/pkgs/flif
}

pkg_prerm() {
	raco link -ir /usr/share/racket/pkgs/flif
}

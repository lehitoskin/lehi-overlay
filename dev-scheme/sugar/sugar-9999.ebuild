# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils git-2

DESCRIPTION="Functions that improve the readability of (my) Racket code"
HOMEPAGE="https://github.com/mbutterick/sugar"
EGIT_REPO_URI="git://github.com/mbutterick/sugar
	https://github.com/mbutterick/sugar"
LICENSE="GPL-3"
SLOT="0"

DEPEND="dev-scheme/racket"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch_user
}

src_install() {
	mkdir -p ${D}/usr/share/racket/pkgs/sugar
	cp -Rv . ${D}/usr/share/racket/pkgs/sugar
}

pkg_postinst() {
	raco link -id /usr/share/racket/pkgs/sugar
	raco setup --only sugar
}

pkg_prerm() {
	raco link -ir /usr/share/racket/pkgs/sugar
}

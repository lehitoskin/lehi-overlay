# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils git-2

DESCRIPTION="Functions that improve the readability of (my) Racket code"
HOMEPAGE="https://github.com/mbutterick/txexpr"
EGIT_REPO_URI="git://github.com/mbutterick/txexpr
	https://github.com/mbutterick/txexpr"
LICENSE="GPL-3"
SLOT="0"

DEPEND="dev-scheme/racket"
RDEPEND="${DEPEND}
		dev-scheme/sugar"

src_prepare() {
	epatch_user
}

src_install() {
	mkdir -p ${D}/usr/share/racket/pkgs/txexpr
	cp -Rv . ${D}/usr/share/racket/pkgs/txexpr
}

pkg_postinst() {
	raco link -id /usr/share/racket/pkgs/txexpr
	raco setup --only txexpr
}

pkg_prerm() {
	raco link -ir /usr/share/racket/pkgs/txexpr
}

# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils git-2

DESCRIPTION="An Object/Relational Mapper for Racket"
HOMEPAGE="https://github.com/brown131/racquel"
EGIT_REPO_URI="git://github.com/brown131/racquel
	https://github.com/brown131/racquel"
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
	mkdir -p ${D}/usr/share/racket/pkgs/racquel
	cp -Rv . ${D}/usr/share/racket/pkgs/racquel
}

pkg_postinst() {
	raco link -i /usr/share/racket/pkgs/racquel
}

pkg_prerm() {
	raco link -ir /usr/share/racket/pkgs/racquel
}

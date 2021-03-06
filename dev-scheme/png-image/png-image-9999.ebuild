# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils git-2

DESCRIPTION="Library to view and modify PNG chunks."
HOMEPAGE="https://github.com/lehitoskin/png-image"
EGIT_REPO_URI="git://github.com/lehitoskin/png-image
	https://github.com/lehitoskin/png-image"
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
	mkdir -p ${D}/usr/share/racket/pkgs/png-image
	cp -Rv . ${D}/usr/share/racket/pkgs/png-image
}

pkg_postinst() {
	raco link -i /usr/share/racket/pkgs/png-image
	raco setup --all-users --only png-image
}

pkg_prerm() {
	raco link -ir /usr/share/racket/pkgs/png-image
}

# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils git-2

DESCRIPTION="RSVG bindings for Racket"
HOMEPAGE="https://github.com/takikawa/racket-rsvg"
EGIT_REPO_URI="git://github.com/takikawa/racket-rsvg
	https://github.com/takikawa/rsvg"
LICENSE="GPL-3"
SLOT="0"

RDEPEND="dev-scheme/racket[X]
		gnome-base/librsvg"

src_prepare() {
	epatch_user
}

src_compile() {
	raco make -v rsvg/main.rkt
}

src_install() {
	mkdir -p ${D}/usr/share/racket/pkgs/rsvg
	cp -Rv . ${D}/usr/share/racket/pkgs/rsvg
}

pkg_postinst() {
	raco link -id /usr/share/racket/pkgs/rsvg
	raco setup --all-users --only rsvg
}

pkg_prerm() {
	raco link -ir /usr/share/racket/pkgs/rsvg
}

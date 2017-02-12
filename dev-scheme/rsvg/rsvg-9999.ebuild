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
	#emake
	raco make -v main.rkt
}

src_install() {
	#emake DESTDIR="${D}/usr" install
	mkdir -p ${D}/usr/share/racket/pkgs/rsvg
	install -m 0644 COPYING ${D}/usr/share/racket/pkgs/rsvg
	install -m 0644 README.md ${D}/usr/share/racket/pkgs/rsvg
	install -m 0644 info.rkt ${D}/usr/share/racket/pkgs/rsvg
	cp -Rv rsvg/* ${D}/usr/share/racket/pkgs/rsvg
}

pkg_postinst() {
	raco link -i /usr/share/racket/pkgs/rsvg
	raco setup --only rsvg
}

pkg_prerm() {
	raco link -ir /usr/share/racket/pkgs/rsvg
}

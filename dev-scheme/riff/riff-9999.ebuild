# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils git-2

DESCRIPTION="Racket wrapper to the FLIF library."
HOMEPAGE="https://github.com/lehitoskin/riff"
EGIT_REPO_URI="git://github.com/lehitoskin/riff
	https://github.com/lehitoskin/riff"
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
	mkdir -p ${D}/usr/share/racket/pkgs/riff
	cp -Rv . ${D}/usr/share/racket/pkgs/riff
}

pkg_postinst() {
	raco link -i /usr/share/racket/pkgs/riff
	raco setup --all-users --only riff
}

pkg_prerm() {
	raco link -ir /usr/share/racket/pkgs/riff
}

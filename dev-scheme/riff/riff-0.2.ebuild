# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit eutils

DESCRIPTION="Racket wrapper to the FLIF library."
HOMEPAGE="https://github.com/lehitoskin/riff"
SRC_URI="https://github.com/lehitoskin/riff/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"

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

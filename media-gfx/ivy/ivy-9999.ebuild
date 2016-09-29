# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils git-2

DESCRIPTION="Ivy is a taggable image viewer"
HOMEPAGE="https://github.com/lehitoskin/ivy"
EGIT_REPO_URI="git://github.com/lehitoskin/ivy
				https://github.com/lehitoskin/ivy"
LICENSE="GPL-3"
SLOT="0"
IUSE=""

DEPEND=">=dev-scheme/racket-6.6[X]"
RDEPEND="${DEPEND}
		dev-db/sqlite:3
		dev-scheme/racquel
		dev-scheme/rsvg"

src_prepare() {
	# recommended by Gentoo
	epatch_user
}

src_compile() {
	emake
}

src_install() {
	emake DESTDIR="${D}/usr" install

	# fix pathing in .desktop file
	for f in /usr/share/applications/ivy-image-viewer.desktop; do
		sed -e "s|${D}||g" \
			-i "${D}/${f}" || die "Failed to patch '${f}'"
	done
}

# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit eutils git-r3 qmake-utils cmake-utils

DESCRIPTION="Support FLIF images in Qt applications"
HOMEPAGE="https://github.com/spillerrec/qt-flif-plugin"
EGIT_REPO_URI="git://github.com/spillerrec/qt-flif-plugin
				https://github.com/spillerrec/qt-flif-plugin"
LICENSE="GPL-3"
SLOT="0"
IUSE=""

DEPEND="dev-qt/qtcore:5
		dev-qt/qtgui:5
		media-libs/flif"
RDEPEND="${DEPEND}"

src_prepare() {
	eapply_user
	# looks for the flif headers in a weird place
	sed -i "s|FLIF/||" src/Flif++.hpp || die
}

src_configure() {
	eqmake5
	cmake-utils_src_configure
}

src_compile() {
	cmake-utils_src_compile
}

src_install() {
	cmake-utils_src_install
}

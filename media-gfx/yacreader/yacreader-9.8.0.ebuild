# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit eutils qmake-utils

DESCRIPTION="Yet another comic reader"
HOMEPAGE="www.yacreader.com"
SRC_URI="https://github.com/YACReader/yacreader/archive/refs/tags/${PV}.tar.gz -> ${PV}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="-qrcode"

DEPEND="app-arch/p7zip
		dev-qt/qtcore
		dev-qt/qtgui
		dev-qt/qtimageformats
		dev-qt/qtmultimedia
		dev-qt/qtnetwork
		dev-qt/qtopengl
		dev-qt/qtsql
		dev-db/sqlite
		qrcode? ( media-gfx/qrencode )"
RDEPEND="${DEPEND}
		dev-qt/qtdeclarative
		dev-qt/qtquickcontrols"

src_prepare() {
	eapply_user
}

src_configure() {
	curl -O http://distfiles.gentoo.org/distfiles/9f/p7zip_16.02_src_all.tar.bz2 && \
		tar -xf p7zip_16.02_src_all.tar.bz2 && \
		mv p7zip_16.02 compressed_archive/libp7zip
}

src_compile() {
	eqmake5 CONFIG+="7zip"
}

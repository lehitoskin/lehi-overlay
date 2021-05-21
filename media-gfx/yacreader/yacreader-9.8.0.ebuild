# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit eutils

DESCRIPTION="Yet another comic reader"
HOMEPAGE="www.yacreader.com"
SRC_URI="https://github.com/YACReader/yacreader/archive/refs/tags/${PV}.tar.gz -> ${PV}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="-p7zip -qrcode"

DEPEND="dev-qt/qtcore
		dev-qt/qtgui
		dev-qt/qtimageformats
		dev-qt/qtmultimedia
		dev-qt/qtnetwork
		dev-qt/qtopengl
		dev-qt/qtsql
		dev-db/sqlite
		p7zip? ( app-arch/p7zip )
		qrcode? ( media-gfx/qrencode )"
RDEPEND="${DEPEND}
		dev-qt/qtdeclarative
		dev-qt/qtquickcontrols"

src_prepare() {
	eapply_user
}

src_configure() {
	use p7zip || curl -O https://sourceforge.net/projects/p7zip/files/p7zip/16.02/p7zip_16.02_src_all.tar.bz2 && \
		tar -xf p7zip_16.02_src_all.tar.bz2 && \
		mv p7zip_16.02 compressed_archive/libp7zip
}

src_compile() {
	local myopts

	use p7zip || myopts="7zip"

	eqmake5 CONFIG+="${myopts}"
}

# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

# The council suggests to use the latest ebuild API
EAPI=6
PYTHON_COMPAT=( python2_7 )

inherit eutils user distutils-r1

DESCRIPTION="Lastfmsubmitd is a Last.fm client plugin framework"
HOMEPAGE="http://www.red-bean.com/decklin/lastfmsubmitd/"
SRC_URI="http://www.red-bean.com/decklin/${PN}/${PF}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE=""

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}"

DIRS="/var/log/lastfm /var/run/lastfm /var/spool/lastfm"

src_prepare() {
	distutils-r1_src_prepare
	mkdir -pv "${D}/etc/init.d"
}

pkg_preinst() {
	install -m 0755 ${FILESDIR}/lastfmsubmitd "${D}/etc/init.d"
}

pkg_postinst() {
	enewgroup lastfm 
	enewuser lastfm -1 /sbin/login /var/log/lastfm lastfm
	mkdir -p $DIRS
	chown lastfm:lastfm $DIRS
}

pkg_prerm() {
	rm -v /etc/init.d/lastfmsubmitd
}

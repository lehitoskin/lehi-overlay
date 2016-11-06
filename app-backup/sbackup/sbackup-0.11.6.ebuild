# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

EAPI=6
PYTHON_DEPEND="2"
PYTHON_COMPAT=( python2_7 )

inherit eutils

DESCRIPTION="Simple Backup solution"
HOMEPAGE="https://launchpad.net/sbackup"
SRC_URI="mirror://sourceforge/${PN}/${PN}_${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="ftp fuse ssh"

RDEPEND="gnome-base/libglade
        dev-python/gnome-python-base
        dev-python/libgnome-python
		dev-python/notify-python
		sys-devel/gettext
		dev-python/setuptools
		dev-python/pygtk
		dev-python/pexpect
		gnome-base/gconf
		ftp? ( net-fs/curlftpfs )
		fuse? ( sys-fs/fuse gnome-base/gvfs[fuse?] )
		ssh? ( net-fs/sshfs )"

DEPEND="${RDEPEND}
        dev-libs/libconfig
        sys-devel/automake
        sys-devel/libtool"

src_prepare() {
	# portage complains otherwise
	eapply_user
	# convert old schema type to new
	mv -v data/apps_sbackup_global-preferences.schemas data/apps_sbackup_global-preferences.schemas.old
	gsettings-schema-convert -g data/apps_sbackup_global-preferences.schemas.old -o data/apps_sbackup_global-preferences.schemas

	# patch the Makefile
	epatch ${FILESDIR}/sbackup-makefile.patch
}

src_compile() {
	emake
}

src_install() {
	emake ROOTDIR="${D}" PREFIX="${D}/usr" install
}

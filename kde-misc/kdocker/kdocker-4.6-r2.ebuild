# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/kdocker/kdocker-4.6-r2.ebuild,v 1.1 2012/06/04 10:01:55 kensington Exp $

EAPI=4
LANGS="it"
inherit qt4-r2

DESCRIPTION="Helper to dock any application into the system tray"
HOMEPAGE="https://launchpad.net/kdocker/"
SRC_URI="http://launchpad.net/${PN}/trunk/${PV:0:3}/+download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	x11-libs/libX11
	x11-libs/libXmu
	x11-libs/libXpm
	x11-libs/qt-core
	x11-libs/qt-gui
"
RDEPEND="${DEPEND}"

DOCS="AUTHORS BUGS ChangeLog CREDITS README TODO"

PATCHES=(
	"${FILESDIR}/${P}-icon.patch"
	"${FILESDIR}/${P}-gcc-4.7.patch"
)

src_prepare() {
	qt4-r2_src_prepare

	if ! use linguas_it ; then
		sed -e '/^INSTALLS +=/s/translations//' -i kdocker.pro || die "sed failed"
	fi
}
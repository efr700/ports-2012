# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/piklab/piklab-0.16.2.ebuild,v 1.1 2013/12/16 05:17:38 patrick Exp $

EAPI=4
KDE_REQUIRED="optional"
KDE_HANDBOOK="optional"
KDE_LINGUAS="de cs es fr hu it"
inherit kde4-base

DESCRIPTION="IDE for applications based on PIC and dsPIC microcontrollers"
HOMEPAGE="http://piklab.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="sys-libs/readline
	virtual/libusb:0
	dev-qt/qtcore:4
	dev-qt/qtgui:4
	dev-qt/qt3support:4"
RDEPEND="${DEPEND}"

DOCS=( Changelog README TODO )

src_prepare() {
	sed -e "/install(FILES README/d" \
		-i CMakeLists.txt || die

	kde4-base_src_prepare
}

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use !kde QT_ONLY)
		-DLOCALE_INSTALL_DIR="/usr/share/locale"
	)
	kde4-base_src_configure
}

# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-tv/w_scan/w_scan-20130331.ebuild,v 1.1 2013/06/15 17:30:01 hd_brummy Exp $

EAPI="5"

DESCRIPTION="Scan for DVB-C/DVB-T/DVB-S channels without prior knowledge of frequencies and modulations"
HOMEPAGE="http://wirbel.htpc-forum.de/w_scan/index2.html"
SRC_URI="http://wirbel.htpc-forum.de/w_scan/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc examples"

DEPEND=">=virtual/linuxtv-dvb-headers-5.3"
RDEPEND=""

src_install() {
	emake DESTDIR="${D}" install

	dodoc ChangeLog README

	if use doc; then
		dodoc doc/README.file_formats doc/README_VLC_DVB
	fi

	if use examples; then
		docinto examples
		dodoc doc/rotor.conf
	fi
}

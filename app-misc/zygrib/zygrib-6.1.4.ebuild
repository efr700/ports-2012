# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/zygrib/zygrib-6.1.4.ebuild,v 1.3 2013/06/01 08:59:57 mschiff Exp $

EAPI=5

inherit eutils qt4-r2

MY_PN="zyGrib"

DESCRIPTION="GRIB File Viewer - Weather data visualization"
HOMEPAGE="http://www.zygrib.org/"
SRC_URI="http://www.zygrib.org/getfile.php?file=${MY_PN}-${PV}.tgz -> ${P}.tgz
	http://dev.gentoo.org/~mschiff/distfiles/${PN}-icon.png
	maps?   (
		http://zygrib.org/getfile.php?file=zyGrib_maps2.4.tgz -> zygrib-maps2.4.tgz
		http://www.zygrib.org/getfile.php?file=cities_1k-3k.txt.gz -> zygrib-cities_1k-3k.txt.gz
		http://www.zygrib.org/getfile.php?file=cities_300-1k.txt.gz -> zygrib-cities_300-1k.txt.gz
		http://www.zygrib.org/getfile.php?file=cities_0-300.txt.gz -> zygrib-cities_0-300.txt.gz
	 )"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+maps"

DEPEND="app-arch/bzip2
sci-libs/libnova
sci-libs/proj
sys-libs/zlib
x11-libs/qwt:6"

RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_PN}-${PV}"

src_prepare() {
	sed -i 's,/usr/include/qwt ,/usr/include/qwt6 ,' src/zyGrib.pro
	sed -i 's,/usr/local/qwt6/lib/,/usr/lib/,' src/zyGrib.pro
	sed -i 's,-lqwt,-lqwt6,' src/zyGrib.pro
	sed -i 's,INSTALLDIR=$(HOME)/zyGrib,INSTALLDIR=$(DESTDIR)/opt/zyGrib,' Makefile
}

src_install() {
	default
	rm zyGrib
	doicon -s 32 "${DISTDIR}/zygrib-icon.png"
	make_wrapper "${PN}" "./bin/${MY_PN}" "/opt/${MY_PN}"
	domenu "${FILESDIR}/zygrib.desktop"

	if use maps; then
		insinto "/opt/${MY_PN}"
		doins -r "${WORKDIR}/data"
		insinto "/opt/${MY_PN}/data/gis"
		gzip "${WORKDIR}"/*.txt
		doins "${WORKDIR}"/*.txt.gz
	fi
}

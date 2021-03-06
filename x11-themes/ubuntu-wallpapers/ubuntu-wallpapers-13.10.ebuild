# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/ubuntu-wallpapers/ubuntu-wallpapers-13.10.ebuild,v 1.2 2013/11/18 21:33:56 pacho Exp $

EAPI=5

DESCRIPTION="Ubuntu wallpapers"
HOMEPAGE="https://launchpad.net/ubuntu/+source/ubuntu-wallpapers"
MY_P="${PN}_13.04.0+${PV}.20130924.1"
SRC_URI="mirror://ubuntu/pool/main/u/${PN}/${MY_P}.orig.tar.gz"

LICENSE="CC-BY-SA-3.0"
KEYWORDS="amd64 ~arm x86"
IUSE=""

RDEPEND=""
DEPEND=""

S="${WORKDIR}/${MY_P/_/-}"

SLOT=0

src_compile() { :; }
src_test() { :; }

src_install() {
	insinto /usr/share/backgrounds
	doins *.jpg *.png

	insinto /usr/share/backgrounds/contest
	doins contest/*.xml

	for i in *.xml.in; do
		insinto /usr/share/gnome-background-properties
		newins ${i} ${i/.in/}
	done

	dodoc AUTHORS
}

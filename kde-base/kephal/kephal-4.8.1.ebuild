# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kephal/kephal-4.8.1.ebuild,v 1.1 2012/03/06 23:35:05 dilfridge Exp $

EAPI=4

KMNAME="kde-workspace"
KMMODULE="libs/kephal"
inherit kde4-meta

DESCRIPTION="Allows handling of multihead systems via the XRandR extension"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug"

RDEPEND="
	x11-libs/libxkbfile
	x11-libs/libXrandr
"
DEPEND="${RDEPEND}
	x11-proto/randrproto
"
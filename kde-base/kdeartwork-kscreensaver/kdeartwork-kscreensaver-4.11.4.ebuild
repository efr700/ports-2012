# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeartwork-kscreensaver/kdeartwork-kscreensaver-4.11.4.ebuild,v 1.1 2013/12/03 22:36:04 johu Exp $

EAPI=5

KMMODULE="kscreensaver"
KMNAME="kdeartwork"
OPENGL_REQUIRED="optional"
KDE_SCM="svn"
inherit kde4-meta

DESCRIPTION="Extra screensavers for kde"
KEYWORDS=" ~amd64 ~arm ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug +eigen +kexiv2 xscreensaver"

# libkworkspace - only as a stub to provide KDE4Workspace config
RDEPEND="
	$(add_kdebase_dep kscreensaver)
	$(add_kdebase_dep libkworkspace)
	media-libs/libart_lgpl
	x11-libs/libX11
	x11-libs/libXt
	kexiv2? ( $(add_kdebase_dep libkexiv2) )
	virtual/glu
	virtual/opengl
	xscreensaver? ( x11-misc/xscreensaver )
"
DEPEND="${RDEPEND}
	eigen? ( dev-cpp/eigen:2 )
"

PATCHES=( "${FILESDIR}/${PN}-xscreensaver.patch"
	"${FILESDIR}/${PN}-4.5.95-webcollage.patch" )

src_configure() {
	mycmakeargs=(
		-DKSCREENSAVER_SOUND_SUPPORT=ON
		-DOPENGL=ON
		$(cmake-utils_use_with eigen Eigen2)
		$(cmake-utils_use_with kexiv2)
		$(cmake-utils_use_with xscreensaver)
	)

	kde4-meta_src_configure
}

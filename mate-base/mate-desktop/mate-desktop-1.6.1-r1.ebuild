# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"
GCONF_DEBUG="yes"
MATE_LA_PUNT="yes"
PYTHON_COMPAT=( python2_{6,7} )

inherit mate python-r1 multilib

DESCRIPTION="Libraries for the MATE desktop that are not part of the UI"
HOMEPAGE="http://mate-desktop.org"

LICENSE="GPL-2 FDL-1.1 LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE=""

# Upstream says to use glib 2.34 so as to not have to rebuild once someone
# moves to 2.34 - see mailing list for more info:
# http://ml.mate-desktop.org/pipermail/mate-dev/2012-November/000009.html
RDEPEND=">=dev-libs/glib-2.34:2[${PYTHON_USEDEP}]
	x11-libs/gtk+:2
	dev-libs/libunique:1
	>=x11-libs/libXrandr-1.2
	>=x11-libs/startup-notification-0.5"

DEPEND="${RDEPEND}
	>=dev-util/intltool-0.40
	virtual/pkgconfig
	>=app-text/mate-doc-utils-1.2.1
	~app-text/docbook-xml-dtd-4.1.2
	x11-proto/xproto
	>=x11-proto/randrproto-1.2"

PDEPEND=">=dev-python/pygtk-2.8:2[${PYTHON_USEDEP}]
	>=dev-python/pygobject-2.14:2[${PYTHON_USEDEP}]"

# Includes X11/Xatom.h in libgnome-desktop/gnome-bg.c which comes from xproto
# Includes X11/extensions/Xrandr.h that includes randr.h from randrproto (and
# eventually libXrandr shouldn't RDEPEND on randrproto)

src_configure() {
	DOCS="AUTHORS ChangeLog HACKING NEWS README"

	mate_src_configure \
		--enable-mate-conf-import \
		--with-gtk=2.0
}

src_install() {
	mate_src_install
	# Do migrate script foo see url:
	# https://github.com/Sabayon/mate-overlay/issues/38
	rm "${D}"/usr/share/applications/mate-conf-import.desktop || die "rm failed"
	mkdir "${D}"/usr/$(get_libdir)/mate-desktop || die "mkdir failed"
	mv "${D}"/usr/bin/mate-conf-import \
		"${D}"/usr/$(get_libdir)/mate-desktop/ || die "mv failed"
}

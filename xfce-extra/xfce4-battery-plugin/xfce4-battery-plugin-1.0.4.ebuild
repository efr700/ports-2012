# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfce4-battery-plugin/xfce4-battery-plugin-1.0.4.ebuild,v 1.2 2012/05/20 12:04:53 ago Exp $

EAPI=4
inherit linux-info xfconf

DESCRIPTION="A battery monitor panel plugin for the Xfce desktop environment"
HOMEPAGE="http://goodies.xfce.org/projects/panel-plugins/xfce4-battery-plugin"
SRC_URI="mirror://xfce/src/panel-plugins/${PN}/${PV%.*}/${P}.tar.bz2"

LICENSE="GPL-2 LGPL-2"
SLOT="0"
KEYWORDS="amd64 ~arm ~ppc ~x86"
IUSE="debug kernel_linux"

RDEPEND=">=dev-libs/glib-2.24
	>=x11-libs/gtk+-2.20:2
	>=xfce-base/libxfce4ui-4.8
	>=xfce-base/libxfce4util-4.8
	>=xfce-base/xfce4-panel-4.8"
DEPEND="${RDEPEND}
	dev-util/intltool
	virtual/pkgconfig"

pkg_setup() {
	XFCONF=(
		$(xfconf_use_debug)
		)

	DOCS=( AUTHORS ChangeLog NEWS README )

	if use kernel_linux; then
		CONFIG_CHECK="~ACPI_BATTERY"
		linux-info_pkg_setup
	fi
}
# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-vpx/gst-plugins-vpx-1.0.8.ebuild,v 1.1 2013/08/26 21:52:23 eva Exp $

EAPI="5"

inherit gst-plugins-good

DESCRIPTION="GStreamer decoder for vpx video format"
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~amd64-fbsd"
IUSE=""

RDEPEND=">=media-libs/libvpx-1.1"
DEPEND="${RDEPEND}"

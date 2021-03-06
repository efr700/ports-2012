# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/ksystraycmd/ksystraycmd-4.11.4.ebuild,v 1.1 2013/12/03 22:35:52 johu Exp $

EAPI=5

KMNAME="kde-workspace"
inherit kde4-meta

DESCRIPTION="Ksystraycmd embeds applications given as argument into the system tray."
KEYWORDS=" ~amd64 ~arm ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug"

DEPEND="x11-libs/libX11"
RDEPEND="${DEPEND}"

# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kompare/kompare-4.12.0.ebuild,v 1.1 2013/12/18 19:58:09 johu Exp $

EAPI=5

KDE_HANDBOOK="optional"
inherit kde4-base

DESCRIPTION="Kompare is a program to view the differences between files."
HOMEPAGE="http://www.kde.org/applications/development/kompare
http://www.caffeinated.me.uk/kompare"
KEYWORDS=" ~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug"

DEPEND="$(add_kdebase_dep libkomparediff2)"
RDEPEND="${DEPEND}"

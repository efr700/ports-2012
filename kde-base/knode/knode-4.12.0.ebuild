# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/knode/knode-4.12.0.ebuild,v 1.1 2013/12/18 19:57:44 johu Exp $

EAPI=5

KDE_HANDBOOK="optional"
KMNAME="kdepim"
inherit kde4-meta

DESCRIPTION="A newsreader for KDE"
HOMEPAGE="http://www.kde.org/applications/internet/knode/"
KEYWORDS=" ~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug"

# test fails, last checked for 4.2.96
RESTRICT=test

DEPEND="
	$(add_kdebase_dep kdepimlibs)
	$(add_kdebase_dep kdepim-common-libs)
"
RDEPEND="${DEPEND}"

KMEXTRACTONLY="
	libkleo/
	libkpgp/
	messagecomposer/
	messageviewer/
	messagecore/
"
KMCOMPILEONLY="
	agents/sendlateragent/
	grantleetheme/
	kaddressbookgrantlee/
	pimcommon/
"

KMLOADLIBS="kdepim-common-libs"

src_unpack() {
	if use handbook; then
		KMEXTRA="
			doc/kioslave/news
		"
	fi

	kde4-meta_src_unpack
}

# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/libsepol/libsepol-2.1.9-r2.ebuild,v 1.1 2013/08/15 18:22:22 swift Exp $

EAPI="4"

inherit multilib toolchain-funcs eutils multilib-minimal

DESCRIPTION="SELinux binary policy representation library"
HOMEPAGE="http://userspace.selinuxproject.org"
SRC_URI="http://userspace.selinuxproject.org/releases/20130423/${P}.tar.gz
	http://dev.gentoo.org/~swift/patches/${PN}/patchbundle-${P}-r1.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

# tests are not meant to be run outside of the
# full SELinux userland repo
RESTRICT="test"

src_prepare() {
	EPATCH_MULTI_MSG="Applying libsepol patches ... " \
	EPATCH_SUFFIX="patch" \
	EPATCH_SOURCE="${WORKDIR}/gentoo-patches" \
	EPATCH_FORCE="yes" \
	epatch

	epatch_user
	multilib_copy_sources
}

multilib_src_compile() {
	tc-export RANLIB;
	emake AR="$(tc-getAR)" CC="$(tc-getCC)"
}

multilib_src_install() {
	LIBDIR="\$(PREFIX)/$(get_libdir)" SHLIBDIR="\$(DESTDIR)/$(get_libdir)" \
		emake DESTDIR="${D}" install
}

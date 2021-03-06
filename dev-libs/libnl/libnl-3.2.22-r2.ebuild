# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libnl/libnl-3.2.22-r2.ebuild,v 1.3 2013/09/05 18:29:54 mgorny Exp $

EAPI=5
PYTHON_COMPAT=( python2_{6,7} python3_{2,3} )
DISTUTILS_OPTIONAL=1
inherit distutils-r1 eutils libtool multilib

DESCRIPTION="A collection of libraries providing APIs to netlink protocol based Linux kernel interfaces"
HOMEPAGE="http://www.infradead.org/~tgr/libnl/"
SRC_URI="
	http://www.infradead.org/~tgr/${PN}/files/${P}.tar.gz
	doc? ( http://www.infradead.org/~tgr/${PN}/files/${PN}-doc-${PV}.tar.gz )
"
LICENSE="LGPL-2.1 doc? ( GPL-3 ) utils? ( GPL-2 )"
SLOT="3"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~amd64-linux ~ia64-linux ~x86-linux"
IUSE="doc static-libs python utils"

RDEPEND="python? ( ${PYTHON_DEPS} )"
DEPEND="${RDEPEND}
	python? ( dev-lang/swig )
	sys-devel/flex
	sys-devel/bison
"

REQUIRED_USE="python? ( ${PYTHON_REQUIRED_USE} )"

DOCS=( ChangeLog )

src_prepare() {
	epatch "${FILESDIR}"/${PN}-1.1-vlan-header.patch
	epatch "${FILESDIR}"/${PN}-3.2.20-rtnl_tc_get_ops.patch
	epatch "${FILESDIR}"/${PN}-3.2.20-cache-api.patch
	epatch "${FILESDIR}"/${PN}-3.2.22-python.patch
	elibtoolize
}

src_configure() {
	econf \
		--disable-silent-rules \
		$(use_enable static-libs static) \
		$(use_enable utils cli)
}

src_compile() {
	default

	if use python; then
		cd "${S}"/python || die
		distutils-r1_src_compile
	fi
}

src_install() {
	default

	if use doc; then
		dohtml -r \
			-a css,html,js,map,png \
			"${WORKDIR}"/${PN}-doc-${PV}/*
	fi

	if use python; then
		# Unset DOCS= since distutils-r1.eclass interferes
		DOCS=''
		cd "${S}"/python || die
		distutils-r1_src_install
	fi

	prune_libtool_files $(usex static-libs --modules --all)
}

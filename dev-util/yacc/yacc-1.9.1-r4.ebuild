# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/yacc/yacc-1.9.1-r4.ebuild,v 1.9 2012/09/26 07:34:45 ulm Exp $

inherit eutils toolchain-funcs

DESCRIPTION="Yacc: Yet Another Compiler-Compiler"
HOMEPAGE="http://dinosaur.compilertools.net/#yacc"
SRC_URI="ftp://metalab.unc.edu/pub/Linux/devel/compiler-tools/${P}.tar.Z"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc x86"
IUSE=""

DEPEND=""

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Use our CFLAGS
	sed -i -e 's: -O : $(CFLAGS) :' Makefile || die 'sed failed'

	# mkstemp patch from byacc ebuild
	epatch "${FILESDIR}"/mkstemp.patch

	# The following patch fixes yacc to run correctly on ia64 (and
	# other 64-bit arches).  See bug 46233
	epatch "${FILESDIR}"/${P}-ia64.patch

	# avoid stack access error, bug 232005
	epatch "${FILESDIR}"/${P}-CVE-2008-3196.patch
}

src_compile() {
	make clean || die
	emake -j1 CC="$(tc-getCC)" CFLAGS="${CFLAGS}" || die
}

src_install() {
	dobin yacc || die
	doman yacc.1
	dodoc 00README* ACKNOWLEDGEMENTS NEW_FEATURES NO_WARRANTY NOTES README*
}

pkg_preinst() {
	# bison installs a /usr/bin/yacc symlink ...
	# we need to remove it to avoid triggering
	# collision-protect errors #90089
	if [[ -L ${ROOT}/usr/bin/yacc ]] ; then
		rm -f "${ROOT}"/usr/bin/yacc
	fi
}

pkg_postrm() {
	# and if we uninstall yacc but keep bison,
	# lets restore the /usr/bin/yacc symlink
	if [[ ! -e ${ROOT}/usr/bin/yacc ]] && [[ -e ${ROOT}/usr/bin/yacc.bison ]] ; then
		ln -s yacc.bison "${ROOT}"/usr/bin/yacc
	fi
}
